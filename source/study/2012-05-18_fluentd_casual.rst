================
fluentd casual
================


fluentdはじめました @oranie
=============

カジュアル枠で参加
fluentd使ってみました
web serverのレスポンスの統計とか

運用側で状況の可視化ができる

DBに袖手しているとくそ重い

rsyslogめんどい
syslog-ngオワコン?

cronのタイムラグ

いいところ
-------------


プラグインが豊富
設定が柔軟
開発が活発

td-agentを使うと捗る

構成
---------


収集サーバ => 中間サーバ => 集計サーバ

困ったこと
----------------

公式ドキュメントが古い
プラグインの情報が散在

1プロセス 一万message/sec
CPU bound


fluentdでwebサイト運用を楽にする @fujiwara
============================================

性能劣化の早期検出
ユーザ問い合わせ対応



web access log
maillog
job worker log
ユーザ行動ログ


access log
--------------

10GB / day

ステータスコードの集計
レスポンスタイムの集計

全数検査的に割合を見てみると良い

ユーザログ
--------------

fluentd => mongodb
ユーザログを貯めている


ssh login が減った

動作が安定している != 枯れている
バージョンアップに注意

fluentdのメッセージも他のメッセージと同様に扱える

小さく始めるfluentd @kzk_mover
===============================

Tresure Data, Inc

tg-agent package manager


messageが構造化されている
json

librato metrics

github issues #3

伝書鳩のロゴ

fluentdを使ってみたい @riywo
================================

DeNAではfluentdを使ってない

fluent-pulugins3を使ってみた @ume3_
========================================

ぺぱぼの人

Simple Storage Service

APIのエンドポイントの指定をしてなかった

IssueよりPull Request

Javaアプリからfluentdにログを送信する @tanaka_733
====================================================

Cloud Foundryをいじってる

インスタンスが落ちるとログが消える

LoggerAppender


アクセスログをごにょって捗る話 @tnmt
==========================================

30days album
のアクセスログ

rbenv + bundler

グラフから始めるといいよ


fluentd + redis レコメンドエンジン @hito_asa
==============================================

画像投稿サービス

1.3億 req /day

センサーデータ @katsyoshi
==========================================

最近作ったプラグイン @tagomoris
==========================================

file-alternative
hoop
mysql
ikachan
growthforecast
flowcounter
datacounter
numeric-monitor
notifier
amplifir-filter
paser
forest


fluen.py @methene
==========================================

メモリ効率いいよ
Debianのシステムpythonでいいよ

pluginが少ない

@repetedly
==========================================

fluent-plugin-mongo

mongodbオワコン?
pluginはテスト書きにくい

内部バッファーの容量を超えることがある

Celluloid::IO


fluentd v11の計画


