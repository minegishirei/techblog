



## Dockerfile ENV 詳細

Dockerfile の ENV は、dockerイメージ内に環境変数を設定します。
構文は次の通りです。

### 親記事

- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)
- [Dockerfile の from ( FROM ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/111814)
- [Dockerfile の user ( USER ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/113541)



### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)




## ENV

Dockerfile の ENV は、dockerイメージ内に環境変数を設定します。
構文は次の通りです。

```Dockerfile
ENV <環境変数名> <値>
```

**環境変数は頻繁に使う変数として後で参照できます。**

```sh
ENV MY_VERSION 1.3
RUN apt-get install -y mypackage=$MY_VERSION
```

環境変数はdockerのイメージ内で利用できます。

### Dockerfile の ENVの具体例：プロキシーを設定する

会社内でDockerfileを扱い際には、プロキシ環境変数を設定してパスを通しておく必要があります。（プロキシーに引っかかってダウンロードができない場合はお試しください）

```Dockerfile
# 環境変数の変更
ENV HTTP_PROXY="<proxy_url>"
ENV HTTPS_PROXY="<proxy_url>"
ENV FTP_PROXY="<proxy_url>"
ENV http_proxy="<proxy_url>"
ENV https_proxy="<proxy_url>"
ENV ftp_proxy="<proxy_url>"
```



## DockerfileでRUN と exportを組み合わせる環境変数指定方法は動かない

例えば環境変数`PATH`は実行可能なプログラムのパスを指定することで、フォルダー名の入力を省略することができます。

その際に次のように`RUN export <変数名>=<値>`と入力しても動きません。

```Dockerfile
RUN export PATH=$PATH:/usr/local/scala/scala-2.11.7/bin
```

代わりに、`ENV`を使用する必要があります。

```Dockerfile
ENV PATH $PATH:/usr/local/scala/scala-2.11.7/bin
```



## Dockerfile の ENV を使用して動的にファイルを生成する

開発環境と本番環境で`config.conf`ファイルを切り替えたいときにも`ENV`は役に立ちます。
次の例では、DBに関する環境変数`DB_HOST`と`DB_PORT`を使用して`config.conf`ファイルに追記を行っています。

```Dockerfile
ENV DB_HOST=localhost
ENV DB_PORT=3306

# 設定ファイルを生成
RUN echo "DB_HOST=$DB_HOST" >> config.conf
RUN echo "DB_PORT=$DB_PORT" >> config.conf
```

`RUN`コマンド実行の際には通常のlinuxコマンドが走るため、環境変数の参照が`$環境変数`で可能です。


## Dockerfile の ENV　で分岐処理を行う

シェルスクリプトの`if`文を使用することで、環境に合わせたビルドを行うことができます。
以下の例では環境変数`ENVIRONMENT`に`production`が入るか入らないかで`npm`のビルドコマンドを変更する仕様になってます。

```Dockerfile
ARG BUILD_ENV
ENV ENVIRONMENT=$BUILD_ENV

# 環境に合わせたビルドステップを実行
RUN if [ "$ENVIRONMENT" = "production" ]; then npm run build; else npm run dev-build; fi
```









