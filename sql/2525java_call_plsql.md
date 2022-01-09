

## Javaからplsqlを呼び出す方法

Cと同様に、Oracleはデータベースに接続するためのさまざまなアプローチを提供します。

そもそもSQLとJavaは高愛称です。

なぜなら、PLSQLもJavaも通常Oracle社が作り出したものだからです。


より一般的でJava中心のアプローチは、JDBC（実際には何も意味しません）として知られていますが、通常の解釈は「Javaデータベースコネクティビティ」です。

## サンプルコード

importの宣言の後に、「java.sql.*」を埋め込むことでSQLを呼ぶ準備は調います。




<pre><code>
import java.sql.*;

public class Book
    {
      public static void main(String[] args) throws SQLException
      {
        // initialize the driver and try to make a connection
        DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver ());
        Connection conn =
           DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:o92",
                                 "scott", "tiger");
       // prepareCall uses ANSI92 "call" syntax
       CallableStatement cstmt = conn.prepareCall("{? = call booktitle(?)}");
       // get those bind variables and parameters set up
       cstmt.registerOutParameter(1, Types.VARCHAR);
       cstmt.setString(2, "0-596-00180-0");
       // now we can do it, get it, close it, and print it
       cstmt.executeUpdate();
       String bookTitle = cstmt.getString(1);
       conn.close();
       System.out.println(bookTitle);
      }
}

</code></pre>



## コードの特徴


この特定の例では、通信パフォーマンスをいくらか犠牲にして、優れた互換性とインストールの容易さ（すべてのネットワークプロトコルスマートはJavaライブラリに存在します）を提供するシンドライバーを使用します



## 備考

title:Javaからplsqlを呼び出す【PLSQL基礎入門】


description:そもそもSQLとJavaは好相性です。なぜなら、PLSQLもJavaも通常Oracle社が作り出したものだからです。より一般的でJava中心のアプローチは、JDBC（実際には何も意味しません）として知られていますが、通常の解釈は「Javaデータベースコネクティビティ」です。


img:https://images.squarespace-cdn.com/content/v1/5c3cf2ac5417fc3efa512c5a/1547588142968-VWQR0WMNFIX7GW18937A/lrg.jpg



category_script:page_name.startswith("25")



