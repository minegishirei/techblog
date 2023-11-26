


## 記事の概要

SQLのfor文について解説する記事です。


## 通常のsqlにfor文は存在しない。

まず大前提として、「通常のSQLにfor文は存在しません」

そもそもSQLにはいくつか種類がありますが、それらがサポートする
ものは以下のキーワードのみです。


<div id="LNPLS1758" class="tblformalwidemax"><a id="sthref1465" name="sthref1465"></a><a id="CIHDHDCH" name="CIHDHDCH"></a>
<p class="titleintable">表D-1 PL/SQLの予約語</p>
<table border="1" cellpadding="3" cellspacing="0" class="FormalWideMax" dir="ltr" frame="hsides" rules="groups" summary="この表は、PL/SQL予約語の概要を示しています。" title="PL/SQLの予約語" width="100%">
<colgroup><col width="13%">
<col width="*">
</colgroup><thead>
<tr align="left" valign="top">
<th align="left" valign="bottom" id="r1c1-t3">頭文字:</th>
<th align="left" valign="bottom" id="r1c2-t3">予約語</th>
</tr>
</thead>
<tbody>
<tr align="left" valign="top">
<td align="left" id="r2c1-t3" headers="r1c1-t3">
<p>A</p>
</td>
<td align="left" headers="r2c1-t3 r1c2-t3">
<p>ALL、ALTER、AND、ANY、AS、ASC、AT</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r3c1-t3" headers="r1c1-t3">
<p>B</p>
</td>
<td align="left" headers="r3c1-t3 r1c2-t3">
<p>BEGIN、BETWEEN、BY</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r4c1-t3" headers="r1c1-t3">
<p>C</p>
</td>
<td align="left" headers="r4c1-t3 r1c2-t3">
<p>CASE、CHECK、CLUSTERS、CLUSTER、COLAUTH、COLUMNS、COMPRESS、CONNECT、CRASH、CREATE、CURSOR</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r5c1-t3" headers="r1c1-t3">
<p>D</p>
</td>
<td align="left" headers="r5c1-t3 r1c2-t3">
<p>DECLARE、DEFAULT、DESC、DISTINCT、DROP</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r6c1-t3" headers="r1c1-t3">
<p>E</p>
</td>
<td align="left" headers="r6c1-t3 r1c2-t3">
<p>ELSE、END、EXCEPTION、EXCLUSIVE</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r7c1-t3" headers="r1c1-t3">
<p>F</p>
</td>
<td align="left" headers="r7c1-t3 r1c2-t3">
<p>FETCH、FOR、FROM、FUNCTION</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r8c1-t3" headers="r1c1-t3">
<p>G</p>
</td>
<td align="left" headers="r8c1-t3 r1c2-t3">
<p>GOTO、GRANT、GROUP</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r9c1-t3" headers="r1c1-t3">
<p>H</p>
</td>
<td align="left" headers="r9c1-t3 r1c2-t3">
<p>HAVING</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r10c1-t3" headers="r1c1-t3">
<p>I</p>
</td>
<td align="left" headers="r10c1-t3 r1c2-t3">
<p>IDENTIFIED、IF、IN、INDEX、INDEXES、INSERT、INTERSECT、INTO、IS</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r11c1-t3" headers="r1c1-t3">
<p>L</p>
</td>
<td align="left" headers="r11c1-t3 r1c2-t3">
<p>LIKE、LOCK</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r12c1-t3" headers="r1c1-t3">
<p>M</p>
</td>
<td align="left" headers="r12c1-t3 r1c2-t3">
<p>MINUS、MODE</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r13c1-t3" headers="r1c1-t3">
<p>N</p>
</td>
<td align="left" headers="r13c1-t3 r1c2-t3">
<p>NOCOMPRESS、NOT、NOWAIT、NULL</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r14c1-t3" headers="r1c1-t3">
<p>O</p>
</td>
<td align="left" headers="r14c1-t3 r1c2-t3">
<p>OF、ON、OPTION、OR、ORDER、OVERLAPS</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r15c1-t3" headers="r1c1-t3">
<p>P</p>
</td>
<td align="left" headers="r15c1-t3 r1c2-t3">
<p>PROCEDURE、PUBLIC</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r16c1-t3" headers="r1c1-t3">
<p>R</p>
</td>
<td align="left" headers="r16c1-t3 r1c2-t3">
<p>RESOURCE、REVOKE</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r17c1-t3" headers="r1c1-t3">
<p>S</p>
</td>
<td align="left" headers="r17c1-t3 r1c2-t3">
<p>SELECT、SHARE、SIZE、SQL、START、SUBTYPE</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r18c1-t3" headers="r1c1-t3">
<p>T</p>
</td>
<td align="left" headers="r18c1-t3 r1c2-t3">
<p>TABAUTH、TABLE、THEN、TO、TYPE</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r19c1-t3" headers="r1c1-t3">
<p>U</p>
</td>
<td align="left" headers="r19c1-t3 r1c2-t3">
<p>UNION、UNIQUE、UPDATE</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r20c1-t3" headers="r1c1-t3">
<p>V</p>
</td>
<td align="left" headers="r20c1-t3 r1c2-t3">
<p>VALUES、VIEW、VIEWS</p>
</td>
</tr>
<tr align="left" valign="top">
<td align="left" id="r21c1-t3" headers="r1c1-t3">
<p>W</p>
</td>
<td align="left" headers="r21c1-t3 r1c2-t3">
<p>WHEN、WHERE、WITH</p>
</td>
</tr>
</tbody>
</table>
<br></div>

