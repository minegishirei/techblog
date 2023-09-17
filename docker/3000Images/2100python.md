


# Docker を使用して python の環境構築する方法

Docker を使用して python の環境構築を行う方法を解説します。


- やること：
    1. Dockerのインストール（事前準備推奨）
    2. Dockerfile作成（ソースコードをダウンロードでもいいが、手作業で書いた方が理解が進みます。）
    3. pythonコード作成
    4. `build`コマンドの実行と解説
    5. `run`コマンドの実行と解説
    6. helloworldの確認



### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)
- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)



## 注意点

使用するPCはWindowsでもMacでもLinuxでも構いません

Docker for Desktopを使用しますので、事前にダウンロードをお願いいたします。

今回行うのは、ソースコードのcloneからpythonのhelloworldまで実施いたします。




## DockerでのpythonによるHello world

## ソースコードを手っ取り早く取得したい人

以下のGithubからソースコードを取得してください。

Github:https://github.com/kawadasatoshi/PythonImages

または、gitコマンドでcloneしてもいいです。

```sh
git clone https://github.com/kawadasatoshi/PythonImages.git
```





### Python Dockerfile の作成(5分)

まずは`Dockerfile`という名前でファイルを作成し、次のコードを入力しましょう。

```Dockerfile
# python version number:3.9.16
FROM python:3.9.16

# code ... directory for python codes.
WORKDIR /code

# copy localcode to container image.
COPY ./code /code

# upgrade pip command
RUN pip install --upgrade pip 

# install python lib 
RUN pip install -r requirements.txt
```


#### Dockerfileとは

Dockerfileとは

> Dockerイメージを作成するためのファイルです。

Dockerイメージとは

> Dockerコンテナの動作環境となるテンプレートファイルです。Dockerイメージには、OSやアプリケーションからアプリケーションの実行に使われるコマンド、メタデータまで含まれます。

つまり、**「DockerfileからDockerイメージが作られて、最終的にDockerコンテナという実態が作られる」** という構図になってます。

<img src="https://images.viblo.asia/0240e699-0175-4ccc-be70-89f6131fd5b7.png">

from https://www.kagoya.jp/howto/cloud/container/dockerimage/


これらの要素の違いにはいくつかポイントがある。

- `Dockerfile`：開発環境段階でいじられることが多い。

- `Docker Image`：直接内部をいじられることはあまりない。ただし、コンテナよりは容量が軽いことが多い。その性質から、本番環境、検証環境、ステージング環境を行き来する。

- `Docker Container`：実際に動く実態。

これらが、大雑把なDockerコンテナのライフサイクルです。


### Dockerfile の内容解説

- `FROM`：すでに存在するイメージファイルを取得し、それを元に新しくイメージファイルを作り出す。


```Dockerfile
FROM python:3.9.16
```

この場合は、「python:3.9.16」という名前のイメージファイルを取得し、その上に新しいイメージファイルを作り出していきます。


- `WORKDIR`：ファイルの作業場所を指定します。


```Dockerfile
WORKDIR /code
```

この場合は、`/code`ディレクトリを指定して作業場所を指定します。


- `COPY`：ローカルPCに存在するファイルをイメージ内部にコピーするコマンド

```Dockerfile
COPY ./code /code
```

- `RUN`：Linuxコマンドを実行します。

```Dockerfile
# upgrade pip command
RUN pip install --upgrade pip 

# install python lib 
RUN pip install -r requirements.txt
```

今回は`pip`ライブラリのアップデートと、`requirements.txt`に存在するライブラリをインストールを実行します。





### codeディレクトリを作成し、ソースコードを配置

`code`という名前のディレクトリをDockerfileと同じ場所に作りましょう。

そして、この中にソースコードを入れていきます。

今回は`code`の中に`main.py`というpythonコードを作ります。

内容は以下のとおりです。

```python
print("hello world")
```

こちらのコードは"hello world"と出力するだけのコードです。


### requirements.txtも作成

次に、`requirements.txt`を作成します。

このファイルは、インストールするpythonのライブラリーを指定します。

実際にDockerfileを見ると、`RUN pip install -r requirements.txt`で`requirements.txt`を指定して、pythonのライブラリーをインストールしていることがわかると思います。

中身はpythonで使用するライブラリを列挙します。

```
numpy
pandas
```


## docker buildコマンド実行

ここまでできたら、buildコマンドでDockerfileからイメージファイルを作成します。

```sh
docker image build -t pythonconsole .
```

- `docker image build`では、dockerイメージをビルドし、コンテナを作成する基本的なコマンド

- `-t`フラグで、`pythonconsole`という名前をつけています。



## docker runコマンド実行し、Hellowroldを出力する

先ほど作成した、pythonconsoleイメージコンテナをrunします。

```sh
docker run -it -v ./code:/code pythonconsole bash
```

- `docker run `は、dockerコンテナを実行するコマンドです。

- `-it`フラグは、**コンテナ内部とやりとりするためのコマンド**で、`bash`コマンドと組み合わせることで、ssh接続されたかのように、コンテナ内部からLinuxコマンドを実行することができます。







