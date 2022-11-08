


## 全ての結果を一つのクエリで出そうとしてはいけない

電話で幹部と話している上司が、いきなりあなたの机に来てこう言いました。

「SQLを使って次の4つの値を調べて欲しい。開発者一人当たりの平均バグ修正数、修正したバグの中で顧客から報告された数、バグを修正した開発者の数、うちの課が取り扱っているバグの数」

**あなたは怒りを抑えて、全ての答えを一気に取り出したいので、次のような複雑なクエリを書くことにしました。(これが間違い)**

```sql
SELECT COUNT(bp.product_id) AS how_many_products,
COUNT(dev.account_id) AS how_many_developers,
COUNT(b.bug_id)/COUNT(dev.account_id) AS avg_bugs_per_developer,
COUNT(cust.account_id) AS how_many_customers
FROM Bugs b JOIN BugsProducts bp ON (b.bug_id = bp.bug_id)
JOIN Accounts dev ON (b.assigned_to = dev.account_id)
JOIN Accounts cust ON (b.reported_by = cust.account_id)
WHERE cust.email NOT LIKE '%@example.com'
GROUP BY bp.product_id;
```

できたデータを確認してみると、なんだか間違っているような気がします。

結局間違いを確認できずに、あなたはデータを提出することができませんでした。


## 複雑な問題を一つのクエリで解決してはいけない

確かにSQLは強力な言語で一つのクエリで全てのタスクを処理することもできます。
ですがだからと言って、SQLは一つのクエリで全てを解決することを強制しません。
時にはそれがよくないアイデアであることがあります。


### デカルト積が生み出されてしまうことがある

一つのクエリで全てを処理しようとする試みは、しばしばデカルト積を生み出す原因になります。

デカルト積とは一言で言うと、総当たりです。

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Cartesian_Product_qtl1.svg/1200px-Cartesian_Product_qtl1.svg.png">

二つのテーブル、AとBがあった場合、それらのテーブルから総当たりとなる集合をデカルト積と呼びます。

各テーブルに10行ずつ存在しいた場合でも、デカルト積として統計データを算出する場合は100行に膨れ上がります。

デカルト積は二つのテーブルの関係を定義しない場合、つまりWHERE句やJOIN句での結合の失敗時に発生しやすいです。
特に、**一つのクエリで全てを処理しようとする試みは、複数のテーブルの関係が曖昧になり、意図しない結合に発展しやすいのです。**


### クエリが読めなくなる

**プログラミングのコードは書くだけでは終わりではありません。むしろ、一度書いたコードを他の人が何回も読みます。**

この「読む」と言うプロセスに問題がないかどうかを確認するためにコードレビューという作業が存在し、
読めないコードやクエリはレビュアーという第三者によって弾かれます。
でなければ保守不可能なコードが蓄積し、更なるスパゲッティコードや障害の温床になるのです。

SQLも同じです。

データベースアプリケーションでは頻繁に機能追加が求められ卯rことを忘れてはいけません。
上司から、詳細なレポート生成やユーザーインターフェースのフィールド追加を求められることもあります。

<img src="https://image.slidesharecdn.com/spaghetti-query-140402104312-phpapp02/95/sql-2-638.jpg?cb=1396435576">

https://www.slideshare.net/makopi/spaghetti-query

スパゲッティのように絡まったコードを解読するのは困難です。


## SQLで統計データを算出する方法

### 1.クエリを複数に分割する

冒頭のエピソードのような、統計データを出して欲しいという緊急のリクエストに答えるにはどうすればいいのでしょうか？

**最善の策は一つの統計データに対して一つのクエリを出すことです**

- 製品の数

```sql
-- 製品の数
SELECT 
    COUNT(*) AS how_many_products
FROM 
    Products;
```

- バグを解決した開発者の数

```sql
-- バグを解決した開発者の数
SELECT 
    COUNT(DISTINCT assigned_to) AS how_many_developers
FROM 
    Bugs
WHERE 
    status = 'FIXED';
```

- 開発者一人当たりの平均バグ修正数

```sql
-- 開発者一人当たりの平均バグ修正数
SELECT 
    AVG(bugs_per_developer) AS average_bugs_per_developer
FROM 
    (
    SELECT 
        dev.account_id, COUNT(*) AS bugs_per_developer
    FROM 
        Bugs b JOIN Accounts dev ON (b.assigned_to = dev.account_id)
    WHERE 
        b.status = 'FIXED'
    GROUP BY 
        dev.account_id
    ) t;
```

- 修正したバグの中で顧客から報告されたバグの数

```sql
-- 修正したバグの中で顧客から報告されたバグの数
SELECT 
    COUNT(*) AS how_many_customer_bugs
FROM 
    Bugs b 
JOIN 
    Accounts cust ON (b.reported_by = cust.account_id)
WHERE 1=1
    AND b.status = 'FIXED' 
    AND cust.email NOT LIKE '%@example.com';
```



### 2.SQLを用いたSQLの生成

コード生成は、新しいコードを手で書くには労力がかかるという場合に非常に有効です。
この技法を使いこなすことによって、プログラマーは繰り返し同じようなコードを書かなくてよくなります。


