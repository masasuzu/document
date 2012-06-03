======================================
2012-05-26 継続的デリバリー座談会2回目
======================================

* ファイルサーバは書き換えられうるので信用ならない。
* hgとsvnは連携できるけど、リビジョンでで指定するので完全には連携できない。
* 実装方法が決まらないと見積もりだせないよ
* 継続的デリバリーはwebアプリと金融屋が書いた本。
* メンバーが替わらないのが大きい

  * 変わっていたら旨く回っていないとおもう。

* 3人メンバーでもsvnロックをかける

* http://d.hatena.ne.jp/troter/20111225/1324823716

* pull request使うと変なのが減る。手戻りは減る

* chrominumのビルドの話

  * http://steps.dodgson.org/b/2012/05/20/gardening-with-canaries/
  * http://steps.dodgson.org/b/2012/02/19/wild-coding/

* sikuli

  * http://sikuli.org/

定期的にtrunkにチェックインする
======================================

* 関連する変更はcherry-pickするとコンフリクトしにくい
* ブランチは最強では無い。
* redmineはブランチができすぎて大変になった
* propsal branch

  * オープンソース向き
  * 基本的にコミット権はコミッタしかない

* 意味的衝突

  * http://capsctrl.que.jp/kdmsnr/wiki/bliki/?SemanticConflict

* rebaseよりグラフからcherry-pickして方がやりやすい
* 大きい変更をするときはリファクタリングブランチを作る

コミットメッセージ
===========================

* Mercurialのコミットメッセージの書き方

  * http://mercurial.selenic.com/wiki/ContributingChanges#Patch_descriptions

* 17時くらいにgithubが重い => あっちの方の夜12時

ソフトウェアの設定
===========================

* YAGNI
* 設定ファイルのメンテナンス
* shelldoctest

  * http://code.google.com/p/shell-doctest/

* ライブラリは最新版は追従して、バグっていたらすぐにresetで無かったことにする
* 最新版を追従すると自然とテストするようになる。
* OSSを使っているのでバグ報告は義務
* エンジニアは前のめりにならないとダメ
* chefには設定ファイルテンプレート機能がある
* 1プロジェクトで複数レポジトリを使う
* windowsの人はどうやって自動化しているのかな?
* azureにgunmaリージョンがある

* pivotal tracker
  * http://www.pivotaltracker.com/

* 週4時間だけ働く

  * http://www.amazon.co.jp/dp/4905042097


環境管理
===========================

* vagrant

  * https://github.com/facebook/tornado

* http://readthedocs.org/
* https://github.com/rtfd/readthedocs.org

* pappetは無い?
* chef と capistranoでいいんじゃないの?

* 環境構築系

  * chef
  * pappet
  * fabric

* デプロイ

  * capistrano
  * fabric

* 環境構築を新人にやらせるのは無駄?
* 複数プロジェクトを立てているならJenkinsは複数立てた方が楽かも知れない
* オックスフォードが月600$でホストしているよ





