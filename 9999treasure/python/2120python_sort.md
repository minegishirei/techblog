


## 辞書から複数の最大値/最小値を取り出す方法

コレクション内の最大または最小のN個のアイテムのリストを作成するとします。

つまり、

- 最大値のtop5を見つけ出したい

- 最小値のtop5を見つけ出したい

などです。



## 配列の複数の最大値を取得する対応方法

heapqモジュールには、**nlargest（）とnsmallest（）** の2つの関数があり、必要な処理を正確に実行します。

<pre><code>
import heapq
nums = [1, 8, 2, 23, 7, -4, 18, 23, 42, 37, 2] 
print(heapq.nlargest(3, nums)) 
# Prints [42, 37, 23] 
print(heapq.nsmallest(3, nums)) 
# Prints [-4, 1, 2]
</code></pre>

## 辞書型の複数の最大値を取得する方法

heapqモジュールのnlargest関数とnsmallest関数は辞書方での対応も可能です。

しかしそのためには**lambda式**を使わなければなりません。

<pre><code>
portfolio = [
    {'name': 'IBM', 'shares': 100, 'price': 91.1},
    {'name': 'AAPL', 'shares': 50, 'price': 543.22},
    {'name': 'FB', 'shares': 200, 'price': 21.09},
    {'name': 'HPQ', 'shares': 35, 'price': 31.75},
    {'name': 'YHOO', 'shares': 45, 'price': 16.35},
    {'name': 'ACME', 'shares': 75, 'price': 115.65}
]
cheap = heapq.nsmallest(3, portfolio, key=lambda s: s['price'])
expensive = heapq.nlargest(3, portfolio, key=lambda s: s['price'])
</code></pre>


## nlargestとnsmarlestのパフォーマンスについて

N個の最小または最大のアイテムを探していて、コレクション全体のサイズに比べてNが小さい場合、これらの機能は優れたパフォーマンスを提供します。


## 配列、辞書をソートしたい時

辞書型や配列をソートしたい時は、heapqの**heapify**を使うことで対応できます

<pre><code>
>>> nums = [1, 8, 2, 23, 7, -4, 18, 23, 42, 37, 2] >>> import heapq
>>> heap = list(nums)
>>> heapq.heapify(heap)
>>> heap
[-4, 2, 1, 23, 7, 2, 18, 23, 42, 37, 8]
</code></pre>

ヒープの最も重要な機能は、heap[0]が常に最小のアイテムであるということです。

さらに、後続のアイテムは、heapq.heappop（）メソッドを使用して簡単に見つけることができます。

このメソッドは「最初のアイテムをポップして、次に小さいアイテムに置き換えます」

たとえば、最小の3つのアイテムを見つけるには、次のようにします。

<pre><code>
>>> heapq.heappop(heap) -4
>>> heapq.heappop(heap) 1
>>> heapq.heappop(heap) 2
</code></pre>




title:辞書から複数の最大値/最小値を取り出す方法【python学習サイト】

description:辞書から複数の最大値/最小値を取り出す方法。nlargestとnsmarlestのパフォーマンスについて。配列、辞書をソートしたい時の対応などなど。

category_script:page_name.startswith("21")

img:https://question.short-tips.info/api/ogp/?text=辞書から複数の最大値/最小値を取り出す方法



