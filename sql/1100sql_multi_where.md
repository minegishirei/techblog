

# すぐ分かる！SQL where句の複数条件指定。


## andを用いてより厳しい条件をつける

andを重ねていくことでselectの実行結果は絞られていきます。

例えば次のクエリであれば、「誕生日が1998年1月14日以降の人」
という条件ですが、

<pre><code>
select
    e.salary,
    e.name
from
    employee e
where
    e.birth > '1998-01-14'

</code></pre>

この条件に「住所が東京の人」という条件を付け加えたければ次のようにandを付け加えて条件を書き込みます


<pre><code>
select
    e.salary,
    e.name
from
    employee e
where
    e.birth > '1998-01-14'
and e.location = '東京'     --追加されたコード
</code></pre>


## 1=1を追加している訳

他の方のプログラムを呼んでいくと次のようなプログラムに出会うことがあります。

<pre><code>
select
    e.salary,
    e.name
from
    employee e
where 1=1 --?????
and e.birth > '1998-01-14'
and e.location = '東京'
</code></pre>

このコードのメリットはandの条件をつけたり消したりが楽に行えることです。

例えば先のコードで「 e.birth > '1998-01-14'」という条件が邪魔だと感じた時、

安易にコメントアウトするとエラーが発生します。

<pre><code>
select
    e.salary,
    e.name
from
    employee e
where 
    -- e.birth > '1998-01-14' --コメントは無視されるのでwhereの後にいきなりandがきてしまう
and e.location = '東京'
</code></pre>

ですがあらかじめ、whereくの後に「1=1」を追加しておくと

<pre><code>
select
    e.salary,
    e.name
from
    employee e
where 1=1 --?????
--and e.birth > '1998-01-14' --1=1の後にandがくるためエラーにならない
and e.location = '東京'
</code></pre>

確実に 「1=1」の後にandがくるためエラーになりません。

条件をつけたり消したりをするときに1=1はとても便利なのです。











## 備考

title:すぐ分かる！where句の複数条件追加方法【SQL】

category_script:page_name.startswith("1")

img:https://images-na.ssl-images-amazon.com/images/I/51NUVWMKzhL._SX258_BO1,204,203,200_.jpg

