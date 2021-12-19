
## 「sql with」とは

SQLのwith文では

- 一度selectした結果の保存,使い回しを可能に
- 副問い合わせのネストの簡略化




## 「sql with 使い方」で検索したあなたへ

with の後に一時テーブル名を宣言 as　のあとの括弧の内部にselect文を書くことで、テーブルの使い回し、副問い合わせのネストの簡略化が可能になる。

<pre><code>
-- 宣言部分
with 一時テーブル as (
    select ~
)


-- 再利用部分
select
    *
from
    一時テーブル
</code></pre>


例えば、次の部署コードテーブルから部署一覧を取り出し、
その中の部署コードから従業員を取り出したい時


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


通常の副問い合わせだと次のようなクエリになる

<pre><code>
select
    *
from
    employee e
where
    e.dept_id IN (
        select
            id
        from
            department
    )
</code></pre>

これは通常の理解可能な範囲であるが、通常ネストは少なければ少ないほどよい。

というわけで、with文を使うと次のようなコードになる。

<pre><code>
with
    ALL_DEPTARTMENT_TABLE
as (
    select
        id
    from
        department
)

select
    *
from
    employee e
where
    e.dept_id IN ALL_DEPTARTMENT_TABLE
</code></pre>

二つのクエリとして分割することに成功し、
コードもグッと見やすくなった。

このように、with文を使うことでネストを浅くし、クエリを見やすくできる。







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




title:「sql with」で検索したあなたへ【SQL基礎】

description:SQLのwith文では。一度selectした結果の保存,使い回しを可能にし、副問い合わせのネストの簡略化も実現できる。


img:https://www.oreilly.co.jp/books/images/picture_large4-87311-281-8.jpeg



category_script:page_name.startswith("1")


