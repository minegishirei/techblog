
- [SnowflakeのSQL](#snowflakeのsql)
  - [クエリタグの使用](#クエリタグの使用)
  - [オブジェクト識別子の大文字と小文字の区別](#オブジェクト識別子の大文字と小文字の区別)
  - [制約](#制約)
  - [LIMIT](#limit)
  - [PIVOT：縦軸と横軸を入れ替えれる](#pivot縦軸と横軸を入れ替えれる)
  - [照合:`collate`で列の比較の定義をする。](#照合collateで列の比較の定義をする)
    - [例.列の照合の指定方法](#例列の照合の指定方法)
    - [例2.snowflakeのWHERE句で`collate`を使用する](#例2snowflakeのwhere句でcollateを使用する)
    - [例3.snowflakeの照合でサポートするもの](#例3snowflakeの照合でサポートするもの)
  - [反復的なサブクエリへTEMPORARYテーブルを使用する](#反復的なサブクエリへtemporaryテーブルを使用する)
  - [クエリタグの使用](#クエリタグの使用-1)
  - [備考](#備考)


# SnowflakeのSQL

SNOWFlakeはANSIの標準のSQLを使用することができる

それに加えて、特殊なコマンドも活用できる

UNDROP,CLONE,SHARE


## クエリタグの使用

クエリタグの設定により、SQL文一つ一つに名前をつけることができる。

サンプルコード：`ALTER SESSION SET QUERY_TAG="tagname"`

このように実行することで、snoflake webuiの履歴画面から、QUERY_TAGを指定して確認することができる。
あるいは、QUERY_TAGにユーザーの名前をつけておくことで、他のユーザーとのシェアも実現できる。


## オブジェクト識別子の大文字と小文字の区別

- CTEATE TABLE My_Tableを実行した後の結果は`MY_TABLE`が作成される
- 基本的に大文字が優先される
- テーブル作成ステートメントで小文字を指定したい場合は、ダブルクォーテーションを使用できる。_
- `CREATE TABLE "My_Table"` の結果は、`My_Tabale`が作成される


## 制約

- Snowflakeは制約の定義と維持をサポートしてくれる

- Snowflakeが適用する唯一の制約は、`NOT NULL`制約
    - **PRIMARYキーや、FOREIGNキーなどの制約をさポートしない点は注意が必要**
    - このような制約はアプリケーション側でサポートする必要がある。
    - このように制約をサポートできないのは、DWHが制約よりも速度を重視しているため。Snowflakeに限らず、BigQueryなどでも同様

- 主にデータモデリングの目的で、制約を使用するクライアントツールをサポートする。
    - Tableauはパフォーマンスを向上できるJoin Vullingのために制約をサポートしている




## LIMIT

返される行異数を指定された値に制限する。

最初のn行を返すわけではないので注意。

LIMITとFETCHの両方がサポートされており、同じ結果を返します。


## PIVOT：縦軸と横軸を入れ替えれる


## 照合:`collate`で列の比較の定義をする。

snowflakeでは適切な文字の順序を、大きい、小さい、同じで並べることができる。この機能を**照合**と呼ぶ。

- 例.以下はアルファベット順+大文字小文字の区別をした場合。
  1. Anne
  2. Bob
  3. Jerry
  4. charies
  5. deborah
  6. klaus

- Snowflakeを使用すると、文字列は内部的にはUTF-8で格納される。

- UTF-8は文字の数値表現を使用してソートする


### 例.列の照合の指定方法

称号はCREATE　TABLEwを使用して設定できる。

次の例はcol2にフランス語でのソート、col3にスペイン語のソートを設定している。

```sql
CREATE TABLE test 
 col1 VARCHAR,
 col2 VARCHAR collate 'fr' -- フランス語でソートをすること
 col3 VARCHAR collate 'es' -- スペイン語でソートすること
```

この時に、次のように実行すると、フランス語順でソートされる。

```sql
SELECT col1 FROM test ORDER BY col2
```

また、次のように実行すると、スペイン語でソートされる。

```sql
SELECT col1 FROM test ORDER BY col3
```



### 例2.snowflakeのWHERE句で`collate`を使用する

```sql
SELECT * from test WHERE c1=c2 collate 'en-ci-pi'
```

### 例3.snowflakeの照合でサポートするもの

- サポートされる称号は次のものがある
    - 言語ロケール:`en en_US fr fr_CA`など,フランス語や日本語などの指定が可能
    - 大文字と小文字の区別:`cs または ci`など、値を比較する際に、大文字小文字を考慮するかどうかを確認できる。
    - アクセントの区別:`asまたはai`など、アクセント付き文字を、基本文字と同じかどうかを考慮する
    - 句読点の区別:`psまたはpi`など、文字以外の文字は重要かどうか、「。」や「、」を無視するかどうか。
    - 最初の文字:`fiまたはfu`など、大文字と小文字でどちらを最初にソートするか




## 反復的なサブクエリへTEMPORARYテーブルを使用する

同じサブクエリを複数回使用する場合。**TEMPORARYテーブルを使用した方kが効率が良くなる**

- TEMPORARYテーブルはセッション内部のみに存在する点は注意（snowflakeのwebuiでは、一つのワークシートを一つのセッションが貼られるので、別のワークシートからTEMPORARYテーブルを覗くことはできない。

- 例:TEMPORARYテーブルのセッションを確認する。

次のクエリで、TEMPORARYテーブルを作る。

```sql
CREATE TEMPOEAEY TABLE temp(
    id INT.
    first VARCHAR(20),
    last VARCHAR(20)
)
```

その後、`SHOW TABLES`コマンドでテーブルの一覧を確認する。

また、別のワークシートを開き、`SHOW TABLES`を実行すると、TEMPORARYテーブルは表示されないことを確認できる。

- WITH句との違い。不明。調査不足



## クエリタグの使用

クエリタグの設定により、SQL文一つ一つに名前をつけることができる。

サンプルコード：`ALTER SESSION SET QUERY_TAG="tagname"`

このように実行することで、snoflake webuiの履歴画面から、QUERY_TAGを指定して確認することができる。
あるいは、QUERY_TAGにユーザーの名前をつけておくことで、他のユーザーとのシェアも実現できる。




## 備考


title:snowsql完全解説

img:https://cdn-ak.f.st-hatena.com/images/fotolife/s/serverworks/20200712/20200712025125.png

from https://blog.serverworks.co.jp/tech/2020/05/15/snowsql-first-step/

category_script:page_name.startswith("3")