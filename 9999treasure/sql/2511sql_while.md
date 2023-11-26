



## 通常のsqlにfor文は存在しない。

まず大前提として、「通常のSQLにfor文は存在しません」

そもそもSQLにはいくつか種類がありますが、それらがサポートする
ものは以下のキーワードのみです。

出典:
<a href="https://docs.oracle.com/cd/E16338_01/appdev.112/b56260/reservewords.htm">
PL/SQLの予約語およびキーワード)
</a>

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

このリストを見るとわかるように、通常のSQLの中にはこれらのキーワードは存在しません。

本記事に登場するキーワードはSQLの中でも「PL/SQL」と呼ばれる種類のみです。

本記事で学習する前に、データベースサーバーがPL/SQLをサポートしているものかどうかを確認することをお勧めします。




## まさに無限ループ！

まずはwhileを使った無限ループから

<pre><code>
BEGIN
   WHILE (1=1) LOOP
           DBMS_OUTPUT.PUT_LINE('呼び出されます');
           DBMS_OUTPUT.PUT_LINE('これも呼び出されます');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('呼び出されます');
END;

</code></pre>




## sqlのbreak

通常のプログラミング言語ではループを一つ抜け出す際にbreakというキーワードを用いることがほとんどですが

pl sqlでは<strong>EXIT WHEN</storng>を使用します。


<pre><code>
BEGIN
   WHILE (1=1) LOOP
           DBMS_OUTPUT.PUT_LINE('呼び出されます');
           EXIT WHEN (1=1) ;
           DBMS_OUTPUT.PUT_LINE('呼び出されません');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('呼び出されます');
END;

</code></pre>






title:SQLのwhileの書き方【PL SQL基礎】

description:通常のプログラミング言語ではループを一つ抜け出す際にbreakというキーワードを用いることがほとんどですがpl sqlではEXIT WHENを使用します。



img:https://images.squarespace-cdn.com/content/v1/5c3cf2ac5417fc3efa512c5a/1547588142968-VWQR0WMNFIX7GW18937A/lrg.jpg



category_script:page_name.startswith("25")




