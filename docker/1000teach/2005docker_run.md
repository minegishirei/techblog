

## dockerのrunコマンド

**docker runコマンドは今のところdockerシステムの中で最も複雑なコマンドのうちの一つとなってます。**

docker runコマンドで引数を使用すると、ユーザーはイメージの実行方法を編集することができます。

次のオプションで、dockerコンテナのライフサイクルとその基本モードをコントロールできます。


## docker -a --attachとは

指定されたストリーム（STDOUTなど）を端末に接続します。

- 指定しない場合は、両方(stdoutとstderr)が付属しています。

- 指定されていない状態でコンテナが起動で開始された場合、インタラクティブモード（-i）、stdinも付属しています。

-dと互換性はありません


## docker -d --detachとは

コンテナを「デタッチ」モードで実行します。

例えばawsのec2にsshで入った後、webサーバーをバックグラウンドプロセスとして動かし続けたい場合に有用です。

コマンドはでコンテナを実行し、コンソールにはコンテナIDを返します。

<pre><code>
$ docker run -d nginx /bin/bash
root@bd0f26f928bb:/# ls
...snip...

</code></pre>


## docker -i --interactive

stdinを開いたままにします（接続されていない場合でも）。

通常は-tとともに使用して開始します。

インタラクティブなコンテナセッションを起動させることが可能です。

例えば：

<pre><code>
$ docker run -it debian /bin/bash
root@bd0f26f928bb:/# ls
...snip...
</code></pre>




## docker --restart

Dockerが終了したコンテナーを再起動しようとするタイミングを構成します。

--restartコマンドはさらに引数をとるコマンドです。

- 引数を指定しない場合、dockerコンテナの終了ステータスに関係なく、再起動します。 

- 「--restart on-failure」引数は再起動を試みますが、コンテナがゼロ以外のステータスで終了し、オプションの引数を取ることができる状態でのみ再起動します。

たとえば、

<pre><code>
docker run --restart onfailure：10 postgres

</code></pre>

はpostgresコンテナを起動し、再起動を試みます。

ゼロ以外のコードで終了する場合は10回まで再起動します。


## docker --rm

コンテナが終了すると、コンテナを自動的に削除します。 

注意！：-dと一緒に使用することはできません。


## docker -t --tty

疑似TTYを割り当てます。(ターミナルとして起動可能であること)

通常、-iとともに使用して、対話型コンテナーを開始します。


# 次のオプションを使用すると、コンテナ名と変数を設定できます。

## docker -e, --env

コンテナ内に環境変数を設定します。

設定の方法は

<pre><code>
$ docker run -e 変数名=変数値 ... 

</code></pre>


例えば：

<pre><code>
$ docker run -e var1=val -e var2="val 2" debian env
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=b15f833d65d8
var1=val
var2=val 2
HOME=/root

</code></pre>

また、ファイルを介して変数を渡すための--env-fileオプションも覚えておいてください。



## docker -h, --hostname

コンテナに名前をつけます。

例えば：

<pre><code>
$ docker run -h "myhost" debian hostname
myhost
</code></pre>


## docker -n --name

名前をコンテナに割り当てます。

その後、名前を使用してアドレス指定できます。

他のDockerコマンドのコンテナ。


# 次のオプションを使用すると、ユーザーはボリュームを設定できます

## docker -v --volume

ボリューム（ファイルまたはディレクトリ）を設定するための引数には2つの形式があります。



- 最初の形式は、コンテナ内のディレクトリのみを指定する形式であり、Dockerが選択したホストディレクトリにバインドします。 

- 2番目の形式はバインドするホストディレクトリもコンテナ内のディレクトリも両方指定します。


## docker --expose

DockerfileでのEXPOSE命令に相当します。

コンテナで使用されているポートまたはポート範囲を識別しますが、実際にはポートを開きません。 

オプションの-Pと関連付けて、コンテナをリンクする場合にのみ実際に意味があります。


## docker --link

指定されたコンテナへのプライベートネットワークインターフェイスを設定します。

詳細については、「コンテナのリンク」を参照してください。


## docker -p --publish

コンテナのポートを「公開」し、ホストからアクセスできるようにします。

ホストポートが定義されていない場合は、ランダムに番号の大きいポートが選択されますが、これは無効にすることができます。

## docker -P --publish-all

コンテナで公開されている**すべてのポート**をホストに公開します。

公開されているポートごとに、ランダムな番号の大きいポートが選択されます。

docker portコマンドを使用して、マッピングを確認できます。


## まとめ

これ以外でも、より高度なネットワーキングを行う必要がある場合に役立つと思われるオプションがいくつかあります。

これらのオプションのいくつかでは、**ネットワークとそれがDockerでどのように実装されているかをある程度理解している必要がある**ことに注意してください。

また、docker runコマンドには、コンテナーの特権と機能を制御するための多数のオプションもあります。

次のオプションは、Dockerfile設定を直接オーバーライドします。

## docker --entrypoint

コンテナのエントリポイントを指定された引数に設定し、DockerfileのENTRYPOINT命令をオーバーライドします。

## docker -u --user

コマンドが実行されるユーザーを設定します。ユーザー名またはUIDとして指定できます。 

DockerfileのUSER命令をオーバーライドします。

## docker -w --workdir

コンテナ内の作業ディレクトリを指定されたパスに設定します。 Dockerfileの値をオーバーライドします。







## 備考

img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-776-8.jpeg

category_script:True

title:dockerのrunコマンドオプション一覧【docker入門】




