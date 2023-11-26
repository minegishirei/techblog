


## メモリーコンポーネントの管理方法


「自動共有メモリー管理」とは

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
SGAのトータルのサイズを指定しておくと、負荷状況にあわせて自動調節してくれる機能ができた。
    </p>
</div>


PGAについても同様に、「自動PGAメモリー管理」と呼ばれるようになった。

最終的に、「自動メモリー管理」という名前によって

SGAとインスタンスPGAをまとめて自動で管理できるようになった。



## 自動メモリー管理

Oracleソフトの基本インストールでデータベースを作成すると
自動メモリー管理が有効になる

この場合、次の環境変数によって指定されたターゲットサイズの範囲内で調整される。


- MEMORY_TARGET

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
Oracleデータベースサーバーで使用可能なメモリーサイズ(ターゲットサイズ)
    </p>
<p>
この値は動的に変更可能
</p>
</div>



- MEMORY_MAX_TARGET


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
Oracleデータベースで使用可能なメモリーの最大サイズ(静的)
    </p>
</div>



## 自動メモリー管理の設定方法

- MEMORY_MAX_TARGETは

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
静的なパラメータなので「SCOPE=SPFILE」を指定する必要がある
    </p>
</div>


この場合、サーバーパラメータファイル内の値のみが設定され、実行中のインスタンスに対する値は変更されない。

よって、再起動が必要になる

<pre><code>
SLTER SYSTEM SET MEMORY_MAX_TARGET = n[K | M | G] SCOPE = SPFILE;
</code></pre>


- MEMORY_TARGETは

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
動的なパラメータなので、MEMORY_MAX_TARGETの値を超えない範囲で0以外の値に動的に変更できる
    </p>
</div>

<pre><code>
ALTER SYSTEM SET MEMORY_TARGET = n[K | M | G];
</code></pre>


<pre><code>
ALTER SYSTEM SET MEMORY_TARGET = n[K | M | G] [SCOPE={MEMORY | SPFILE | BOTH}]
</code></pre>


## SGAとインスタンスPGAのサイズを個別に制御したい場合

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
自動共有メモリー管理を使用する
    </p>
    <p>
    この場合、自動PGAメモリー管理が暗黙的に有効になる
    </p>
</div>



## 初期化パラメータ


- SGA_TARGET

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
SGAのターゲットサイズ
    </p>
    <p>
    動的に変更可能だが、SGA_MAX_SIZE以上のサイズを指定することはできない。
    </p>
</div>

- SGA_MAX_SIZE

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
SGAのサイズ(静的)
    </p>
    <p>
静的パラメータ
    </p>
</div>


- PGA_AGGREGATE_TERGET

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
インスタンスPGAのターゲットサイズ
    </p>
    <p>
    動的に変更可能
    </p>
</div>


- メモリー管理の対象

SGA_TAEGETが指定されている場合、SGAのメモリーコンポーネントのサイズは自動的に設定される

データベースバッファキャッシュ

~

ラージプール

これらのメモリーコンポーネントが個別に設定されているサイズが0ではなく、整数である場合、

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
    この値はコンポーネントの最小値として使用される
    </p>
</div>

- REDOログバッファ

- 固定SGA

これらは自動共有メモリー管理の影響を受けない

ただし、SGA_TAEGETに設置絵されている総量から差し引かれる。



## 自動共有メモリー管理を行うための設定方法



自動共有メモリー管理を行うためには、最初にMEMORY_TAEGETに0を設定して、自動メモリー管理を無効化する。

<pre><code>
ALTER_SYSTEM SET MEMORY_TAEGET = 0;
</code></pre>

または

<pre><code>
ALTER_SYSTEM SET MEMORY_TAEGET = 0 [SCOPE = {MEMORY | SPFILE | BOTH }];
</code></pre>

その上で、SGA_MAX_SIZEを設定する。

SGA_MAX_SIZEは静的パラメータなので、SCOPE=SPFILEを指定することが必要。

反映するにはインスタンスの再起動が必要

<pre><code>
ALTER_SYSTEM SET SGA_MAX_SIZE = 0 [SCOPE = {MEMORY | SPFILE | BOTH }];
</code></pre>

SGA_TAGETは動的なパラメータなので、SGA_MAX_SIZEを超えない範囲で動的に指定可能

<pre><code>
ALTER_SYSTEM SET SGA_TARGET = 0 [SCOPE = {MEMORY | SPFILE | BOTH }];
</code></pre>

または

<pre><code>
ALTER_SYSTEM SET SGA_TAERGET = 0 [SCOPE = {MEMORY | SPFILE | BOTH }];
</code></pre>



## 手動共有メモリー管理+自動PGAメモリー管理

自動メモリー管理と自動共有メモリー管理を無王にすると

- 手動共有メモリー管理になる


- 自動PGAメモリー管理が暗黙的に有効になる


<ここの部分の説明は省略>





title:Oracleデータベースのメモリー管理のパラメータについて

description:Oracleソフトの基本インストールでデータベースを作成すると自動メモリー管理が有効になる。この場合、次の環境変数によって指定されたターゲットサイズの範囲内で調整される。

category_script:page_name.startswith("6")



