

# Dockerfile の from ( FROM ) 句の使い方

Dockerfileの`FROM`命令は、Dockerイメージを構築する際のベースイメージを指定するために使用されます。以下に、`FROM`命令の詳細と使い方を解説します。



### 親記事

- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)
- [Dockerfile の from ( FROM ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/111814)


### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)


### 目次

[:contents]



`FROM`命令の基本的な構文は次のとおりです：

```Dockerfile
FROM <イメージ名>:<タグ>
```

ここで、各要素の説明を行います：

1.  `<イメージ名>`: これはベースイメージの名前です。Docker Hubや他のイメージリポジトリから取得できるイメージの名前を指定します。例えば、Ubuntuベースのイメージを使いたい場合、`ubuntu`を指定します。
2.  `<タグ>`: これはイメージのバージョンやバリエーションを示すものです。タグを指定しない場合、デフォルトで最新のタグが選択されます。しかし、安定性を保つために、特定のバージョンのイメージを使用することを推奨します。例えば、`ubuntu:18.04`はUbuntu 18.04の特定のバージョンを指定します。

以下に、具体的な例をいくつか示します：


```Dockerfile
# Ubuntu 18.04をベースとするDockerイメージを指定
FROM ubuntu:18.04

# タグを指定しない場合、最新のUbuntuイメージを使用
FROM ubuntu

# 別のイメージ、例: Alpine Linuxの最新バージョン
FROM alpine

# カスタムイメージリポジトリからのイメージ指定
FROM myregistry/myimage:1.0
```

注意事項:

* `FROM`句はDockerfile内で最初に指定する必要があります。それ以外の場所で指定するとエラーが発生します。
* イメージ名とタグは必要に応じて指定します。タグを指定しない場合、デフォルトのタグが選択されますが、安定性のためにタグを特定のバージョンに設定することをお勧めします。

`FROM`命令を使用してベースイメージを指定することで、その後のDockerfileでイメージをカスタマイズし、新しいカスタムイメージを構築することができます。


## Dockerfile の マルチステージビルドとは何か？

Dockerfileのベストプラクティスの一つに、`マルチステージビルド`と呼ばれるものがあります。
これはDockerfileのベースイメージに複数の選択肢を用意するアプローチで、例えばビルド時と実行時で異なるベースイメージを使用することができます。

### 1.  **`AS`キーワード**

`FROM`命令に`AS`キーワードを追加することで、特定のステージでのベースイメージを指定することができます。これは、マルチステージビルドと呼ばれるアプローチで、ビルド段階と実行段階で異なるベースイメージを使用する場合に便利です。

```Dockerfile
# ビルドステージでのベースイメージ
FROM node:14 AS build

# ビルドステージでのコードのコピーとビルド
...


# 実行ステージでのベースイメージ
FROM nginx:alpine AS production

# 実行ステージでの設定とコンテンツのコピー
...
```

### サンプル : Reactでビルドし、Nginxで本番実行する

以下の例ではマルチステージビルドというアプローチで、react(nodeがベースイメージ)でビルドを行い、nginxで本番稼働させています。

```Dockerfile
# syntax=docker/dockerfile:1
FROM node:18 AS build
WORKDIR /app
COPY package* yarn.lock ./
RUN yarn install
COPY public ./public
COPY src ./src
RUN yarn run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
```

reactアプリケーションでは開発段階で`node.js`を使用し、webアプリケーションの開発を行いますが、
reactのbuildで生成される最終成果物はHTML,CSS,JSの静的なファイルのみです。（本番段階ではnode.jsは不要になります）

本番稼働のビルドステージではnodeではなく、nginxを使用し、reactによりビルドされた静的ファイルをコピーしています。

from https://docs.docker.jp/get-started/09_image_best.html#react







### 2.  **マルチアーキテクチャのサポート**

`FROM`命令を使用して、異なるアーキテクチャのベースイメージを指定することもできます。例えば、ARMアーキテクチャ向けのベースイメージを選択することができます。

```Dockerfile
# ARM64アーキテクチャ向けのベースイメージ
FROM arm64v8/debian:bullseye
```


3.  **外部URLからのベースイメージ取得**: `FROM`命令では、外部のURLからベースイメージを取得することもできます。これは、特定のイメージがDocker Hubなどの公式リポジトリに存在しない場合に役立ちます。

```Dockerfile
# 外部URLからベースイメージを取得
FROM example.com/custom-image:1.0`
```










from https://minegishirei.hatenablog.com/entry/2023/09/12/111814