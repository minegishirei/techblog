



## 表領域とは


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
データベースのオブジェクトである表と索引など
    </p>
    <p>
    「セグメント」という論理構造が格納される先
    </p>
    <p>
    表領域は表や索引をまとめる入れ物と考えることができる
    </p>
    <p>
    表領域に対して一つ以上のデータファイルが作成される。
    </p>
</div>

なお

UNDOセグメントや一時セグメントといった、Oracleデータベースシステムが「内部的に使用するセグメント」には
専用の表領域が存在する



## 記憶域のコンポーネント

- セグメント

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
一つのオブジェクトには一つのセグメントが入る
    </p>
    <p>
    セグメントにはいろんなタイプがある。
    </p>
    <p>
    表であれば「表セグメント」
    </p>
    <p>
    索引は「索引セグメント」
    </p>
    <p>
    一つのセグメントは、同じ表領域ないであれば複数のデータファイルにまたがることも可能
    </p>
</div>

- エクステンと


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
一回の割り当てで取得される特定数の連結したデータブロック
    </p>
    <p>
    エクステンとのサイズは表領域の作成時に指定できる。
    </p>
    <p>
    一つのエクステンとはデータファイルをまたぐことはできない
    </p>
</div>

- データブロック



<h3 class="title">
答え
</h3>
<div class="box">
    <p>
IOの最小単位。
    </p>
    <p>
    データブロックにはデータが格納される。
    </p>
    <p>
    オブジェクトが表であれば、一つのデータブロックに複数の行を格納できる。
    </p>
    <p>
    データブロックのサイズは、データベースの作成時に指定できるが、事前構成済みのデータベースを選択した場合は「8l」で固定され、変更できない
    </p>
</div>


行データの格納によってエクステンとが満杯になると、
自動的に次のエクステントが取得され、セグメントは拡張される。


## 事前構成済みのデータベースの表領域


インストール時に作成した事前構成済みデータベースには作成時点で次の表領域が自動的に作成される。


## 事前構成済みのデータベースの表領域一覧

- SYSTEM

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
データベース作成時に自動的に作られる。
    </p>
    <p>
    データベースの管理情報を角の薄rために使用する。
    </p>
    <p>
    「データディクショナリ」はこの表裏いょういきに格納する
    </p>
</div>

SYSTEM表領域ないのオブジェクトは


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
SYSスキーマに存在するため、SYSユーザまたは他の管理者ユーザーしか開くっすできない
    </p>
</div>


- SYSAUX


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
SYSTEM表領域の補助領域
    </p>
    <p>
    データベース作成時に自動的に作られる。
    </p>
    <p>
    SYSTEM表領域の負担が減ったため、メンテナンスの負担も軽減されている
    </p>
</div>


- TEMP


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
一時表領域の
    </p>
    <p>
    デフォルトの一時表領域である。
    </p>
    <p>
    ソート処理のデータといった、セッション中にのみ存在する、SQLの処理中に生成された一時的なデータが格納される
    </p>
</div>


- UNDOTBS1

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
OracleデータベースシステムがUNDOデータの保存に使用する領域。
    </p>
    <p>
    データベースの作成時に作られる。
    </p>
    <p>
    全てのデータベースに必要
    </p>
</div>

- USERS


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
ユーザーが作成するオブジェクトを格納するための表領域
    </p>
</div>

- EXAMPLE


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
DBCAのなかで「サンプルスキーマを作成する」をチェックすると作られる。
    </p>
    <p>
    サンプルデータが格納される
    </p>
</div>


## SQL文を使用した表領域の新規作成

CREATE TABLESPACE文を使用する。


<h3 class="title">
答え
</h3>
<div class="box">
<pre>
CREATE TABLESPACE
  表領域
DATAFILE 'データファイル名'
SIZE サイズ
[EXTENT MANAGEMENT LOCAL { AUTOALLOCATE | UNIFORM SIZE サイズ}]
[SEGMENT SPACE MANAGEMENT {AUTO | MANUAL}];
</pre>
</div>


- WXTENT MANAGEMENT LOCAL


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
ローカル管理表領域の指定
    </p>
    <p>
    その表領域ないの全ての「エクステンとの割り当て情報」が
    ヘッダーに格納されているビットマップを使用して追跡されるため、
    エクステントの割り当て及び解除のパフォーマンスが工場する
    </p>
</div>


デフォルトはAUTOALLOCATEである。


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
これはデータベースが自動的にエクステンとの割り当てを管理する。
最小で64kb。
    </p>
</div>



もう一つのオプションがUNIFORM SIZE


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
エクステンがサイズに指定した部分で均一に管理される。
指定しない場合は1MB
    </p>
</div>


- SEGMENT SPACE MANAGEMENT

セグメント領域の管理方法の指定。

自動と手動のに種類がある。

