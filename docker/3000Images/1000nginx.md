


# docker-compose と nginx を使用してWebｗサーバーを立ち上げる方法

docker-compose , Docker , Dockerfile を使用して nginx を立ち上げる方法を解説します。
コピペで完成するため、だれでも簡単にサービスを立ち上げれます。



### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)
- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)

## nginx + docker-compose のソースコード

ディレクトリ構成は以下の通りです。

この後、`docker-compose.yml`,`Dockerfile`, `default.con`ファイルを作成します。
`nginx`ディレクトリと`conf.d`,`html`ディレクトリはあらかじめ作成しておいてください。

```
C:.
│  docker-compose.yml
│  Readme.md
│
└─nginx
    │  Dockerfile
    │
    ├─conf.d
    │      default.conf
    │
    └─html
            index.html
```

vscodeでのディレクトリ構造ですと以下の通りです。


<img src="https://github.com/minegishirei/techblog/blob/main/docker/3000Images/images/nginx/dir.png?raw=true">


### docker-compose のソースコード

nginxを動かすためのdocker-compose.ymlファイルは以下の通りです。
内容をコピーして`docker-compose.yml`ファイルを作成し書き込みましょう。

```yml
version: "3"

services:
  nginx:
    container_name: nginx
    build:
      ./nginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx/html:/usr/share/nginx/html
      - ./nginx/conf.d:/etc/nginx/conf.d
```

ソースコードの内容を少し解説します。

-  `ports`について

portは80番と443番を開けている。
これはそれぞれHTTPとHTTPSで使用するポート番号に対応しており、
これがなければブラウザからアクセスすることができない。

- `volumes`について

nginxで必要なフォルダーは主に二つ。

- `html`フォルダー。ここにはウェブサイトに表示されるhtmlを格納する。
- `conf.d`フォルダー。ここにはnginxで使用する設定ファイルを格納する。

`html`には`index.html`のみを入れている。

`conf.d`には`default.conf`ファイルを入れており、この中にnginxの設定内容を書き込んでいる。


### nginx の Dockerfile

今回の`Dockerfile`は以下の`FROM`句のみです。

```Dockerfile
FROM nginx:latest
```

### `nginx/conf.d/default.conf`について

この設定ファイルには次の内容を書き込んでいる。


```js
server {
    listen       80;
    server_name  localhost;
    location / {
        # ゲストOS上のWebアプリ（index.html等）カレントディレクトリ
        root /usr/share/nginx/html;
        index  index.html index.htm;
    }
}
```


### `index.html`の内容

今回は`Hello world`を表示させましょう。
以下の内容をコピーして保存してください。

```html
<h1>
    hello world!
</h1>
```


## nginx + docker-compose のソースコードを入手

以下のgithubリポジトリからソースコードを手に入れることができます。

gitコマンドをインストールしている方は次のコマンドからインストールしましょう。

```sh
git clone https://github.com/minegishirei/DockerImages.git
```


## nginx を docker-composeで立ち上げる。


### ディレクトリ移動

```sh
cd DockerImages/nginx
```


### コンテナ立ち上げ

```sh
docker-compose up
```

http://localhost/index.html

にアクセス。

以上。終わり。

