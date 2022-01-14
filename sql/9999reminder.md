
## やばいかもしれないリスト

- Union order byの位置

- Union とunion allの違い

- 関数の使い方について

TO_CHAR TO_DATE TO_NUMBERについて

- Create文など

- 制約について

- Alter table

- Alter table row define

- Table add row

行のソート

- INTERVAL型

曜日(月曜日,日曜日)

- 画像データのデータ型

- 副問い合わせを使用した表の作成時

- RR指定の日付データを意図的に変えることができるか


- オブジェクト指向のDBとリレーショナル型のDB(rdms)
<a href="https://blog.emptyq.net/a?id=00009-0e266983-c3d9-426a-bfbb-68c03f3dccaa">
解説
</a>

- REPLACE関数


## 作戦

120minで75Q

1Q:1.6min

- 30秒-60秒考えて即答できないのを飛ばす。
その代わりチェックは付けておくこと。

- 自信がないものもチェックをつけておくこと。

0.5*75 = 37.5min

60*75 = 75min

結果として、25問/75まで間違えて良い




## 覚えた方がいい

<pre>
SELECT
    TO_CHAR(123456.78, '99,999')
FROM
    dual;
A: 123456,78

B: 123,456.78

C: 指定した桁数よりも桁が多いのでエラーになる

D: 1234,56.78

E: ########
</pre>

 ########。 TO_CHARの書式指定は桁数を超えると全て#になる



? 日付書式設定


## 覚えた方がいい2

<pre>
HIREDATEの曜日順(月から始まり、に社員を並び替えるSQLを選べ

A: SELECT * FROM employees ORDER BY TO_CHAR(hiredate-1, 'DAY')

B: SELECT * FROM employees ORDER BY TO_CHAR(hiredate, 'DAY')

C: SELECT * FROM employees ORDER BY TO_CHAR(hiredate, 'D')

D: SELECT * FROM employees ORDER BY TO_CHAR(hiredate-1, 'D')

E: SELECT * FROM employees ORDER BY TO_CHAR(hiredate+1, 'D')

答え
D: SELECT * FROM employees ORDER BY TO_CHAR(hiredate-1, 'D')

曜日の日付書式は'DAY','DY','D'の三つがある

'DAY'は「日曜日,月曜日,」'DYは「日,月,,,」'D'は「1,2,3,,,,」 と増えていく

そこから一日増やさなければならないため、hiredate-1を指定する。

</pre>



## 世紀形

<a href="https://qiita.com/mochichoco/items/2904384b2856db2bf46c#%E6%AD%A3%E8%A6%8F%E5%8C%96%E3%81%AE%E6%89%8B%E9%A0%86-1">
正規形
</a>



## 「&&置換」

&&はユーザー変数として覚えてくれるバインド変数

&は覚えてくれないバインド変数



## UNUSEDマーク

UNUSEDマークの付け方

<pre><code>
ALATER TABLE 表名
SET UNUSED [COLUMN](列名)
</code></pre>

UNUSEDマークのついた列の消し方

<pre><code>
LATER TABLE 表名
DROP UNUSED COLUMNS
</code></pre>


- 削除された列と同様の列の扱いになり、同じ名前の列を作れる

- ただし、LONG型はUNUSEDマークをつけることができない

- 列の名前の確認や取り消しができない




## 代替引用符(q)

文字リテラルの一部に「'」を使用したい時

- 任意のシングルバイト文字列やダブルバイト文字列

- []{}()<>の組み合わせ

次の例は?を引用デリみたに指定する。

<pre><code>
SELECT
  yomi || q'?'s Salary : ?' || sal "Monthly Salary"
FROM
  employees
</code></pre>

他の引用符デリミタ「[]」

<pre><code>
SELECT
  yomi || q'['s Salary : ]' || sal "Monthly Salary"
FROM
  employees
</code></pre>



## 列別名とダブルクオーテーション

<pre><code>
SELECT
  employee_id 社員番号
  , name "Name"
  , salary * 12 AS 年間給与
  , salary + 10000 AS "Bonus Money"
FROM
  test5;
</code></pre>




<h3 class="title">
覚えたほうがいいこと
</h3>
<div class="box">
  <p>
スペースや特殊文字を使用する場合は"で囲む必要がある
  </p>
  <p>

  </p>
  <p>
  
  </p>
</div>


## DISTINCTについて

DISTINCTは一個のSELECTで一回のみ




## ESCAPEオプション

LIKE演算子では%と_をワイルドカードとして扱うため
100%
のような#を含む文字列を指定する場合はESCAPEオプションを設定する必要がある

<pre><code>
WHERE 列名 LIKE '文字列パターン' ESCAPE 'エスケープ文字(一文字 |¥,$,#,aなど)'
</code></pre>

- サンプルコード
<pre><code>
WHERE pname LIKE '100¥%%' ESCAPE '¥'
</code></pre>

- サンプルコード2(100%_で始まる文字列)
<pre><code>
WHERE pname LIKE '100¥%¥_%' ESCAPE '¥'
</code></pre>


## 演算子の優先順位

<pre><code>
select
  *
form
  employees
where
  deptno = 10
or
  deptno = 30
and 
  sal >= 300000;
</code></pre>

- 計算結果
- BETWEEN
- <>
- NOT
- AND
- OR

の順で評価される

よって、先にAND演算子が評価されるので

(deptno = 30 and sal >= 30000)が先

その後にORが評価される(ORは最後)


## row_limiting_clause



<h3 class="title">
書き方
</h3>
<div class="box">
<pre><code>
select
  *
from
  表名
[where句]
[ORDER BY句]
[OFFSET offset { ROWS | ROWS } ]
[FETCH { FIRST | NEXT}
       { row_count | percent PERCENT }
       { ROW | ROWS }
       { ONLY | WITH TIES }
]
</code></pre>
</div>


<h3 class="title">
FETCHのあとは
</h3>
<div class="box">
<pre><code>
NEXTかFIRSTの選択肢がある
</code></pre>
</div>


<h3 class="title">
ROWとROWSの違いは
</h3>
<div class="box">
<pre><code>
ない。
どちらも同じだが、ないという選択肢はない
</code></pre>
</div>






## OFFSET句

スキップする行数

指定しなければ0からスタートする

<pre><code>
OFFSET N ROW | ROWS
</code></pre>

<h3 class="title">
Nに負の値を指定した場合
</h3>
<div class="box">
<pre>
は0とみなされる
</pre>
</div>



<h3 class="title">
ROWもROWSも
</h3>
<div class="box">
<pre>
違いはない
OFFSETが宣言されている時は省略不可
</pre>
</div>










## FETCH句

返される行数か行の割合を表す

FETCHを省略すると 最初からスタートする

