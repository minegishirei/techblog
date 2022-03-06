
## 制御ファイルとREDOログファイル【OracleBronzeDBA】

Oracle Bronze DBAの合格に向けた「制御ファイルからREDOログファイル」という分野の解説です。

## データベースの物理構造

- 制御ファイル

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
物理構造に関する情報が格納される
    </p>
</div>



- REDOログファイル

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
データに対して行われた変更情報が格納される
    </p>
</div>


- データファイル

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
全ての表や索引のデータが格納される
    </p>
</div>


主な構造は「表領域」である

表領域では、表や索引などのデータベースのオブジェクトを格納する入れ物と考えることができる。

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
各表領域に対して一つ以上のデータファイルが作成される
    </p>
</div>


## 制御ファイル

制御ファイルとは、

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
データベースの物理構造の情報が記録されたバイナリファイルのこと
    </p>
    <p>
    データベースのマウント時に読み込まれる
    </p>
    <p>
    この時に全てのデータファイルとREDOログファイルのパスが認識される
    </p>
</div>

制御ファイルのファイル名は

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
CONTROL_FILES初期化パラメータで指定する
    </p>
</div>


## 制御ファイルの更新タイミング

制御ファイルは

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
データベースによって自動的に更新される
    </p>
    <p>
    表領域を作成し他ことでデータファイルがデータベースに追加されると物理ファイルの情報が自動的に追加される
    </p>

</div>


データベースが制御ファイルにアクセスできなくなると


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
インスタンスが停止する
    </p>
</div>

このために通常は制御ファイルを多重化しておく


## REDOログファイル

REDOファイルとは

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
SQLを使用して行ったトランザクションの内容や、
    </p>
    <p>
    データベースが内部で行ったデータベースへの更新が記録される。
    </p>
</div>

## REDOログが書き込まれる時

トランザクションの変更情報である「REDOレコード」は

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
一時的にSGA内のREDOログバッファに書き込まれる。
    </p>
</div>


REDOログバッファのREDOレコードは、トランザクションのCOMMIT時に、

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
LGWR(ログライター)プロセスによってREDOログファイルに書き込まれる
    </p>
</div>


## REDOログファイルの構成

REDOログファイルは必ず

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
二つ以上のREDOロググループで構成され
    </p>
</div>

LGRWは各グループに対して、


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
循環方式で書き込みを行う。
    </p>
</div>


また、各グループには

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
一つ以上のREDOログファイルが含まれる。(それぞれのファイルを「メンバー」と呼ぶ)
    </p>
</div>

一つのグループ内に複数のファルが構成されている場合

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
それらのファイルには同一の内容が書き込まれる
    </p>
</div>


RGWRは

1. グループ1のログファイル(メンバー)に書き込みを行う
2. 満杯になったら別のグループに切り替えを行う
3. これを循環させる。

LGWRの書き込も対象のREDOログファイルを含むグループのことを

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
カレントのREDOロググループという。
    </p>
    <p>
    書き込み先グループが変わることを「ログスイッチ」と呼ぶ
    </p>
    <p>
    このログスイッチはSQL文でも切り替えられる
    </p>
</div>


## REDOログファイルのアーカイブ

連続したREDOログファイルをとっておくには、REDOログファイルが上書きされる前にコピーを作成させることが必要。

これを


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
REDOログファイルをアーカイブする
    </p>
    <p>
    と呼ぶ。
    </p>
    <p>
    作成されるファイルを「アーカイブファイル」
    </p>
    <p>
    ARCnプロセスによってアーカイブされるREDOログファイルのコピー
    </p>

</div>



## REDOログファイルの多重化

REDOログファイルの多重化とは

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
2つ以上のメンバー(書き込み先のディスク)がある状態
    </p>
    <p>
    片方のディスクが壊れても稼働し続けることができる
    </p>
</div>



## 備考


title:制御ファイルとREDOログファイル【OracleBronzeDBA】

description:Oracle Bronze DBAの合格に向けた「制御ファイルからREDOログファイル」という分野の解説

category_script:page_name.startswith("6")






<h3 class="title">
答え
</h3>
<div class="box">
    <p>

    </p>
</div>





<div class="question_tag">

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
    
    
</div>
















