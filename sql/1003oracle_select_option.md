



## 表構造の表示

<pre><code>
DESCRIBE
</code></pre>

## SELECTでの算術使用

selectの実行結果に対して計算を行うことができる。

例えば給料の12倍を示したいときは給料のカラムsalに*12を付け加える

<pre><code>
SELECT
    empno, sal, sal*12
FROM
    社員データベース
</code></pre>

+は足し算

-は引き算

*は掛け算

/は割り算

さらに複雑な算術は()を使用して優先順位を指定する

<pre><code>
SELECT
    empno, sal, (sal+1000)*12
FROM
    社員データベース
</code></pre>


## 列別名の使用

上記のsqlを実行するとsal*12がタグとして出てきてしまう。

これに対して独自のラベルをつけたいときは列別名を使う

列別名1

<pre><code>
SELECT
    empno 社員番号, sal 給料, sal*12 年間給料予測
FROM
    社員データベース
</code></pre>

列別名2(ASを使用でも可能)

<pre><code>
SELECT
    empno AS 社員番号, sal AS 給料, sal*12 AS 年間給料予測
FROM
    社員データベース
</code></pre>

列別名2(特殊文字を使用)

<pre><code>
SELECT
    empno AS "社員No", sal AS "sal", sal*12 AS "WHERE"
FROM
    社員データベース
</code></pre>



## 文字列の結合


||を使う

その際の文字列は'(単一引用ふ)でなければ行けない

<pre><code>
SELECT
    empno || 'さんの入社日は' ||  hiredate
FROM
    社員データベース
</code></pre>



## 代替引用符(q)演算子

'や?などの特殊な文字列を使いたい時はqの後に指定した文字列で区切ることでその区間だけは特殊文字列を使用できる

<pre><code>
SELECT
    name || q'?'s Salary is : ?' || sal "Monthly Salary"
FROM
    emplyoees;
</code></pre>

<pre><code>
sato's Salary : 5000
</code></pre>

[]でも可能

<pre><code>
SELECT
    name || q'['s Salary is : ]' || sal "Monthly Salary"
FROM
    emplyoees;
</code></pre>




## 重複行の削除

DISTINCTを使用

<pre><code>
SELECT 
    DISTINCT 部署コード
FROM
    emplyoees;
</code></pre>

これにより部署コードを重複なしで一覧で出すことができる

DISTINCTはselect内に一度しかかけず、二つ書くとエラーになる





## 複数列の重複行の削除

DISTINCTを使用して

部署コード, job二つが被ったものは重複としてみなすことができる

<pre><code>
SELECT 
    DISTINCT 部署コード, job
FROM
    emplyoees;
</code></pre>

同じ部署コード, jobは二度出てこない








title:select句でできること一覧【SQL基礎入門】

description: データベースの中からデータを取り出す文であるSQLのselect文。select句では文字列の結合や算術計算、重複の削除などができます。

img:https://www.oreilly.co.jp/books/images/picture_large4-87311-281-8.jpeg

category_script:page_name.startswith("1")