<pre><code>
FETCH { FIRST | NEXT (省略不可,違いはない)} { N | N PERCENT } { ROW | ROWS(省略不可) } { ONLY | WITH TIES }
</code></pre>


<h3 class="title">
ONLYは
</h3>
<div class="box">
<pre>
行数を正確に返す
</pre>
</div>


<h3 class="title">
WITH TIESは
</h3>
<div class="box">
<pre>
同着も返す
</pre>
</div>


<h3 class="title">
WITH TIESを指定するときは
</h3>
<div class="box">
<pre>
ORDER BYが必須
</pre>
</div>




- サンプル

<pre><code>
ORDER BY sal DESC
OFFSET 5 ROWS
FETCH FIRST 3 ROWS ONLY;
</code></pre>

先頭から5行をスキップし
6行目か3行ぶんを取り出している

ONLY指定のためSALの値が8行目と同じであっても9行目のデータは表示されない(ROWS WITH TIESなら9行目も取り出す)


- PERCENTのサンプル


<pre><code>
ORDER BY sal DESC
OFFSET 5 ROWS
FETCH FIRST 50 PERCENT ROWS ONLY;
</code></pre>

最初の5行をスキップした後、
全体の14行(50%)を取り出している


- OFFSETの省略


<pre><code>
ORDER BY sal DESC
FETCH FIRST 3 ROWS ONLY;
</code></pre>

最初の3行を取得する


- FETCHの省略


<pre><code>
ORDER BY sal DESC
OFFSET 5 ROWS
</code></pre>

最初の 5行を取得する



## SUBSTR

<pre><code>
SUBSTR(文字列, m[,n])
</code></pre>

m文字目からn文字分を取り出す関数



<h3 class="title">
mは
</h3>
<div class="box">
<pre>
負の値でも可能
</pre>
</div>




- サンプルコード

<pre><code>
select
  SUBSTR('Oracle Server', 2, 3),
  SUBSTR('Oracle Server', 2)
from
  dual
</code></pre>

> rac, 

> racle Server



<h3 class="title">
mに負の値を設定すると...
</h3>
<div class="box">
<pre>
文字の後ろから数えてm文字目からn文字ぶんを取り出す

</pre>
</div>


- サンプルコード2

<pre><code>
select
  SUBSTR('Oracle Server', -6, 3),
  SUBSTR('Oracle Server', -6)
from
  dual
</code></pre>

> Ser, Server



## INSTR

指定した文字パターンが現れる位置を戻す関数

<pre><code>
INSTR(文字列1, 文字列2 [,m=1][,n=1])
</code></pre>

m文字目から検索を行い,n回目に一致した文字列の位置を返す


<h3 class="title">
最初から最後まで文字がない場合は
</h3>
<div class="box">
<pre>
0を返す
</pre>
</div>



<pre><code>
select
  INSTR('Oracle Server', 'er',1 , 2),
  INSTR('Oracle Server', 'er')
from
  dual;
</code></pre>

> 12, 9


## TRIM関数

前後にある削除文字を取り除いて返す関数

<pre><code>
TRIM([LEADING | TRAILING | BOTH] [削除文字列] FROM 文字列)
or
TRIM(文字列)
</code></pre>

削除文字列は

<strong>
1文字だけ。
</strong>

- LEADING

先頭にあるものを取り除く


- サンプルコード

<pre><code>
select
  TRIM(LEADING 'O' FROM 'Oracle Server')
from
  dual
</code></pre>


## REPLACE関数

<pre><code>
REPLACE(文字列, 変更前文字列)
</code></pre>

- サンプルコード
  
<pre><code>
select
  REPLACE('Oracle Server', 'Server', 'Master'),
  REPLACE('Oracle Server', 'Server')
from
  dual
</code></pre>

> Oracle Master, Oracle



## 文字列の結合

文字列 string1 と string2 を連結した （CONCATenated） 文字列を戻す。


<h3 class="title">
引数は常に
</h3>
<div class="box">
<pre>
2つしかない。
3つ以上の文字列を結合するには関数の中に関数を埋め込んで表現する。
</pre>
</div>


<pre><code>
CONCAT ( string1 , string2 )
</code></pre>





# 日付関数

日本語環境では「DD-MON-RR(日-月-年)」

英語環境では「RR-MM-DD(年-月-日)」

の順番


(ALTER SESSION SET nls_data_format='表示形式')で帰ることができる



## TO_CHAR関数

<pre><code>
TO_CHAR(日付 [,'日付書式'][,NLSパラメータ])
</code></pre>


- サンプルコード

<pre><code>
select
  TO_CHAR(SYSDATE 'YYYY-MM-DD HH24:MI:SS')
from
  dual;
</code></pre>

> 2014-01-24 19:51:46



