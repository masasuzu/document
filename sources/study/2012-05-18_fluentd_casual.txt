============================
2012-05-12 fluentd casual
============================

資料まとめ
=============

* http://togetter.com/li/305806
* http://dl.dropbox.com/u/224433/fluentd_casual_1/index.html
* http://www.slideshare.net/oranie/fluentd-casual-12981506
* http://www.slideshare.net/treasure-data/fluentd-for-small-projects-fluentd-casual-20120518
* https://docs.google.com/presentation/embed?id=1uFqdgCKJnD87Yad3MLTM00G9pbtWTRe1ptDn4OUC-sI
* http://www.slideshare.net/katsyoshi/fluentd
* http://www.slideshare.net/tagomoris/plugins-by-tagomoris-fluentdcasual

fluentdとは、
============================

* ググれ

  * http://fluentd.org/doc/
  * https://github.com/fluent/fluentd
  * http://d.hatena.ne.jp/masasuz/20120520/1337518231
  * rvmで入れられる
  * treasure dataがdeb packageを提供しているのでこっちを使うとお手軽

    * https://github.com/treasure-data/td-agent

* ログを転送、収集ツール
* ログデータのフォーマットはJSON
* 入力

  * アプリがログを投げる
  * 既存のログをtail
  * 他のfluentdから転送

* 出力

  * ファイル
  * メール
  * DB mongodbとか
  * growthforecast

何となく私見
============================

以下自己メモ

* ひとまず、32bit lennyのdebを作るのはできたから、ちょこちょこ試したい。
* ログを貯めるのはmongdbかなー。

  * その辺も検証しないといけないから、まずはファイルかな。

* apache logをtailして転送が一番実現が早いかな。
* errorlogをパースして集約するとものすごい捗りそう
* accesslogを集計してレスポンスタイムを可視化したい

  * http://dl.dropbox.com/u/224433/fluentd_casual_1/index.html#15

* CPUをけっこう使うとか言われているけど、大規模じゃ無ければ大丈夫かな?

fluentdはじめました @oranie
============================

* 資料

  * http://www.slideshare.net/oranie/fluentd-casual-12981506

* カジュアル枠で参加
* fluentd使ってみました
* web serverのレスポンスの統計とか

* 運用側で状況の可視化ができる

* DBに袖手しているとくそ重い

* rsyslogめんどい
* syslog-ngオワコン?

* cronのタイムラグ

いいところ
-------------


* プラグインが豊富
* 設定が柔軟
* 開発が活発

* td-agentを使うと捗る

構成
---------


* 収集サーバ => 中間サーバ => 集計サーバ

困ったこと
----------------

* 公式ドキュメントが古い
* プラグインの情報が散在

* 1プロセス 一万message/sec
* CPU bound


fluentdでwebサイト運用を楽にする @fujiwara
============================================
* 資料

  * http://dl.dropbox.com/u/224433/fluentd_casual_1/index.html

* 性能劣化の早期検出
* ユーザ問い合わせ対応


* web access log
* maillog
* job worker log
* ユーザ行動ログ


access log
--------------

10GB / day

* ステータスコードの集計
* レスポンスタイムの集計

* 全数検査的に割合を見てみると良い

ユーザログ
--------------

* fluentd => mongodb
* ユーザログを貯めている


* ssh login が減った

* 動作が安定している != 枯れている
* バージョンアップに注意

* fluentdのメッセージも他のメッセージと同様に扱える

小さく始めるfluentd @kzk_mover
===============================

Tresure Data, Incの人

* 資料

  * http://www.slideshare.net/treasure-data/fluentd-for-small-projects-fluentd-casual-20120518

* tg-agent package manager


* messageが構造化されている

  * json

* librato metrics

  * グラフツール

* github issues #3

  * https://github.com/fluent/fluentd/issues/3
  * 伝書鳩のロゴになったよ

fluentdを使ってみたい @riywo
================================

* 資料

  * http://www.slideshare.net/riywo/i-want-to-use-fluentd

* DeNAではfluentdを使ってない

* dstatの内容をfluentdに投げて見る

* td-agentのcentos対応した



fluent-pulugins3を使ってみた @ume3_
========================================

* ぺぱぼの人

* Simple Storage Service

* APIのエンドポイントの指定をしてなかった

* IssueよりPull Request

Javaアプリからfluentdにログを送信する @tanaka_733
====================================================

* Cloud Foundryをいじってる

* インスタンスが落ちるとログが消える

* LoggerAppender


アクセスログをごにょって捗る話 @tnmt
==========================================

* 資料

  * https://docs.google.com/presentation/embed?id=1uFqdgCKJnD87Yad3MLTM00G9pbtWTRe1ptDn4OUC-sI

* 30days album
* のアクセスログ

* rbenv + bundler

* グラフから始めるといいよ


fluentd + redis レコメンドエンジン @hito_asa
==============================================

* 資料

  * http://www.slideshare.net/hitoasa/fluentd-casual-talks-lt-fluentd-fluentdcasual

* 画像投稿サービス

* 1.3億 req /day

センサーデータ @katsyoshi
==========================================

* 資料

  * http://www.slideshare.net/katsyoshi/fluentd

最近作ったプラグイン @tagomoris
==========================================

* 資料

  * http://www.slideshare.net/tagomoris/plugins-by-tagomoris-fluentdcasual

* file-alternative
* hoop
* mysql
* ikachan
* growthforecast
* flowcounter
* datacounter
* numeric-monitor
* notifier
* amplifir-filter
* paser
* forest


fluen.py @methene
==========================================

* メモリ効率いいよ
* Debianのシステムpythonでいいよ

* pluginが少ない

プラグイン開発者の憂鬱 @repetedly
==========================================

* fluent-plugin-mongo

* mongodbオワコン?
* pluginはテスト書きにくい

* 内部バッファーの容量を超えることがある

* Celluloid::IO


* fluentd v11の計画


