



## コンテナ間のデータの共有

一般的な方法は、データコンテナ（唯一の目的が他のコンテナ間でデータを共有すること)を利用する方法です。

このアプローチの主な利点は、--volumes fromコマンドを使用して簡単にロードできるボリュームの便利な名前空間を提供します。

たとえば、次のコマンドを使用してPostgreSQLデータベースのデータコンテナを作成できます。

<pre><code>
docker run --name dbdata postgres echo "Data-only container for postgres"
</code></pre>

これにより、echoコマンドを実行して終了する前にpostgresイメージからコンテナが作成され、ボリュームが初期化されます。

データコンテナを実行したままにしておく必要はないです。それはリソースの浪費に繋がります。


- データコンテナの利用方法

次に、他のコンテナのこのボリュームを--volumes-from引数で使用できます。


<pre><code>
docker run -d --volumes-from dbdata --name db1 postgres

</code></pre>


## コンテナが削除されるタイミング

dockerコンテナは次のいずれかのタイミングで削除されます。

- dockerコンテナが意図的に削除された場合(docker rm -v)

- docker run --rmが意図的につけられた場合



## 備考

title:dockerのコンテナ間でデータ共有する方法【docker入門】

description:dockerのコンテナ間でのデータ共有について、今回はデータコンテナを使用したデータの共有方法をお伝えします。


img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-776-8.jpeg

category_script:True

