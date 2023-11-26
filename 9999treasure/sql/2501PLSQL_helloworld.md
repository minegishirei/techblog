

## PL SQLのコンソール出力

<pre><code>
SET SERVEROUTPUT ON
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World!');
END;
</code></pre>

- 実行結果

<pre><code>
Hello World!
PL/SQL procedure successfully completed.

</code></pre>



- PL/SQLの基本的なポイント「PL/SQL procedure successfully completed.」
- 「SET SERVEROUTPUT ON」を先頭に付け加えることでコンソール画面に出力する。


## もっと短い PL/SQLの『hello world!』



<pre><code>
EXECUTE DBMS_OUTPUT.PUT_LINE('Hey look, Ma!')

</code></pre>



## 備考欄

title:【PL/SQL基礎入門】PLSQLのコンソール出力

description:PL/SQLの基本的なポイント「PL/SQL procedure successfully completed.」「SET SERVEROUTPUT ON」を先頭に付け加えることでコンソール画面に出力する。


img:https://images.squarespace-cdn.com/content/v1/5c3cf2ac5417fc3efa512c5a/1547588142968-VWQR0WMNFIX7GW18937A/lrg.jpg



category_script:page_name.startswith("25")





