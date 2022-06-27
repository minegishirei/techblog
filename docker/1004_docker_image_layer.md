


## dockerfileとレイヤーの仕組み

Dockerfileを使用してdockerイメージを作り上げる場合、一行ごとに新しいイメージレイヤーが作成されます。

![picture 7](../images/ebeddb9a4bc04a47363ab2b3b75ed3eb384a8c925468bd7680bcf96f9b4e934e.png)  

出典：https://qiita.com/zembutsu/items/24558f9d0d254e33088f

新しいレイヤーは、前のdockerイメージを使用してコンテナを起動することによって作成されます。

この時に注意点が二つあります

- 最新のレイヤーでビルドが成功する時以外は中間のレイヤーは保存されず削除されます。

- 命令のアクセスは停止されます。つまり、データベースやSSHデーモンなどの長期的なプロセスをRUN命令で開始することはできますが、開始することはできません。


## dockerのhistoryコマンドとは？

それでは早速dockerイメージを構成するレイヤーを見てみましょう。

次のDockerコマンドを実行すると、dockerイメージを構成するレイヤーの完全なセットを確認できます。

<pre><code>
docker history mongo:latest
</code></pre>

次の例は2018年時点でのmongoDBのdockerイメージレイヤーの一覧です

<pre><code>
$ docker history mongo:latest
IMAGE CREATED CREATED BY ...
278372cb22b2 4 days ago /bin/sh -c #(nop) CMD ["mongod"]
341d04fd3d27 4 days ago /bin/sh -c #(nop) EXPOSE 27017/tcp
ebd34b5e9c37 4 days ago /bin/sh -c #(nop) ENTRYPOINT &{["/entrypoint.
f3b2b8cf226c 4 days ago /bin/sh -c #(nop) COPY file:ef2883b33ed7ba0cc
ba53e9f50f18 4 days ago /bin/sh -c #(nop) VOLUME [/data/db]
c537910de5cc 4 days ago /bin/sh -c mkdir -p /data/db && chown -R mong
f48ad436057a 4 days ago /bin/sh -c set -x
df59596772ab 4 days ago /bin/sh -c echo "deb http://repo.mongodb.org/
96de83c82d4b 4 days ago /bin/sh -c #(nop) ENV MONGO_VERSION=3.0.6
0dab801053d9 4 days ago /bin/sh -c #(nop) ENV MONGO_MAJOR=3.0
5e7b428dddf7 4 days ago /bin/sh -c apt-key adv --keyserver ha.pool.sk
e81ad85ddfce 4 days ago /bin/sh -c curl -o /usr/local/bin/gosu -SL "h
7328803ca452 4 days ago /bin/sh -c gpg --keyserver ha.pool.sks-keyser
ec5be38a3c65 4 days ago /bin/sh -c apt-get update
430e6598f55b 4 days ago /bin/sh -c groupadd -r mongodb && useradd -r
19de96c112fc 6 days ago /bin/sh -c #(nop) CMD ["/bin/bash"]
ba249489d0b6 6 days ago /bin/sh -c #(nop) ADD file:b908886c97e2b96665
</code></pre>


## dockerのhistoryコマンドを使ったデバッグ

ビルドが失敗した場合、失敗する前にレイヤーを起動すると非常に便利です。

例えば、次のDockerfileを元にしてイメージを作成する場合

<pre><code>
FROM busybox:latest
RUN echo "This should work"
RUN /bin/bash -c echo "This won't"
</code></pre>

次のコマンドでdockerイメージを立ててみましょう。

するとある程度のエラーが出てくるはずです。

<pre><code>
$ docker build -t echotest .

</code></pre>

例えば以下のように。

<pre><code>
Sending build context to Docker daemon 2.048 kB
Step 0 : FROM busybox:latest
 ---> 4986bf8c1536
Step 1 : RUN echo "This should work"
 ---> Running in f63045cc086b                               --1.
This should work
 ---> 85b49a851fcc                          --2.
Removing intermediate container f63045cc086b --3.
Step 2 : RUN /bin/bash -c echo "This won't"
 ---> Running in e4b31d0550cd
/bin/sh: /bin/bash: not found
The command '/bin/sh -c /bin/bash -c echo "This won't"' returned a non-zero
code: 127
</code></pre>

少しログを解説すると

1. Dockerが起動した一時コンテナのID。

2. DockerイメージのID

3. 一時コンテナが削除されます。

この場合、問題はエラーからかなり明らかですが、イメージを実行してデバックすることができます。

命令をデバッグするために、最後に成功したレイヤーから調査を行います。

私たちがここで指し示しているのは、最後のコンテナのIDではなく、最後のdockerイメージID（85b49a851fcc）を使用しています

<pre><code>
$ docker run -it 7831e2ca1809
/ # /bin/bash -c "echo hmm"
/bin/sh: /bin/bash: not found
/ # /bin/sh -c "echo ahh!"
ahh!
/ #
</code></pre>

そして、問題はさらに明白になります。

busyboxのdockerイメージにはbashシェルは存在せず、shシェルのみしか存在しませんでした。


## docker historyのデバッグまとめ

このように、 dockerのイメージレイヤーを遡りそのコンテナを動かしてみることでデバッグはさらに容易になるのです。



## dockerのhistoryコマンドの使い方

title:dockerのhistoryコマンドの使い方【docker入門】

description:dockerのイメージレイヤーを遡りそのコンテナを動かしてみることでデバッグはさらに容易になります。

img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-776-8.jpeg

category_script:True