このリストを見るとわかるように、通常のSQLの中にはloopを補助するものはありません。

そしてSQLのうちでfor文が存在するのはSQLの中でも
<strong>PL SQL</strong>と呼ばれる種類のもののみです。


for文をサポートしているのは「PL/SQL」

## for文をサポートしている「PL/SQL」とは

PL/SQLとは「Procedure Language SQL」という意味の文法です。

Procedureは順序、手続きなどの意味を持ちますから、PLSQLは
手続き型に拡張したSQLという意味を持つのです。





## PL/SQLのforのきほんの書き方

まずはデータベースに接続しない例から

次のコードでは1から3の数字をループしてコンソールに出力しています。

<pre><code>
FOR i IN 1..3 LOOP
    DBMS_OUTPUT.PUT_LINE('ループ変数 i = ' || i);
END LOOP;
</code></pre>

- 実行結果

<pre><code>
ループ変数 i = 1
ループ変数 i = 2
ループ変数 i = 3

</code></pre>

## 「PL/SQL for 逆順」のきほんの書き方

1から3のループを逆順にしたいときはREVERSEキーワードを使います。

<pre><code>
FOR i IN REVERSE 1..3 LOOP
    DBMS_OUTPUT.PUT_LINE('ループ変数 i = ' || i);
END LOOP;
</code></pre>

- 実行結果

<pre><code>
ループ変数 i = 3
ループ変数 i = 2
ループ変数 i = 1

</code></pre>


## selectをforで回す

次はselectでデータベースから取得した値をfor文で回します。

ポイントは次の三つ

- cursorを用いて「変数のように」selectした結果を代入すること
- その値をfor句の IN　に代入すること
- ループの変数は「レコード」として値を取り出すことができること

<pre><code>
DECLARE
    CURSOR employee_cur IS
        SELECT id, name FROM employees WHERE name like '悟';
BEGIN
    FOR employee_rec IN employee_cur LOOP
        DBMS_OUTPUT.PUT_LINE( 'idは' || employee_rec.id || 'です');
        DBMS_OUTPUT.PUT_LINE( 'nameは' || employee_rec.name 'です');
    END LOOP;
END;
</code></pre>

- 実行結果

<pre><code>

idは20です。
nameはtarouです。
...

PL/SQLプロシージャが正常に完了しました。
</code></pre>







## サンプルテーブル


- employees


<table>
    <thead>
        <tr>
            <th>id</th>
            <th>name</th>
            <th>salary</th>
            <th>dept_id</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1234</td>
            <td>tarou</td>
            <td>10,00
            </td>
            <td>20
            </td>
        </tr>
        <tr>
            <td>
            1235
            </td>
            <td>
            kaiou
            </td>
            <td>
            20.000
            </td>
            <td>
            20
            </td>
        </tr>
        <tr>
            <td>
            1236
            </td>
            <td>
            nanashi
            </td>
            <td>
            30,00
            </td>
            <td>
            10000
            </td>
        </tr>
    </tbody>
</table>




## 備考

title:「sql for」で検索した方へ【SQL基礎】

description:次はselectでデータベースから取得した値をfor文で回します。ポイントは次の三つ。cursorを用いて「変数のように」selectした結果を代入すること。その値をfor句の IN　に代入すること。ループの変数は「レコード」として値を取り出すことができること

img:https://images.squarespace-cdn.com/content/v1/5c3cf2ac5417fc3efa512c5a/1547588142968-VWQR0WMNFIX7GW18937A/lrg.jpg


category_script:page_name.startswith("25")


