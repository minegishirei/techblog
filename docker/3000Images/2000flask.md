









## flask によるwebサーバーを Docker で環境構築する

目的：**本サイトではDockerによる環境構築方法を学びます。**

- やること：
    1. Dockerのインストール（事前準備推奨）
    2. Dockerfile作成（ソースコードをダウンロードでもいいが、手作業で書いた方が理解が進みます。）
    3. pythonコード作成
    4. `build`コマンドの実行と解説
    5. `run`コマンドの実行と解説
    6. flaskサーバーの動作確認

- やらないこと：
    1. Docker Enginについての詳しい解説
    2. pythonの詳しい解説

- 対象者：簡単なlinuxコマンドを扱えることを前提とします。

- 優先する内容：
    - スピード
    - 手を動かす
- 優先しない内容：
    - 講義
    - 理屈

本イベントでは参考書籍として、オライリー書籍出版のDocker入門を用いてます。


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



## Dockerのインストール

Dockerのインストールは以下のサイトを参考が参考になると思います。

- macでのDocker for desktopのインストール方法：https://minegishirei.hatenablog.com/entry/2023/05/04/124946



# DockerでのpythonによるHello world

## ソースコードを手っ取り早く取得したい人

以下のGithubからソースコードを取得してください。

Github:https://github.com/kawadasatoshi/PythonImages

または、gitコマンドでcloneしてもいいです。

```sh
git clone https://github.com/kawadasatoshi/PythonImages.git
```



### Dockerfileの作成

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



### codeディレクトリを作成し、ソースコードを配置

`code`という名前のディレクトリをDockerfileと同じ場所に作りましょう。

そして、この中にソースコードを入れていきます。

今回は`code`の中に`main.py`というpythonコードを作ります。

内容は以下のとおりです。

```python
from flask import Flask
app = Flask(__name__)

@app.route("/")
def index():
  return "<h1>Hello, Flask!</h1>"

if __name__ == "__main__":
  app.run(host="0.0.0.0", port=80, debug=True)
```

こちらのコードでは、htmlのh1タグで"hello Flask!"と出力するコードとなってます。


### requirements.txtも作成

次に、`requirements.txt`を作成します。

このファイルは、インストールするpythonのライブラリーを指定します。

実際にDockerfileを見ると、`RUN pip install -r requirements.txt`で`requirements.txt`を指定して、pythonのライブラリーをインストールしていることがわかると思います。


今回はPythonでWebサービスを作るために必要な`Flask`サービスを追記します。

```
Flask
```

## buildコマンド実行

ここまでできたら、buildコマンドでDockerfileからイメージファイルを作成します。

```sh
docker image build -t flask .
```

- `docker image build`では、dockerイメージをビルドし、コンテナを作成する基本的なコマンド

- `-t`フラグで、`flask`という名前をつけています。



## runコマンド実行し、Flaskサーバーを起動する

先ほど作成した、flaskイメージコンテナをrunします。

```sh
docker run -it -p 80:80 -v ./code:/code flask bash
```

- `docker run `は、dockerコンテナを実行するコマンドです。

- `-it`フラグは、**コンテナ内部とやりとりするためのコマンド**で、`bash`コマンドと組み合わせることで、ssh接続されたかのように、コンテナ内部からLinuxコマンドを実行することができます。

- `-p`フラグは、**ローカルPCのポート番号と、コンテナ内部のポート番号を繋げるためのコマンドです。**

コンテナに入った後は、`python main.py`を実行してサーバーを起動しましょう。


次のリンクからwebサイトに入れたら成功です。

http://localhost






