


# dockerfile の COPY命令

DockerfileのCOPY命令は、ホストマシンのファイルやディレクトリからイメージにファイルをコピーするために使用されます。 
このコピーは一方向で、`ホストマシン→コンテナイメージ`の一方向にしかコピーできません。



### 親記事

- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)
- [Dockerfile の from ( FROM ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/111814)
- [Dockerfile の user ( USER ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/113541)



### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)



## dockerfile の COPY 命令

DockerfileのCOPY命令は、ホストマシンのファイルやディレクトリからイメージにファイルをコピーするために使用されます。 
このコピーは一方向で、`ホストマシン→コンテナイメージ`の一方向にしかコピーできません。

COPYには2つの形式がありますが、どちらもファイルまたはディレクトリをコピーします。

```sh
COPY src target
COPY ["src", "dest"]
```

- 引数の一つ目がローカルのコピー元です。
- 引数の二つ目がイメージファイル内のコピー先です。

ADDコマンドでも同様の機能がありますが、**ADDよりはこちらのCOPYを優先してください。**




### Dockerfile COPY命令の具体例 : nginxのconfファイルをコピーする

Nginxの設定ファイルや静的ウェブコンテンツをイメージにコピーすることで、ngixの動きをカスタムすることが可能です。以下がDockerfileでnginxの設定ファイルを変更する例です。

```Dockerfile
# ベースイメージを指定
FROM nginx:latest

# カスタムNginx設定ファイルをコピー
COPY nginx.conf /etc/nginx/nginx.conf

# カスタムウェブコンテンツをコピー
COPY html/ /usr/share/nginx/html/
```

1. `FROM nginx:latest` : Nginx公式のDockerイメージをベースに使用します。
2. `COPY nginx.conf /etc/nginx/nginx.con` : カスタムNginx設定ファイル `nginx.conf` をコンテナ内のNginx設定ディレクトリ `/etc/nginx/` にコピーします。
3. `COPY html/ /usr/share/nginx/html/` : カスタムのウェブコンテンツをコンテナ内のNginxデフォルトのウェブルートディレクトリ /usr/share/nginx/html/ にコピーします。


### Dockerfile COPY 命令でワイルドカードを使用する。

あまり知られてはいないことですが、`Dockerfile`の`COPY`命令では**ワイルドカードを使用することができます。

以下はホストマシン上にある名前が`.txt`で終わるファイル名を、すべて`/app/`配下にコピーしています。

```Dockerfile
COPY *.txt /app/
```


### `.dockerignore`命令でコピーしないファイルを指定する。

DockerfileのCOPY命令では不要なファイルやディレクトリがコピーされることがあります。これを防ぐために、`.dockerignore`ファイルを使用できます。

下記の例では`node_modules`や`.log`ファイルをDockerイメージに含めないように`.dockerignore`に記載しています。

```ignore
# 以下のファイルやディレクトリはDockerイメージに含めない
node_modules
npm-debug.log
*.log
*.json
```

### dockerfileのCOPYのオプション

COPY命令には、以下のオプションがあります。

* `--chown=<user>:<group>`：コピー先のファイルの所有者とグループを指定します。このオプションを指定することで、コピーされたファイルの所有者とグループを制御することができます。例えば、以下のように書くことができます。

```sh
COPY --chown=user:group src dest
```

* `--from=<image>`：別のDockerイメージからファイルをコピーすることができます。このオプションを指定することで、別のDockerイメージからファイルを取得して、現在のイメージにコピーすることができます。例えば、以下のように書くことができます。

```sh
COPY --from=ubuntu:20.04 /src /dest
```

* `--no-cache`：Dockerビルドキャッシュを無効にすることができます。このオプションを指定すると、ビルド時にキャッシュが使用されず、常に新しいファイルがコピーされます。例えば、以下のように書くことができます。

```sh
COPY --no-cache src dest
```

