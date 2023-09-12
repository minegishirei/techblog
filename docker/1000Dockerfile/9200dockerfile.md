

[:contents]


Docker入門関連記事
------------

* [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
    * [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
    * [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
    * [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)
* Dockerfile
    * [Dockerfileの書き方: Dockerイメージを効率的に作成する方法]()
    * [Dockerfileの書き方: Dockerイメージを効率的に作成する方法]()





## dockerのFROM (dockerのベースイメージを指定する)

**Dockerfileのベースイメージを設定します。**


ベースイメージの指定方法は`IMAGE：TAG`（`debian：wheezy`など）として指定されます。

```sh
FROM <イメージ名>:<タグ>
```

例えば以下の例では、Ubuntu 18.04をベースとするDockerイメージが作成されます。

```sh
FROM ubuntu:18.04
```

**タグは省略した場合最新のものと思われるイメージを指定しますが、予期しない事態を避けるために、タグを特定のバージョンに設定することを常にお勧めします。**

```sh
FROM ubuntu
```

注意：*FROM句はdockerfileの最初の命令である必要があります*
それ以外はエラーが出ます。


### 補足

以降の手順により発生するイメージは、このベースイメージの上にイメージが重ねられます。

レイヤーイメージの最下層に位置するイメージと言っていいでしょう。



## dockerfileのUSER

**後続のRUN、CMD、またはENTRYPOINTで使用するユーザーを（名前またはUIDで）設定します。**
これにより、セキュリティ上の理由から、**ルートユーザーとしてプロセスを実行することを避けることができます。**

例えば、以下のようにDockerfileにUSERコマンドを追加することで、プロセスを"appuser"ユーザーとして実行するように設定することができます。

```sh
FROM python:3.9.16

# ユーザーの作成
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

# ファイルの所有者を設定
COPY --chown=appuser:appgroup app /app

# 実行ユーザーを指定
USER appuser

# コンテナ起動時に実行するコマンドを指定
CMD ["python", "app.py"]
```

UIDはホストとコンテナで同じですが、ユーザー名は異なるUIDに割り当てられる可能性があり、これにより権限を設定するときに問題が発生する可能性があります。



## dockerのRUNコマンド

**DockerfileのRUNコマンドは、Dockerイメージ内でコマンドを実行するために使用されます。RUNコマンドは、Linuxコマンドを用いて、イメージの構成に必要なパッケージのインストール、ファイルのダウンロード、データの準備など、様々な作業を行うことができます。**

**DockerfileのRUNコマンドはDockerfileで最も重要です。**

RUNコマンドは以下のように書きます。

```sh
RUN <コマンド>
```

例えば、以下のように書くことができます。

```sh
RUN apt-get update && apt-get install -y \
    package1 \
    package2 \
    package3
```

この例では、apt-getコマンドを使用して、パッケージマネージャーから「package1」「package2」「package3」をインストールしています。

複数のコマンドを実行する場合は、バックスラッシュ（\）を使用して、コマンドを複数行に分けることができます。また、RUN命令を複数回記述することで、複数のコマンドを実行することもできます。ただし、コマンドを実行するたびに新しいレイヤーが作成されるため、イメージサイズが大きくなる可能性があることに注意してください。

また、RUNコマンドで実行されるコマンドは、シェルスクリプトに書くこともできます。例えば、以下のように書くことができます。

```sh
RUN ["sh", "-c", "echo $HOME"]
```

この例では、シェルスクリプトを使用して、環境変数「$HOME」の値を出力しています。

DockerfileでRUN命令を使用することで、Dockerイメージを構成するためのさまざまなタスクを自動化することができます。また、Dockerfileのキャッシュを利用することで、同じコマンドを繰り返し実行することを避けることができます。



## dockerfileのWORKDIR

後続のRUN、CMD、ENTRYPOINT、ADD、またはCOPYの作業ディレクトリを設定します。

WORKDIRコマンドは以下のように書きます。

```sh
WORKDIR /path/to/directory
```

例えば、以下のように書くことができます。
```sh
WORKDIR /app
```

この例では、作業ディレクトリを「/app」と指定しています。この後のRUN、CMD、COPYなどのコマンドが実行される際に、そのディレクトリが作業ディレクトリとして使用されます。


## dockerfileのCOPY

DockerfileのCOPY命令は、ホストマシンのファイルやディレクトリからイメージにファイルをコピーするために使用されます。 

COPYには2つの形式がありますが、どちらもファイルまたはディレクトリをコピーします。

```sh
COPY src target
COPY ["src", "dest"]
```

- 引数の一つ目がローカルのコピー元で
- 引数の二つ目がイメージファイル内のコピー先です。

ADDコマンドでも同様の機能がありますが、**ADDよりはこちらのCOPYを優先してください。**


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

COPY命令は、Dockerfile内でファイルをコピーするための基本的な方法を提供します。また、上記のオプションを使用することで、ファイルの所有者、別のDockerイメージからのファイルの取得、Dockerビルドキャッシュの制御など、コピー操作をより柔軟に制御することができます。



## ENV

dockerイメージ内に環境変数を設定します。
**環境変数は頻繁に使う変数として後で参照できます。**

```sh
ENV MY_VERSION 1.3
RUN apt-get install -y mypackage=$MY_VERSION
```

環境変数はdockerのイメージ内で利用できます。



## EXPOSE

**コンテナが指定された一つ以上のポートをlistenするプロセスを持つことをDockerに示します。**
この情報は、コンテナをリンクするときにDockerによって使用されます

EXPOSE命令は以下のように書きます。

```sh
EXPOSE <port> [<port>/<protocol>...]
```

厳密にいうと、EXPOSE命令自体は、ネットワークに影響を与えません。
Dockerコンテナからホストシステムにアクセスするためには、`docker run`時に`-p`オプションを使用してポートのマッピングを定義する必要があります。

以下のように書くことで、Dockerコンテナのポート80をホストシステムのポート8080にマッピングすることができます。

```sh
docker run -p 8080:80 my-image
```

`EXPOSE`命令は、Dockerコンテナが使用するポートを定義するための基本的な方法を提供しますが、実際にホストシステムとの通信を確立するためには、-pオプションを使用してポートのマッピングを定義する必要があります。




# 起動時の挙動をコントロールするコマンド

## dockerfileのCMD:コンテナ起動時のコマンドを設定する

**コンテナの起動時に指定された命令を実行します。**
*`RUN`コマンドはビルド時に命令が実行されますが、`CMD`はコンテナの起動時であることに注意してください*

例えば、`docker run -it -p 80:80 -v ./code:/code flask`でflaskサーバーを起動したい場合、

```Dockerfile

# install python lib 
RUN pip install -r requirements.txt

# flaskサーバーを起動する
CMD ["python", "index.py"]
```

のように、pythonでindex.pyを実行してくれるように設定することができます。

**その性質上、`Dockerfile`の末尾に書かれることが多いです。**

### CMDの注意点

CMDにはいくつか注意点があります。

- まず、ENTRYPOINTに定義されている場合、命令はENTRYへの引数として解釈されます。
- また、CMD命令はイメージ名の後に実行されるdockerへの引数によってオーバーライドされます。
CMD命令は重複されることはない特徴があり、以前のCMD命令はすべてオーバーライドされます（ベースイメージのものを含む）。



## dockerのENTRYPOINT

コンテナの起動時に実行される実行可能ファイル（およびデフォルトの引数）を設定します。

イメージ名の後に実行されるdockerへのCMD命令または引数は、パラメータとして実行可能ファイルに渡されます。 

ENTRYPOINT命令は、多くの場合、「スターター」スクリプトを提供する想定で盛り込まれた機能です。



# あまり使わないコマンド

## dockerfileのADD:あまり使われない

ビルドコンテキストまたはリモートURLからイメージにファイルをコピーします。アーカイブの場合
ファイルはローカルパスから追加され、自動的に解凍されます。

**ADDの対象となる機能は非常に大きいため、通常はよりシンプルな以下のものを選択するのが最適です。**

- ビルドコンテキストでファイルとディレクトリをコピーして実行するためのCOPYコマンド

- リモートリソースをダウンロードするためのcurlまたはwgetを使用した手順（同じ命令でダウンロードを処理および削除する可能性を考慮してます。）


## dockerのMAINTAINER(dockerで廃止された命令)

dockerイメージの「作成者」メタデータを指定された文字列に設定します。


## dockerのONBUILD

dockerイメージをベースとして使用するときに後で実行する命令を指定して別のイメージにレイヤーします。

これは、追加されるデータの処理に役立ちます。





## 備考


title:dockerfileで使えるコマンド一覧【docker入門】

description:dockerfileのADDはビルドコンテキストまたはリモートURLからイメージにファイルをコピーします。アーカイブの場合
ファイルはローカルパスから追加され、自動的に解凍されます。

img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-776-8.jpeg

category_script:True


