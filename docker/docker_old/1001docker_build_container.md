




Dockerで作られるCowsayアプリケーションを作成します。

次のコマンドを入力してください。

対話形式のlinuxターミナルが出現するはずです。

<pre><code>
docker run -it --name cowsay --hostname cowsay debian bash

</code></pre>

その後は以下のようにコマンドを入力して行ってください。

<pre><code>
root@cowsay:/# apt-get update
...
Reading package lists... Done
root@cowsay:/# apt-get install -y cowsay fortune
...
root@cowsay:/#
</code></pre>


最後に以下のコマンドです。

<pre><code>
root@cowsay:/# /usr/games/fortune | /usr/games/cowsay
</code></pre>

牛のアスキーアートが出現したら成功です。



## dockerコンテナを作り、保存する

先程までの操作をイメージとして保存します。
docker commitコマンドを入力しまししょう。

コンテナが実行中か停止中かは関係ありませんが、
これを行うには、コマンドにコンテナの名前（「cowsay」）に名前を付ける必要があります


例えば、画像（「cowsayimage」）とそれを保存するリポジトリの名前（「test」）の場合：

<pre><code>
root@cowsay:/# exit
exit
$ docker commit cowsay test/cowsayimage
d1795abbc71e14db39d24628ab335c58b0b45458060d1973af7acf113a0ce61d
</code></pre>

戻り値は、dockerイメージの一意のIDです。

これで、「コマンドを入力すると牛が何かしらをしゃべるdockerイメージ」ができました。
実行できるインストール済みと言います。

<pre><code>
docker run test/cowsayimage /usr/games/cowsay "Moo"
</code></pre>


## dockerイメージを作る過程を保存する

これは素晴らしい！

ただし、いくつかの問題があります。

- 何かを変更する必要がある場合は、その時点から手動で手順を繰り返す必要があります。


- さらに重要なのは、簡単に再現することはできません。共有したり繰り返したりすることは難しく、エラーが発生しやすい可能性があります。

これに対する解決策は、**イメージを作成するために必要な一連の手順をコードとして保管指定置くこと**

次回は、Dockerfileを使用してイメージの自動ビルドを作成します。



## 備考

title:Dockerコンテナの保存方法【docker入門】





img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-776-8.jpeg

category_script:True


