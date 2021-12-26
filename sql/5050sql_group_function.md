


## AVGグループ関数

次の表のあるカラム (NUMBER(10)型)があるとする。

<pre>
40000, NULL, 40000, 0, 20000
</pre>


この表に対する次のクエリの結果はいくつか

<pre><code>
SELECT AVG(歩合給) FROM 社員表;
</code></pre>

<h3 class="title">答え</h3>
<div class="box">
  <p>
  A: 2500
  </p>
  <p>
  ポイント：NULLはグループ関数において、ないものとして処理される
  </p>
    <p>
  よって、NULL以外の4つで合計10000を割った2500が答え。
  </p>
</div>






## グループ関数の概要

次ん選択肢で正しいものを全て選べ

A: グループ関数は行グループごとに結果を一つ返す

B: グループ関数の引数ではDISTINCTは使用できない

C: グループ関数でグループがNULLの場合は0を返す

D: DISTONCTとALLを使用しない場合はALLが適用される



<h3 class="title">答え</h3>
<div class="box">
  <p>
  D: DISTONCTとALLを使用しない場合はALLが適用される
  </p>
  <p>
  A: グループ関数は行グループごとに結果を一つ返す
  </p>
    <p>
  Cについては、グループ関数でグループがNULLの場合は無視される
</div>


## グループ関数が使用できる句

グループ関数が使用できる句を全て選べ。

A: select

B: from

C: where

D: group by

E: having

f: order by



<h3 class="title">答え</h3>
<div class="box">
  <p>
  A: select, E: having, f: order by
  </p>
  <p>
  group byでは使えないことに注意
  </p>
    <p>
  
  </p>
</div>



## order byとavg関数

部門ごとの平均給料を出し、並び替えるクエリとしてただしものを選べ

A: select deptno, avg(sal) from employees group by deptno

B: select deptno, avg(sal) from employees;

C: select deptno, avg(sal) from employees group by deptno;

D: select deptno, avg(sal) from employees group by deptno order by deptno;



<h3 class="title">答え</h3>
<div class="box">
  <p>
D: select deptno, avg(sal) from employees group by deptno order by deptno;
  </p>
  <p>
  deptnoでgroup byを行うこと
  </p>
    <p>
  order byでdeptnoを並び替えること
  </p>
  <p>
  最後にavg(sal)で平均を割り出すこと を把握することが大事。
  </p>
</div>



## 列別名の使用

次のうち正しいものを選べ

A: order byでは列別名の指定ができるが、group byでは列別名の指定ができない

B: order byもgroup byも列別名の指定ができる

C: order byでは列別名の指定ができないが、group byでは列別名の指定ができる

D: order byもgropu byも列別名の指定ができない


<h3 class="title">答え</h3>
<div class="box">
  <p>
A: order byでは列別名の指定ができるが、group byでは列別名の指定ができない
  </p>
  <p>
  group byでは正式な指定しか受け付けない
  </p>
    <p>
  order byでは列別名の指定も、selectの一による指定もできる。
  </p>
</div>


## 句の並び順

正しいい並び順を選べ

A: SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY

B: SELECT, FROM, WHERE, GROUP BY, ORDER BY, HAVING

C: SELECT, FROM, WHERE, HAVING, GROUP BY, ORDER BY



<h3 class="title">答え</h3>
<div class="box">
  <p>
A: SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY
  </p>
  <p>
C: SELECT, FROM, WHERE, HAVING, GROUP BY, ORDER BY

  </p>
    <p>
group byとhavingは入れ替えることが可能
  </p>
</div>


## グループ関数の説明

間違えた説明を選べ

A: グループ関数はいくらでもネストできる

B: グループ関数の引数には関数を指定できる

C: where句にグループ関数は指定できない

D: selectにgroup関数を指定する場合、group byで指定されていない場合は一緒にselectできない。


<h3 class="title">答え</h3>
<div class="box">
  <p>
A: グループ関数はいくらでもネストできる
  </p>
  <p>
  B-Dは全て正しい
  </p>
    <p>
  グループ関数は最大2回までネストできる。
  </p>
</div>



## listagg

次のクエリの実行結果を選べ

<pre><code>
select 
    deptno,count(*),
    Listagg(ename) group within(order by sal DESC)
from employees
group by deptno,
order by 1;
</code></pre>

A: デリミタがないのでエラーになる

B: 社員ごとの名前と給料が繋がった状態で一列に出力される

C: 部署コードごとに社員の名前と給料が繋がった状態で一列に出力される

D: groupとwithinが逆なのでエラーになる




<h3 class="title">答え</h3>
<div class="box">
  <p>
    D: groupとwithinが逆なのでエラーになる
  </p>
  <p>
    within group(order by sal DESC)が正しい順番
  </p>
    <p>
  
  </p>
</div>


## MIN MAX関数

文字列に対して有効なグループ関数を3つ選べ

A: count

B: AVG

C: SUM

D: MIN

E: MAX

<h3 class="title">答え</h3>
<div class="box">
  <p>
A: count、D: MIN、E: MAX
  </p>
  <p>
  MIN,MAXは文字数を見て最もXXなものを返す。
  </p>
    <p>
  
  </p>
</div>


<h3 class="title">答え</h3>
<div class="box">
  <p>

  </p>
  <p>
  
  </p>
    <p>
  
  </p>
</div>


<h3 class="title">答え</h3>
<div class="box">
  <p>

  </p>
  <p>
  
  </p>
    <p>
  
  </p>
</div>


<h3 class="title">答え</h3>
<div class="box">
  <p>

  </p>
  <p>
  
  </p>
    <p>
  
  </p>
</div>


<h3 class="title">答え</h3>
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





title:Oracle SQL Bronze web問題集【グループ関数】

description:oracleマスターbronzeのweb問題集です。MINMAX関数やCOUNT関数の隠された性質についても解説してあります。

img:https://s3-ap-northeast-1.amazonaws.com/i.schoo/images/class/600x260/3456.jpg

category_script:page_name.startswith("50")




