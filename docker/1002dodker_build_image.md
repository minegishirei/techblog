


## 目的はdockerイメージを作る過程を保存すること

前回まではdockerコンテナを立てて、手動で開発環境を整えました。

ただし、いくつかの問題があります。

- 何かを変更する必要がある場合は、その時点から手動で手順を繰り返す必要があります。



- さらに重要なのは、簡単に再現することはできません。共有したり繰り返したりすることは難しく、エラーが発生しやすい可能性があります。

これに対する解決策は、**イメージを作成するために必要な一連の手順をコードとして保管指定置くこと**

Dockerfileを使用してイメージの自動ビルドを作成します。



## Dockerfileを使ってデプロイを自動化する

この例では、新しいフォルダとファイルを作成することから始めます。

Dockerfileは、作成に使用できる一連の手順を含む単なるテキストファイルです。


<pre><code>
$ mkdir cowsay
$ cd cowsay
$ touch Dockerfile
</code></pre>

ここでは

1. cowsayディレクトリを作り

2. そのなかにDockerfileという名前のファイルを作ります。

ここで大事なのは「Dockerfile」というキーワードです。

**dockerでは特にファイル名を指定しない限りDockerfileという名前のファイルをdockerイメージファイルとして扱います**

その次に、Dockerfileを以下のように記述してください。

<pre><code>
FROM debian:wheezy
RUN apt-get update && apt-get install -y cowsay fortune
</code></pre>

少しDockerfileを解説します。


- FROM命令は、使用するベースイメージを指定します（以前と同様にDebianですが、今回は「wheezy」とタグ付けされたバージョンを使用するように指定しました）。
すべてのdockerfileには、最初の命令としてFROM命令が必要です。

- その後、イメージ内で実行するシェルコマンドを指定します。
この場合、私たちはただインストールしています。以前と同じように、cowsayとfortuneを鳴らします。

次に docker buildコマンドを使って実際にコンテナをデプロイしましょう。

<pre><code>
$ ls
Dockerfile
$ docker build -t test/cowsay-dockerfile .
Sending build context to Docker daemon 2.048 kB
Step 0 : FROM debian:wheezy
 ---> f6fab3b798be
Step 1 : RUN apt-get update && apt-get install -y cowsay fortune
 ---> Running in 29c7bd4b0adc
...
Setting up cowsay (3.03+dfsg1-4) ...
 ---> dd66dc5a99bd
Removing intermediate container 29c7bd4b0adc
Successfully built dd66dc5a99bd
</code></pre>

ここまできたらdockerコンテナがデプロイできています。

最後に次のコマンドを打ってみましょう。

<pre><code>
docker run test/cowsay-dockerfile /usr/games/cowsay "Moo"
</code></pre>

牛のアスキーアートが出てきたら成功です。

Dockerfileに記述を行い、一つのコマンドでデプロイ、一つのコマンドで実行という流れがありました。

**ここまでで「コンテナをデプロイするまでの一連の流れをDockerfileに記述する」ということが理解できたと思います。**


## Dockerファイルの綺麗な書き方

しかし、実際には、ユーザーが利用することで、物事を少し簡単にすることができます。

次の命令をDockerfileに記述しましょう。

<pre><code>
FROM debian
RUN apt-get update && apt-get install -y cowsay fortune
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

</code></pre>


- ENTRYPOINT Dockerfile命令の一つで、ENTRYPOINT命令では
docker runに渡される引数を処理するために使用される実行可能ファイルを指定できます。

- COPY命令は、ファイルをホストからイメージのfilesystemにコピーするだけです。最初の引数はホスト上のファイルで、2番目の引数は宛先パスです。cpコマンドと非常によく似ています。



また、新しく「entrypoint.sh」を作成し、実行権限を指定します。

<pre><code>
#!/bin/bash
if [ $# -eq 0 ]; then
    /usr/games/fortune | /usr/games/cowsay
else
    /usr/games/cowsay "$@"
fi
</code></pre>

権限付与のためのコマンドは以下の通りです。

<pre><code>
chmod +x entrypoint.sh.
</code></pre>

ここまでできたら、次のようにコマンドを実行しましょう。

<pre><code>
$ docker build -t test/cowsay-dockerfile .
...snip...
$ docker run test/cowsay-dockerfile
$ docker run test/cowsay-dockerfile Hello Moo
</code></pre>

ここでは**引数がある場合とない場合で挙動が変わるはずです**

ここの挙動の変化は「entrypoint.shで指定されているのです」




## 備考

title:すぐにわかる！dockerによるコンテナデプロイ【docker入門】

description:Dockerでイメージを作成するために必要な一連の手順をコードとして保管指定置くことで、環境構築の再現性が可能になります。

img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-776-8.jpeg

category_script:True