### 例.複数のUPDATEステートメント生成

別のIT部門が電話があり、「在庫マネジメントシステムが朝からオフラインだ」と連絡を受けました。

「原因はデータベースにあり、特定の条件の行をアップデートすれば解決するのだが、良いコードが書けない」

彼はSQLの初心者ではありませんでしたが、**彼の失敗は良いコードを一回で書こうとしたことでした。**

**私は複雑な一つのSQLステートメントを書く代わりに、シンプルなSQLを複数生成するスクリプトを書きました。**
その結果、求めていたUPDATEステートメントを獲得できたのです。

```sql
SELECT CONCAT('UPDATE Inventory ',
    ' SET last_used = ''', MAX(u.usage_date), '''',
    ' WHERE inventory_id = ', u.inventory_id, ';') AS update_statement
FROM 
    ComputerUsage u
GROUP BY 
    u.inventory_id;
```

このSQLの実行結果は次の通りです。

```sql
UPDATE Inventory SET last_used = ’2002-04-19’ WHERE inventory_id = 1234;
UPDATE Inventory SET last_used = ’2002-03-12’ WHERE inventory_id = 2345;
UPDATE Inventory SET last_used = ’2002-04-30’ WHERE inventory_id = 3456;
UPDATE Inventory SET last_used = ’2002-04-04’ WHERE inventory_id = 4567;
```

このテクニックによって、その担当者が何時間も頭を悩ませていた問題を、数分のうちに解決できたのです。


### 3.UNIONでつなげる

それでもあなたの上司が「どうしても一つのクエリがいいんだ〜〜〜」と喚いたとしましょう。

その場合にはUNIONを使って一つのクエリとして結合することをお勧めします。


```sql
(
    SELECT p.product_id, f.status, COUNT(f.bug_id) AS bug_count
    FROM 
        BugsProducts p
    LEFT OUTER JOIN 
        Bugs f ON (p.bug_id = f.bug_id AND f.status = 'FIXED')
    WHERE 
        p.product_id = 1
    GROUP BY 
        p.product_id, f.status
)

UNION ALL

(
    SELECT 
        p.product_id, o.status, COUNT(o.bug_id) AS bug_count
    FROM 
        BugsProducts p
    LEFT OUTER JOIN 
        Bugs o ON (p.bug_id = o.bug_id AND o.status = 'OPEN')
    WHERE 
        p.product_id = 1
    GROUP BY 
        p.product_id, o.status
)

ORDER BY bug_count;
```

このクエリの結果は、各サブクエリの結果を合わせたものになります。
全体として合計2行が結果として出力されることになるのです。

### 4.全部SELECT句に納める:オリジナル

あなたの上司が「縦に並ぶのやだ〜横二列がいい〜」と喚いたとします。

その場合は~~怒りを鎮めて~~dualと副問い合わせを使用して、select句に全て納めましょう。


```sql
select
    (
        SELECT 
            COUNT(f.bug_id) AS bug_count
        FROM 
            BugsProducts p
        LEFT OUTER JOIN 
            Bugs f ON (p.bug_id = f.bug_id AND f.status = 'FIXED')
        WHERE 
            p.product_id = 1
        GROUP BY 
            p.product_id, f.status
    ) AS "修正済みバグ件数",
    (
        SELECT 
            COUNT(o.bug_id) AS bug_count
        FROM 
            BugsProducts p
        LEFT OUTER JOIN 
            Bugs o ON (p.bug_id = o.bug_id AND o.status = 'OPEN')
        WHERE 
            p.product_id = 1
        GROUP BY 
            p.product_id, o.status
    ) AS "対応中バグ件数"
from
    dual
```


### 5.CASE文とSUM関数を組み合わせる

上司が「ヤダヤダ〜〜新しいステータスがきても対応できるように拡張してくれないとやだ〜」と喚いたとします。

そんな場合は~~怒りを抑えて~~条件ごとの集約を一つのクエリでシンプルに行うために、CASE式とSUM関数を組み合わせる方法もあります。

```sql
SELECT
    p.product_id,
    SUM(CASE b.status WHEN 'FIXED' THEN 1 ELSE 0 END) AS count_fixed,
    SUM(CASE b.status WHEN 'OPEN'  THEN 1 ELSE 0 END) AS count_opend,
FROM
    BugsProduct p
INNER JOIN
    Bugs b USING (bugid)
WHERE
    p.product_id = 1
GROUP BY
    p.product_id;
```



## 参考

SQLアンチパターン：17章スパゲッティクエリ

<img src="https://www.oreilly.co.jp/books/images/picture_large978-4-87311-589-4.jpeg">












### SQLでの統計データの出力方法

title:SQLでの統計データの出力方法

description:確かにSQLは強力な言語で一つのクエリで全てのタスクを処理することもできます。ですがだからと言って、SQLは一つのクエリで全てを解決することを強制しません。時にはそれがよくないアイデアであることがあります。


category_script:page_name.startswith("30")


img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-589-4.jpeg

