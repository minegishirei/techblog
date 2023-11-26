

## WHERE句

WHERE句の基本

<pre><code>
SELECT
    列
FROM
    表名
WHERE
    列名 比較演算子 比較対象;
</code></pre>

例)2000年の1月14日以降に生まれた従業員


<pre><code>
SELECT
    empno 従業員番号
FROM
    employees
WHERE
    birtday > '2000-01-14';
</code></pre>


### 文字列や日付の比較

- ""で囲まなければいけない

- 大文字と小文字は区別される

名前がsatoで一件もヒットしなくても、SATOで引っかかる可能性はある



###比較演算子

<pre><code>
= 同じ値
> 大なり
< 小なり
> 以上
< 以下
</code></pre>

### WHERE句での列別名は使用ができない

次のSLEECT文はエラーになる

<pre><code>
SELECT
    empno 従業員番号
FROM
    employees
WHERE
    従業員番号 > '1000';
</code></pre>

原因は従業員番号がWHERE句で使用されているため


### WHERE句では演算子が使える

従業員番号を2倍した時で1000と比較

<pre><code>
SELECT
    empno 従業員番号
FROM
    employees
WHERE
    empno*2 > '1000';
</code></pre>


### BETWEEN演算子

BETWEENの後に続く二つの数字の間にあるものが当てはまる

以下の例だと1000以上2000以下

1000と2000も含む

<pre><code>
SELECT
    empno 従業員番号
FROM
    employees
WHERE
    empno BETWEEN 1000 AND 2000;
</code></pre>


### BETWEENの日付での比較

日付の範囲もBETWEENで比較が可能

以下のSQLは

2000-01-14生まれの人から2000-10-14生まれの人までを含む

<pre><code>
SELECT
    empno 従業員番号
FROM
    employees
WHERE
    birtday BETWEEN '2000-01-14' and '2000-10-14';
</code></pre>



### IN演算子

資子を使用すると、列値と複数の値を比較できる

WHERE 列名 IN(値1,値2...)

次の例では10,20版の従業員番号に当てはまると結果にヒットする

<pre><code>
SELECT empno, ename, deptno
FROM employees
WHERE deptno IN(10, 20);
</code></pre>

次の例はその真逆で 10,20以外のものに当てはまるとヒットする

<pre><code>
SELECT empno, ename, deptno
FROM employees
WHERE deptno IN(10, 20);
</code></pre>



### LIKE演算子

LIKE演算子を使うとさらに高度な文字列パターンで検索をかけられます

% 0文字以上の任意の文字列と一致する

_ 任意の文字列と一致する

例えば次の例では名前に鈴木を含む従業員を全て抽出しています

<pre><code>
SELECT
    *
FROM
    emplyoees
WHEERE
    empname like "%鈴木%"
</code></pre>

次の例では鈴木の後に三文字続く人を出力しています

<pre><code>
SELECT
    *
FROM
    emplyoees
WHEERE
    empname like "%鈴木___"
</code></pre>

### ESCAPEオプション

%が文字列に入るものを認識したい時はさらに高度な技が必要になります。

そのためにはESCAPEオプションが役に立ちます

ESCAPEの後に任意の文字を指定することで、その文字をエスケープシークエンスとして扱うことができます

例えば以下の場合は50%を文字列として含むものを抽出できます

50％を50¥%として表記することで、%がワイルドカードとして認識されることを防げます

<pre><code>
SELECT
    *
FROM
    emplyoees
WHEERE
    work_rate like "%50¥%%" ESCAPE '¥'
</code></pre>


### IS NULL演算子

IS NULLは値がNULLかどうかを比較することができます

つぎのselectはwork_rateがNULLになっている従業員を出力します

<pre><code>
SELECT
    *
FROM
    emplyoees
WHEERE
    work_rate IS NULL
</code></pre>

逆にNULL出ないものを抽出したい時は IS NOT NULLを使用します

