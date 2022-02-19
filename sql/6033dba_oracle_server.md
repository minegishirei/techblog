

## OracleインスタンスとOracleデータベース

Oracleデータベースシステムは次の二つの構成要素から成る。

- Oracleインスタンス

- Oracleデータベース


　
## データベースとは

データベースとはつまるところ、
さまざまなデータが格納されている

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
ファイル郡
    </p>
</div>

である。


##  インスタンスとは

データベースに対するさまざまな管理を行うための

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
プロセス郡
    </p>
</div>

と

それが使用する

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
共有メモリー構造
    </p>
</div>

の総称で、Oracleデータベースのエンジン部分でもある。

インスタンスが停止している状態ではユーザーはデータベースにアクセスできない

また、基本構造としてはインスタンス一つに対してデータベース一つ



## Oracleインスタンスについての詳しい特徴

インスタンスは一台のコンピューターに複数のインスタンスを同時に動かすこともできる

インスタンスはコンピューター上で

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
システム識別子(SID)
    </p>
</div>

で区別される

この名前は環境変数

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
ORACLE_SID
    </p>
</div>

に設定される


インスタンスは共有メモリー構造である



<h3 class="title">
答え
</h3>
<div class="box">
    <p>
SGA
    </p>
</div>

と



<h3 class="title">
答え
</h3>
<div class="box">
    <p>
Oracleバックグラウンドプロセス
    </p>
</div>

で構成される


## SGA(システムグローバル領域)


SGAは「OSの共有メモリー」内に確保される領域

ここに保存することで複数のプロセスからアクセスでき、キャッシュ化することでパフォーマンスを保つことができる。

SGAは以下の6要素からなり、REDOログバッファ以外はインスタンスを起動したままサイズを変更できる


- 「データベース・バッファ・キャッシュ」

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
データ用の作業領域
    </p>
    <p>
    ディスクから取り出されたデータがキャッシュされる。

各ユーザーはこの領域にアクセスしてデータの参照と変更を行う。

</p>
</div>

データベース・バッファ・キャッシュにデータがない場合はディスクから読み込まれる。


- 「REDOログバッファ」


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
データベースに加えられた変更履歴情報を一時的に蓄えておく領域。
    </p>
    <p>
REDO情報がログファイルに書き込まれる間、ここに保存される
</p>
</div>


- 「共有プール」

SQL文が解析された時に、

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
解析ずみのSQLやPL/QSLのコード、実行計画、データディレクショナり情報
    </p>
</div>

などが蓄積される場所。

SQL文実行の際に必要な情報を多数のユーザーが共有し、再利用できるようにキャッシュすることでメモリの節約やディスクアクセス/CPUの浪費を防いでいる





- ラージプール

データベースで共有サーバー構成を使用する場合

パラレル問い合わせを使用する場合

RMAN(Recovery Manager)を使用してバックアップ/リストアを行う場合など





- javaプール

JVM内部のセッション固有のjavaコードやデータのために使用される

- Streamsプール

Oracle Streamによって使用される領域





## Oracleバックグランドプロセス

Oracleバックグランドプロセスとはインスタンスの起動時に自動的に起動するプロセス郡

このプロセス軍は、ユーザー個別の処理ではなく、

OSと連携してメモリーを管理したり、ディスクI/Oを行う。



<h3 class="title">
答え
</h3>
<div class="box">
    <p>
Oracleデータベースシステムがスムーズに動作するために必要な全体管理を行っている。
    </p>
    <p>
    Oralceデータベースの裏でさまざまなメンテナンスを行っている
    </p>
</div>


- 「SMON」

システムモニター

障害などによってインスタンスを再起動した際に

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
インスタンス/リカバリを実行する
    </p>
    <p>
    これはインスタンスの以上終了によって失われたデータを直前のトランザクションのコミット時まで回復すること
    </p>
</div>



- 「PMON」

プロセスモニター

ユーザープロセうsの障害時に、使用していたプロセスを開放して


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
クリーンアップを行う。
    </p>
</div>

