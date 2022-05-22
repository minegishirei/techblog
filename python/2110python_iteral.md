



## pythonで最初と最後の配列の値が欲しい

今回はあなたの次のような希望に答える方法をお伝えします

- 最初と最後の配列の値が欲しい

- 配列からN個の要素を別々の変数に代入する必要がありますが、配列がN個の要素より長くなる可能性があり、「アンパックする値が多すぎる」という例外が発生します。

- 可変な配列の途中の値を変数に代入したい


## 参考書籍

このページは以下の書籍を参考にしています。

https://www.amazon.co.jp/Python-Cookbook-Recipes-Mastering/dp/1449340377


## 対応方法

Pythonの **「スター式」** を使用して、この問題に対処できます。

具体例：学期の終わりに最初と最後の宿題の成績以外で、残りの成績だけを平均することを決定したとします。

問題は「配列の長さがわからない」ということです。

こんな時は次のように3行の関数で対応することができます。

<pre><code>
def drop_first_last(grades): 
    first, *middle, last = grades 
    return avg(middle)
</code></pre>



## 対応方法2

別の使用例として、

名前と電子メールアドレスの後に任意の数の電話番号が続くユーザー列があるとします。

次のように列を解凍できます。

<pre><code>
>>> record = ('Dave', 'dave@example.com', '773-555-1212', '847-555-1212') 
>>> name, email, *phone_numbers = user_record
>>> email
'dave@example.com'
>>> phone_numbers 
['773-555-1212', '847-555-1212']
</code></pre>


## まとめ

拡張反復可能アンパックは、未知または任意の長さの反復可能オブジェクトをアンパックするためにカスタマイズされています。

多くの場合、これらの反復可能オブジェクトの構造には既知パターンがあります（たとえば、「要素1の後のすべては電話番号です」）

スターアンパッキングを使用するとこれらのパターンを簡単に活用して、関連するものを取得できます。

<pre><code>
records = [
    ('foo', 1, 2),
    ('bar', 'hello'),
    ('foo', 3, 4),
]
def do_foo(x, y): 
    print('foo', x, y)
def do_bar(s): 
    print('bar', s)

for tag, *args in records: 
    if tag == 'foo':
        do_foo(*args) 
    elif tag == 'bar':
        do_bar(*args)
</code></pre>



title:pythonで可変な配列の値を変数代入したい時

description:配列からN個の要素を別々の変数に代入する必要がありますが、配列がN個の要素より長くなる可能性があり、「アンパックする値が多すぎる」という例外が発生します。

category_script:page_name.startswith("21")

img:https://question.short-tips.info/api/ogp/?text=pythonで可変な配列の値を変数代入したい時




