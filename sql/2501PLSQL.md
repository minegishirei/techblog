





## 「PL SQL 書き方」で検索した方へ

初めにPL/SQLのサンプルコードを紹介します。


<pre><code>
DECLARE
    l_book_count INTEGER;
BEGIN
    SELECT COUNT(*)
        INTO l_book_count
    FROM books
        WHERE author LIKE '%FEUERSTEIN, STEVEN%';

    DBMS_OUTPUT.PUT_LINE ('Steven has written' ||l_book_count ||' books.');

    - 名前を変える。
    SET author = REPLACE 
        (author, 'STEVEN', 'STEPHEN')
    WHERE 
        author LIKE '%FEUERSTEIN, STEVEN%';
END;

</code></pre>


## PL SQLがサポートしているもの

- IF文やCASE文
- - これらの大切なロジックももちろんサポートしています。
- - 例えば、「もし本の数が1,000より大きければ...」
- ループやイテレートコントロールなどのサポートも充実しています。
- GOTO文
- - なんとPL/SQLはGOTO文もサポートします。
- - もちろん、それが許されているからといって無闇やたらに使っていわけではないが。



IF文とループをうまく組み合わせたサンプルコード

<pre><code>

PROCEDURE pay_out_balance (account_id_in IN accounts.id%TYPE)
    IS
    
    l_balance_remaining NUMBER;
    BEGIN
        LOOP
            l_balance_remaining := account_balance (account_id_in);
            IF l_balance_remaining < 1000 THEN
                EXIT;
            ELSE
                apply_balance (account_id_in, l_balance_remaining);
            END IF;
        END LOOP;
END pay_out_balance;

</code></pre>

参考：<a href="https://datubaze.files.wordpress.com/2015/09/s_feuerstein_oracle-pl_sql-programming_6th-edition_2014.pdf">Oracle PL SQL プログラミング</a>

<pre><code>
IF and CASE statements
These implement conditional logic; for example, “If the page count of a book is
greater than 1,000, then...”
A full complement of looping or iterative controls
These include the FOR loop, the WHILE loop, and the simple loop.
The GOTO statement
Yes, PL/SQL even offers a GOTO that allows you to branch unconditionally from
one part of your program to another. That doesn’t mean, however, that you should
actually use it.
</code></pre>






title:【PL/SQL基礎入門】PLSQLのきほんの文法


description:- IF文やCASE文. これらの大切なロジックももちろんサポートしています。例えば、「もし本の数が1,000より大きければ...」ループやイテレートコントロールなどのサポートも充実しています。 GOTO文。なんとPL/SQLはGOTO文もサポートします。もちろん、それが許されているからといって無闇やたらに使っていわけではないが。


img:https://images.squarespace-cdn.com/content/v1/5c3cf2ac5417fc3efa512c5a/1547588142968-VWQR0WMNFIX7GW18937A/lrg.jpg



category_script:page_name.startswith("25")


