=================================
Git tutorial
=================================

:Version:
    1.0 of 2011/05/08

:Author:
    SUZUKI Masashi / masasuzu

:Mail:
    m15.suzuki.masashi@gmail.com

Agenda
=================================

#. バージョン管理とは
#. Gitの概要
#. 実践Git
#. 私とGit

バージョン管理とは
=================================

from wikipedia 先生

* http://ja.wikipedia.org/wiki/%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E7%AE%A1%E7%90%86%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0

::

    バージョン管理システム（バージョンかんりシステム）とは、コンピュータ上で作成、
    編集されるファイルの変更履歴を管理するためのシステム。
    特にソフトウェア開発においてソースコードの管理に用いられることが多い。

なんでバージョン管理するの?
---------------------------------

バージョン管理することによって

* 過去に正常に動いていたバージョンに簡単に戻せる。
* 多人数で開発する際、容易に最新バージョンにアクセスすることができる。

集中型と分散型
---------------------------------

* 集中型バージョン管理システム

  * 1つの中央レポジトリに対してクライアントがアクセス(checkout, commit)することができる。

* 分散型バージョン管理システム

  * 複数のレポジトリを持つことができ相互にアクセス(pull, push)することができる。

Gitの概要
=================================

Gitは

* 分散バージョン管理システム。
* Linuxカーネル開発で使用されている。
* Bazaar、Mercurialのようば他の分散バージョン管理システムに比べ、

  * 採用実績が多い。
  * Windows対応が貧弱。

用語
---------------------------------


実践Git
=================================

新規ローカルレポジトリの作成
---------------------------------

::

    cd $ProjectDir
    # レポジトリ作成
    git init
    # カレントディレクトリをINDEXに上げる
    git add .
    # 変更をコミット
    git commit -m 'initial commit'


ファイルをINDEXに上げる
---------------------------------

::

    # ファイルを指定してINDEXに上げる
    git add $FILENAME

    # 対話的にINDEXに上げる箇所を選ぶ
    git add -p


変更をコミットする
---------------------------------

::

    # INDEXをコミットする
    git commit

    # ファイルを指定してコミットする
    git commit $FILENAME

    # コマンドラインでコミットログを指定する
    git commit -m 'ほげほげ refs #555'

    # 変更箇所を確認しつつコミットする
    git commit -v

    # Gitの管理対象ファイルをINDEXに上がっていないものも含めてコミットする
    git commit -a


変更履歴を見る
------------------------------------------

::

    # INDEXに上がっていない、変更された管理対象ファイルを確認する
    git status

    # INDEXに上がっていない、変更された管理対象ファイルの差分を確認する
    git diff

    # 直前のコミットを見る
    git show

    # コミットログを見る
    git log

    # 変更履歴をdiff付きで見る
    git log -p

    # ブランチツリーを見る
    git log --graph

    # 変更がどのコミットで入ったのかを確認する
    git blame $FILENAME


リモートレポジトリの他人の変更を反映する
------------------------------------------

::

    # 他人のコミットを
    git pull --rebase

    # 他人のコミットをマージする
    git pull

リモートレポジトリに自分の変更を反映する
------------------------------------------

::

    # 自分のコミットをリモートレポジトリに反映する
    git pull --rebase
    git push

私とGit
=================================


さて仕事を始めるか
---------------------------------

::

    screen -rd $ProjectName
    cd $ProjectDir
    git checkout master
    git pull --rebase
    git checkout work
    git rebase master


新しい機能を実装するか
---------------------------------

::

    git checkout master
    git pull --rebase
    git branch topic/hoge-feature
    git checkout topic/hoge-feature

    #... edit and test ...

    git checkout master
    git pull --rebase
    git checkout topic/hoge-feature
    git rebase master

    # if deploy new feature
        git checkout master
        git rebase topic/hoge-feature
        git push
        git branch -D topic/hoge-feature

    # else
        git push origin topic/hoge-feature


バグ修正依頼がはいったぞ
---------------------------------

::

    git checkout master
    git branch fix/hoge-bug
    git checkout fix/hoge-bug

    #... edit and pray ...

    git checkout master
    git pull --rebase
    git checkout fix/hoge-bug
    git rebase master
    git checkout master
    git rebase fix/hoge-bug
    git push
    git branch -D fix/hoge-bug

