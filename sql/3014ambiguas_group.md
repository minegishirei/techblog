

## 概要(良いクエリ)

ある程度SQLを学んだプログラマーは、クエリでGroup Byと集約関数(MIN,MAX,SUM,COUNTなど)を巧みに用いて集計することを覚える。

少量のコードで複雑なレポートを作成できる強力な機能である。

例えば「product_idごとにレポート日付の最大値を取得したい」という要件を考えると、次のようなコードになる。

<pre><code>
SELECT
    product_id, MAX(data_report)
FROM
    Bugs
Group By
    product_id
</code></pre>

このクエリはうまく動いた。


## 概要(悪いクエリ)

ところで、上のクエリでbug_idは幾つになるかも同時に表示したいと考えた。

あなたは次のようにbug_idをselect句に加えた。

<pre><code>
SELECT
    product_id, MAX(data_report), bug_id
FROM
    Bugs
Group By
    product_id
</code></pre>

ところが、カラムを加えた瞬間エラーが出るようになった。

## 各データベースからのエラー文言

Firebird2.1の例)

    invalid expression in the select list not contained in either an aggregate function

IBM DB2の例）

    an expression starting with specified in a select clause

Microsoft SQL Server 2008

    column is invalid in the select list because it is not contained in either an aggregate function

MySQL

    Error ... isn't in group by

Oracle

    not a group by expression
    (日本語だと「Broup Byの式ではありません」です)

PostgreSQL

    must appear in the group by clause or be used
    (日本語だと「group by句で指定するか、集約関数内で使用しなければなりません」)


## 原因(結論)

**Group Byを用いるとき、Select句では次のどちらかの要件を満たす必要がある**

- 集約関数を使用して「グループごとに一つの値が帰る」ようにする

- Group Byで使用しているカラム

## 原因(詳細)

**Group Byには「単一値の原則」が適応される**

単一値の原則とは

「グループごとに一つの値が帰る」

状態である。

select句の選択リストに列挙されるs全ての列は、行グループごとに単一の値でなければならない

例えば先程の例

<pre><code>
SELECT
    product_id, MAX(data_report), bug_id
FROM
    Bugs
Group By
    product_id
</code></pre>

product_id はGroup Byで指定しているのでproduct_idごとに「単一の値が帰る」

MAX(data_report) もMAXでproduct_idごとの最大のdata_reportを帰しているので「単一のアタイが帰る」

ところがbug_idについては **「product_idごとに複数のbug_idがついている可能性があり「単一の値が帰る」ことを保証できない**

よってエラーが起きるのである。


## 対策方法１：曖昧でない列を使用する。

先程の例では、「bug_id」というふわっとしたものを追加したためエラーが起きた。

<pre><code>
SELECT
    product_id, MAX(data_report), bug_id
FROM
    Bugs
Group By
    product_id
</code></pre>

この場合はbug_idを消せば元通り動く

<pre><code>
SELECT
    product_id, MAX(data_report)
FROM
    Bugs
Group By
    product_id
</code></pre>


## 対策方法2:集約関数を使う

どうしても「bug_id」を出力したいときだが、
「product_idごとにbug_idが一つに定まらない」ことが問題である

であればbug_idから何か一つ代表的な値を取り出せば良い。

例えば平均値とか

<pre><code>
SELECT
    product_id, MAX(data_report), AVG(bug_id)
FROM
    Bugs
Group By
    product_id
</code></pre>

あるいはdata_reportが最大の日付を取得しているので、最大のbug_idを返す方が適切かもしれない。


<pre><code>
SELECT
    product_id, MAX(data_report), MAX(bug_id)
FROM
    Bugs
Group By
    product_id
</code></pre>






## 概要

title:アンビギュアスグループとGroup By句の誤用【SQLアンチパターン】


description:ある程度SQLを学んだプログラマーは、クエリでGroup Byと集約関数(MIN,MAX,SUM,COUNTなど)を巧みに用いて集計することを覚える。しかし、Group Byを用いるとき、Select句では次のどちらかの要件を満たす必要がある...


img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-589-4.jpeg


category_script:page_name.startswith("30")