<pre><code>
SELECT
    *
FROM
    emplyoees
WHEERE
    work_rate IS NOT NULL
</code></pre>

- ちなみにNULL稼働かの比較は,=では行えません。



### AND演算子

前後に指定された条件が両方ともTRUEの場合にTRUE 



### OR演算子

前後に指定された条件のどちらか一方でもTRUEの場合にTRUE 




### INとORのパフォーマンスの違い

IN演算子は、内部的にはOR演算子を使用したものに置き換えられてしまう。

よって、
IN演算子を使用して書き換えても実行時のパフォーマンスは変わらない

テストに出ることもあるので覚えておきましょう


###ORDER BYによる行のソート

ORDER BY句に列名を指定すると、ソートされたデータの抽出が可能になる。

同時に複数の列を指定することも可能(その場合は,区切る。左に書いたものほど優先度が高い）。

<pre><code>
SELECT 
    *
FROM 
    データベース
WHERE 
    条件 
ORDER BY 列名[,列名 ...];
</code></pre>

ASCとDESCで並び替えを逆順にすることも可能

サンプル

<pre><code>
SELECT 
    *
FROM employees
ORDER BY sal;
</code></pre>

このコードでは従業員データベースから給料順に並べている


### 「ASC」

昇順:小さいほうから順

デフォルトの設定はこちらになっている


### 「DESC」

降順:大きいほうから順

<pre><code>
SELECT 
    *
FROM employees
ORDER BY sal DESC;
</code></pre>

こちらは意図的に設定しないと反映されない。


### ORDER BYと列別名

ORDER BY句では列別名は使用可能



### ソートの順序はデータによって異なる

例えば数値であれば、大きい順に並ぶ

日付であれば、最新の値順に並ぶ


###NULLの扱いとORDER BY

<pre><code>
NULL値は数値、日付値、文字値のいずれの場合も、デフォルトでは「最も大きい値」として扱われます。
</code></pre>


### NULLS FIRSTとNULLS LAST

NULLの値に関しては最初に出てくるように調整するコードが「NULLS FIRST」

<pre><code>
SELECT
    *
FROM employees 
ORDER BY sal NULLS FIRST;
</code></pre>


###WHERE句とORDER BY句

この二つは同時に指定することが可能。

しかし順番は入れ替えることはできない。

where句の後にorder by句がくる。


例）次のコードはNULL以外の列でsalの昇順。(グラフに並び替えたときに登っていく)

<pre><code>
SELECT
    *
FROM employees 
WHERE sal IS NOT NULL
ORDER BY sal;
</code></pre>


### SLECT句で指定しない列名でのORDER BY

SLECT句で指定しない列名でのORDER BYは

エラーにならない

### 列別名とORDER BYの関係

WHERE句には列別名は指定できませんが、

#### ORDER BY 句には列別名 を指定できます




###row_limiting_clauseを使用

<pre><code>
SELECT *
FROM employees
WHERE sal IS NOT NULL
ORDER BY sal
OFFSET ?? ROW(またはROWS)
FETCH { FIRST | NEXT }
{ row_count | percent PERCENT } { ROW | ROWS } | { ONLY | WITH TIES }]
</code></pre>

sample コード

先頭から5行をスキップした6行目から

3行分を取り出している。 

<pre><code>
SELECT 
    empno, ename, sal
FROM 
    employees
ORDER BY 
    sal DESC 4 
OFFSET 5 ROWS       --先頭から5行をスキップした6行目から
FETCH FIRST 3 ROWS  --13行ぶんを取り出している
WITH TIES;
</code></pre>




title:where句の基本的な使い方【SQL基礎入門】

description:select句の基本的な文法をOracle bronze SQL基礎の資格をなぞりながら解説

img:https://www.oreilly.co.jp/books/images/picture_large4-87311-281-8.jpeg

category_script:page_name.startswith("1")



