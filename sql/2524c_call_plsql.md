

## PLSQLをC言語から呼び出す

オラクルは、少なくとも2つの異なるC言語インターフェースをOracleに提供しています。

一つ目の方法はOCI（Oracle Call Interface）と呼ばる

もう1つはPro * Cと呼ばれます。

OCIは行数が長くなる傾向があるので、代わりに「Pro * C」を使った方法を例としてあげる。





## サンプルコード

<pre>
<code>
/* File on web: callbooktitle.pc */
#include <stdio.h>
#include <string.h>
EXEC SQL BEGIN DECLARE SECTION;
VARCHAR uid[20];
VARCHAR pwd[20];
VARCHAR isbn[15];
VARCHAR btitle[400];
EXEC SQL END DECLARE SECTION;
EXEC SQL INCLUDE SQLCA.H;
int sqlerror();

int main() {
        /* VARCHARs actually become a struct of a char array and a length */
46 | Chapter 2: Creating and Running PL/SQL Code
 www.it-ebooks.info
strcpy((char *)uid.arr,"scott");
        uid.len = (short) strlen((char *)uid.arr);
        strcpy((char *)pwd.arr,"tiger");
        pwd.len = (short) strlen((char *)pwd.arr);
        /* this is a cross between an exception and a goto */
        EXEC SQL WHENEVER SQLERROR DO sqlerror();
        /* connect and then execute the function */
        EXEC SQL CONNECT :uid IDENTIFIED BY :pwd;
        EXEC SQL EXECUTE
           BEGIN
              :btitle := booktitle('0-596-00180-0');
           END;
        END-EXEC;
        /* show me the money */
        printf("%s\n", btitle.arr);
        /* disconnect from ORACLE */
        EXEC SQL COMMIT WORK RELEASE;
        exit(0);
}
sqlerror() {
        EXEC SQL WHENEVER SQLERROR CONTINUE;
        printf("\n% .70s \n", sqlca.sqlerrm.sqlerrmc);
        EXEC SQL ROLLBACK WORK RELEASE;
        exit(1);
}

</code></pre>

## 呼び出しているPLSQL


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





title:PLSQLをC言語から呼び出す【PLSQL基礎】

description:オラクルは、少なくとも2つの異なるC言語インターフェースをOracleに提供しています。一つ目の方法はOCI（Oracle Call Interface）と呼ばる。もう1つはPro * Cと呼ばれます。OCIは行数が長くなる傾向があるので、代わりに「Pro * C」を使った方法を例としてあげる。



img:https://images.squarespace-cdn.com/content/v1/5c3cf2ac5417fc3efa512c5a/1547588142968-VWQR0WMNFIX7GW18937A/lrg.jpg



category_script:page_name.startswith("25")