<h3 class="title">
/ - ( などの半角記号は
</h3>
<div class="box">
<pre>
そのまま結果に表示される
</pre>
</div>


<h3 class="title">
年や月、「日」などの感じやひらがな、カタカナなどは
</h3>
<div class="box">
<pre>
"で囲むと表示される(そうでなければエラー)
</pre>
</div>



### 年関連

- SCC or CC

世紀。Sを指定すると紀元前に-がつく

- SYYYY or YYYY

年。Sを指定すると日付の先頭に-がtく

- YYY or YY or Y

年の下 n桁

- SYEAR or YEAR

スペルによる年

- RR

年の下2桁。
YYとは「世紀」の扱いが異なり、

- Q

年の四半期


### 月

- MM

二桁の月

- MONTH

空白が埋め込まれた9文字の長さの名前
「January」など


- MON

月の名前の3文字の略称
「Jan」など

- RM

ローマ数字で表した月


### 週

- WW or W

年または月における週

- IW

ISOに基づく年間における週

### 日にち

- DDD or DD or D

年または月、週における日にち

- DAY

空白がm埋め込まれた9文字の長さの曜日。
「TUERTHDAY」など

- DY

曜日。3文字の略称系。「日」「月」など


## 時間

- AMorPM

午前か午後かを示す要素

- A.M. or P.M.

ピリオドを使用したA.M.を示す要素。
日本語だと「午前」「午後」

- HH or HH12 or HH24

時間,時間(1-12),時間(1-24)


- MI

分

- SS

秒

- SSSS

午前0時からの経過時間


### その他

- "of the"

そのまま反映される二重引用ふ

- FM

埋め込みモードの有効と無効を切り替えれる



- サンプルコード2


<pre><code>
select
  TO_CHAR(SYSDATE, 'YYYY/MM/DD'),
  TO_CHAR(SYSDATE, 'YYY"年"MM"月"DD"日"(DAY)')
from
  dual
</code></pre>

> 2014/01/24 2014年01月24日(金曜日)

- サンプルコード3


<pre><code>
select
  TO_CHAR(SYSDATE, 'YYYY/MM/DD'),
  TO_CHAR(SYSDATE, 'YYY年MM月DD日(DAY)')
from
  dual
</code></pre>

> エラーが発生する(二重引用ふを使っていないので)



## 大文字とお文字

<pre><code>
select
  sysdate,
  TO_CHAR(SYSDATE, 'Month:Mon:Day:Dy') 日本語環境,
  TO_CHAR(SYSDATE, 'Month:Mon:Day:Dy','nls_date_language = AMERICA') 先頭大文字,
  TO_CHAR(SYSDATE, 'month:mon:day:dy','nls_date_language = AMERICA') 先頭小文字
from
  dual
</code></pre>

> 14-01-24

> , 1月 :1月 :金曜日:金


> , January :Jan:Friday :Fry


> , javuary :jan:fryday :fri


## 日付書式の表示形式の変更

- サンプルコード

<pre><code>
select
  TO_CHAR(hiredate, 'DDth "of" Month, YYYY','nls_data_language = AMERICA'),
from
  employees
where
  deptno = 10
</code></pre>

> 25TH of February, 2001


> 02ND of May     , 2004



<h3 class="title">
DDthをddthに変えると
</h3>
<div class="box">
<pre>
「25th」や「02nd」に変わる
</pre>
</div>


- 02ndはsecondという意味か




<h3 class="title">
TH
</h3>
<div class="box">
<pre>
順序表記( DDTH : 4TH)
</pre>
</div>




<h3 class="title">
SP
</h3>
<div class="box">
<pre>
スペル表記( DDSP : FOUR)
</pre>
</div>




<h3 class="title">
SPTH or THSP
</h3>
<div class="box">
<pre>
スペル表記+順序表記

DDSPTH : FOURTH
</pre>
</div>


## FM要素


埋め込みモードを無効にして「数値の先行0」や「文字列の前後に含まれるスペース」が取り除かれて表示される

- サンプルコード

<pre><code>
select
  ename
    TO_CHAR(hiredate
      'ddth "of" Month, YYYY',
      'nls_date_language = AMERICA')
    TO_CHAR(hiredate
      'fmddth "of" Month, 'YYYY'),
      'nls_data_language = AMERICA')
from
  employees
</code></pre>

例一)
> 25th of Feburary , 2001


> 25th of Feburary, 2001

Monthの後のスペースがなくなる

例2)
> 02nd of May       , 2001


> 2nd of May, 2004

先行の0が取り除かれている



## TODO:数値の書式



## TODO:YYとRRの違い




## NULLチェック

- NVL(式一, 式2)

<h3 class="title">
戻り値のデータ型は
</h3>
<div class="box">
<pre>
式1と同じになる
</pre>
</div>


- NVL2(式1, 式２, 式3)

式1がNULL以外なら式2を

式1がNULLならば式3を返す


<h3 class="title">
常に式2と同じデータ型と同じになるようにデータが戻り
</h3>
<div class="box">
<pre>
それができない場合はエラーになる
</pre>
</div>


- NULLIF(式1, 式2)

二つの値を比較して、
<strong>等しい場合は「NULL」を戻し</storng>
そうでない場合は式1を戻す。


<h3 class="title">
式1には
</h3>
<div class="box">
<pre>
NULL以外なら設定できる
</pre>
</div>




- COALESCE(式1, 式2 [,式n])

式を左からチェックして最初に式1と一致したものを選択する


<h3 class="title">
引数は
</h3>
<div class="box">
<pre>
全て同じデータ型である必要がある
</pre>
</div>


<pre><code>
select
  comm,
  mgr,
  ename,
  COALESCE(comm, mgr, ename)
from
  employees
</code></pre>

> データ型が一致しません：　NUMBERが予想されましたがCHARです。

<pre><code>
select
  comm,
  mgr,
  ename,
  COALESCE(TO_CHAR(comm), TO_CHAR(mgr), ename)
from
  employees
</code></pre>

> 正常に実行可能



# IF-THEN-ELSEロジック

## DECODE関数

switch文みたいな感じ

<pre><code>
DECODE(式
        ,条件1, 戻り値1
        [,条件2, 戻り値1]
        [, デフォルトの戻り値])
</code></pre>

<pre><code>
select
  dept, ename, sal
  DECODE(deptno
               , 10, sal * 1.1
               , 20, sal * 1.2
               , sal*1.5) NEW_SAL
from
  employees
</code></pre>



# グループ関数

SELECT句とORDER BY句, HAVING句で使用可能。

WHERE句では使用できない

## COUNT関数

COUNTの中身は*とDISTINCTとALLを選べる

- *

NULLも含む全てのデータの件数

- ALL

重複した値でもそれぞれ1としてカウント。
NULLは無視される

- DISTINCT

重複した値を1回だけカウント
NULLは無視される

## MIN/MAX関数

<h3 class="title">
引数は
</h3>
<div class="box">
<pre>
数値型,文字列型, 日付型を指定可能
</pre>
</div>


文字を指定した場合はアルファベット順に並べ替えられる

## AVG/SUM

数値型飲みの列と式のみ指定できる

## LISTAGG関数

<pre><code>
LISTAGG( 連結する列名 [, デリミタ] ) WITHIN GROUP( ORDER BY ソート列名)
</code></pre>

<pre><code>
select
  deptno,
  LISTAGG(ename, ':')
  WITHIN GROUP(order by sal desc) menber_list
from
  employees
GROUP BY deptno;
</code></pre>

> 10, 32500, 佐藤:中村:佐々木


## NULLについて

NULLは基本無視される

AVGでヌルが入っていたら、MULLを無視したカウントで割る


## ネストについて

2レベルまでネスト可能





### GROUP BYについて


<h3 class="title">
 列別名は
</h3>
<div class="box">
<pre>
指定できない
</pre>
</div>


<h3 class="title">
SELECT句の選択可能な列は
</h3>
<div class="box">
<pre>
- GROUP BYで指定した列と
- グループ関数のみ指定可能
</pre>
</div>




<h3 class="title">
ORDERBYの指定可能な列は
</h3>
<div class="box">
<pre>
GROUP BYで指定した列と
グループ関数のみ
指定可能
</pre>
</div>

- サンプル

<pre><code>
select
  deptno, job, COUNT(*), AVG(sal)
from
  employees
group by
  deptno;
</code></pre>

> GROUP BYの式ではありません

※ GROUP BYに指定している列をselect句に必ず指定する必要はない
知ってるよね。

<pre><code>
select
  COUNT(*), AVG(sal)
FROM employees
GROUP BY deptno;
</code></pre>

>エラーは出ず、カウントと平均が出てくる

