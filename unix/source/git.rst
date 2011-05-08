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

Gitの概要
=================================

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
    git commit -m 'commit log refs #555'

    # 変更箇所を確認しつつコミットする
    git commit -v

    # Gitの管理対象ファイルをINDEXに上がっていないものも含めてコミットする
    git commit -a

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

