


## 記事の概要

sql分で複数のテーブルを使用する場合の全てのパターンについて解説を行います。







## サンプルテーブル

- employees

|  id    |  name   |  salary | dept_id
| ----   |  ----   | ---- | ---- |
|  1234  |  tarou  |  10,000 | 10 |
|  1235  |  kaiou  |  20,000 | 20 |
|  1236  |  nanashi  |  30,000 | (NULL) |

- Department

| id | name |
| -- | ---- |
| 10 | 情報システム室 |
| 20 | 経営企画室     |


## 2種類の結合

<img src="https://s3-ap-northeast-1.amazonaws.com/amg-s3-01/wp-content/uploads/2021/09/16155729/join-ic.jpg">


この図の通り、結合には大きく分けて2種類存在する。

- INNER JOIN(内部結合)

二つのデータベースを結合する際に、
<strong>両方のデータベースにデータが存在していれば</strong>
列が表示されるパターン。

通常の「結合」ではこちらを指すことが多い


- OUTER JOIN(外部結合)

二つのデータベースを結合する際に、
<strong>どちらかデータベースにデータが存在すれば</strong>
表示されるパターン

- Left Join, right join

この二つは少し例外で「Left Join」であれば
<strong>左側のデータベースに存在するものは全て表示する</strong>
というもの。

後付けで右側のデータベースがくっつくイメージ






## INNER JOIN(内部結合)

二つのデータベースを結合する際に、
<strong>両方のデータベースにデータが存在していれば</strong>
列が表示されるパターン。

今回だと「従業員データベースと部署データベースに部署コードという共通の値が存在する場合のみ」が目的となる

通常、結合とはこのタイプの結合を表す。

- サンプルコード

<pre><code>
select
    e.*,
    d.*
from
    employees e,
    Department d
where
    e.dept_id = d.id

</code></pre>





### 純粋な結合のポイント

- fromの中身のテーブルは「,」で区切ること
- 二つのテーブルを分けるために、「e」「d」などテーブルに別名(エイリアス)をつけること
- そのための名前はわかりやすいもの(今回はemployeeとdepertmentの頭文字)にすること
- 結合する場所はwhere句の中で指定すること

### 内部結合の特徴

下記の従業員データベースではdept_idがNULLになっているnanashiは実行結果に表示されない。

これは、dept_idと同一の値(10000)が部署データベースのidカラムには存在しないためである。


- employees

|  id    |  name   |  salary | dept_id
| ----   |  ----   | ---- | ---- |
|  1234  |  tarou  |  10,000 | 10 |
|  1235  |  kaiou  |  20,000 | 20 |
|  1236  |  nanashi  |  30,000 | 10000 |



### 実行結果

|  id  |  name  |  salary | dept_id| id | name |
| ---- | ---- | ---- | ---- | -- | ---- |
|  1234  |  tarou  |  10,000 | 10 | 10 | 情報システム室 |
|  1235  |  kaiou  |  20,000 | 20 | 20 | 経営企画室    |





## LEFT JOIN


<img src="https://s3-ap-northeast-1.amazonaws.com/amg-s3-01/wp-content/uploads/2021/09/16155729/join-ic.jpg">

LEFT JOINはこちらの図の通り、左側のデータを絶対的な基準としてデータを表示したい場合に使われることが多い。

今回だと「従業員データベースのデータは全て表示し、そこの付随情報として部署コードを付け加える」というイメージ


- サンプルコード

<pre><code>
select
    e.*,
    d.*
from
    employees e　LEFT JOIN Department d 
    ON e.dept_id = d.id

</code></pre>


### 実行結果

|  id  |  name  |  salary | dept_id| id | name |
| ---- | ---- | ---- | ---- | -- | ---- |
|  1234  |  tarou  |  10,000 | 10 | 10 | 情報システム室 |
|  1235  |  kaiou  |  20,000 | 20 | 20 | 経営企画室    |
|  1234  |  nanashi  |  10,000 | 10 | NULL | NULL |

先程の内部結合とは違い、idがNULLであっても表示がされている。











## 備考欄

title:「sql from 複数」で検索したあなたへ


description:sql分で複数のテーブルを使用する場合の全てのパターンについて解説を行います。


img:https://images-na.ssl-images-amazon.com/images/I/51NUVWMKzhL._SX258_BO1,204,203,200_.jpg