- ORDER BYでは必ずGROUP BYで指定している列とグループ関数しか定義できない

<pre><code>
select
  deptno 部門番号, MAX(sal) 最高給与
from
  employees
GROUP BY deptno
ORDER BY empno
</code></pre>

> GROPU BYの式ではありません：empno


### HAVING句

グループごとに条件を指定したい場合


<h3 class="title">
HAVING句の位置は
</h3>
<div class="box">
<pre>
WHERE句の後ろ
ORDER BY句の前
</pre>
</div>







## 列別名について

SQLの実行順序

<pre><code>
FROM
ON
JOIN
WHERE
GROUP BY
HAVING
SELECT(列別名)
DISTINCT
ORDER BY(列別名可能)
TOP
</code></pre>




# 表の結合

表接頭辞を使用した列



<h3 class="title">
両方の列に存在する列を
</h3>
<div class="box">
<pre>
SELECTで指定するとエラーになる

回避するためには表接頭辞を付けなければならない
</pre>
</div>




<pre><code>
select
  deptno, ename, deptno
from
  employees, departments
</code></pre>

> 列の定義が未確定です：deptno





## 自然結合

- 明示的に結合条件を指定する必要はない

- 共通する列が複数ある場合は、全ての列が結合条件になる


<h3 class="title">
データ型の異なる同名の列があると
</h3>
<div class="box">
<pre>
エラーになる
</pre>
</div>




<h3 class="title">
自然結合の結合列には
</h3>
<div class="box">
<pre>
表接頭辞を設定できない。where句でも同様
</pre>
</div>





<pre><code>
select
  e.empno, e.name, d.depth, d.name
from
  employees e
natural join
  departments d
</code></pre>

> NATURAL結合で使用される列は表接頭辞を指定できません

> エラー

<pre><code>
select
  e.empno, e.name, depth/* d.depthがないのでOK*/ d.name
from
  employees e
natural join
  departments d
</code></pre>

### 3つ以上の結合

NATURAL JOINもUSINGでも3つ以上の表を結合することは可能

- NATURAL JOINを使用する例
<pre><code>
sleect
  ordno,
  o.data_orderd
  ,od.quantity
  ,product_name
FROM
  customer c
NATURAL JOIN order o
NATURAL JOIN ord_details od
NATURAL JOIN product p
ORDER BY ordno,prodno;
</code></pre>

- USINGを使用する例

<pre><code>
sleect
  ordno,
  o.data_orderd
  ,od.quantity
  ,product_name
FROM
  customer c
JOIN order o USING(custno)
JOIN ord_details od USING(ordno)
JOIN product p USING(prodno)
ORDER BY ordno,prodno;
</code></pre>

- 2つのキメラも可能

<pre><code>
sleect
  ordno,
  o.data_orderd
  ,od.quantity
  ,product_name
FROM
  customer c
NATURAL JOIN order o
JOIN ord_details od USING(ordno)
JOIN product p ON od.prodno = p.prodno
ORDER BY ordno,prodno;
</code></pre>




## USING

二つの列に共通する列を指定できる

<h3 class="title">
NAtURAL JOINとUSINGは
</h3>
<div class="box">
<pre>
同時に使用できない
</pre>
</div>


<h3 class="title">
USING句もNATURAL JOINでも
</h3>
<div class="box">
<pre>
結合列に表接頭辞をつけるとエラーになる
</pre>
</div>


<pre><code>
select
  e.name,
  e.ename,
  d.dname
FROM
  employees e 
JOIN 
  departs d
USING (deptno)
WHERE
  e.deptno IN (10,20)
</code></pre>

> エラー


## ONの使用

異なる名前の列を結合したい時など

ONは「悲透過結合」や「自己結合」などでも使える

USINGは透過結合のみしか使えない

- 接頭辞は同じ名前の列を使用する際は必須


## 完全外部結合

JOINの左右に指定された表データを全て取り出すための結合

結合条件を満たさないものも含めて

FULL OUTER JOINを使う


# 副問い合わせについて


<h3 class="title">
一見も戻さない副問い合わせ
</h3>
<div class="box">
<pre>
NULLが戻されるので結果も0件になる

</pre>
</div>



