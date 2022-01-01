

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






# DDLについて

以下の3つのコマンドはDDLである


<h3 class="title">
DDLコマンド3つ
</h3>
<div class="box">
  <p>
    !!!ALTERコマンド(オブジェクトの定義情報を変更する)
  </p>
  <p>
  DROPコマンド
  </p>
  <p>
  TRUNCATEコマンド(表が使用しているデータ領域を丸ごと削除)
  </p>
</div>





# DROP TABLE

- 表ないの全てのデータが削除されう

- <strong>表に定義されている索引も削除される</strong>

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

- サイズ指定不可


<h3 class="title">
覚えた方がいいこと
</h3>
<div class="box">
  <p>
  副問い合わせを使用した表の作成時にLONG列はコピーできない
  </p>
    <p>
    GROPU BYとORDER BY句に指定できない
  </p>
    <p>
    一つの表に一つだけ(LONG列またはLONG RAW列)しか定義できない
  </p>
    <p>
    LONG列には制約を定義できない
  </p>
</div>



## CLOB型

最大4Gまでの文字列を格納できるデータ型

- サイズ指定不可

## NCLOB型

最大4GまでのUnicode文字列を格納できるデータ型

- サイズ指定不可


# 数値型

NUMBER型を使う

<pre><code>
列名 NUMBER[(最大精度[,位取り])]

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

- ??自動的に制約と同じ名前の一意索引(重複が許可されない索引)が作成される

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

- 表に一つのみ定義できる

- 名前の一意索引が作成される

- 組み合わせに対してもPRIMARY KEYは作成できる
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



title:ORACLE Bronze SQL 間違いやすいところ一覧


