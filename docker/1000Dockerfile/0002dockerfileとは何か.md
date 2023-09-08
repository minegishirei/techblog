
Dockerfileの書き方: Dockerイメージを効率的に作成する方法
=====================================

Dockerfileの書き方を詳しく紹介します。Dockerfileは、Dockerイメージを作成するために必要な一連の手順をコードとして記述できる強力なツールです。正しく使用することで、環境の再現性を高め、コンテナ化されたアプリケーションの開発とデプロイメントをスムーズに行うことができます。

Docker入門関連記事
------------

* [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
* [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
* [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
* [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)

目次
--

[:contents]

Dockerfileの目的: Dockerイメージを作成する手順をコード化する
---------------------------------------

Dockerコンテナは手動で開発環境を設定できますが、これにはいくつかの問題があります。一行ごとにコマンドを入力すると、コードが冗長になり、見づらくなります。さらに重要なのは、手動で環境を設定した場合、その結果を再現するのが難しいことです。これはDockerイメージやコンテナの共有や再利用が難しく、エラーが発生しやすくなります。

この問題に対処するために、Dockerfileを使用してイメージの自動ビルドを行います。Dockerfileには、イメージを構築するために必要な手順をコードとして記述します。

Dockerfileを使ってデプロイを自動化する
------------------------

デプロイを自動化するために、まずは新しいフォルダとDockerfileを作成します。
以下はlinuxコマンドで作成してますが、`cowsay`フォルダと`Dockerfile`を作成できればどのツール(vscode,メモ帳)でもよいです。

```sh
mkdir cowsay
cd cowsay
touch Dockerfile
```

この後、Dockerfileにコードを書いていきます。エディターはメモ帳でもvscodeでもvimでもよいです。
Dockerfileは、単なるテキストファイルで、イメージのビルドに使用する手順を含んでいます。

```Dockerfile
FROM debian:wheezy
RUN apt-get update && apt-get install -y cowsay fortune
```


このDockerfileの内容を解説します。

* `FROM`命令は、ベースイメージを指定します。ここではDebianの"wheezy"というバージョンを使用しています。全てのDockerfileには最初に`FROM`命令が必要です。
* その後、Dockerイメージ内で実行するシェルコマンドを指定します。この場合、cowsayとfortuneをインストールしています。

次に、実際にコンテナをビルドしてデプロイします。

```sh
docker build -t test .
```

ここで、Dockerfileに記述された手順に従ってコンテナがビルドされます。
`-t test`でbuildされるイメージに`test`という名前を付けています。
最後に、コンテナを実行してみましょう。

```sh
docker run test /usr/games/cowsay "Moo"
```

上記の`run`コマンドでは、`test`コンテナに対してlinuxコマンド`usr/games/cowsay`を実行しました。(引数は`"Moo"`)
このコマンドで牛のアスキーアートが表示されるはずです。Dockerfileに手順を記述し、一つのコマンドでコンテナをデプロイし、実行できることが確認できました。

Dockerファイルのクリーンな書き方
-------------------


上記の`run`コマンドでは、`test`コンテナに対してlinuxコマンド`usr/games/cowsay`を実行しました。(引数は`"Moo"`)
利便性を向上させるために、以下のようにDockerfileを改善できます。

```Dockerfile
FROM debian
RUN apt-get update && apt-get install -y cowsay fortune
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
```

このDockerfileでは、`ENTRYPOINT`命令を使用して、コンテナが実行される際に実行されるスクリプトを指定しています。また、`COPY`命令を使用してファイルをコンテナ内部へコピーしています。これにより、ユーザーがコンテナを実行する際に引数を指定できるようになります。

新しい`entrypoint.sh`スクリプトを作成し、実行権限を付与しましょう。

```sh
#!/bin/bash
if [ $# -eq 0 ]; then
    /usr/games/fortune | /usr/games/cowsay
else
    /usr/games/cowsay "$@"
fi
```

実行権限を付与するには次のコマンドを使用します。

```sh
chmod 755 entrypoint.sh
```

これで以下のコマンドを使用してコンテナをビルドし実行できます。

```sh
docker build -t test/cowsay-dockerfile .
docker run test/cowsay-dockerfile
docker run test/cowsay-dockerfile Hello Moo
```

**`entrypoint.sh`スクリプトによって、引数の有無に応じてコンテナの挙動が変わることが確認できます。**


