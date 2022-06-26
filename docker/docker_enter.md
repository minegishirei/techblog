


## docker学習サイト

この章では、Dockerを使用する最初の手順について説明します。

まずはDockerがどのように機能するかを理解するために、いくつかの単純なコンテナーを起動して使用します。

次に、Dockerfiles（Dockerコンテナーの基本的な構成要素）と
コンテナの配布をサポートするDockerレジストリ。

最後にコンテナを使用して、永続ストレージを備えたKey-Valueストアを展開する方法を学びます

## 参考図書

以下のリンクを参考にしました。

https://pepa.holla.cz/wp-content/uploads/2016/10/Using-Docker.pdf

<img src="https://www.oreilly.co.jp/books/images/picture_large978-4-87311-776-8.jpeg">


## dockerのhello world

dockerのhello worldは簡単です。

<pre><code>
docker run debian echo "Hello World"

</code></pre>

このコマンドを実行した後、環境によって多少は違えど以下のようなログが出現するはずです。


<pre><code>
Unable to find image 'debian' locally
debian:latest: The image you are pulling has been verified
511136ea3c5a: Pull complete
638fd9704285: Pull complete
61f7f4f722fb: Pull complete
Status: Downloaded newer image for debian:latest
Hello World
</code></pre>

何はともあれ、最後の**Hello World**が出現すれば成功です


## dockerのhello worldの解説

では、ここで何が起こったのでしょうか。

hello worldと応答する**docker runコマンド**を呼び出しました。

引数debianはDebian Linuxディストリビューションの簡略版です。

1. 出力の最初の行は、Debianイメージのローカルコピーがないことを示しています。(イメージが何かはここではあまり気にしないでください。コンテナを作るための設計書みたいなものでいいです。)

2. 次に、Docker Hubでオンラインで確認し、最新バージョンのDebianイメージをダウンロードしてきます。

3. イメージがダウンロードされると、Dockerはイメージをコンテナを実行し、指定したコマンドを実行します

<pre><code>
—エコー "Hello World" —
</code></pre>

4. このコマンドを実行した結果は、出力の最後の行に表示されます。

5. また同じコマンドを再度実行すると、すぐにコンテナが起動します。
ダウンロードとコマンドの実行には約1秒かかるはずです。

発生した作業の量を考えるとこの短時間での作業は驚くべきことです。

Dockerには**コンテナを起動して起動し、echoコマンドを実行してから、シャットダウンしました--**

あなたが伝統的な方法で同じようなことをしようとした場合
-つまりVMやVirtual Boxの場合、数秒、場合によっては数分待つことになります。


## dockerのlinuxのなかに入る

あなたは先ほど実行したコンテナの中に入ることができます。

以下のコマンドを実行してみてください

<pre><code>
docker run -i -t debian /bin/bash
</code></pre>

以下のような対話形式のターミナルが出現すれば成功です。

<pre><code>
$ docker run -i -t debian /bin/bash
root@622ac5689680:/# echo "Hello from Container-land!"
Hello from Container-land!
root@622ac5689680:/# exit
exit
</code></pre>


これにより、コンテナ内に新しいコマンドプロンプトが表示されます。

この場合、フラグ-iと-tはDockerにあたかもリモートマシンにSSH接続するようにと伝えてます。

- -tはttyが接続されたインタラクティブセッション。

- コマンド/bin/bashはbashを提供します

シェルを終了すると、コンテナは停止します。コンテナは、dockerの主なプロセスなのです。


## dockerで遊んでみる

コンテナを起動して何を確認するかで、Dockerをもう少し理解してみましょう。

さまざまなコマンドやアクションが持つ効果。まず、新しいコンテナを起動しましょう。しかし今回は、時間の経過とともに、-hフラグを使用して新しいホスト名を指定します

<pre><code>
docker run -h CONTAINER -i -t debian /bin/bash

</code></pre>

**ここでもしあなたがコマンドをぶっ壊したらどうなってしまうのでしょう...?**