自動セグメント領域管理では

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
セグメント内の空き領域を管理するために「ビットマップ」を使用する。
    </p>　
    <p>
    AUTO
    </p>
    <p>
    こっちがデフォルト
    </p>
</div>

手動セグメント領域管理では

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
セグメント内の空き領域を管理するために「空きリスト」を使用する。
    </p>
    <p>
    MANUAL
    </p>
</div>


## OMFを使用した表領域の新規作成

Oracle Managed Filesの昨日を使用することで
OSファイルをDBAが管理する必要がなくなる。

そのためには
DB_CREATE_FILE_DEST初期化パラメータを指定する必要がある。

データベースはそのディレクトリにファイルを自動的に作成しm管理する。

ファイル名はデータベースが自動設定する。

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
ALTER SYSTEM SET DB_CREATE_FILE_DEST = 'ディレクトリ名'
    </p>
</div>

上記を指定した上で次のコマンドを実行する。

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
CREATE TABLESPACE 表領域名;
    </p>
</div>

デフォルトのサイズは「100MB」で、無制限に自動拡張可能。


## 表領域の拡張

ALTER TABLESPACE文を使用する。

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
ALTER TABLESPACE 表領域名 ADD DATAFILE 'データファイル名' SIZE サイズ;
    </p>
</div>


## データファイルのサイズを手動で拡張する

ALTER DATABESE文を使用する。

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
ALTER DATABESE DATAFILE 'データファイル名' RESIZE サイズ;
    </p>
</div>


## 自動拡張に設定する


ALTER DATABESE文を使用する。

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
ALTER DATABESE DATAFILE 'データファイル名' 
AUTOEXTEND ON
NEXT サイズ
MAXSIZE {サイズ | UNLIMITED};
    </p>
</div>

データファイルに割り当てられるディスク領域を制限しない場合は、UNLIMITEDを指定する。


## その他の変更

- 表領域使用率のアラートのしきい値を変更する

- 表領域のステータスをオフラインに変更する


## 表領域の削除

DROP TABLESMACE文を使用する。

空でないセグメントも含めて削除するには


<h3 class="title">
答え
</h3>
<div class="box">
    <pre>
DROP TABLESPACE 表領域名 INCLUDING CONTENTS;
    </pre>
</div>

同時にデータファイルを削除する場合は

<h3 class="title">
答え
</h3>
<div class="box">
    <pre>
DROP TABLESPACE 表領域名 INCLUDING CONTENTS AND DATAFILES;
    </pre>
</div>


表領域を削除する場合でも対象が「アクティブセグメント」である場合は、
表領域を削除することはできない。

その場合は表領域をオフラインにすることが推奨される。

<h3 class="title">
答え
</h3>
<div class="box">
    <pre>
DROP TABLESPACE 表領域名 OFFILNE;
    </pre>
</div>

## オンラインでのセグメントの縮小

DML操作を行うと時間の経過とともに

「使用しているデータブロック」「空き領域のデータブロック」が混在し、
データが断片か指定く。

これはパフォーマンスに影響が出る恐れもあるため、「オンラインでのセグメントの縮小」を行い、断片かしているデータを統合する必要がある。


## セグメントアドバイザ

DML操作を行うごとにエクステント内部にもデータのフラグメントが起こる。

これにより部分的な未使用領域が発生することもある。

これを防ぐためにも


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
オンラインでのセグメントの縮小
    </p>
</div>

が必要となる。






## セグメントの縮小

ここのプロセスでは「最高水位票HWM(どのデータブロックまでで０田を入れたことがあるかを示す値)」の下の断片化されたデータを統合する。

そうするとHWMが移動し、新しい空き容量が出る。

この「セグメントの縮小」を行うには、セグメントアドバイザを使用すると便利。


## セグメントアドバイザとは

オブジェクトのデータを分析して、再利用できる未使用領域が存在するデータベースオブジェクトを特定することができる機能。

この機能は


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
自動セグメント管理(ASSM)を備えたローカル管理票領域のセグメントに対して使用可能
    </p>
</div>

## セグメントアドバイザによるセグメントの縮小

oracle databaseではセグメントアドバイザが定期的に実行される。


これを

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
自動セグメントアドバイザ
    </p>
</div>


必要な場合は手動でも可能。

分析結果については「Enterprise manager Cloud Control」またはPL/SQLパッケージプロシージャで確認できる。



分析結果で

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
セグメントアドバイザ推奨と表示されると、手動で縮小操作を実行して、セグメントを縮小できる。
    </p>
</div>





title:表領域とは何か？【Oracle Database】

description:データベースのオブジェクトである表と索引など「セグメント」という論理構造が格納される先。表領域は表や索引をまとめる入れ物と考えることができる。表領域に対して一つ以上のデータファイルが作成される。

category_script:page_name.startswith("6")








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
















