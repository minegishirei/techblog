
## ユーザー属性

- 名前

ユーザー名のこと
アカウントの識別に用いる。


- データベース認証パスワード

ユーザー名に対するパスワード。

ユーザーはデータベースとの接続確率時にパスワードを求められ、一致しないと拒否される。

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
パスワードは「データディクショナリに暗号化されて格納される。
    </p>
    <p>
    大文字、小文字は区別される
    </p>

</div>

- デフォルト表領域

ユーザーがオブジェクトを作成する際に、
格納さきを指定しなかった場所に使用される表領域。

ただし、

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
アカウントに「オブジェクトを作成する権限」と「表領域の割り当て制限」が設定されていない場合は割り当てることはできない。
    </p>
</div>

また、ユーザーアカウントに対してデフォルト表領域を指定しない場合は、

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
デフォルトの永続表領域が暗黙的に設定される
    </p>
</div>


- 一時表領域

ユーザーが

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
一時セグメントの作成を必要とするSQL文(ソート処理、表の結合等)
    </p>
</div>

を実行した時に使用される表領域。

ユーザーアカウントに対して一時表領域を指定しない場合は、

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
デフォルトの表領域
    </p>
</div>

が暗黙的に指定される。



- 表領域の割り当て制限

ユーザーに対して、

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
使用を許可する表領域ないの容量。
    </p>
</div>

デフォルトでは全ての表領域に対して

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
0
が指定されており、
表領域の使用は許可されていない。
    </p>
</div>

ただし

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
一時表領域やUNDO表領域は割り当ての制限なしで利用できる。
    </p>
</div>


- アカウントステータス

ロック解除とロックを指定してログインを制限できる


- パスワードステータス

パスワードを無効(期限ぎれ)にするか有効にするかを指定する。


## 新しいユーザーアカウントの接続

CREATE SESSIONシステム権限が付与されている必要がある。


## SQL文を使用したユーザーアカウントの作成


<pre><code>
CREATE USER ユーザー名
IDENTIFIED BY パスワード
[DEFAULT   TABLESPACE 表領域名]
[TEMPORARY TABLESPACE 表領域名]
[QUOTA サイズ ON 表領域名]
[PROFILE プロファイル]
</code><pre>

また、CREATE SESSION権限も与えておく必要がある

<pre><code>
GRANT CREATE SESSION TO ユーザ名
</code></pre>


## 事前定義されたユーザーアカウント

- 管理者アカウント(SYSアカウント)

- SYSTEMアカウント

データベース管理者アカウント
管理情報を表示する表やビュー、Oracleデータベースのオプションやツールで使用する内部的な表やビューを所有数r


- SYSMANアカウント

Enterprise Managerによる操作を実行するためのアカウント

- DBSMNP

Enterprise Managerの管理エージェントがデータベースの監視及び管理するために使用するアカウント


- サンプルスキーマユーザー



## SQL文を使用したユーザー属性の変更

ALTER USERコマンド

<pre><code>
ALTER USER ユーザ名
[IDENTIFIED BY パスワード]
[DEFAULT TABLESPACE 表領域名]
[TEMPORARY TABLESPACE 表領域名]
[QUOTA サイズ ON 表領域名]
[PROFILE プロファイル]
</code></pre>



## ユーザーアカウントの削除

<pre><code>
DROP USER ユーザ名 [CASCADE]
</code></pre>

オブジェクトとともに削除できる。


## ユーザーアカウントのロック/ロック解除

<pre><code>
ALTER USER ユーザー名 ACOUNT LOCK;
</code></pre>

<pre><code>
ALTER USER ユーザー名 ACOUNT UNLOCK;
</code></pre>


## Oracleパスワードポリシ

Oracleのパスワードに対するルールを設定できる

普段はDEFAULTという名前のプロファイルを割り当てられている。

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
パスワードは自動的に180日で期限ぎれ
    </p>
</div>


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
期限切れの後にログインした7日いないにパスワードを変更する必要がある。
    </p>
    <p>
    変更しないとロックされる
    </p>
