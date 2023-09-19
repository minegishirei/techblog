


# Docker入門

Docker を使ってプログラミングの学習を開始される方を対象とした Docker 入門サイトです。 Docker の開発環境をローカル環境に構築する手順や、 Docker を使ったプログラムの記述方法や実行までをサンプルを使いながら順に学習していきます。

[:contents]




## Dockerのインストール方法と環境設定

#### [Dockerのダウンロードとインストール(MacOS編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)

MacOSでのDocker のダウンロードとインストール方法について解説します。 2023 年 9 月現在、最新のバージョンは Docker v4.19.0 となっています。

#### [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)

WindowsOSでのDocker のダウンロードとインストール方法について解説します。

#### [Dockerに関するドキュメントを参照する](https://minegishirei.hatenablog.com/entry/2023/09/03/184308)

Docker を使ったプログラミング、開発を行う上で、参考になるドキュメントを参照する方法について解説します。

#### [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)

Docker のプロキシーの設定をする方法や、Dockerfileへのプロキシの記述方法など Dockerを社内で使う上で基本となる項目について解説します。

会社内でDockerを使用する際にはよくプロキシに引っかかるのでご注意ください。



## Dockerの基本事項

#### [docker で HelloWorld!](https://minegishirei.hatenablog.com/entry/2023/09/06/100027)

この記事ではDockerを使ったことのない方に向けて、Dockerを使ってHelloworldを画面に出力する方法を紹介します。
まずはDockerがどのように機能するかを理解するために、いくつかの単純な Docker コンテナを起動して動かしてみましょう。



#### [docker runコマンドのオプション一覧](https://minegishirei.hatenablog.com/entry/2023/05/09/095603)

**docker runコマンドは今のところdockerシステムの中で最も複雑なコマンドのうちの一つとなってます。**

docker runコマンドで引数を使用すると、ユーザーはイメージの実行方法を編集することができます。


#### [docker run portオプション(-pオプション)](https://minegishirei.hatenablog.com/entry/2023/09/07/120532)

dockerのportオプションの使い方について詳しく解説します。その過程で、Dockerを使用してWebサーバーを立てる方法について詳しく説明します。コンテナ内でウェブサーバーを実行して外部にサービスを提供する手順を理解しましょう。

#### [docker buildコマンドのオプション一覧](https://minegishirei.hatenablog.com/entry/2023/05/09/200108)

dockerのbuildコマンドについて詳しく解説します。
dockerのイメージはDockerfileによって定義されますが、buildコマンドのオプションによってコントロールできます。



## Dockerfileの基本的な書き方

#### [Dockerfileの書き方: Dockerイメージを効率的に作成する方法](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)

Dockerfileの書き方を詳しく紹介します。Dockerfileは、Dockerイメージを作成するために必要な一連の手順をコードとして記述できる強力なツールです。正しく使用することで、環境の再現性を高め、コンテナ化されたアプリケーションの開発とデプロイメントをスムーズに行うことができます。


#### [Dockerfile の from ( FROM ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/111814)

Dockerfileの`FROM`命令は、Dockerイメージを構築する際のベースイメージを指定するために使用されます。以下に、`FROM`命令の詳細と使い方を解説します。

#### [Dockerfile の user ( USER ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/113541)

Dockerfileでの`USER`命令は、Dockerイメージ内で実行されるプロセスがどのユーザーとして実行されるかを指定するために使用されます。これにより、セキュリティ上の理由からルートユーザーとしてプロセスを実行しないようにすることができます。以下は`USER`命令の使用方法と注意点です。



#### [Dockerfile の run ( RUN ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/14/102912)

DockerfileのRUNコマンドは、Dockerイメージをビルドする際に実行されるコマンドを指定するためのものです。このコマンドはDockerfile内で複数回使用できます。以下に、DockerfileのRUNコマンドに関する詳細な情報を示します。



#### [Dockerfile の env ( ENV ) の使い方](https://minegishirei.hatenablog.com/entry/2023/09/14/140239)

Dockerfile の ENV は、dockerイメージ内に環境変数を設定します。


#### [Dockerfile の copy ( COPY ) の使い方](https://minegishirei.hatenablog.com/entry/2023/09/14/152703)

DockerfileのCOPY命令は、ホストマシンのファイルやディレクトリからイメージにファイルをコピーするために使用されます。 

#### [Dockerfile の arg ( ARG ) の使い方](https://minegishirei.hatenablog.com/entry/2023/09/16/172148)

DockerfileのARG命令は、ビルド時に変数を設定し、その値をDockerイメージ内で使用するための命令です。


#### [Dockerfile の cmd ( CMD ) の使い方](https://minegishirei.hatenablog.com/entry/2023/09/14/210740)

**コンテナの起動時に指定された命令を実行します。**
`docker run`の起動時に実行されるコマンドを指定することが可能です。


#### [Dockerfile の workdir ( WORKDIR ) の使い方](https://minegishirei.hatenablog.com/entry/2023/09/16/094349)

Dockerfile の WORKDIR 命令は**後続のRUN、CMD、ENTRYPOINT、ADD、またはCOPYの作業ディレクトリを設定します。**
WORKDIRコマンドは以下のように書きます。


#### Dockerfileにコメントを記述する

#### Dockerfileを保存する文字コードを設定する

#### Dockerワンライナー起動





## docker-composeの使い方

#### docker-composeのインストール

#### docker-compose.ymlの作成と起動

#### docker-compose.ymlのオプション一覧






## Dockerイメージ集

#### [docker-compose と nginx を使用してWebサーバーを立ち上げる方法](https://minegishirei.hatenablog.com/entry/2023/09/16/112502)
docker-compose , Docker , Dockerfile を使用して nginx を立ち上げる方法を解説します。 コピペで完成するため、だれでも簡単にサービスを立ち上げれます。



#### [Docker を使用して python の環境構築する方法](https://minegishirei.hatenablog.com/entry/2023/05/04/171154)

Docker を使用して python の環境構築を行う方法を解説します。

- やること：
    1. Dockerのインストール（事前準備推奨）
    2. Dockerfile作成（ソースコードをダウンロードでもいいが、手作業で書いた方が理解が進みます。）
    3. pythonコード作成
    4. `build`コマンドの実行と解説
    5. `run`コマンドの実行と解説
    6. helloworldの確認



#### [FlaskサーバーをDockerで立ち上げる方法](https://minegishirei.hatenablog.com/entry/2023/05/06/180545)

目的：**本サイトではDockerを利用したflaskサーバーの環境構築方法を学びます。**



#### [Django と MySQL を docker-compose で動かす【docker-compose,django,mysql】](https://minegishirei.hatenablog.com/entry/2023/09/18/205930)

MySQLを搭載したDjangoアプリケーションdocker-composeを用いて動かす方法を解説します。 ソースコードの入手からDjangoプロジェクトのアカウント作成、MySQLコンテナの確認まで行います。



