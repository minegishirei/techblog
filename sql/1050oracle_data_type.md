

## 暗黙的な型変換

暗黙的な型変換とは、SQL側の忖度である。

通常プログラミングにおいて二つ以上のデータの比較、代入等が発生した場合、その二つが異なるデータ型であればエラーとなってしまう。

<pre><code>
例）
select max(to_date("2021-01-14") , 10) from dual
>　これはエラーになる
</code></pre>

しかし、ある特定の異なるデータ方の代入、比較、演算においてはエラーが出ない

<pre><code>
例）
select to_date("2021-01-01") + 1  from dual
> 2021-01-02
</code></pre>

これは

###SQLというプログラミング言語が忖度を行い、ユーザーの意向を取り計らってくれるからである。

これを

### 暗黙的な型変換

と呼ぶ




## 暗黙的な型変換が失敗するケース

### 暗黙的な型変換は、変換データが意味を持たない場合に失敗する

例えば次のコードはエラーが発生する

<pre><code>
select
    *
FROM
    employees e
where
    e.birthday > '1998-90-90'
</code></pre>

理由は、'1998-90-90'を日付に変更しようにも、90月という月も、90日という月も存在しないためである。

よって、次のクエリは実行が可能

<pre><code>
select
    *
FROM
    employees e
where
    e.birthday > '1998-01-01'
</code></pre>



## 明示的な型変換

to_char, to_dateは明示的な型変換を行う関数である。

これはJavaやpythonなどでの"キャスト"に値する

型変換を行う関数は全部で3つ

- to_char

- to_date

- to_number

※日付を数値に、数値を日付に変換する関数は存在しない



## 日付から文字列を取り出す

to_char関数は日付から好きな形で文字列を取り出すことができます。

例えば次のSQL

<pre><code>
select
    sysdate,
    to_char(sysdate, "YYYY/MM/DD HH12:MI:SS")
from dual

> 2021-01-01 14:01:01,
> 2021/01/01 02:01:01

</code></pre>

ここで

YYYY : 4桁で「西暦何年」を取り出す

MM : 「何月」を取り出す

DD : 「何日」を取り出す

HH12 : 1-12の形式で時間を取り出す

HH24 : 1-24の形式で時間を取り出す

MI : 「何分」を取り出す

" some string " : 二重引用符は好きな文字列を入れられる。

を示す。

また、-や(, : などの半角記号はそのまま表示される


## 数値から文字列への変更

数値から文字列への変更もTO_char関数で可能




## TO_CHAR関数について(数値から文字列)


「数値書式」を使用して数値を 文字値に変換して戻す。

例

<pre><code>
SELECT SYSDATE - TO_DATE('00-01-01')

>4157.81799
</code></pre>

また、「NLS パラメータ」を指定することで、小数点文字や桁 区切り、各国通貨記号、国際通貨記号を指定することもできる。

その際にはは以下の要素を指定できます。

### 数値の位置(9の数で表示桁数が決まる) 

例）99999

結果）1234

### 先頭の0を表示

例）099999

001234

### $の表示

例）$9999999

$1234

### 通過記号の表示

例）L999999

¥1234

### 小数点の位置を指定

例）999D999

1.234

### 指定された位置にカンマを表示

例）999,999

1,234






## TO_NUMBER関数について

次のコードはエラーになる

<pre><code>
SELECT '\5,000,000' * 2

> エラー
</code></pre>

理由は

### 暗黙の型変換に失敗した（SQLが忖度に失敗した）から

よって、ユーザーからどのように変換するかを手取り足取り教えてあげれば良い

<pre><code>
SELECT TO_NUMBER('\5,000,000', 'L9,999,9991) * 2

> 10000000
</code></pre>







## NVL関数（NULLの取扱について）

<pre><code>
NVL(式1, 式2)
</code></pre>

NVL関数は、引数の「式1」に指定された値がNULL値以外の場合は「式1」を、NULL 値の場合は「式2」を戻す関数です。

例）「money」列がNULLの時は0として扱う。

<pre><code>
SELECT 
    10 + money, 
    10 + NVL (money, 0) 
FROM employees

> NULL,10
</code></pre>

NVLを使わずにNULLの足し算を行う場合、いかなる値でもNULLに値がたされた時点でNULLが結果として返されてしまう。



## NULV2関数

<pre><code>
NVL2(式1, 式2, 式3)
</code></pre>

NVL2関数は、引数の「式1」に指定された値がNULL値以外の場合は「式2」を、NULL 値の場合は「式3」を戻す関数

(この関数考えたやつ...orz)


## COALESCE関数

<pre><code>
COALESCE(式1, 式2 [bgn ...])
</code></pre>

COALESCE関数は、引数に指定された式リストを先頭(左側)からチェックし、
「最初 に見つかった NULL 値以外の値」を戻す関数です(すべての式がNULL値の場合、NULL 値 を戻します)。


## CASE文

caseで指定した値ごとに処理を振り分けることができる

CASEからENDの間にWHENとTHENの組み合わせを分岐の数だけ入れる。

例）

<pre><code>
SELECT ename, sal,
    (CASE 
        WHEN sal < 230000 THEN 'A'
        WHEN sal < 380000 THEN 'B' 
        WHEN sal < 480000 THEN 'C'
        ELSE 'D'
    END)　SAL_LEVEL 
FROM 
    employees
ORDER BY 
    sal_level;

</code></pre>




## 備考



title:データ型とその変換について【SQL】

description:oracleマスターbronzeのweb問題集です。間違いやすい問題に厳選してあります。

img:https://s3-ap-northeast-1.amazonaws.com/i.schoo/images/class/600x260/3456.jpg

category_script:page_name.startswith("5")





