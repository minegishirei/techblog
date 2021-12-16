
##  ORを用いて条件を緩くする


先の例では「誕生日が1998年1月14日以降の人」なおかつ「住所が東京の人」という条件で絞り込んでました。

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

では逆に

「誕生日が1998年1月14日以降の人」

または

「住所が東京の人」

と絞り込みを行いたいときはどのようにしてすればよろしいでしょうか。

答えは次のように、andではなくorを用いることです。

<pre><code>
select
    e.salary,
    e.name
from
    employee e
where
    e.birth > '1998-01-14'
or  e.location = '東京'     --追加されたコード
</code></pre>









## 備考

title:すぐ分かる！where句で条件を緩くする方法【SQL】

category_script:page_name.startswith("1")


img:https://images-na.ssl-images-amazon.com/images/I/51NUVWMKzhL._SX258_BO1,204,203,200_.jpg