mvコマンドを使用してbin配下を消してしまいます。

<pre><code>
> docker run -h CONTAINER -i -t debian /bin/bash
root@CONTAINER:/# mv /bin /basket
root@CONTAINER:/# ls
bash: ls: command not found
</code></pre>

/binディレクトリを削除し、コンテナをかなり役に立たないものにしました。


このコンテナを削除する前に、新しいターミナルを開いて、dockerの

ps、inspect、diff

を見てみましょう。

これらのコマンドはコンテナの状態について教えてくれます。


## docker psコマンドについて

新しいターミナルを開きます（コンテナセッションは実行したままにします
）

ホストから「docker ps」を実行してみてください。すると次のようなものが表示されます。


<pre><code>
CONTAINER ID IMAGE COMMAND ... NAMES
00723499fdbf debian "/bin/bash" ... stupefied_turing
</code></pre>

これにより、現在実行中のすべてのコンテナーに関するいくつかの詳細がわかります。

出力のほとんどは一目瞭然ですが、名前がstupefied_turingとなっていることに注目して、覚えておいてください。次のコマンドを実行するのに必要です。


## docker inspectコマンドについて

dockerの「inspect」コマンドはコンテナの状態についてより詳しい情報をjson形式で教えてくれます

<pre><code>
docker inspect stupefied_turing
[
    {
        "Id": "00723499fdbfe55c14565dc53d61452519deac72e18a8a6fd7b371ccb75f1d91",
        "Created": "2015-09-14T09:47:20.2064793Z",
        "Path": "/bin/bash",
        "Args": [],
        "State": {
            "Running": true,
</code></pre>


## docker diffコマンドについて

docker diffコマンドは**実行中のコンテナで変更されたファイルのリスト**です。

次のコマンドを実行してみてください。

<pre><code>
$ docker diff stupefied_turing
C /.wh..wh.plnk
A /.wh..wh.plnk/101.715484
D /bin
A /basket
A /basket/bash
A /basket/cat
A /basket/chacl
A /basket/chgrp
</code></pre>



この場合、

- /binの削除
- /basket内のすべての追加、
- およびストレージドライバに関連するいくつかのファイルの作成。 

を確認できるのです。


## docker logsの見方

dockerコンテナのログを見たければ docker logsと入力すれば良いです

<pre><code>
$ docker logs stupefied_turing
root@CONTRAINER:/# mv /bin /basket
root@CONTRAINER:/# ls
bash: ls: command not found
</code></pre>


## dockerコンテナの脱出方法

dockerコンテナから出る時はexitコマンドを実行しましょう。

これはちょうどsshコマンドでログインしていた状態を抜けるのと同じです。

<pre><code>
root@CONTRAINER:/# exit
exit
$
</code></pre>

シェルが唯一の実行中のプロセスであったため、これによりコンテナも停止します。
もし、あなたがdocker psを実行すると、実行中のコンテナーがないことがわかります。

## dockerコンテナの削除

ただし、これですべてがわかるわけではありません。 

docker ps -aと入力すると、停止したコンテナー（正式には終了コンテナーと呼ばれます）を含むすべてのコンテナーのリストが表示されます。

終了したコンテナは、docker startを発行することで再起動できます（ただし、このコンテナ内のパスを削除してしまったため、この場合、開始することはできません）。

コンテナを削除する場合は、dockerrmコマンドを使用します。

<pre><code>
$ docker rm stupefied_turing
stupefied_turing
</code></pre>


## 備考

title:5分でわかるDockerの使い方を学ぶ【docker入門】

description:Dockerを使用する最初の手順について説明します。まずはDockerがどのように機能するかを理解するために、いくつかの単純なコンテナーを起動して使用します。次に、Dockerfiles（Dockerコンテナーの基本的な構成要素）とコンテナの配布をサポートするDockerレジストリ。最後にコンテナを使用して、永続ストレージを備えたKey-Valueストアを展開する方法を学びます。

img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-776-8.jpeg

