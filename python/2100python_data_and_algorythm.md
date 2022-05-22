


## pythonで配列を開封したい時

N要素の配列があります。

その配列を別々の変数に代入したい場合、どのようにすれば良いでしょうか？



## 参考書籍

このページは以下の書籍を参考にしています。

https://www.amazon.co.jp/Python-Cookbook-Recipes-Mastering/dp/1449340377




## 解決策

単純な代入操作を使用して、任意のシーケンス（または反復可能）を変数にアンパックできます。

その場合に必要な条件は、変数の数と構造がシーケンスと一致することです。

<pre><code>
x, y = (4, 5)
print(x)
>> 4
print(y)
>> 5
</code></pre>


## エラー

要素の数に不一致がある場合は、エラーが発生します。

例えば：

<pre><code>
>>> p = (4, 5)
>>> x, y, z = p
Traceback (most recent call last):
File "<stdin>", line 1, in <module>
ValueError: need more than 2 values to unpack
>>>
</code></pre>

この場合、以下のように配列の個数と変数の個数を合わせることで対応できます。

<pre><code>
>>> p = (4, 5)
>>> x, y = p
>>> x
4
>>> y
5
</code></pre>


## 文字列の分割も可能

アンパッキングは、タプルやリストだけでなく、偶然反復可能なオブジェクトでも機能します。

具体的には、文字列、ファイル、イテレータ、およびジェネレータが含まれます。

例えば：

<pre><code>
>>> s = 'Hello'
>>> a, b, c, d, e = s >>> a
'H'
>>> b
'e'
>>> e
'o'
>>>
</code></pre>

## いらない変数は「_」を使おう

アンパッキングには、特定の値を使わない場合があります。

多くの場合、使い捨ての変数名を選択するだけです。

そしてその変数名としては「_(アンダーバー)」がよく使われます。

<pre><code>
>>> p = (4, 5)
>>> x, _ = p #先頭の値をxに代入したい
>>> x
4
>>> y
5
</code></pre>

当然ながら、この変数は値を保っている状態ではあります。

どこかで使っていないか気をつけておいてください。





title:pythonで配列を個別の値に分割したい時

description:pythonで配列を開封したい時の解説です。例えばN要素の配列があります。その配列を別々の変数に代入したい場合、どのようにすれば良いでしょうか？

category_script:page_name.startswith("21")

img:https://question.short-tips.info/api/ogp/?text=pythonで配列を個別の値に分割したい時

