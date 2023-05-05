


docker runに加えて、次のdockerコマンドを使用して、ライフサイクル中にコンテナーを管理します。


## コンテナ内のプロセス表示

attachコマンドを使用すると、ユーザーはコンテナー内のメインプロセスを表示または操作できます。

例えば：

<pre><code>
docker attach [OPTIONS] CONTAINER
</code></pre>

<pre><code>
$ ID=$(docker run -d debian sh -c "while true; do echo 'tick'; sleep 1; done;") $ docker attach $ID
tick
tick
tick tick
</code></pre>

Ctrl+Cでattachコマンドを終了するときに、内部のプロセスも同時に終了してしまうことに気をつけてください。

## docker createでコンテナ生成

イメージからコンテナを作成しますが、**開始しません**。 

dockerrunと同じ引数のほとんどを取ります。

また、コンテナーを開始するには、dockerstartを使用します。

## docker cpでファイルコピーする

コンテナとホストの間でファイルとディレクトリをコピーします。

## docker execでコマンドを実行する

コンテナ内でコマンドを実行します。

メンテナンスタスクを実行するために、またはコンテナにログインするためのsshの代わりとして使用できます。

<pre><code>
$ ID=$(docker run -d debian sh -c "while true; do sleep 1; done;") $ docker exec $ID echo "Hello"
Hello
$ docker exec -it $ID /bin/bash
    root@5c6c32041d68:/# ls
    bin   dev  home  lib64  mnt  proc  run   selinux  sys  usr
    boot  etc  lib   media  opt  root  sbin  srv    tmp  var
    root@5c6c32041d68:/# exit
    exit
</code></pre>


## docker killでコンテナのプロセスを止める

コンテナ内のメインプロセス（PID 1）にシグナルを送信します。

デフォルトでは、SIGKILLを送信します。
これにより、コンテナはすぐに終了します。

または、-s引数を使用してシグナルを指定することもできます。

引数ではコンテナIDが返されます。

<pre><code>
$ ID=$(docker run -d debian bash -c \
"trap 'echo caught' SIGTRAP; while true; do sleep 1; done;")
$ docker kill -s SIGTRAP $ID e33da73c275b56e734a4bbbefc0b41f6ba84967d09ba08314edd860ebd2da86c $ docker logs $ID
caught
$ docker kill $ID e33da73c275b56e734a4bbbefc0b41f6ba84967d09ba08314edd860ebd2da86c

</code></pre>

ただしこの方法ではプロセスは完全に途絶えてしまいます。

一時的に止めたいのであれば次のdocker pauseコマンドをお勧めします。


## docker pauseコマンドでコンテナを一時停止する

指定されたコンテナ内のすべてのプロセスを一時停止します。

プロセスは、中断されているというシグナルを受信しないため、シャットダウンまたはクリーンアップできません。 

Dockerを一時停止解除して、プロセスを再開できます。 

docker pauseは、Linux cgroupsフリーザー機能を内部的に使用します。

このコマンドは、プロセスを停止し、プロセスが監視できるシグナルを送信するdockerstopとは対照的です。


## docker unpauseコマンドでコンテナ再起動

以前にdocker pauseで一時停止したコンテナを再起動します。


## docker restartコマンドでコンテナを再起動する

1つ以上のコンテナを再起動します。

コンテナでdockerstopを呼び出し、続いてdockerstartを呼び出すのとほぼ同じです。

コンテナーがSIGTERMで強制終了される前に、コンテナーがシャットダウンするのを待機する時間を指定するオプションの引数-tを取ります。


## docker rmコマンドでコンテナ削除

1つ以上のコンテナーを削除します。

正常に削除されたコンテナの名前またはIDを返します。

デフォルトでは、**dockerrmはボリュームを削除しません。**

-f引数を使用して実行中のコンテナーを削除できます。

-v引数を使用すると、コンテナーによって作成されたボリュームが削除されます（ただし、バインドマウントされていないか、別のコンテナーで使用されていない場合）。

## dockerでコンテナボリューム一括削除

次のコマンドを実行してみてください。

<pre><code>
$ docker rm $(docker ps -aq) b7a4e94253b3
</code></pre>

すると次のような結果が得られるはずです。

<pre><code>
$ docker rm $(docker ps -aq)
b7a4e94253b3
e33da73c275b
f47074b60757
</code></pre>

## dockerでコンテナを起動する方法

停止したコンテナー（または複数のコンテナー）を開始します。

主に次のような意図で使用されます。

- 終了したコンテナーを再始動するため、

- docker createで作成されたが起動されなかったコンテナーを開始するために使用できます。


## dockerでコンテナをストップする方法

コンテナでは、「終了」状態に移行します。

オプションの引数-tを取ることができます。

これは、コンテナーがSIGTERMで強制終了される前にコンテナーがシャットダウンするのを待機する時間を指定します。



title:dockerでコンテナのライフサイクル管理【docker入門】

description:docker-runに加えて、次のdockerコマンドを使用して、dockerのライフサイクル中にコンテナーを管理します。



