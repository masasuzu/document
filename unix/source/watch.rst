=================================
Watch Your Server
=================================

:Version:
    1.0 of 2012/04/06

:Author:
    SUZUKI Masashi / masasuzu

:Mail:
    m15.suzuki.masashi@gmail.com

負荷
====================================

負荷は主に2つに分類されます。

* CPU負荷
* I/O負荷

CPU負荷が高いサーバをCUPバウンドなサーバ、I/O負荷が高いサーバをI/Oバウンドなサーバと言ったりします。前者の例としてはDBサーバ、後者の例としてはアプリケーションサーバがあります。

ロードアベレージ
====================================

サーバの負荷を表す指標として ロードアベレージがあります。LAと略することもあります。uptimeコマンドを叩くとロードアベレージを取得することができます。
ロードアベレージの数値は単位時間あたりの平均待ちタスクの数を表します。一般的に数値が高いほど負荷が高いと言えます。

::

    % uptime
    13:58:02 up 19 days, 19:23, 14 users,  load average: 0.07, 0.04, 0.06

左側から順に、現在の時間、起動からどれくらい時間が経っているか、ログインしているユーザ数(w | wc -c 相当) 、1分間、5分間、15分間のロードアベレージ

プロセスの状態遷移
====================================

+-----------------------+-------------------------------------------------------+
| 状態                  | 説明                                                  |
+=======================+=======================================================+
| TASK_RUNNING          | タスクが実行可能な状態                                |
+-----------------------+-------------------------------------------------------+
| TASK_INTERRUPTIBLE    | 割り込み可能な待ち状態。入力待ちなど                  |
+-----------------------+-------------------------------------------------------+
| TASK_UNINTERRUPTIBLE  | 割り込み不可能な待ち状態。ディスクの入出力待ちなど    |
+-----------------------+-------------------------------------------------------+
| TASK_STOPPED          | サスペンド状態                                        |
+-----------------------+-------------------------------------------------------+
| TASK_ZOMBIE           | ゾンビ状態                                            |
+-----------------------+-------------------------------------------------------+

* SEE ALSO; http://sourceforge.jp/projects/linux-kernel-docs/wiki/internal22-6-%E3%83%97%E3%83%AD%E3%82%BB%E3%82%B9%E3%81%AE%E7%8A%B6%E6%85%8B%E9%81%B7%E7%A7%BB



::

    プロセスの状態遷移図(簡略)

                    実行待ち            scheduling         実行中
    ---------> TASK_RUNNING(READY)  ------------------> TASK_RUNNING
    generate           ^            <-----------------      |
                       |                preempt             |
                       |                                    |
                       |          イベント待ち              |
                       +----- TASK_INTERRUPTIBLE   <--------+
                              TASK_UNINTERRUPTIBLE
                       wake_up                          sleep_on
                       interruptiple_wake_on            interruptiple_sleep_on



プロセスの状態のうちロードアベレージに換算されるのは、TASK_RUNNINGとTASK_UNINTERRUPTIBLEのみです。
つまり、CPUの実行権限が与えられるのを待っているプロセスとディスクI/Oが完了するのを待っているプロセスのみとなります。
ロードアベレージが高い場合、どちらに起因するのかを考えなければなりません。

ps
------------------------------------

ちなむとpsコマンドでプロセスの実行状態を参照することができます。

::

    PROCESS STATE CODES
           Here are the different values that the s, stat and state output specifiers (header "STAT" or "S") will display to describe the state of a process.
           D    Uninterruptible sleep (usually IO)
           R    Running or runnable (on run queue)
           S    Interruptible sleep (waiting for an event to complete)
           T    Stopped, either by a job control signal or because it is being traced.
           W    paging (not valid since the 2.6.xx kernel)
           X    dead (should never be seen)
           Z    Defunct ("zombie") process, terminated but not reaped by its parent.

           For BSD formats and when the stat keyword is used, additional characters may be displayed:
           <    high-priority (not nice to other users)
           N    low-priority (nice to other users)
           L    has pages locked into memory (for real-time and custom IO)
           s    is a session leader
           l    is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
           +    is in the foreground process group



メモリ
====================================

物理メモリ、仮想メモリとかページキャッシュの話

ps
====================================

top
====================================

mpstat
====================================

iostat
====================================

vmstat
====================================

netstat
====================================

sar
====================================

dstat
====================================

