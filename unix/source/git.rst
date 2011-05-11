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
#. Gitの基本操作
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

HEAD
    現在チェックアウトされているコミット、ブランチのこと。

INDEX
    コミット対象のファイル、状態のこと。

ワークツリー
    レポジトリの内容がディレクトリに展開されたもの。
    作業ファイルのこと。

STASH
    一時的な保存領域ワークツリーの変更を一時的に保存する時に使う。

Gitの基本操作
=================================

Gitでの開発の基本ワークフローを以下に示します。

Gitの各コマンドはgit subcmd という形式で表されます。

Gitで開発するためにはまず、Gitレポジトリをローカルに作る必要があります。\
そのための方法として、git init(まっさらなレポジトリを作る)とgit clone(リモートのレポジトリをコピーする)があります。

::

    # リモートのレポジトリからソースコードをコピーしてくる
    git clone $REMOTEREPOSITORY

    # ソースコードを編集

    # ファイルをINDEXに上げる
    git add $FILENAME

    # ファイルをコミットする
    git commit -av

    # 編集している間に入ったリモートレポジトリの変更を反映する
    git pull --rebase

    # ローカルの変更をリモートレポジトリに反映する
    git push


実践Git
=================================

よく使いそうなGitコマンドを紹介していくよ。


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

リモートレポジトリからコピーしてくる
-------------------------------------

::

    git clone $REMOTEREPOSITORY


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


変更を一時領域に保存する
---------------------------------


::

    # 変更を横によける
    git stash save

    # 横によけた変更をワークツリーに反映させる
    git stash pop

    # STASHをリスト表示する
    git stash list


変更履歴を見る
------------------------------------------

::

    # INDEXに上がっていない、変更された管理対象ファイルを確認する
    git status

    # INDEXに上がっていない、変更された管理対象ファイルの差分を確認する
    git diff

    # INDEXに上がっているファイルも含め、変更された管理対象ファイルの差分を確認する
    git diff HEAD

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

ブランチを操作する
------------------------------------------

::

    # ブランチをリストアップする
    git branch

    # ブランチを作成する
    git branch $BRANCHNAME

    # ブランチを切り替える
    git checkout -b $BRANCHNAME

    # ブランチを作成してそのブランチに切り替える
    git checkout -b $BRANCHNAME

    # マージ済みのブランチを削除する
    git branch -d $BRANCHNAME

    # ブランチを強制削除する
    git branch -D $BRANCHNAME


コミットをやり直す
------------------------------------------

::

    # 直前のコミットを取り消す
    git reset 'HEAD^'

    # 直前のコミットに変更を付け足す
    git commit --amend

    # 歴史を(コミット3件分)改竄する
    git commit -i 'HEAD~3'

私とGit
=================================

私が仕事で使うテンプレ的なワークフローを紹介するよ。

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
    git checkout -b topic/hoge-feature

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
    git checkout -b fix/hoge-bug

    #... edit and pray ...

    git checkout master
    git pull --rebase
    git checkout fix/hoge-bug
    git rebase master
    git checkout master
    git rebase fix/hoge-bug
    git push
    git branch -D fix/hoge-bug

