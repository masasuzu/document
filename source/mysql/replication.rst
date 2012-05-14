=================================
MySQLのレプリケーション
=================================

:Version:
    1.0 of 2012/05/14

:Author:
    SUZUKI Masashi / masasuzu

:Mail:
    m15.suzuki.masashi@gmail.com

概要
====================================

DBの複製を別のサーバに作ることとその仕組みをレプリケーションと言います。データの複製元をマスター、複製先をスレーブと呼びます。
1台のマスターに対して複数台のスレーブを設定することが可能です。

マスターとスレーブのデータはリアルタイムでコピーされますが、基本的に非同期であるため、スレーブのデータが最新であることは保証されません。
スレーブを使用する際、遅延が置きうることをあらかじめ考慮しておく必要があります。

目的
====================================

* データのコピー
* 負荷分散
* バックアップ

  * ただし、レプリケーション自体はバックアップでは無い。

* 可用性の向上

  * 複数台のスレーブとスレーブDBに対するフェイルオーバーシステムがあれば、SPOFの解消となる。

* MySQLのアップグレードのテスト


レプリケーションの仕組み
====================================

単純化するとレプリケーションは以下のような仕組みで動いています。

1. マスターがデータの更新内容をバイナリログに記録する
2. スレーブがバイナリログを読み取ってリレーログにコピーする (I/Oスレッド)
3. スレーブがリレーログの内容を再生して、自身のデータを更新する (SQLスレッド)

TODO: 図解入れるよ

スレーブがコピーしているのは、マスターのDB(ストレージエンジン)に入っているデータでは無く、バイナリログの中身です。

ここで注意しなくてはいけないのはマスターでのデータ更新は並列で行えるのに対し、スレーブにおけるリレーログの再生は直列で行われるるため、\
マスターで大量の更新があるとスレーブの遅延が激しくなります。


設定
====================================


レプリケーションアカウントの設定
------------------------------------

両サーバでREPLICATION SLAVE, REPLICATION CLIENTの権限を与えたユーザを作成します。

REPLICATION SLAVEが実際にレプリケーションを行う権限。REPLICATION CLIENTはレプリケーションの監視コマンドを実行する権限です。

::

    GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO replication@'192.168.1.%' IDENTIFIED BY 'replpasswd';

マスターの設定
------------------------------------

マスター上で一意なサーバーIDの指定とバイナリログを出力させる設定を入れる必要があります。

::

    log_bin=mysql-bin   # host名を付けておくと無難
    server_id=10        # IPアドレスの4オクテット目を付けることが多い


スレーブ設定
------------------------------------

マスターに障碍が起きたときにスレーブがマスターに昇格できるようにバイナリログを出力させます。log_slave_updatesを入れることでSQLスレッドで再生された更新をバイナリログに出力できます。
また、スレーブには書き込みをさせないようにread_onlyを入れておきます。

::

    log_bin=mysql-bin   # host名を付けておくと無難
    server_id=20        # IPアドレスの4オクテット目を付けることが多い
    read_only=1
    log_slave_updates=1

スレーブの開始
------------------------------------

::

    CHANGE MASTER TO MASTER_HOST='master_host',
        MASTER_USER='replication',
        MASTER_PASSWORD='replpasswd';

    SLAVE START;



スレーブの状態確認
------------------------------------


I/OスレッドとSQLスレッドが動いていることを確認します。

::

    > SHOW FULL PROCESSLIST;
    +---------+------------------+-----------------------+-----------------+---------+--------+-----------------------------------------------------------------------+-----------------------+
    | Id      | User             | Host                  | db              | Command | Time   | State                                                                 | Info                  |
    +---------+------------------+-----------------------+-----------------+---------+--------+-----------------------------------------------------------------------+-----------------------+
    |      11 | system user      |                       | NULL            | Connect | 393287 | Waiting for master to send event                                      | NULL                  |
    |      12 | system user      |                       | NULL            | Connect |      0 | Has read all relay log; waiting for the slave I/O thread to update it | NULL                  |
    +---------+------------------+-----------------------+-----------------+---------+--------+-----------------------------------------------------------------------+-----------------------+

::

    SHOW SLAVE STATUS;
    > SHOW SLAVE STATUS\G
    *************************** 1. row ***************************
                   Slave_IO_State: Waiting for master to send event
                      Master_Host: 192.168.200.119
                      Master_User: replication
                      Master_Port: 3306
                    Connect_Retry: 60
                  Master_Log_File: 51319-bin.001705
              Read_Master_Log_Pos: 45405275
                   Relay_Log_File: 51251-relay-bin.130426
                    Relay_Log_Pos: 45405177
            Relay_Master_Log_File: 51319-bin.001705
                 Slave_IO_Running: Yes   //
                Slave_SQL_Running: Yes   // この二つがYesならば、レプリケーションは動いている
                  Replicate_Do_DB:
              Replicate_Ignore_DB:
               Replicate_Do_Table:
           Replicate_Ignore_Table:
          Replicate_Wild_Do_Table:
      Replicate_Wild_Ignore_Table:
                       Last_Errno: 0
                       Last_Error:
                     Skip_Counter: 0
              Exec_Master_Log_Pos: 45405032
                  Relay_Log_Space: 45405618
                  Until_Condition: None
                   Until_Log_File:
                    Until_Log_Pos: 0
               Master_SSL_Allowed: No
               Master_SSL_CA_File:
               Master_SSL_CA_Path:
                  Master_SSL_Cert:
                Master_SSL_Cipher:
                   Master_SSL_Key:
            Seconds_Behind_Master: 0  // マスターからどのくらい遅れているかの目安。0以外なら遅延している
    Master_SSL_Verify_Server_Cert: No
                    Last_IO_Errno: 0
                    Last_IO_Error:
                   Last_SQL_Errno: 0
                   Last_SQL_Error:

