

遅かれ早かれ、C、Java、Perl、PHP、またはその他の多くの場所からPL / SQLを呼び出すことをお勧めします。

これは妥当な要求のように思えますが、これまでに言語間の作業を行ったことがある場合は、言語固有のデータ型、特に配列、レコード、およびオブジェクト-MicrosoftのOpenDatabase Connectivity（ODBC）のような「標準」アプリケーションプログラミングインターフェイス（API）に対する異なるパラメータセマンティクスまたはベンダー拡張は言うまでもありません。


<pre><code>
/* File on web: booktitle.fun */
    FUNCTION booktitle (isbn_in IN VARCHAR2)
       RETURN VARCHAR2
    IS
       l_title books.title%TYPE;
       CURSOR icur IS SELECT title FROM books WHERE isbn = isbn_in;
    BEGIN
       OPEN icur;
       FETCH icur INTO l_title;
       CLOSE icur;
       RETURN l_title;
END;
</code></pre>


## 他の言語からの呼び出し

## c言語

オラクルが提供する「precompiler(Pro*C)」


## Java

JDBCライブラリを使用しましょう

## Perl

Perl DBIとDBD::Oracleを使用しましょう


## 備考

title:PLSQLを他のプログラミング言語から呼び出す方法【PLSQL基礎入門】


description:遅かれ早かれ、C、Java、Perl、PHP、またはその他の多くの場所からPL / SQLを呼び出すことをお勧めします。これは妥当な要求のように思えますが、これまでに言語間の作業を行ったことがある場合は、言語固有のデータ型、特に配列、レコード、およびオブジェクト-MicrosoftのOpenDatabase Connectivity（ODBC）




img:https://images.squarespace-cdn.com/content/v1/5c3cf2ac5417fc3efa512c5a/1547588142968-VWQR0WMNFIX7GW18937A/lrg.jpg



category_script:page_name.startswith("25")




