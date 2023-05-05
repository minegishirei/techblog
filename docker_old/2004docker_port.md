


## dockerでwebサーバーを立てる

コンテナ内でウェブサーバーを実行しているとします。どのように外部にサービスを提供するのでしょうか？

答えは、**-pまたは-Pコマンドを使用してポートを「公開」すること**です。

-pがついたrunコマンドは、ホスト上のポートをコンテナに転送します。


## dockerのnginxでwebサーバーを立てる

例えば

<pre><code>
docker run -d -p 8000:80 nginx

</code></pre>

と実行したとします。

ここでこのコマンドについて少し解説します。

- -pはホスト側の8000番のポートに80番のポートを結びつけます。

- -dはバックグラウンドでの実行を意味します。

実行すると以下のように一意のIDが返却されます。

<pre><code>
$ docker run -d -p 8000:80 nginx
af9038e18360002ef3f3658f16094dadd4928c4b3e88e347c9a746b131db5444
</code></pre>

実際にアクセスしてみましょう。

<pre><code>
$ curl localhost:8000

</code></pre>

ここで、htmlのソースコードが表示されれば成功です。




## dockerrunにより空いているポートを自動で取得する

-p 8000：80引数は、ホストのポート8000​​をポートに転送するようにDockerに指示しました。

コンテナ内の80にです。

または、-P引数を使用して、Dockerにホスト側の空いているポートを自動で指定するように指示することもできます。

例えば以下のように。

<pre><code>
$ ID=$(docker run -d -P nginx)
$ docker port $ID 80
0.0.0.0:32771
$ curl localhost:32771
(...htmlのソースコード...)
</code></pre>

-Pコマンドの主な利点は、開発者側に責任がなくなることです。

docker portコマンドでは$IDに割り当てられたポートを追跡します。

これは、複数の接続がある場合に重要になります。




## 備考

title:docker run -pによるポート開放について【docker入門】

description:-p 8000：80引数は、ホストのポート8000​​をポートに転送するようにDockerに指示しました。また、-P引数を使用して、Dockerにホスト側の空いているポートを自動で指定するように指示することもできます。

img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-776-8.jpeg

category_script:True