<h3 class="title">
単一行用の演算子を使って複数行帰ってきたとき
</h3>
<div class="box">
<pre>
( < (副問い合わせ, <>(副問い合わせなど))

エラーになる
</pre>
</div>




<h3 class="title">
NOT IN演算子とNULL
</h3>
<div class="box">
<pre>
NOT IN で指定したリストやサブクエリーの値に NULL が存在すると、常に空の結果セットが返ってきてしまいます。

理由：IN は「=」であるためNOT INは「<>」となる。
ところが、<> NULL　の結果は常にFalseになるので、
NULLが存在するだけでどれもFalseになる。
</pre>
</div>


## 複数列副問い合わせ

<pre><code>
select
  empno,
  ename,
  sal,
  deptno
from
  employees
where
  (sal, deptno) 
  = (
    select 
      sal, deptno
    from
      employees
    where
      empno = 1013)
  and
    ename <> '山田'
</code></pre>



# 集合演算子

A : B : C

## UNION

二つの問い合わせを連結し、重複は一度のみで戻す。
こちらの方が一般的。

A : B : C

<h3 class="title">
内部的にソートした上で重複を廃城するので
</h3>
<div class="box">
<pre>
実行結果は(ORDER BYを使わずとも)selectの先頭で昇順にソートされる。
同一の値は二つ目の列でソートされる。
</pre>
</div>



## UNION ALL

二つの問い合わせを連結し、重複したものはその数だけ戻す。

A : B : B : C

<h3 class="title">
内部的に重複の削除を行わないので
</h3>
<div class="box">
<pre>
唯一実行結果もソートされない
</pre>
</div>


## INTERSECt

二つの問い合わせの結果のうち、共通するものを戻す。

 : B : 

<h3 class="title">
内部的にソートした上で共通部分を取り出すので
</h3>
<div class="box">
<pre>
実行結果はselectの先頭で昇順にソートされる。
</pre>
</div>


## MINUS

一つ目の問い合わせの結果のうち、二つ目にないものを返す。

a :

<h3 class="title">
内部的にソートした上で
</h3>
<div class="box">
<pre>
実行結果はselectの先頭で昇順にソートされる。
</pre>
</div>


<h3 class="title">
Aだけ取り出すというその性質上、
</h3>
<div class="box">
<pre>
一つ目と二つ目の列を入れ替えた時に

MINUSのみが表示されるデータが異なる。
</pre>
</div>

## 集合演算子のガイドライン


<h3 class="title">
個数は
</h3>
<div class="box">
<pre>
同数に
</pre>
</div>


<h3 class="title">
データ型は
</h3>
<div class="box">
<pre>
1つ目の問い合わせのデータ型と同じか
同じデータ型グループ(CHARとVARCHAR2など)である必要がある
</pre>
</div>


- サンプルコード

<pre><code>
select
  empno from employees
union
select
  deptno from employees
</code></pre>

> 正常に実行される

<pre><code>
select
  empno from employees
union
select
  ename from employees
</code></pre>

> エラーになる(NUMBERとCHAR)


## 集合演算子とORDER BYについて




<h3 class="title">
ORDER BYの位置は
</h3>
<div class="box">
<pre>
- 最後の集合の後に指定する必要がある
</pre>
</div>

<h3 class="title">
ORDER BYの列指定では
</h3>
<div class="box">
<pre>
最初のselect句の列と列別名のみ使用可能
</pre>
</div>



## NULLについて

NULLは無視されない

<h3 class="title">
UNION ALLでは
</h3>
<div class="box">
<pre>
重複したNULLも戻す
</pre>
</div>

<h3 class="title">
UNIONでは
</h3>
<div class="box">
<pre>
NULLがあれば一件だけ出てくる
</pre>
</div>



# データ操作,トランザクション

- INSERT文(想像通り)

<pre><code>
INSERT INTO 表名
[( 列名1[,列名2, ...] )]

VALUES( 値1 [,値2...] )
</code></pre>

列名は省略できるが、その場合は表の定義と同じ順番で、
全ての値を指定する必要がある。

列の値を明示的にした場合、
列名とVALUESの一対一関係が同じである必要がある。

NULLについては列の名前を省略するか、NULLキーワードを指定すれば良い

ただし、NULL?が「NOT NULL」では指定できずエラーになる

関数や副問い合わせの利用も可能

- 副問い合わせを利用したINSERT文

<pre><code>
INSERT INTO 表名1 (列名 [,列名2 ...] )
SELECT
  列名 [,列名2 ...] 
FROM
  表名2
...
</code></pre>


<h3 class="title">
VALUES句は
</h3>
<div class="box">
<pre>
指定しない
</pre>
</div>



<h3 class="title">
副問い合わせの()は
</h3>
<div class="box">
<pre>
必須ではない
</pre>
</div>

INSERTの省略も可能だが、同じ位置に同じ数ではあること。

副問い合わせのSELECTの*の
使用可能不可能のみ不明。多分できない。⇨可能だった

<pre><code>
定義が同じテーブルで全件 INSERT する場合

INSERT INTO テーブルA
SELECT * 
FROM   テーブルB
</code></pre>



## UPDATEと副問い合わせ

- サンプルコード1

<pre><code>
UPDATE
  emp_compy
SET
  job = (
      SELECT
        job
      FROM
        employees
      WHERE
        empno = 1010
  ),
  sal = (
      SELECT
        sal
      FROM
        employees
      WHERE
        empno = 1010
  )
WHERE
  empno = (
    SELECT
      empno
    FROM
      employees
    WHERE
      ename = '加藤'
  )
</code></pre>

- サンプルコード2

<pre><code>
UPDATE
  emp_compy
SET
  (job, sal) = (
      SELECT
        job, sal
      FROM
        employees
      WHERE
        empno = 1010
  )
WHERE
  empno = (
    SELECT
      empno
    FROM
      employees
    WHERE
      ename = '加藤'
  )
</code></pre>

# トランザクション

DMLでエラーが出たときは
自動コミットはされず、自動ロールバックされる


## 読み取り一貫性

：ロールバックされる可能性のある未確定のデータは他のセッションからは参照できない




## 排他ロック

FOR UPDATE句を使用すると、SELECTの実行中に行レベルの排他ロックを取得することができる

排他ロックはトランザクションの終了(COMMITされるまで)続く。












## CREATE TABLE

<pre><code>
CREATE TABLE スキーマ名.表名
(
    列名 データ型
    [, 列名 データ型
    ...]
)
</code></pre>

サンプル

<pre><code>
CREATE TABLE empl
(
    empno NUMBER(4),
    ename VARCHAR(10)
)
</code></pre>


## DEFAULTオプション

表の作成時に列の定義にデフォルトオプションを追加できる。

INSERT文で値を省略した際にはこの時に設定した値が適応される。

構文

<pre><code>
CREATE TABLE [スキーマ名].表名
(
    列名 データ型 DEFAULT デフォルト値
    [,列名 データ型
     ,列名 データ型
     ...
    ]
)
</code></pre>

- サンプルコード

<pre><code>
CREATE TABLE employees
(
    empno NUMBER(4),
    ename VARCHAR2(20),
    hiredate DATE DEFAULT SYSDATE
)
</code></pre>

- INSERT時の挙動

<pre><code>
INSERT INTO emp2(empno, ename)
values (10, 'tarou');

SELECT * FROM emp2;
</code></pre>


## DEFAULTの値

リテラル値、式またはSQL関数を指定できる。(SYSDATE式やUSER式など)


## NULLの取扱

NULLは無視される



# DDLについて

以下の3つのコマンドはDDLである


<h3 class="title">
DDLコマンド3つ
</h3>
<div class="box">
  <p>
    ALTERコマンド(オブジェクトの定義情報を変更する)
  </p>
  <p>
  DROPコマンド
  </p>
  <p>
  TRUNCATEコマンド(表が使用しているデータ領域を丸ごと削除)
  </p>
</div>





# DROP TABLE

- 表内の全てのデータが削除されう

<h3 class="title">
表に定義されている
</h3>
<div class="box">
  <p>
索引も削除される
  </p>
</div>

- ただし、完全に削除したわけではなく、ゴミ箱に移動されるのみ

- また、シノニムやビューは削除されない

- 完全に削除したい場合はPURGE句を使うと良い。


<h3 class="title">
PUERGRのサンプルコード
</h3>
<div class="box">
  <p>

<pre><code>
DROP TABLE empl PURGE;
</code></pre>
  </p>
</div>


(削除されたごめ箱を復元するにはFLASHBACK TABLEコマンドを使用する)


# データ型

## VARCHAR2型

最大4000バイトまで格納可能。可変長のデータ型

<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
  <p>
サイズの指定が必須
  </p>
</div>



可変長とは、格納するデータのサイズに応じてサイズが変わる。

VARCHAR(10)の列にabcを代入すると「abc」が格納される



## CHAR型

最大2000バイトまで格納可能。固定長のデータ型


<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
  <p>
サイズの指定を省略すると、サイズが「1」になる
  </p>
</div>


固定長とは、表作成時に作成したサイズで一定という意味。

CHAR(10)の列にabcを代入すると「abc_______」が代入される。



<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
  <p>
よって、CHAR(10)の列をLENGTHで測ると、格納したサイズにかかわらず必ず10になる
  </p>
</div>


## LONG型

最大2Gまでの文字データを格納可能


<h3 class="title">
サイズ指定
</h3>
<div class="box">
  <p>
  不可
  </p>
</div>


<h3 class="title">
副問い合わせを使用した表の作成時に
</h3>
<div class="box">
  <p>
  LONG列はコピーできない
  </p>
</div>

<h3 class="title">
GROPU BYとORDER BY句に
</h3>
<div class="box">
  <p>
  指定できない
  </p>
</div>



<h3 class="title">
一つの表に
</h3>
<div class="box">
    <p>
    一つだけ(LONG列またはLONG RAW列)しか定義できない
  </p>
</div>

<h3 class="title">
LONG列には
</h3>
<div class="box">
    <p>
    制約を定義できない
  </p>
</div>


# 以下LOB(Large Object )だが

<h3 class="title">
LOBは全て
</h3>
<div class="box">
    <p>
    サイズ指定不可
  </p>
</div>




## CLOB型

最大4Gまでの文字列を格納できるデータ型



## NCLOB型

最大4GまでのUnicode文字列を格納できるデータ型




# 数値型

NUMBER型を使う

<pre><code>
列名 NUMBER[(最大精度[,位取り])]
</code></pre>

最大精度は最大桁数：最大38桁

位取り：格納する数値データの小数点以下の桁数を指定する



<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>
NUMBER(5,2)が指定されている場合
実質的に整数部分は5-2で3桁が上限となる。

123.456を代入すると
データに四捨五入がされて「123.46」が代入される

1234.567を代入すると
整数部分が5-2=3より大きい4桁であるため、エラーになる。
</pre>
</div>


# 日付型

固定長で7バイトのデータ

<pre><code>
列名 DATE
</code></pre>

世紀、年、月、日、時間、分、秒が内部的な数値形式で格納される。


# バイナリデータ型

## RAW型

バイナリデータ(最大2000)を指定可能。

- サイズの指定はできない


## LONG RAW型

最大2Gまでのバイナリデータを格納可能

- LONGと同等の制約がある


## BLOB 

4Gまでのバイナリデータを格納できる。


## BFILE

4Gまでのバイナリデータを格納できる、読み取り専用のデータ型

OS上のファイルイメージに保存されている。


## LOB型

CLOB,BLOB,BFILEはLOB型と呼ばれる。

<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>
実際には表とは異なる場所に実際のデータを格納し、
費用の中には実際にデータを格納した場所へのポインタ
情報のみを格納して使うことができる。

LONG型に当てはまるような制約はない
(一つの列に複数のLOBを定義できる)

</pre>
</div>

CLOBとBLOBはOracleサーバーのデータファイルにデータとポインタ情報を格納するが、
BFILEはサーバー上のポインタ情報のみを格納する。



# ROWID型

<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>
全ての表に自動的に登録されている列

どの表も、それぞれの行を一意に識別するROWIDが存在する。(表作成時に宣言しなくとも)
</pre>
</div>



# そのほかのデータ型


## TIMESTAMP型

DATE型を拡張子たデータ型

<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>
DATEのかく列に加えて、秒の使用数点以下の値も格納可能
</pre>
</div>

TIMESTAMPではSYSTIMESTAMPの実行で容易に格納可能

## TIMESTAMP WITH TIME ZONE

タイムゾーンの時差を含むことができる。タイムゾーンの時差は列の一部として格納される

alter sessionでローカル日時を変えても変化しない

## TIMESTAMP WITH LOCAL TIMEZONE

タイムゾーンの時差を含むことができる。

<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>
タイムゾーンの時差は列の一部として格納されず、

データ取得時にローカルセッションのタイムゾーンの値で
表示される

alter sessionでローカル日時を変えても変化しない

</pre>
</div>


# INTERVAL関連

- INTERVAL YEAR TO MONTH

二つの自国の感覚を、年、または月の単位で保存する

- INTERVAL DAY TO SECOND

二つの時間の差を、日付から秒単位で格納する

サンプルコード

<pre><code>
CREATE TABLE time3
(
    timeA INTERVAL YEAR TO MONTH,
    timeB INTERVAL DAY  TO SECOND
);
</code></pre>

<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>
INSERT INTO time3
VALUES(
    INTERVAL '1-2'      YEAR TO MONTH,
    INTERVAL '10 12:30' DAY TO MINUTE
);

SELECT
    TO_CHAR( SYSDATE, 'YYY-MM-DD HH24:MI'),
    TO_CHAR( SYSDATE + timeA, 'YYY-MM-DD'),
    TO_CHAR( SYSDATE + timeB, 'YYY-MM-DD HH24:MI')
from
    time3;

</pre>
</div>





# 制約

## 制約一覧

- NOT NULL制約

NULLを許可しない

- UNIQUE制約

重複値を許可しない。

NULLは許可する


- PRIMARY KEY制約

表内の各業を一意に識別できる値を許可する。

- FOREGN KEY制約

参照先の列にある値、またはNULLのみ許可する

- CHECK制約

自前の制約をつけることができる


## 制約の定義方法

制約は

<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>
列レベル or 表レベルで定義できる

列レベル制約、表レベル制約と呼ぶ
</pre>
</div>

- サンプルコード

<pre><code>
CREATE TABLE [スキーマ名].表名
(
    列名 データ型 [列レベル制約 [列レベル制約 ...]],
    ...
    [, 表レベル制約 [,表レベル制約]]
)
</code></pre>


- 列レベル制約の基本構造

<pre><code>
[CONSTRAINT 制約名] 制約の種類
</code></pre>

<pre><code>
CREATE TABLE emp1
(
    empno NUMBER(4) CONSTRAINT emp1_empno_pk PRIMARY KEY,
    ename CARCHAR2(20)
)
</code></pre>


<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>
- CONSTRAINT 制約名を省略した場合、
「SYS_Cn」の名前が自動的につけられる

- NOT NULL制約は列レベルでのみ定義可能

- 複数の制約をつける場合は改行かスペースで区切る
</pre>
</div>





- 表レベルの制約の基本構文

<pre><code>
[CONSTRAINT 制約名] 制約の種類 (列名,[列名...])
</code></pre>

サンプルコード

<pre><code>
CREATE TABLE emp2
(
    empno NUMBER(4) ,
    ename VARCHAR2(20) ,
    CONSTRAINT emp2_empno_pk PRIMARY KEY (empno)
)
</code></pre>

<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>
- ()内に制約を定義する列を1つ以上指定すること

- 複数の制約を定義するときは「,」を使う

- 複数の列からなる制約は表レベルで制約が可能
</pre>
</div>

- そのほかのルール

<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>
- 表作成後にもルールを定義することができる

- その場合は、格納されているデータが追加する制約のルールにしたがっている場合に限る。
</pre>
</div>



## NOT NULL制約

NULLの値を設定できなくなる


<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>
列レベルでのみ設定可能
</pre>
</div>


## UNIQUE制約(一意キー制約)

重複した値を格納できなくなる制約。


<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>
- NULLは格納可能

- 複数行にNULLを含めることも可能(NULLは重複しても良い)

- 自動的に制約と同じ名前の一意索引(重複が許可されない索引)が作成される

- 列の組み合わせについての索引は表レベルでなければいけない
</pre>
</div>

- 列の組み合わせについての索引は表レベルでなければいけない、
その場合は()に複数の列を追加する

<pre><code>
CREATE TABLE emp6
(
    empno NUMBER(4) CONSTRAINT emp6_empno_nn NOT_NULL,
    ename VARCHAR2(20) CONSTRAINT emp6_ename_nn NOT NULL,
    job VARCHAR2(20),
    deptno NUMBER(3),
    CONSTRAINT emp6_dept_no_job_uk UNIQUE(deptno, job)
)
</code></pre>

- 「,」で区切ることが大事



## PRIMARY KEY制約

重複とNULLを許可しなくなる制約


<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>
- NULLも許可しないことに注意(一意に定まらなければならない)

- 

- 名前の一意索引が作成される

- 組み合わせに対してもPRIMARY KEYは作成できる
</pre>
</div>


<h3 class="title">
PRIMARY KEYの数は
</h3>
<div class="box">
<pre>
表に一つのみ定義できる
</pre>
</div>



## FOREGN KEY(外部キー制約):REFERRENCES

参照先の列に存在する値しか格納できなくなる

<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>
- NULLは格納可能である

- 参照先の列は「UNIQUE制約」か「PRIMARY KEY制約」がついていないといけない

</pre>
</div>

- 列レベルの構文

<pre><code>
[CONSTRAINT 制約名] REFERENCES 親表名( 参照する列名 [, 参照する列名])
</code></pre>

サンプルコード

<pre><code>
CREATE TABLE emp7
(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(4) CONSTRAINT emp7_dept1_deptno_fk REFERENCES dept1(deptno)
)
</code></pre>



- 表レベルの構文

<pre><code>
[CONSTRAINT 制約名] FOREGN KEY(列名[,列名])
REFERENCES 親表名(参照する列名 [,参照する列名])
</code></pre>

サンプルコード

<pre><code>
CREATE TABLE emp8
(
    empno NUMBER(4)
    ename VARCHAR(10),
    deptno NUMBER(4)
    CONSTRAINT emp8_dept1_deptno_fk FOREGN KEY(deptno) REFERENCES dept1(deptno)
)
</code></pre>

- 親表とは

参照先の列名のこと

- そのほか注意

<pre><code>
- 列の組み合わせに対してFOREIGN KEY制約を定義する場合は表レベルの制約にする必要がある
その場合は()を使用する必要がある
</code></pre>


<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>

- 親表で依存されている行を削除する場合は「子」の表から
行を削除する必要がある。

- FOREGIN KEYを定義した表は依存する行がなくても、子の表があるかぎり削除できない。

</pre>
</div>





## ON DELETE CASCADE

子の表に親表を参照する行が存在する場合に
親表の依存されている行を削除すると
「子の表の行も同時に削除される」

親が倒れると子も倒れる

<pre><code>
CREATE TABLE emp9
(
    empno NUMBER(4),
    ename VARCHAR2(20)
    deptno NUMBER(4) CONSTANT emp9_dept2_deptno_fk
    REFERENCES dept2(deptno)
    ON DELETE CASCADE
)
</code></pre>


## ON DELETE SET NULL

子の表に親表を参照する行が存在する場合に
親表の依存されている行を削除すると
子の参照している行にNULLが設定される

<pre><code>
CREATE TABLE emp9
(
    empno NUMBER(4),
    ename VARCHAR2(20)
    deptno NUMBER(4) CONSTANT emp9_dept2_deptno_fk
    REFERENCES dept2(deptno)
    ON DELETE SET NULL
)
</code></pre>


## CHECK制約

地震で指定した条件に対してTRUEまたはNULLを戻す値しか格納できなくなる
(FALSEのみNG)

基本的に
where句と同じ条件を指定できるが、以下の行為は禁止

<pre><code>

- ほかの行の値を参照すること

- SYSDATE
  
- USER

- CURRVAL,NWXTVAL,ROWNUMの呼び出し

</code></pre>

サンプルコード

<pre><code>
CREATE TABLE emp11
(
    empno NUMBER(4),
    ename VARCHAR2(20)
    sal NUMBER(7) CONSTRUCT
    emp11_sal_ck
    CHECK(sal > 0 AND sal < 1500000)
)

</code></pre>

複数の列でCHECK制約をする場合は、表レベルである必要がある

<pre><code>
CREATE TABLE emp11
(
    sal NUMBER(4),
    comm NUMBER(20),
    CONSTRAINT emp12_sal_ck CHECK(sal > 0 and sal < 1500000),
    CONSTRAINT emp12_com_ck CHECK(comm < sal)
)

</code></pre>



## 副問い合わせを使用した表の作成

データ型は指定できない。

元々のがコピーされる


<pre><code>
CREATE TABLE 表名
AS
副問い合わせ
</code></pre>

<h3 class="title">
列名の指定は省略できる。select句で指定した列名または列別名と同じ名前の列が作成される。
</h3>
<div class="box">
<pre>
ただし、副問い合わせのselectで計算式や関数を使用している場合は、
列名を指定するか、列別名を指定する必要がある。
</pre>
</div>


<h3 class="title">
列名を指定すると、その名前が表に定義される
</h3>
<div class="box">
<pre>
ただし、その場合はselect句のリストと同じ数にする必要がある
</pre>
</div>


<h3 class="title">
制約については
</h3>
<div class="box">
<pre>
NOT NULL以外はコピーされない。(PRIMARY KEYもコピーされない)
</pre>
</div>

- サンプルコード

<pre><code>
CREATE TABLE dept_copy
AS
SELECT * FROM departments;
</code></pre>

上記もNOT NULL制約以外はコピーされない

- エラーが出るサンプルコード

<pre><code>
CREATE TABLE emp10
AS
SELECT empno, sal, sal*12
FROM employees
WHERE deptno = 10
</code></pre>

> 式に列の別名を指定する必要があります

<pre><code>
CREATE TABLE emp10(empno, sal, annsal)
AS
SELECT empno, sal, sal*12
FROM employees
WHERE deptno = 10
</code></pre>

- 表構造だけのコピー

<pre><code>
CREATE TABLE emp_copy2
AS
SELECT * FROM employees
WHERE 1 = 2;
</code></pre>

絶対にTRUEにならない条件を指定することで表構造だけをコピーすることもできる。



# 表構造の変更


ALTER TABLEを使用することで表を後から変更できる

- 新しい列を追加する
- 列のデータ型を変更する
- デフォルト値を設置絵する
- 列を削除する
- 列の名前を変更する
- 読み取り、書き込みモードに変更する
- 読み取り専用モードにする

## 列の追加

列の追加もALTER TABLEコマンドを使う

新しく追加された列にはNULLが含まれている

<pre><code>
ALTER TABLE 表名
ADD (
    列名 データ型 [DEFAULT 式][列レベル制約]
    [,列名 データ型 [DEFAULT 式][列レベル制約]]
);
</code></pre>


- サンプルコード

<pre><code>
CREATE TABLE emp14
(
    empno number(4),
    ename varchar2(10)
);
</code></pre>

## 制約について

<h3 class="title">
既存の行が制約のルール
</h3>
<div class="box">
<pre>
既存の行が制約のルールにしたがっている場合のみ、
列レベルの制約を使用して制約を追加できる。
</pre>
</div>



- NOT NULL制約の付け加え方

「新しく追加された列にはNULLが含まれている」という性質から
NOTNULL制約をつけるには次の方法がある


<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>
表自体がからの場合
DEFAULT オプションを指定してデフォルトにNULL以外を設定すること
</pre>
</div>

サンプルコード

<pre><code>
ALTER TABLE emp14
(
    sal number(8) NOT NULL
);
</code></pre>

> (既存のデータがあると)エラーになる

<pre><code>
ALTER TABLE emp14
(
    sal number(8) DEFAULT  200000 NOT NULL
);
</code></pre>

> 既存の行は200000が設定される

## 列の変更

<h3 class="title">
変更可能な要素
</h3>
<div class="box">
<pre>
データ型
サイズ
デフォルト値
</pre>
</div>


<pre><code>
ALTER TABLE MODIFIY 
(
    列名 [データ型] [DEFAULT 式]
)
</code></pre>


<h3 class="title">
サイズ,精度については
</h3>
<div class="box">
<pre>
いつでも増加できる
</pre>
</div>


<h3 class="title">
減少は次の場合に可能
</h3>
<div class="box">
<pre>
データがない
NULLしかない
既存の列の最大値未満にはできない
</pre>
</div>

<h3 class="title">
NULLだけの場合
</h3>
<div class="box">
<pre>
データ型を変更できる
</pre>
</div>


<h3 class="title">
NULL以外でも
</h3>
<div class="box">
<pre>
サイズを変更しない場合は
CHARとVARCHAR2の行き来はできる
</pre>
</div>


<h3 class="title">
デフォルトの設定は
</h3>
<div class="box">
<pre>
以降の表への挿入に適応される
</pre>
</div>




## 列の削除

<pre><code>
ALTER TABLE 表名 DROP (列名 [,列名])
</code></pre>

<h3 class="title">
対象の列にデータが
</h3>
<div class="box">
<pre>
存在する場合も存在しない場合も可能
</pre>
</div>

<h3 class="title">
列が0になるにように削除することは
</h3>
<div class="box">
<pre>
できない
</pre>
</div>

<h3 class="title">
列の削除は
</h3>
<div class="box">
<pre>
元に戻せない
</pre>
</div>

<h3 class="title">
依存される主キーは
</h3>
<div class="box">
<pre>
CASCADEオプションを指定しない限り削除できない
</pre>
</div>


## 表モードの変更

「読み取り/書き込みモード」と「読み取り専用モード」の2種類がある

<pre><code>
ALTER TABLE 表名 (READ WRITE | READ ONLY);
</code></pre>

<h3 class="title">
ただし
</h3>
<div class="box">
<pre>
表の削除はできる
</pre>
</div>




<h3 class="title">

</h3>
<div class="box">
<pre>


</pre>
</div>





<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
<pre>


</pre>
</div>




<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
  <p>

  </p>
</div>




<h3 class="title">

</h3>
<div class="box">
  <p>

  </p>
  <p>

  </p>
  <p>
  
  </p>
</div>





<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>




<script>
//アコーディオンをクリックした時の動作
$('.title').on('click', function() {//タイトル要素をクリックしたら
  var findElm = $(this).next(".box");//直後のアコーディオンを行うエリアを取得し
  $(findElm).slideToggle();//アコーディオンの上下動作
    
  if($(this).hasClass('close')){//タイトル要素にクラス名closeがあれば
    $(this).removeClass('close');//クラス名を除去し
  }else{//それ以外は
    $(this).addClass('close');//クラス名closeを付与
  }
});

//ページが読み込まれた際にopenクラスをつけ、openがついていたら開く動作※不必要なら下記全て削除
$(window).on('load', function(){
  $('.accordion-area li:first-of-type section').addClass("open"); //accordion-areaのはじめのliにあるsectionにopenクラスを追加
  $(".open").each(function(index, element){ //openクラスを取得
    var Title =$(element).children('.title'); //openクラスの子要素のtitleクラスを取得
    $(Title).addClass('close');       //タイトルにクラス名closeを付与し
    var Box =$(element).children('.box'); //openクラスの子要素boxクラスを取得
    $(Box).slideDown(500);          //アコーディオンを開く
  });
});
</script>

<style>
@charset "UTF-8";

/*==================================================
アコーディオンのためのcss
===================================*/

/*アコーディオン全体*/
.accordion-area{
    list-style: none;
    width: 96%;
    max-width: 900px;
    margin:0 auto;
}

.accordion-area li{
    margin: 10px 0;
}

.accordion-area section {
  border: 1px solid #ccc;
}

/*アコーディオンタイトル*/
.title {
    position: relative;/*+マークの位置基準とするためrelative指定*/
    cursor: pointer;
    font-size:1rem;
    font-weight: normal;
    padding: 3% 3% 3% 50px;
    transition: all .5s ease;
}

/*アイコンの＋と×*/
.title::before,
.title::after{
    position: absolute;
    content:'';
    width: 15px;
    height: 2px;
    background-color: #333;
    
}
.title::before{
    top:48%;
    left: 15px;
    transform: rotate(0deg);
    
}
.title::after{    
    top:48%;
    left: 15px;
    transform: rotate(90deg);

}
/*　closeというクラスがついたら形状変化　*/
.title.close::before{
  transform: rotate(45deg);
}

.title.close::after{
  transform: rotate(-45deg);
}

/*アコーディオンで現れるエリア*/
.box {
    display: none;/*はじめは非表示*/
    background: #f3f3f3;
  margin:0 3% 3% 3%;
    padding: 3%;
}

</style>



title:ORACLE Bronze SQL 勉強メモ




