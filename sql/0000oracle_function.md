


#### oracleで使用可能な関数一覧

oracleでは以下の関数が使用可能である。

- [UPPER関数](#upper関数)
- [LOWER関数](#lower関数)
- [INTCAP関数](#intcap関数)
- [CONCAT関数](#concat関数)
- [SUBSTR関数](#substr関数)
- [LENGTH関数](#length関数)
- [INSTR関数](#instr関数)
- [LPAD,RPAD関数](#lpadrpad関数)
- [TRIM関数](#trim関数)
- [REPLSCE関数](#replsce関数)
- [ROUND関数](#round関数)
- [TRUNC関数](#trunc関数)
- [MOD関数](#mod関数)
- [現在時刻を返す関数](#現在時刻を返す関数)
- [日付の四則演算](#日付の四則演算)
- [日付-日付](#日付-日付)
- [日付 + 日付](#日付--日付)
- [MONTHS\_BETWEEN関数](#months_between関数)
- [ADD\_MONTHS関数](#add_months関数)
- [NEXT\_DAY関数](#next_day関数)
- [LAST\_DAY関数](#last_day関数)
- [ROUND関数](#round関数-1)
- [TRUNC関数](#trunc関数-1)


 二種類の関数

SQLの関数には二種類ある

一つが単一行関数

もう一つがグループ関数

グループ関数は複数の結果を集計して出力するのが特徴

- 例）MAX関数(複数の値から最大のものを返すもの)

対して単一行関数は複数の結果に対して一つの結果を出力するのが特徴

- 例）UPPER関数（太文字に変換する）



### UPPER関数

文字列を全て大文字に書き換えることができる関数

<pre><code>
SELECT name, UPPER(name) FROM employees;

>satomi, SATOMI
</code></pre>

上記の例では「satomi」というフィールドを「SATOMI」に変換している


### LOWER関数

全ての文字列を小文字に変えることができる関数


### INTCAP関数

- 単語の先頭にあるアルファベットを大文字に、

- それ以外を小文字に直す

<pre><code>
select INTCAP("test code") from dual;

> Test Code
</code></pre>

単語として区切られる文字列はスペースの他に-や,も認識される


### CONCAT関数

文字列を結合する関数

<pre><code>
select
    CONCAT("Hello", "World")
from
    dual;

> HelloWorld
</code></pre>

注意！結合できる文字列は二つだけ！、三文字以上の結合はできない！



### SUBSTR関数

範囲を選択して文字列を取り出す関数

SUBSTR(m,n)なら

m文字目からn文字だけ取り出すという意味

1スタートなのは注意！

<pre><code>
select
    SUBSTR("test code", 6, 3)
from
    dual;

> cod
</code></pre>


### LENGTH関数

文字数を表す関数

<pre><code>
select
    LENGTH("あいうえお")
from
    dual

> 5
</code></pre>


###  INSTR関数

指定した文字列パターンが現れる位置
を表す関数

最後まで文字がない場合はINSTRは0を返す。



<pre><code>
select 
    instr('Oracle server', 'er', 1, 3),
    instr('Oracle server','er')
FROM dual;

> 12, 9

</code></pre>

###  LPAD,RPAD関数

 n文字になるように埋め込みを行う関数


<pre><code>
select
    yomi,
    LPAD(yomi, 10, '*'),
    RPAD(yomi, 10, '$'),
from
    employees;

>sato,
******sato
sato$$$$$$
</code></pre>

上記の例だと「sato」が10文字になるように埋め合わせを行なっている。

LPADは左にパディングを(padding　Left の略)

RPADは右にパディングを(padding right の略)



###  TRIM関数

TRIMの第一引数には三通りの選択があり

- LEADINGなら「文字列の先頭にある削除文字を削除する」

- TRALINGなら「文字列の末尾にある削除文字を削除する」

- BOTH(デフォルトの値)なら「先頭と末尾両方の文字列を削除する」

という挙動に変わる

次の例では、Oracle Serverから,先頭のOが取り除かれている

<pre><code>
SELECT TRIM(LEADING 'O' FROM 'Oracle Server')
FROM dual;

> racle Server
</code></pre>

注意！TRIMの第一引数を省略するとBOTHが適用されます


###  REPLSCE関数

マッチした文字列を全て書き換える関数

書き換える文字列を省略した場合は、対象の文字列を削除する挙動に変わる

<pre><code>
select
    REPLACE('Oracle Server', 'Server', 'Hello!!!'),
    REPLACE('Oracle Server', 'Server')
FROM dual;

> Oracle Hello!!!  Oracle
</code></pre>


### ROUND関数

小数点以下n桁を四捨五入する関数

桁数の指定を行わない場合は整数値になるように四捨五入される

負の値を返すことで、整数値の値も四捨五入できる

<pre><code>
ROUND(12345.678, 1)
> 12345.7

ROUND(12345.678)
>12346

ROUND(12345.678, -1)
>12350
</code></pre>


### TRUNC関数

小数点以下n桁に切り捨てる関数

桁の繰り上げを行わないのが特徴。

<pre><code>
ROUND(12345.678, 1)
> 12345.6

ROUND(12345.678)
>12345
</code></pre>



### MOD関数

割り算の余りを返す関数

<pre><code>
MOD(10,3)
>1

MOD(20,4)
>0
</code></pre>


###  現在時刻を返す関数

sysdateは現在の時刻を返す関数

<pre><code>
select
    sysdate
from dual;

>2021-11-10 14:15:00
</code></pre>


###  日付の四則演算

日付の計算における1は「一日」を表す

よって、一時間を表したい時は「1/24」と表記する

<pre><code>
sysdate -1,
>> 2021-11-9 14:15:00

sysdate -1/24
>> 2021-11-10 13:15:00
</code></pre>

###  日付-日付

日付同士の四則演算は「日数」が返される

<pre><code>
2021-11-10 13:15:00 - 2021-11-9 13:15:00
> 1
</code></pre>

###  日付 + 日付

エラーが出る

(日付と日付の四則演算はできません。)


###  MONTHS_BETWEEN関数

二つの日付の月数を戻す

次の関数は雇った日から何ヶ月たったかを表す（4ヶ月)

<pre><code>
select
    MONTHS_BETWEEN(sysdate, hire_date)
from
    employees;

> 4
</code></pre>

###  ADD_MONTHS関数

日付に対して加算、引き算ができる。

<pre><code>
ADD_MONTHS(sysdate, -1)
> 2021-10-10 13:15:00
</code></pre>


###  NEXT_DAY関数

指定された曜日の翌日以降に指定された曜日になる日付(つまり一週間後)を返す関数

<pre><code>
NEXT_DAY(日付,'曜日')
</code></pre>

曜日は「日曜日」「月曜日」
または「日」「月」...の形式

英語だと
「SUM」「MON」...の形式


###  LAST_DAY関数

日付に指定された月の最終日を持ってくる関数

<pre><code>
LAST_DAY("2021-01-21")

> 2021-01-31
</code></pre>


###  ROUND関数 

指定された日付を四捨五入して表す関数

<pre><code>
ROUND(日付, 'YEAR')
ROUND(日付, 'MOMNTH')
ROUND(日付, 'DD')

例）
ROUND("2021-01-21",'YEAR')

> 2021-02-01
</code></pre>



###  TRUNC関数 

指定された日付を四捨五入して表す関数

<pre><code>
TRUNC(日付, 'YEAR')
TRUNC(日付, 'MOMNTH')
TRUNC(日付, 'DD')

例）
TRUNC("2021-01-21",'YEAR')

> 2021-01-01
</code></pre>






title:SQLで使える関数一覧【SQL基礎入門】

description:oracleマスターbronzeのweb問題集です。間違いやすい問題に厳選してあります。

img:https://www.oreilly.co.jp/books/images/picture_large4-87311-281-8.jpeg

category_script:page_name.startswith("1")