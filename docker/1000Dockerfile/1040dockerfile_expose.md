





## Dockerfile EXPOSE 命令の詳細

Dockerfile に書かれた EXPOSE 命令は**コンテナが指定されたポートをlistenするプロセスを持つことをDockerに示します。**
しかし厳密にはネットワークに何ら影響を与えないので、実質コメントと同義です。


### 親記事

- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)
- [Dockerfile の from ( FROM ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/111814)
- [Dockerfile の user ( USER ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/113541)



### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)





## EXPOSE

**コンテナが指定されたポートをlistenするプロセスを持つことをDockerに示します。**
この情報は、コンテナをリンクするときにDockerによって使用されます。

EXPOSE命令は以下のように書きます。

```sh
EXPOSE <port> [<port>/<protocol>...]
```

**厳密にいうと、EXPOSE命令自体は、ネットワークに影響を与えません。**
Dockerコンテナからホストシステムにアクセスするためには、`docker run`時に`-p`オプションを使用してポートのマッピングを定義する必要があります。

以下のように`docker run`命令に`-p`オプションを使用してポートを結びつけるように書くことで、Dockerコンテナのポート80をホストシステムのポート8080にマッピングすることができます。

```sh
docker run -p 8080:80 my-image
```

`EXPOSE`命令は、Dockerコンテナが使用するポートを定義するための基本的な方法を提供しますが、実際にホストシステムとの通信を確立するためには、-pオプションを使用してポートのマッピングを定義する必要があります。

