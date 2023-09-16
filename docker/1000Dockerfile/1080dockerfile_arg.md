




## dockerfileのARG命令について

DockerfileのARG命令は、ビルド時に変数を設定し、その値をDockerイメージ内で使用するための命令です。



### 親記事

- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)
- [Dockerfile の from ( FROM ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/111814)
- [Dockerfile の user ( USER ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/113541)



### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)







### Dockerfileの ARG命令 宣言方法

DockerfileのARG命令を実行するためには、次のように「変数名」と、「デフォルト値」を宣言する必要があります。
（ただし、デフォルト値は必ずしもDockerfile内で定める必要はありません。）

```Dockerfile
ARG <変数名>[=<デフォルト値>]
```


Dockerfile内でARG命令で定義した変数は、ビルドプロセス中で使用できます。
例えば、環境変数を設定したりコマンド内で変数を参照したりできます。


```Dockerfile
# Dockerfile内で変数を定義
ARG APP_PORT=8080
ARG APP_VERSION=1.0

# 環境変数を設定
ENV PORT=$APP_PORT
ENV VERSION=$APP_VERSION
```



### Build時に ARGで宣言した環境変数の値を変更する

`Dockerfile`内で宣言した`ARG`による環境変数は、`docker build`でDockerイメージをビルドする際に変更することができます。
変更の際には以下のように`--build-arg`オプションを使用します。

```sh
docker build --build-arg <変数名>=<値> -t <イメージ名> <Dockerfileのパス>
```

ここで、`<変数名>`はDockerfile内で定義された変数の名前で、`<値>`はその変数に設定する値です。



### Dockerfile ARG命令の具体例 

以下のDockerfileはnginxの公式イメージをベースにしており、NGINX_PORTというARG命令を使用してNginxのポート番号をカスタマイズします。

```Dockerfile
# Dockerfile内で変数を定義
ARG NGINX_PORT=80

# 公式のNginxイメージをベースにする
FROM nginx:latest

# Nginxのポート番号をEXPOSEで公開
EXPOSE $NGINX_PORT

# カスタムNginx設定ファイルをコピー
COPY nginx.conf /etc/nginx/nginx.conf
```

このDockerfileの中で、ARG命令を使用して`NGINX_PORT`という環境変数を定義し、デフォルト値として80を設定しています。
仮に公開するポート番号を80番から8080番へ変更したい時は、以下のように`--build-arg`オプションを使用します。

```sh
docker build --build-arg NGINX_PORT=8080 -t custom-nginx-image .
```

