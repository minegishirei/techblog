


## 副題

問題にぶつかると「正規表現を使えばいい」という人がいる。
そして問題を二つ抱えることになる。



## 事例:検索エンジンの必要性

webサイトで記事の数が膨大になるにつれて、検索機能の必要性が明らかになる。

分類して設置しておくことも一つの解決策だが、分類が難しい記事もあるし、結局は検索機能が必要になる。

検索には次のような用件が求められる

- crashで検索すると、crashed,crashes,chrashingなどが出てくる

- 記事が増加しても処理が重くならない

確かに、オンラインでのテキスト検索は一般的になった。

しかしSQLでテキスト検索を高速かつ正確に行うのは、簡単そうに見えて難しい。


## 目的：全文検索を行う。

SQLをRDMSたらしめているのは列の値がアトミックであること

つまり他の値と比べることができることだ。

しかし文字部分列の比較はSQLにおいては非効率で深く精査につながりやすい

## アンチパターン：パターンマッチを使う

パターンマッチとは簡単にいうとワイルドカードか正規表現のこと

例えば、以下の要件を叶えたいとする。

> crashで検索すると、crashed,crashes,chrashingなどが出てくる

単純なワイルドカードならば以下の通り

<pre><code>
select
    *
from
    Bugs
where
    description like '%crash%'
</code></pre>

SQLの標準ではないが、多くのデータベースは **正規表現** もサポートしている

<pre><code>
select
    *
from
    Bugs
where
    description REGEXP 'crash'
</code></pre>

## デメリット１:パフォーマンスの低下

しかしこれらのパターンマッチの最も大きな問題点は、 **パフォーマンスの低下** である。

パターンマッチは **インデックスのメリットを受けることはできない**

パターンマッチには二つの整数の等価性比較よりも大きなコストがかかる。


## もう一つの欠点:意図しないマッチ

LIKEや正規表現を用いた単純なパターンマッチでは、意図しないマッチが生じてしまう

例えば英数字のoneをパターンマッチで検知したい場合

<pre><code>
select
    *
from
    Bugs
where
    description like '%one%'
</code></pre>

と書くことが予想されるが、これは次の単語にもマッチする

- money

- prone

- lonely

前後にスペースを入れて検索したい場合でも、句読点や先頭、語尾にある場合にヒットしない



## 解決策：SQLで解決しない

身も蓋もないが **SQLの代わりに専用の全文検索エンジンを使う** が答え

次善の策は繰り返しのコストを減らすために検索結果を保存すること。


## MySQLのフルテキストインデックス

MySQLではMyISAMストレージエンジンのみがサポートする、シンプルな**フルテキストインデックス**が提供される。

フルテキストインデックスはCHAR,VARCHAR,TEXT型に定義できる。

適用するためには **ALTER TABLE文** を使用する

<pre><code>
ALTER TABLE Bugs ADD FULLTEXT INDEX bugfts (summary, description)
</code></pre>

インデックスに格納されたテキストからキーワードを検索するにはMATCH関数を使用する。

このとき列名は複数指定可能である。

`
select * from Bugs Where MATCH(summary, description) AGAINST('crash')
`


## Oracleのテキストインデックス

<pre><code>
> CREATE INDEX BugsText ON Bugs(summary) INDEXTYPE CTXSYS.CONTEXT

> SELECT * FROM Bugs Where CONTAINS(summary, 'crash') > 0
</code></pre>


# サードパーティーのサーチエンジン

これまでの方法は全てベンダーに依存している。

ベンダーごとに依存したくない場合はSQLデータベースから独立して動く検索エンジンが必要になる。

## Sphinx Search

オープンソースの検索エンジン

MySQLやPostgreSQLとうまく連携できる。



## Apach Lucene

Javaアプリケーション向けの成熟した検索エンジン

C++,C#,Perl,Ruby,Python,PHPなどのプロジェクトも存在している



## 転地インデックスの作成

ユーザーが検索するキーワードの一覧を **Keywords** テーブルとして

多対多の関係の構築のために **BugsKeywords** 交差テーブルを作る

<pre><code>
CREATE TABLE Keywords {
    keyword_id  SERIAL PRIMARY KEY,
    keyword     VARCHAR2 NOT NULL,
    UNIQUE KEY  (Keyword)
}

CRETAE TABLE BugsKeyword {
    keyword_id  BIGINT UNSINED NOT NULL,
    bug_id      BIGINT UNSINED NOT NULL,
    PRIMARYKEY (keyword_id, bug_id),
    FOREIGN KEY (keyword_id) REFERENCES Keywords(keyword_id),
    FOREGIN KEY (bug_id) REFERENCES Bugs(bug_id)
}
</code></pre>

BugsKeywordは Keywordテーブルと Bugsテーブルの組み合わせを **重複なしにする役割を担う**

BugsKeywordにはあるバグの説明文に使われる全てのキーワードを、行として加える

次に、次のようなプロシージャを作る

<pre><code>
CREATE PROCEDURE BugsSearch(keyword VARCHAR(40))
BEGIN
    set @keyword = keyword;

    -- Keywordsに対して検索を行う
    -- 検索結果がない場合はNULLが返される
    PREPARE s1 FROM 'SELECT MAX(keyword_id) INTO @k FROM Keywords WHERE keyword = ?`
    EXCUTE s1 USINF @keyword;
    DEALLOCATE PREPARE s1;

    IF (@k IS NULL) THEN
        -- マッチしなかった時は新しい語として挿入される
        PREPARE s2 FROM 'INSERT INTO Keywords (keyword) VALUES (?)';
        EXCUTE s2 USING @keyword;
        DEALLOCATE PREPARE s2;

        -- Keywordsで生成された主キーを検索
        SELECT LAST_INSRT_ID() INTO @k;

        -- 新しいキーワードを含む行をBugsで検索して、交差テーブルに代入する
        PREPARE s3 FROM '
            INSERT INTO BugsKeywords (bug_id, keyword_id)
            SELECT 
                bug_id, ? 
            FROM 
                Bugs
            Where
                summary REGEXP CONCAT('' [[:<:]], ?, '' [[:>:]] '')
            OR 
                description REGEXP CONCAT('' [[:<:]], ?, '' [[:>:]] '')';
        EXCUTE s3 USINF @k, @keyword, @keyword;
        DEALLOCATE PREPARE s3;
    END IF;

    --新しいキーワードを含む行をBugsで検索して、交差テーブルに値を代入する
    PREPARE s4 FROM '
        SELECT 
            b.* 
        FROM 
            Bugs b
        INNER JOIN
            BugsKeywords k USING(bug_id)
        WHERE
            k.kwyword_id = ?`;
    
    EXCUTE s4 USINF @k
    DEALLOCATE PREPARE s4;
END
</code></pre>


















title:プアマンズ・サーチエンジン


description:SQLをRDMSたらしめているのは列の値がアトミックであること。つまり他の値と比べることができることだ。。しかし文字部分列の比較はSQLにおいては非効率で深く精査につながりやすい。


img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-589-4.jpeg

category_script:page_name.startswith("30")


