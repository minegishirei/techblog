
## サービスとは


クライアントがデータベースサーバー上のデータベースに接続する際に指定するのはデータベースの「サービス名」である

データベースのサービス名は


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
SERVICE_NAMES
    </p>
</div>

初期化パラメータに指定されている

この初期化パラメータのデフォルトはうあtっっっっっf：

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
グローバルデータベース名
    </p>
</div>

通常はグローバルデータベース名をサービス名として指定する。

グローバールデータベース名は以下の要素で構成される

<pre><code>
データベース名(DB_NAME) + ドメイン名(DB_DOMAIN)
</code></pre>


一つのデータベースには複数のサービス名を対応づけれる

これは処理を明確に区別できるようにするためである。

(銀行の窓口まで連れて行ってくれるのがリスナー。貯金という窓口に対応するのがサービス)


- oracle.edifist.com

- sales.efist.com

- finance.edifist.com


## 接続記述子

クライアントはデータベースの場所とサービス名を指定してデータベースに接続する

この情報を

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
接続記述子
    </p>
</div>

と呼ぶ

また、これらの情報をまとめた時の名前を

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
ネットサービス名
    </p>
</div>

と呼ぶ


<pre><code>
例)

proj1-svサーバーにある
1521でリスニングしているリスナーに接続し、
sales.edifist.comデータベースサービスへ接続するための記述子
</code></pre>


<h3 class="title">
答え
</h3>
<div class="box">
<pre><code>
(DESCRIPTION=
    (ADDRESS=(PROTOCOL=tcp)(HOST=proj1-sv)(PORT=1521))
    (CONNECT_DATA=(SERVICE_NAME=sales.edifist.com))
)
</code></pre>
</div>

クライアントのSQL`Plusからhrユーザーで接続したい場合は「＠」以降に接続指定しを記述する


<pre><code>
SQL> connect hr@(DESCRIPTION=
    (ADDRESS=(PROTOCOL=tcp)(HOST=proj1-sv)(PORT=1521))
    (CONNECT_DATA=(SERVICE_NAME=sales.edifist.com))
)
</code></pre>


- ネットサービス名

testがサービス名の時、

<h3 class="title">
答え
</h3>
<div class="box">
<pre><code>
test = (DESCRIPTION=
        (ADDRESS=(PROTOCOL=tcp)(HOST=proj1-sv)(PORT=1521))
        (CONNECT_DATA=(SERVICE_NAME=sales.edifist.com))
    )
</code></pre>
</div>

のように記述する


## ネーミングメソッド

ネーミングメソッドとは、ネットサービス名を接続記述子に変換する方法である。

接続文字列にネットサービス名が使用されると、その文字列は

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
情報リポジトリ
    </p>
</div>

に保存されている情報を元に名前解決される。

Oracle Netでは次のネーミングメソッドがサポートされている

## ローカル・ネーミング米


<h3 class="title">
実態
</h3>
<div class="box">
    <p>
クライアントに保存されているtnsnames.oraファイル
    </p>
</div>

ネットサービス名とマッピングされる接続記述子クライアントのコンピューターのローカルにファイルとして保存する


## ディレクトリネーミング

LDAP準拠のディレクトリサーバー

ネットサービス名とマッピングされる接続記述子をLDAP準拠のサーバーに格納し集中管理する


## 簡易接続ネーミング米

保存場所なはい


<h3 class="title">
実態
</h3>
<div class="box">
    <p>
TCP/IP接続文字列をどこかに入力するのではなく。
接続時に直接入力して接続する
    </p>
</div>


## 外部ネーミング

Oracle以外のネーミング

サポートされているOracle以外のネーミングサービス名を格納する




## ローカル・ネーミングの構成

ネットサービス名とそれにマッピングする接続記述子を
クライアントコンピュータに「tnsnamesora」ファイルとして保存。

保存場所は

#ORACLE_HOME/network/adminディレクトリ配下のtnsnames.oraファイルに登録される


## 簡易接続ネーミングの構成





title:「サービス」とは何か？【Oracle Database】

description:クライアントがデータベースサーバー上のデータベースに接続する際に指定するのはデータベースの「サービス名」である

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