- DBWn(nは数字)

データベースライター


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
データベースバッファキャッシュで変更されたデータをデータファイルに書き込む
    </p>
</div>


- CKPT

全てのバッファのDBWnによる書き込みを「チェックポイント」という。

CKPTがDBWnを呼び出し、メモリーとディスクの同期情報を制御アイルとデータファイルに書き込む。

この情報により、障害の発生時でも＠デコまでディスクによる書き込みが終了しているか」がわかるため、発生後の復旧が実行できる。

- 「LGWR」

ログライター

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
REDOログエントリをREDOログファイルに書き込む
    </p>
</div>




- ARCn

アーカイバ

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
REDOログファイルをアーカイブログファイルとしてコピーする
    </p>
</div>


- MMON

管理性に関するタスクを実行する






## ユーザープロセスとサーバープロセス


バックグランドプロセスだけではユーザー固有のリクエストに対応できない

それに対応するのが「ユーザープロセス」と「サーバープロセス」である。



## ユーザープロセスとは

ユーザープロセスはユーザーのアプリケーションのプロセス

- SQL*Plus

- Enterprise Manager

など、

クライアント側のプロセスのこと




## サーバープロセスとは

サーバープロセスとは

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
ユーザープロセスから送信されたSQLのリクエストを処理するためのプロセス
    </p>
</div>


一つのユーザープロセスに対して、一つのサーバープロセスがある。



## PGAとは

プログラムグローバル領域とは

各サーバープロセスやバックグラウンドプロセスが個々にデータを保存している

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
非共有メモリー領域のこと
    </p>
    <p>
    SGAとは違い、PGAのデータにアクセスするのは一つのプロセスに限られる
    </p>
</div>


SQL文の処理時の作業領域や、ログイン及びそのほかのセッション情報、セッションで使用する変数などを保存すつための領域

- 「セッションメモリー」(ログイン情報とセッションに関連する情報)

- 「プライベートSQL領域」(バインド変数値、問い合わせ実行状況の情報、及び問い合わせ実行作業領域など)


一つのSGAに対して、

- 複数の(PGA-サーバープロセス) 

- 一つの(PGA-バックグラウンドプロセス)

が含まれる




## インスタンスの起動/停止

インスタンスは次のいずれかのタイミングで起動される

- SQL＊Plusからs「startup」コマンド(or「shutdown」コマンド)を実行する

- windowsサービスプログラムを使用する

その他のタイミングでは

- SQL Developer

- Enterprise Manager Cloud Control

を使用したタイミング


## データベースに接続するまでの手順


1. インスタンスの起動(UnMount状態)
 1. インスタンスが起動していない状態でstartupコマンドを使用する
 2. インスタンスを構成するためのパラメータが記載されているため、その値によってSGAが割り当てられ、バックグランドプロセスが起動
 3. この状態を「UnMount状態」と呼ぶ
1. データベースのマウント(Mount状態)
 1. 初期化パラメータに記述してある「CONTROL_FILES」初期化パラメータにしたがって「制御ファイル」がオープンされる
 2. 制御ファイルがオープンされたことにより、インスタンスとデータベスが関連付けられる状態を(Mount状態と呼ぶ)
1. データベースのオープン状態
 1. 全ての「データファイルとREDOログファイル」がオープン(作成?)される。
 2. この状態をOPEN状態と呼ぶ。
 3. この状態では一般のユーザーが接続できる。



## インスタンスが停止するまでの流れ


1. データベースのクローズ(OPEN→CLOSED状態)
   1. チェックポイントが発生。
   2. SGAのデータが「データファイル及びオンラインREDOログファイル」に書き込まれる。その後クローズ
   3. 制御ファイルはオープンしたまま
   
2. データベースのアンマウント(CLOSED状態⇨DISMOUNT状態)
   1. データベースがアンマウントされてインスタンスから切り離される。
   2. 制御ファイルもクローズされている
   3. インスタンスは起動されたまま


