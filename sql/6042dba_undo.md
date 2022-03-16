

## UNDOデータ

UNDOデータとは、トランザクションによって行われるデータの変更前に
データベースによって保存されるデータのコピーである。

- ロールバック操作

- 読み取り一貫性

- フラッシュバック機能

- データベースリカバリ

のために使われる


## ロールバック操作

「コミットされていない変更」を元に戻す操作

UNDOデータはトランザクションがコミットされるまで上書きされない。


## フラッシュバック機能

問い合わせ中にデータが変更されても一貫したデータを見ることができる機能。


## フラッシュバック機能

コミット済みのデータを
過去のある時点のデータの表示やリカバリを行う機能。

フラッシュバック機能は

- フラッシュバック問い合わせ

- フラッシュバック・トランザクション

- フラッシュバック表

などいくつか種類があるが、全てUNDOデータを使用している

## データベースのリカバリ

障害が起こった後のリカバリ操作では

障害発生時にコミットされていなかったトランザクションをロールバックする。


## UNDO保存期間

トランザクションがコミットされるまで上書きされない。

トランザクションをコミットするとそのUNDOデータが占有している領域は利用可能な状態になるが
「UNDO保存期間中」は再利用できる状態ではなく、UNDOデータは保持される。


この保存期間は、「自動UNDO管理」が行われているデータベースでは自動的にチューニングされる。

例えコミット済みであってもUNDOデータはできる限り保持される。

自動拡張するUNDO表領域を使用している場合は、UNDO保存期間の加減値(秒)をUNDO_RETENTION初期化パラメータで指定できる。


## 「UNDO保存期間の補償」オプション

UNDOデータは、UNDO保存期間内であっても領域が不足した場合は上書きされて位しまうこともある。

必ず保持したい場合は

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
「UNDO保存期間の補償」オプションを有効にする。
    </p>
</div>

ただしこのオプションを有効にすると、UNDO表領域の不足が原因で、
DML操作が失敗する可能性もある。

このオプションは

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
デフォルトでは無効
    </p>
</div>


## UNDO保存期間の有効

UNDO表領域の作成または変更時に


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
RETENTION GUARANTEE句を指定する。
    </p>
</div>

無効にしたい場合は

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
RETENTION NOGUARANTEE句を指定する。
    </p>
</div>


## UNDOデータの管理

自動UNDO管理はデフォルトのモードである。


## UNDOセグメントとUNDO表領域

UNDOデータはUNDOセグメントに格納され、
UNDOセグメントはUNDO表領域という特別な表領域に格納される。

このセグメントに他のセグメントは作成できず、
インスタンス一つにつき必ず一つのUNDO表領域が必要。


## 自動UNDO管理

UNDOデータは不要になったら上書きされ、循環方式で再利用される。

チューニングは2種類あり

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
自動拡張可能(AUTOEXTEND ON)
    </p>
    <p>
    UNDO保存期間は最も時間のかかる問い合わせよりもわずかに長くなるようにチューニングされる。
    </p>
</div>


と

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
自動拡張不可能(AUTO EXTEND OFF)
    </p>
    <p>
    固定サイズ
    </p>
    <p>
    表領域のサイズと現行の負荷に対して最適化される
    </p>
</div>

がある、



## UNDO表領域が小さい場合

この場合次のようなエラーが発生する場合もある。

- DML文の失敗(UNDOデータの領域不足により)

- 読み取り一貫性が維持できない事による「スナップショットが古すぎます」


## UNDOアドバイザ




title:UNDOデータとは？【Oracleデータベース解説】

description:UNDOデータとは、トランザクションによって行われるデータの変更前にデータベースによって保存されるデータのコピーである。

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


















