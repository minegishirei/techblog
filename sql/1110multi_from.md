


## 記事の概要

sql分で複数のテーブルを使用する場合の全てのパターンについて解説を行います。







## サンプルテーブル


- employees


<table>
    <thead>
        <tr>
            <th>id</th>
            <th>name</th>
            <th>salary</th>
            <th>dept_id</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1234</td>
            <td>tarou</td>
            <td>10,00
            </td>
            <td>20
            </td>
        </tr>
        <tr>
            <td>
            1235
            </td>
            <td>
            kaiou
            </td>
            <td>
            20.000
            </td>
            <td>
            20
            </td>
        </tr>
        <tr>
            <td>
            1236
            </td>
            <td>
            nanashi
            </td>
            <td>
            30,00
            </td>
            <td>
            10000
            </td>
        </tr>

    </tbody>
</table>



- Department

<table>
    <thead>
        <tr>
            <th>id</th>
            <th>name</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>20</td>
            <td>情報システム室</td>
        </tr>
        <tr>
            <td>10</td>
            <td>
            品質管理室
            </td>
        </tr>
    </tbody>
</table>


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


<table>
    <thead>
        <tr>
            <th>id</th>
            <th>name</th>
            <th>salary</th>
            <th>dept_id</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1234</td>
            <td>tarou</td>
            <td>10,00
            </td>
            <td>20
            </td>
        </tr>
        <tr>
            <td>
            1235
            </td>
            <td>
            kaiou
            </td>
            <td>
            20.000
            </td>
            <td>
            20
            </td>
        </tr>
        <tr>
            <td>
            1236
            </td>
            <td>
            nanashi
            </td>
            <td>
            30,00
            </td>
            <td>
            10000
            </td>
        </tr>
    </tbody>
</table>




### 実行結果



<table>
    <thead>
        <tr>
            <th>id</th>
            <th>name</th>
            <th>salary</th>
            <th>dept_id</th>
            <th>id</th>
            <th>name</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1234</td>
            <td>tarou</td>
            <td>10,00
            </td>
            <td>20
            </td>
            <td>20</td>
            <td>情報システム室</td>
        </tr>
        <tr>
            <td>
            1235
            </td>
            <td>
            kaiou
            </td>
            <td>
            20.000
            </td>
            <td>
            10
            </td>
            <td>10</td>
            <td>
            品質管理室
            </td>
        </tr>
    </tbody>
</table>






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



<table>
    <thead>
        <tr>
            <th>id</th>
            <th>name</th>
            <th>salary</th>
            <th>dept_id</th>
            <th>id</th>
            <th>name</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1234</td>
            <td>tarou</td>
            <td>10,00
            </td>
            <td>20
            </td>
            <td>20</td>
            <td>情報システム室</td>
        </tr>
        <tr>
            <td>
            1235
            </td>
            <td>
            kaiou
            </td>
            <td>
            20.000
            </td>
            <td>
            10
            </td>
            <td>10</td>
            <td>
            品質管理室
            </td>
        </tr>
        <tr>
            <td>
            1236
            </td>
            <td>
            nanashi
            </td>
            <td>
            10.000
            </td>
            <td>
            10000
            </td>
            <td>NULL</td>
            <td>
            NULL
            </td>
        </tr>
    </tbody>
</table>


先程の内部結合とは違い、idがNULLであっても表示がされている。











## 備考欄

title:「sql from 複数」で検索したあなたへ


description:sql分で複数のテーブルを使用する場合の全てのパターンについて解説を行います。


img:https://images-na.ssl-images-amazon.com/images/I/51NUVWMKzhL._SX258_BO1,204,203,200_.jpg