3. インスタンスの停止(DISMOUNT⇨SHUTDOWN状態)
   1. バックグランドプロセスが停止する
   2. SGAが使用している共有メモリーの割り当ても解除される



## 停止モード

インスタンスを停止する際は、停止動作を決定するモードを指定できる。

デフォルトはNORMAL

- NORMAL

- TRANSACTIONAL

- IMMEDIATE

はチェックポイントが発生し、正常にクローズする処理が行われる。

一方、「ABORT」は以上終了のモードであり、チェックポイントが実行されないため、データファイいるの整合性が保たれない。

この場合はインスタンスを再起動して
データベースを再オープンする前に「インスタンス・リカバリ」を実行する必要がある。


## データベースの動作と停止モード

1. チェックポイントを実行し、オープン状態のファイルをクローズする

 1. NORMAL
 2. TRANSCATION
 3. IMMEDIATE

2. 現行トランザクションが終了するまで待機する

 1. NORMAL
 2. TRANSCATION

3. 現行セッションが終了するまで待機する

 3. NORMAL

4. 新しい接続の許可
    1. 全て不許可


abortは全て不許可



## インスタンスの起動/停止をできる権限

次の権限を付与されているユーザーでなければならない

- SYSDBA(データベースを完全に制御できる)

- SYSOPER(インスタンスの起動と停止ができるが、ユーザーオブジェクトへのアクセス権は持たない)

その時のコマンドは次のように入力する

<pre><code>
connect ユーザー名/パスワード AS {SYSOPER | SYSDBA}
</code></pre>



## SQL*Plusによるインスタンスの起動

次のコマンドを使用する

<pre><code>
> sqlplus /nolog
> connect sys as sysdba
> startup
</code></pre>




## 初期化パラメータファイル

インスタンスの起動時に読み込まれる

オプションのバックグラウンドプロセスの追加起動など
インスタンスの基本動作に影響を与えるパラメータ

このパラメータは「初期化パラメータ」と呼ばれる

- データベース・バッファ・キャッシュ

- 共有プールなどのSGAのメモリー領域のサイズなど

大きくは30の「基本パラメータと拡張パラメータ」に分類できる

全てのパラメータを設定する必要はなく、デフォルトの値が存在する


## パラメータの種類

- 動的パラメータ

インスタンスの稼働中に設定を変更可能

- 静的パラメータ

設定の変更時にはインスタンスの再起動が必要



## パラメータファイルの種類

- サーバーパラメータファイル(SPFILE)

インスタンスの読み取りと書き込みが可能な「バイナリファイル」

このパラメータはSQLの「ALTER SYSTEM」文で編集可能

Oracleデータベースによる自己チューニングの基礎にもなるためこちらが優先される


- テキスト初期化パラメータファイル

テキストファイルであり、インスタンスによる読み取りのみが可能

テキストエディタでこのテキストを編集し、インスタンスの再起動が必要になる。


## SQL文による初期化パラメータの設定

1. SQL*Plusを起動してください

1. 次のコマンドでパラメータを確認
    1. 「SHOW PARAMETERS パラメータ名」を実行すると、現行のパラメータ名を確認できる。

1. ALTER SYSTEM文を使用

<pre><code>
「ALTER SYSTEM SET パラメータ名 = 値 [SCOPE ={ MEMORY | SPFILE | BOTH }]」
</code></pre>

SCOPEのしては次の適用範囲を示す

- MEMORY

現行のインスタンスに対して行われる。

- SPFILE 

サーバーパラメータファイルのみに行われ、インスタンスの再起動で反映される

- BOTH

現行インスタンスとサーバーパラメータファイルの両方が変更される

デフォルトは「サーバーパラメータファイルを使用しているときは」BOTH

テキスト初期化パラメータファイルはMEMORYがデフォルト













title:どこよりも詳しいOracleデータベースサーバーのアーキテクチャ


descriptin:Oracleインスタンス,データベース,SGA,PGA,初期化パラメータ,ALTER SYSTEM文など、Oracleデータベースのアーキテクチャの基礎から実践までを網羅しました。


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













