=================================
ストレージエンジンの話
=================================

:Version:
    1.0 of 2012/05/14

:Author:
    SUZUKI Masashi / masasuzu

:Mail:
    m15.suzuki.masashi@gmail.com

MySQLのストレージエンジン
====================================

ストレージエンジンとはデータの保存および取り出しを行う機構のことを指します。主なストレージエンジンとしてMyISAM、InnoDBがあります。

使用できるストレージエンジンはSHOW ENGINESで確認できます。

::

    > SHOW ENGINES;
    +--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
    | Engine             | Support | Comment                                                        | Transactions | XA   | Savepoints |
    +--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
    | FEDERATED          | NO      | Federated MySQL storage engine                                 | NULL         | NULL | NULL       |
    | MRG_MYISAM         | YES     | Collection of identical MyISAM tables                          | NO           | NO   | NO         |
    | MyISAM             | YES     | MyISAM storage engine                                          | NO           | NO   | NO         |
    | BLACKHOLE          | YES     | /dev/null storage engine (anything you write to it disappears) | NO           | NO   | NO         |
    | CSV                | YES     | CSV storage engine                                             | NO           | NO   | NO         |
    | MEMORY             | YES     | Hash based, stored in memory, useful for temporary tables      | NO           | NO   | NO         |
    | ARCHIVE            | YES     | Archive storage engine                                         | NO           | NO   | NO         |
    | InnoDB             | DEFAULT | Supports transactions, row-level locking, and foreign keys     | YES          | YES  | YES        |
    | PERFORMANCE_SCHEMA | YES     | Performance Schema                                             | NO           | NO   | NO         |
    +--------------------+---------+----------------------------------------------------------------+--------------+------+------------+


MyISAM
====================================

* MySQL 5.1までのデフォルトのストレージエンジン
* テーブル全体をロックする
* トランザクション処理が不可能
* テーブルの行数を保持しているのでCOUNTクエリが高速

InnoDB
====================================

* MySQL 5.5からデフォルトのストレージエンジン
* トランザクション可能
* 行ロックが可能
* 主キーによるルックアップが高速

BLACKHOLE
====================================

* データを一切保持しない
* ただし、バイナリログには書き込む


