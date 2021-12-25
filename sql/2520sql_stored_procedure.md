


## ストアドプログラムとは

ストアドプログラムとは言ってしまえばただの関数です。


## ストアドプログラムの宣言方法



<pre><code>
CREATE OR REPLACE FUNCTION wordcount (str IN VARCHAR2)RETURN PLS_INTEGER　AS
    len PLS_INTEGER := NVL(LENGTH(str),0);
    inside_a_word BOOLEAN;
BEGIN
    FOR i IN 1..len + 1
    LOOP
        IF ASCII(SUBSTR(str, i, 1)) < 33 OR i > len　THEN
            IF inside_a_word
            THEN
                words := words + 1;
                inside_a_word := FALSE;
            END IF;
        ELSE
            inside_a_word := TRUE;
        END IF;
    END LOOP;
    return Words;
END;
/
</code></pre>


## エラーが発生した時の対応

次のコマンドを実行することで、どんなエラーが出ているかを把握できます。

<pre><code>
SHO ERR

</code></pre>

実行結果

<pre><code>
Errors for FUNCTION WORDCOUNT:
LINE/COL ERROR
-------- ---------------------------------------------- 14/13 PLS-00201: identifier 'WORDS' must be declared 14/13 PL/SQL: Statement ignored
21/4 PL/SQL: Statement ignored
21/11 PLS-00201: identifier 'WORDS' must be declared
</code></pre>





## ストアドプログラムを呼び出す方法。

ストアドプログラムを呼び出す2つの異なる方法については、すでに説明しました。

単純なPL / SQLブロックでラップするか、SQL * PlusEXECUTEコマンドを使用します。

他のストアドプログラム内でストアドプログラムを使用することもできます。

たとえば、整数式を使用できる任意の場所で、
wordcountなどの関数を呼び出すことができます。

これは、奇妙な入力で単語数関数をテストする方法の簡単な図です
（CHR（9）はASCIIの「タブ」文字です）。


<pre><code>
BEGIN
       DBMS_OUTPUT.PUT_LINE('There are ' || wordcount(CHR(9)) || ' words in a tab');
END; /
</code></pre>

ここで、PL / SQLは整数を文字列に自動的にキャストするため、
他の2つのリテラル式と連結できます。結果は次のとおりです。

<pre><code>
There are 0 words in a tab
</code></pre>



## ストアドプロシージャの一覧取得

これは、ある種のGUIベースのナビゲーションアシスタントを使用するとはるかに簡単になるタスクの1つですが、そのようなツールがない場合は、データから目的の情報を引き出すSQLステートメントをいくつか作成するのはそれほど難しくありません。

たとえば、プログラム（およびテーブル、インデックスなど）の完全なリストを表示するには、次のようにUSER_OBJECTSビューにクエリを実行します

<pre><code>
SELECT * FROM USER_OBJECTS;
</code></pre>

このクエリを実行することで、あなたはword_count関数を見つけることができるでしょう。


## ストアドプロシージャの説明の取得

DESCRIBEコマンドを使うことでプロシージゃの情報も手に入れられます

<pre><code>

DESCRIBE wordcount
</code></pre>

実行結果

<pre><code>
FUNCTION wordcount RETURNS BINARY_INTEGER
Argument Name  Type        In/Out Default?
-------------  ----        ------ --------
STR            VARCHAR2    IN
</code></pre>



## ストアどプログラムの削除方法

本当に特定のストアドプログラムが必要なくなった場合は、SQLのDROPステートメントを使用してプログラムを削除できます。

<pre><code>
DROP FUNCTION wordcount;

</code></pre>






title:ストアドプログラムとは何か【PLSQL学習サイト】

category:ストアドプログラムを呼び出す2つの異なる方法については、すでに説明しました。単純なPL / SQLブロックでラップするか、SQL * PlusEXECUTEコマンドを使用します。

img:https://images.squarespace-cdn.com/content/v1/5c3cf2ac5417fc3efa512c5a/1547588142968-VWQR0WMNFIX7GW18937A/lrg.jpg



category_script:page_name.startswith("25")

