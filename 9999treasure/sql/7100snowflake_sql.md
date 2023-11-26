
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
- [Organizationを利用するまでの手順](#organizationを利用するまでの手順)
  - [1step.公式にお願いする](#1step公式にお願いする)
    - [1.SnowsightのSupportにアクセス](#1snowsightのsupportにアクセス)
    - [2.右上のNew Caseを押下してCaseを起票する](#2右上のnew-caseを押下してcaseを起票する)
    - [3.詳しい内容をポップアップされたフォーム内部に記述する](#3詳しい内容をポップアップされたフォーム内部に記述する)
  - [2step.組織ボタンが有効になった後、ユーザーにOrgAdmin権限を与える](#2step組織ボタンが有効になった後ユーザーにorgadmin権限を与える)
    - [補足:Orgadminロールでできること一覧](#補足orgadminロールでできること一覧)
  - [3step.新たにアカウントを作成する](#3step新たにアカウントを作成する)
  - [4step.データベースを複製する](#4stepデータベースを複製する)
- [クエリプロファイル](#クエリプロファイル)
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
- [Organizationを利用するまでの手順](#organizationを利用するまでの手順)
  - [1step.公式にお願いする](#1step公式にお願いする)
    - [1.SnowsightのSupportにアクセス](#1snowsightのsupportにアクセス)
    - [2.右上のNew Caseを押下してCaseを起票する](#2右上のnew-caseを押下してcaseを起票する)
    - [3.詳しい内容をポップアップされたフォーム内部に記述する](#3詳しい内容をポップアップされたフォーム内部に記述する)
  - [2step.組織ボタンが有効になった後、ユーザーにOrgAdmin権限を与える](#2step組織ボタンが有効になった後ユーザーにorgadmin権限を与える)
    - [補足:Orgadminロールでできること一覧](#補足orgadminロールでできること一覧)
  - [3step.新たにアカウントを作成する](#3step新たにアカウントを作成する)
  - [4step.データベースを複製する](#4stepデータベースを複製する)
- [クエリプロファイル](#クエリプロファイル)
  - [備考](#備考)



# Organizationを利用するまでの手順

## 1step.公式にお願いする

以下の内容を見ると[Snowflakeサポート](https://community.snowflake.com/s/article/How-To-Submit-a-Support-Case-in-Snowflake-Lodge)から起票を行うことで準備が整う

https://docs.snowflake.com/ja/user-guide/organizations-gs.html#assigning-the-orgadmin-role-to-a-user-or-role:embed:cite

### 1.SnowsightのSupportにアクセス


<img src="https://community.snowflake.com/servlet/rtaImage?eid=ka93r000000Xebn&feoid=00N3r00000GVCkH&refid=0EM3r000001nxxg">


### 2.右上のNew Caseを押下してCaseを起票する

<img src="https://community.snowflake.com/servlet/rtaImage?eid=ka93r000000Xebn&feoid=00N3r00000GVCkH&refid=0EM3r000001nxxl">


### 3.詳しい内容をポップアップされたフォーム内部に記述する

<img src="https://community.snowflake.com/servlet/rtaImage?eid=ka93r000000Xebn&feoid=00N3r00000GVCkH&refid=0EM3r000001nxyF">




## 2step.組織ボタンが有効になった後、ユーザーにOrgAdmin権限を与える

orgadminロールが自動的に作成されるので、ユーザーやロールにORGADMIN権限を付与する。

※orgadminの付与は`acountadmin`ロールでの作業が必須。

```sql
-- Assume the ACCOUNTADMIN role
use role accountadmin;

-- Grant the ORGADMIN role to a user
grant role orgadmin to user <user_name>;

-- Grant ORGADMIN to a role
grant role orgadmin to role <role_name>;
```

### 補足:Orgadminロールでできること一覧

- 組織にアカウントを作成します。(次節で解説)
- 組織内のすべてのアカウントを表示/表示します。(
SHOW ORGANIZATION ACCOUNTS)
- 組織で有効になっているリージョンのリストを表示/表示します。
- 組織内のすべてのアカウントの使用情報を表示します。
- 組織内のアカウントのデータベース レプリケーションを有効にします。


## 3step.新たにアカウントを作成する

- CASE.A : Snowsightからアクセスして、`Admin » Accounts » Create New Account`の手順でアカウントを作成する。

- CASE.B : またはSQLを投げる

例) AWSのaws_us_west_2にsnowflakeアカウントを作成する。

```sql
create account myaccount1
  admin_name = admin
  admin_password = 'TestPassword1'
  first_name = jane
  last_name = smith
  email = 'myemail@myorg.org'
  edition = enterprise
  region = aws_us_west_2;
```


## 4step.データベースを複製する

複製可能パラメーターをonにする。

```sql
select system$global_account_set_parameter('myorg.account1',
  'ENABLE_ACCOUNT_DATABASE_REPLICATION', 'true');
```





# クエリプロファイル

クエリ統計の中の、履歴タブから、過去のクエリ実行結果を確認できる。

確認できる内容は以下の通り。
- start time
- end time
- total duration
- bytes scanned
- rows










## 備考


title:sqlユーザーのためのsnowflakeのsql【snowflake解説】

img:https://cdn-icons-png.flaticon.com/512/4299/4299956.png

category_script:page_name.startswith("7")