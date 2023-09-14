

# DockerfileのRUNコマンドの詳細

DockerfileのRUNコマンドは、Dockerイメージをビルドする際に実行されるコマンドを指定するためのものです。このコマンドはDockerfile内で複数回使用できます。以下に、DockerfileのRUNコマンドに関する詳細な情報を示します。

### 親記事

- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)
- [Dockerfile の from ( FROM ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/111814)
- [Dockerfile の user ( USER ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/113541)

### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)


### イメージのレイヤー

Dockerfile内でRUNコマンドを実行するたびに、新しいイメージレイヤーが作成されます。これは、イメージの変更点をトラッキングし、再利用可能なキャッシュを提供するための仕組みです。一度実行したコマンドを再実行することは避けるべきです。なぜなら、同じコマンドを実行するたびに新しいレイヤーが追加され、イメージのサイズが大きくなる可能性があるからです。

<img src="https://docs.docker.com/build/guide/images/layers.png">

from https://github.com/minegishirei/techblog/tree/main/docker

### シェルスクリプトの使用

RUNコマンドは通常、Linuxのシェルコマンドを実行するために使用されますが、シェルスクリプトを使用して複数のコマンドをまとめて実行することもできます。これにより、コマンドの組み合わせを読みやすくし、複雑なタスクを実行できます。

例えば、次のようにシェルスクリプトを使用して複数のコマンドを実行することができます：

```Dockerfile
RUN ["sh", "-c", "echo 'Hello, Docker!' > /tmp/docker.txt"]
```

この例では、シェルスクリプトを使用してテキストをファイルに書き込んでいます。

**このように配列を駆使してRUNを使用することで、ダブルクォーテーションやシングルクォーテーションをエスケープしながら書くことも可能です**



### パッケージマネージャーの使用

多くの場合、DockerfileのRUNコマンドはパッケージマネージャーを使用してソフトウェアパッケージをインストールするために利用されます。例えば、Ubuntuベースのイメージでapt-getを使用してパッケージをインストールする方法は以下の通りです：

```Dockerfile
RUN apt-get update && apt-get install -y package1 package2 package3`
```

このようにすることで、必要なパッケージをイメージに追加できます。*ただし、不要なキャッシュファイルを削除しないと、イメージサイズが増加し続ける可能性があるため、イメージ最適化のためにキャッシュクリアコマンドを実行することも考慮してください。*



### 最適化とベストプラクティス

DockerfileのRUNコマンドを効果的に使用するために、以下のベストプラクティスに従うことが重要です：

* 不要なファイルやキャッシュを削除してイメージサイズを最小化する。
* パッケージのインストールなど、必要なタスクを1つのRUNコマンド内でまとめて実行し、レイヤー数を最小限に抑える。
* 変更の頻度が低い部分から始め、頻繁に変更される部分を後で追加することで、キャッシュを最大限に利用する。








## Dockerfile RUNの詳細


### Dockerfile RUN の ARGとの組み合わせ

Dockerfile内でARG（引数）を使用すると、ビルド時に変数を渡すことができます。これを利用して、実行時に変数の値に基づいてコマンドをカスタマイズすることができます。例えば、特定のバージョンのソフトウェアをインストールする場合、ARGを使用してバージョン番号を渡すことができます。

```Dockerfile
ARG APP_VERSION=1.0
RUN wget https://example.com/app-${APP_VERSION}.tar.gz
```

この例では、APP_VERSIONという引数を定義し、その値を使って特定のバージョンのアプリケーションをダウンロードしています。ビルド時に`--build-arg`オプションを使用して引数の値を変更することができます。


### 複数ステップのビルド

特にコンパイルやビルドプロセスが含まれる場合、Dockerfile内で複数のRUNステップを使用することが一般的です。これにより、一時的なビルドイメージを作成し、最終的なイメージを最適化できます。

```Dockerfile
# ビルドステージ1: コードのコンパイル
FROM compiler as build
WORKDIR /app
COPY . .
RUN make

# ビルドステージ2: 最終的な実行イメージの構築
FROM base-image
COPY --from=build /app/output /app`
```

この例では、ビルドステージ1ではコードのコンパイルを行い、ビルドステージ2では最終的な実行イメージを構築しています。これにより、不要なビルド依存性を含まない軽量な実行イメージを作成できます。


### Multi-stageビルドとコピー

Multi-stageビルドを利用すると、ビルドステージから必要なアーティファクトをコピーすることができます。これにより、最終的な実行イメージに不要なファイルや依存性を含めないことができます。このアプローチは、最終的なイメージのサイズを最小限に抑えるのに役立ちます。


```Dockerfile
# ビルドステージ1: コードのビルド
FROM golang:1.16 as builder
WORKDIR /app
COPY . .
RUN go build -o myapp

# 最終的な実行イメージ
FROM debian:stretch-slim
COPY --from=builder /app/myapp /usr/local/bin/
CMD ["myapp"]`
```

この例では、ビルドステージ1でGoアプリケーションをビルドし、最終的な実行イメージにビルドアーティファクトをコピーしています。

