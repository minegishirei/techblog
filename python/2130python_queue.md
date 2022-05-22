


## pythonのqueueに優先順位をつけて管理する

特定の優先度でアイテムを並べ替え、各ポップ操作で常に最も優先度の高いアイテムを返すキューを実装する必要があります。

数値でないオブジェクト同士に優先順位を持たせる方法。

## 参考書籍

このページは以下の書籍を参考にしています。

https://www.amazon.co.jp/Python-Cookbook-Recipes-Mastering/dp/1449340377



## 解決策:オリジナルのqueueを作成しましょう

次のクラスは、heapqモジュールを使用して、単純な優先キューを実装します。

<pre><code>
class PriorityQueue: 
    def __init__(self):
        self._queue = []
        self._index = 0
    def push(self, item, priority):
        heapq.heappush(self._queue, (-priority, self._index, item)) 
        self._index += 1
    def pop(self):
        return heapq.heappop(self._queue)[-1]
</code></pre>

次のコードはこのクラスの使用例です。

<pre><code>
class Item:
    def __init__(self, name): 
        self.name = name
    def __repr__(self):
        return 'Item({!r})'.format(self.name

>>> q = PriorityQueue()
>>> q.push(Item('foo'), 1) 
>>> q.push(Item('bar'), 5) 
>>> q.push(Item('spam'), 4) 
>>> q.push(Item('grok'), 1) 
>>> q.pop()
Item('bar') 
>>> q.pop() 
Item('spam') 
>>> q.pop() 
Item('foo') 
>>> q.pop() 
Item('grok') 
>>>
</code></pre>

最初のpop（）操作が最も高い優先度のアイテムをどのように返したかを観察します。

また、同じ優先度の2つのアイテム（fooとgrok）がある場合、
キューに挿入されたのと同じ順序で対応します。


## オブジェクト同士を比較する方法

ところで、このItemクラス自身には比較する能力は備わっていません。

<pre><code>
>>> a = Item('foo')
>>> b = Item('bar')
>>> a < b
Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
    TypeError: unorderable types: Item() < Item()
>>>
</code></pre>


ここで追加のインデックスを導入し、（priority、index、item）タプルを作成することで、この問題を完全に回避できます。

<pre><code>
>>> a = (1, 0, Item('foo')) 
>>> b = (5, 1, Item('bar')) 
>>> c = (1, 2, Item('grok')) 
>>> a < b
True
>>> a < c
True
</code></pre>

これは、2つのタプルがインデックスに同じ値を持つことはないためです。
（Pythonの比較級では一つ目の比較の結果が得られたら、残りのタプル値をわざわざ比較することはありません。)



## 備考

title:pythonのqueueに優先順位をつける【python学習サイト】

description:特定の優先度でアイテムを並べ替え、各ポップ操作で常に最も優先度の高いアイテムを返すキューを実装する必要があります。

category_script:page_name.startswith("21")

img:https://question.short-tips.info/api/ogp/?text=数値でないオブジェクト同士に優先順位を持たせる方法。


