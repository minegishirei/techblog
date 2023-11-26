


## この記事について

この記事は7ステップでReact+Dockercomposeの開発環境の構築の完了を目指します。
10分もかからない見積もりです。

最終的には以下の画面が現れることを目標としています。

<img src="https://i.stack.imgur.com/PXvBv.png">

よろしくお願いします。


## No1 Docker Enginをインストールする

<a href="https://docs.docker.com/get-docker/">こちらのサイト</a>
からDocker Enginをインストールを実施してください。

よろしくお願いします。

(Docker Composeのインストールは不要です。Docker Enginをインストールした際にすでに含まれています。)

## No2 今回のプロジェクトフォルダーを作る

名前はなんでもいいですが、今回は「react_test」にします。

よろしくお願いします。

## No3 Docker composeファイルを作成する

作ったフォルダー配下に「docker-compose.yml」ファイルを配置し、以下の内容をコピペしてください。

<pre><code>
version: '3.9'

services:
  node:
    build: ./react
    volumes:
      - ./react:/usr/src/app:cached
    command: sh -c "cd react-sample && yarn start"
    ports:
      - "3000:3000"
</code></pre>

よろしくお願いします。

## No4 reactフォルダーを作る

よろしくお願いします。

## No5 reactフォルダー配下にDockerfileを作る

作ったDockerfileには以下の内容をコピペしてください


<pre><code>
FROM node:16-alpine
WORKDIR /usr/src/app

#docker-compose run --rm node sh -c "npm install -g create-react-app && create-react-app react-sample"
</code></pre>

よろしくお願いします。

## No6 コマンド実行

No2で作ったフォルダー(今回はreact_test)にコマンドプロンプト/Powershell/terminalなんでもいいので移動してください。

そのフォルダー配下(今回はreact_test)で以下のコマンドを実行してください。

よろしくお願いします。

<pre><code>
docker-compose run --rm node sh -c "npm install -g create-react-app && create-react-app react-sample"
</code></pre>

そうすると新しく「react-sample」という名前のフォルダーが「react」配下に作られます


## No7 サーバースタート

次のコマンドでサーバースタートです。

<pre><code>
docker-compose up
</code></pre>

立ち上がったサーバーには次のURLで接続できます。

http://localhost:3000/index.html

目標としていた画面が出力されれば成功です（一回目の接続には30~1分ほどかかります）

<img src="https://i.stack.imgur.com/PXvBv.png">

## 次回

今回作成したプロジェクトをいじりながらReactについて学んでいきます。

<a href="./2102react_filesystem.md">
Reactのファイル構造について解説【React学習サイト】
</a>






## 備考

title:React+DockerComposeで環境構築【10分で完了】

description:この記事は7ステップでReact+Dockercomposeの開発環境の構築の完了を目指します。10分もかからない見積もりです。

img:https://i.stack.imgur.com/PXvBv.png

category_script:page_name.startswith("21")


