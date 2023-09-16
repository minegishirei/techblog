






# dockerfileのWORKDIR

Dockerfile の WORKDIR 命令は**後続のRUN、CMD、ENTRYPOINT、ADD、またはCOPYの作業ディレクトリを設定します。**
WORKDIRコマンドは以下のように書きます。


### 親記事

- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)
- [Dockerfile の from ( FROM ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/111814)
- [Dockerfile の user ( USER ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/113541)



### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)





## dockerfileのWORKDIR

Dockerfile の WORKDIR 命令は**後続のRUN、CMD、ENTRYPOINT、ADD、またはCOPYの作業ディレクトリを設定します。**
WORKDIRコマンドは以下のように書きます。

```sh
WORKDIR /path/to/directory
```

例えば、以下のように書くことができます。
```sh
WORKDIR /app
```

この例では、作業ディレクトリを「/app」と指定しています。この後のRUN、CMD、COPYなどのコマンドが実行される際に、そのディレクトリが作業ディレクトリとして使用されます。



## Dockerfile WORKDIR 実例 : flaskアプリで WORKDIRを使う

以下はnginxのDockerコンテナの例で、WORKDIR を使用する方法です。
後続の`COPY`コマンドの作業ディレクトリを変更するために、`WORKDIR`命令を実行しています。

```Dockerfile
# ベースイメージを指定
FROM nginx:latest

# コンテナ内での作業ディレクトリを設定
WORKDIR /usr/share/nginx/html

# ファイルやアプリケーションをコピーする例
COPY index.html index.html

```

1.  `nginx:latest` イメージをベースにしています。これは最新のnginxイメージを使用しますが、バージョンを指定することもできます。
2.  `WORKDIR /usr/share/nginx/html` を使用して、コンテナ内の作業ディレクトリを `/usr/share/nginx/html` に設定しています。これはnginxのデフォルトの静的コンテンツディレクトリです。
3.  `COPY index.html index.html` を使用して、ホストマシンの `index.html` ファイルをコンテナ内の作業ディレクトリにコピーしています。これにより、nginxがこのファイルを提供する静的ウェブコンテンツとして使用できます。




