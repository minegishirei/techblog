




## storedプログラムの権限のについて

PL / SQLプログラムを最初に作成するときは、通常、あなたまたはDBA以外の誰もそれを実行できません。

別のユーザーにプログラムを実行する権限を与えるには、GRANTステートメントを発行します。

<pre><code>
GRANT EXECUTE ON wordcount TO scott;
</code></pre>

ロールにEXECUTE権限を付与することもできます。

## 全ユーザーに実行許可を与える

または、必要に応じて、現在のデータベースのすべてのユーザーにプログラムの実行を許可することもできます。

<pre><code>
GRANT EXECUTE ON wordcount TO PUBLIC;
</code></pre>


<pre><code>
GRANT EXECUTE ON wordcount TO all_mis;
</code></pre>

## ストアドプログラムの権限の剥奪


<pre><code>
 REVOKE EXECUTE ON wordcount FROM scott;
</code></pre>


DESCRIBEは、テーブル、ビュー、オブジェクトタイプ、プロシージャ、およびパッケージでも機能します


## 権限の階層

スコットのような個人に特権を付与し、そのユーザーがメンバーであるロール（たとえば、all_mis）に特権を付与し、それをPUBLICにも付与すると、データベースは3つの付与すべてを取り消されるまで記憶します。



## 権限の確認方法

USER_TAB_PRIVS_MADEに全てのプロシージゃ,テーブルに関する権限が与えられています。

<pre><code>
SELECT table_name, grantee, privilege
FROM USER_TAB_PRIVS_MADE
WHERE table_name = 'WORDCOUNT';
</code></pre>

実行結果

<pre><code>
TABLE_NAME  GRANTEE   PRIVILEGE
----------  -------   ---------
WORDCOUNT   PUBLIC    EXECUTE
WORDCOUNT   SCOTT     EXECUTE
WORDCOUNT   ALL_MIS   EXECUTE
</code></pre>




title:ストアドプログラムの権限のについて【PLSQL基礎】

description:PL / SQLプログラムを最初に作成するときは、通常、あなたまたはDBA以外の誰もそれを実行できません。別のユーザーにプログラムを実行する権限を与えるには、GRANTステートメントを発行します。



img:https://images.squarespace-cdn.com/content/v1/5c3cf2ac5417fc3efa512c5a/1547588142968-VWQR0WMNFIX7GW18937A/lrg.jpg



category_script:page_name.startswith("25")

