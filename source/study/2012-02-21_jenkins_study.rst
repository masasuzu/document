======================================
2012-02-21 Jenkis勉強会@楽天
======================================

* http://www.ustream.tv/recorded/20598441
* http://connpass.com/event/246/
* http://togetter.com/li/261426

川口さん
==========================

* DEV@Cloud

  * http://www.cloudbees.com/dev.cb
  * Jenkisのホスティングサービス
  * EC2上で稼働


* マスターは別々のJVM、別々のOSユーザで稼働する。

  * 隔離が簡単
  * モニタリングが簡単

* 1台で多数のマスターを集積している

* OSS Jenkinsの素のものを使っている
* ただし独自プラグインを使って、ユーザに使われると困るものや要らないものを消している

  * メールの設定とか
  * Groovyコンソールとか

* 1テナント1UNIXユーザ
* スナップショットによるバックアップ

* マウントし直してサイズの拡張

  * 最初は小さく作る

* Chefで配布

  * Tomcat
  * 設定ファイル
  * ただし、AMIをあらかじめ作っておいて差分だけ、Chefを配布している


スレーブの割り当て
------------------------

* Providoreo

* スレーブの動的割り当て
* プールがあれば、そこからなければ、EC2APIを叩いてインスタンスを作る

* Linux コンテナ LXC

  * OSレベルの仮想化
  * もともとSolarisにある

  * スレーブのリサイクルが高速
  * リセットリブートが高速

  * EC2からの独立性
  * 下のサービスに依存しなくてすむ


Nagiosによるモニタリング
--------------------------

*
 WEB +DB PRESSにJenkins特集有るよ


はやせさん @ 楽天
==========================

* Continius Derivery読書会

  * http://www.amazon.co.jp/dp/0321601912/

* yammer上で読む本を投票

* 楽天のyammerは英語


かとうさん @ mixi
==========================

* たんぽぽチーム

* master 3台

  * 1. IOS

    * build .plist

  * 2. Android

    * build test 
    * gerrit
    * だいぶモダンらしい

  * 3. mixi

    * test

* execute shell

Test
------------------------

* TAP::Harness::JUnit

  * tapをJUNIT xMLに変換する


Code Metrics
------------------------

* Perl::Metrics::Lite

  * CheckStyleのXML


カバレッジ
------------------------

* Devel::Cover:Report::Clover

* PerlでもXMLの形式に会わせればJenkinsの機能が使える

mix特有の話
-------------

* Ikachan => IRC

* 全テストに15-30分かかる

  * SLOW TEST

* Google Testing Blog

  * テストのサイズの分類
  * Small Medium Large
  * http://googletesting.blogspot.com/2010/12/test-sizes.html

recent job
^^^^^^^^^^^^^^^^
* コミットに関連するテストを実行する

  * クラスとテストが名前ベースでルールが決まっている
  * Mixi::Hoge => t/Mixi/Hoge.t or t/Mixi/Hoge/foo.t

* jsonのデータがHTTPで取れる
* $BUILD_URL

try job
^^^^^^^^^^^^^^^^

* ブランチの設定

* ローカルでmake remote-testするとJenkinsの情報が分かる

??? job
^^^^^^^^^^^^^^^^

* 速いマシンを使うと速いテストができる!

  * Mixiは開発には仮想サーバ使っているがJenkinsだけ物理サーバ

まとめ
^^^^^^^^^^^^^^^^

* Jenkins はweb apiをいっぱい使えるよ


* Feature Toggle マーティンファウラー

  * Flickrはブランチ使わないぜって話。
  * http://code.flickr.com/blog/2009/12/02/flipping-out/
  * http://martinfowler.com/bliki/FeatureToggle.html
  * masterで設定で機能を切り替える

    *  AB Testがしやすい



LT
===================

* Smart jenkins on Ruby
* Jenkins Pluginの話

* 電力不足で、昼間スレーブが動かせないので、スケジュールでスレーブを落とす






