</div>

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
ログインに10回失敗すると、ユーザーアカウントが一日ロックされる。
    </p>
</div>





## データベースにおける権限

権限は、「ユーザーによるデータベース操作を制御するため」に使用します。

権限を付与することで、各ユーザーのデータベースに対する操作を一つ一つ制御できます。


## システム権限

システム権限とは

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
特定のデータベース操作の実行を許可するために使用する
    </p>
    <p>
    例えば、表を新たに作成するのには「CREATE TABLE」システム権限が必要
    </p>
</div>


## オブジェクト権限


<h3 class="title">
答え
</h3>
<div class="box">
    <p>
特定のデータベースオブジェクトへのアクセスを制御するために使用する。
    </p>
    <p>
    例えば、AさんのEMP表に対するSELECTの実行は
    </p>
    <code>
    SELECT ON スキーマ名.オブジェクト名
    </code>
    <p>
    権限が必要
    </p>

</div>



## 管理権限

## SYSDBAシステム権限

全ての権限を持つデータベース管理者用のシステム権限


## SYSOPERシステム権限

基本的な管理タスクを実行するユーザー用のシステム権限。
インスタンスの起動/停止はできるが、作成やユーザーデータ表示はできない


## SYSBACKUPシステム権限

バックアップ及びリカバリ操作の権限



## 管理権限を使用する場合の認証方式

管理権限を使用した接続の認証は、データディクショナリではなく、
「OS認証」「パスワードファイル認証」という二つの方式がある。

- OS認証

OSのグループによって認証を行う。
ローカル上でデータを管理する場合に使用


- パスワードファイル認証

Oracleデータベース内部にパスワードファイルを作成することで認証。

単一のリモートクライアントから複数のデータベースを管理する場合に使用。
データベースのインストール時に作成されており、デフォルトは「SYS」


## 実際の接続

- OS認証

<pre><code>
connect / as sysdba
</code></pre>

- パスワードファイル認証

<pre><code>
connect ユーザー名/パスワード as sysdba
</code></pre>

SYSDBAシステム権限、またはSYSOPERで接続すると、指定したユーザー名に関連付けられたスキーマではなく


<h3 class="title">
SYSDBAの場合は
</h3>
<div class="box">
    <p>
SYS
    </p>
</div>




<h3 class="title">
SYSOPERの場合は
</h3>
<div class="box">
    <p>
PUBLIC
    </p>
</div>

として接続される




## 権限の付与

<pre><code>
GRANT システム権限 TO {ユーザー名 | ロール名 | PUBLICK} [WITH ADMIN OPTION]
</code></pre>

PUBLICKは全てのユーザーを含むユーザーグループ。

また、「WITH ADMIN OPTION」を指定すると



<h3 class="title">
答え
</h3>
<div class="box">
    <p>
その権限が付与されたユーザーで第三のユーザーに同じ権限を付与できる
    </p>
</div>





## SQLぶんを使用した「オブジェクト権限」の付与

GRANT文を使用

<h3 class="title">
答え
</h3>
<div class="box">
    <p>
GRANT オブジェクト権限 ON オブジェクト名
TO {ユーザー名 |　ロール名 | PUBILICK} [WITH GRANT OPTION]
    </p>
</div>

例)


<h3 class="title">
答え
</h3>
<div class="box">
    <pre><code>
    GRANT SELECT ON hr.emp TO test;
    </code></pre>
</div>




## 権限の剥奪

<pre><code>
REVOKE システム権限 FROM {ユーザー名 | ロール名 |PUBLICK}
</code></pre>

- WITH ADMIN OPTIONが指定されている場合

第三のユーザーは取り消されない。
(ユーザー単位でいきなり権限が落ちることはない)



<pre><code>
REVOKE {オブジェクト権限 | ALL} ON オブジェクト名
FROM {ユーザー名 |ロール|PUBLIC};
</code></pre>

- WITH ADMIN OPTIONが指定されている場合

第三者に付与したオブジェクト権限も「同時に取り消される」
(いきなり消える)


## ロールの作成

?






<h3 class="title">
答え
</h3>
<div class="box">
    <p>

    </p>
</div>




