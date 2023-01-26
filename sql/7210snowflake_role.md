


- [snowflakeロール解説：ロールによるアクセス制御](#snowflakeロール解説ロールによるアクセス制御)
  - [ユーザーおよびロール](#ユーザーおよびロール)
  - [デフォルトのロール](#デフォルトのロール)
  - [snowflakeでロールを作る](#snowflakeでロールを作る)
  - [snowflakeでロールに権限を与える](#snowflakeでロールに権限を与える)
  - [snowflakeでロールをユーザーに付与](#snowflakeでロールをユーザーに付与)
  - [ロール関連の裏話](#ロール関連の裏話)
  - [ウェアハウスの権限は二種類ある](#ウェアハウスの権限は二種類ある)
- [SQL、テーブルレベルのセキュリティ](#sqlテーブルレベルのセキュリティ)
  - [セキュアビュー、およびユーザー定義関数について](#セキュアビューおよびユーザー定義関数について)
  - [行レベルのアクセスの認可](#行レベルのアクセスの認可)
  - [備考](#備考)



# snowflakeロール解説：ロールによるアクセス制御

アクセス制御とは以下の内容のこと
- 誰がどのロールを使用できるか
- どのロールがオブジェクトにアクセスできるか
- どのような操作をオブジェクトに対し実行できるか
- 誰がアクセス制御ポリシーを変更できるか


## ユーザーおよびロール

アカウントアイコンから「ロールを切り替え」ボタンで切り替えることができる。
このロールを変更することで、確認できるデータベースが変更したり、実行できるプロシージャが変わる。

- 例.オブジェクトに対して実行するのは、USAGE権限を持っていなければ、実行できない。
- SELECT文を実行したい場合、selectの権限だけを持つのではんく、USAGE権限も持つことが必須。


## デフォルトのロール

snowflakeのデフォルトのロールは以下の通り(上位にいるロールほど、役割を与えられている。)

<img src="https://interworks.com/wp-content/uploads/2020/01/SnowSecurity1.jpg">

- ACOUNTADMIN : これはシステムの最上位のロールであり、アカウント内の限られた/制御された数のユーザーにのみ付与する必要があります。

- SECURITYADMIN : MANAGE GRANTS セキュリティ権限が付与されており、付与の取り消しを含め、あらゆる付与を変更できます。

- USERADMIN : ユーザーとロールの管理のみに専用のロール。

- SYSADMIN : アカウントでウェアハウスとデータベース（およびその他のオブジェクト）を作成する権限を持つロール。(データベース管理者)

- PUBLIC : 基本は何もできない、ログインだけ

## snowflakeでロールを作る

ロールを作るためには、まずロールを作れる権限を持つロールに自分自身がならなければならない。

サンプルコードは以下の通り

```sql
USE ROLE useradmin;
CREATE ROLE PROD;
```



## snowflakeでロールに権限を与える

ロールは、以下のSQLの通り

```sql
GRANT CREATE SCHEMA ON DATABASE prod_db TO ROLE PROD
```

この場合は、データベースにスキーマを与える権利を、PRODロールに与えている。

```sql
GRANT SELECT, INSERT, DELETE ON ALL TABLES IN SCHEMA my_schema TO ROLE analyst dba;
```

この場合は、select insert deleteのmy_schemaの中にある全てのテーブルに対し実行できる権限を、analyst dbaのロールに与えている。


## snowflakeでロールをユーザーに付与

このロールは、**ユーザーに与えることで使用可能となる。**
一ユーザーは複数のロールをもらうことができるし、その場合はwebuiの操作で変更が可能。

```sql
GRANT ROLE PROD TO USER JENN;
GRANT ROLE PROD TO USER ANN;
```

## ロール関連の裏話

snowflakeのオブジェクトツリーは以下の通り

<img src="https://d1tlzifd8jdoy4.cloudfront.net/wp-content/uploads/2022/01/Untitled-47-960x626.png">

この権限ツリーを見ると、Schemaの中にRoleとUesrは独立している。
これらが独立していることで、権限のGTANTとREVOKEが可能になっている。

## ウェアハウスの権限は二種類ある

各ユーザーに対して、次のウェアハウスに対する権限を次の2通りでコントロールできる。

- USAGE : ウェアハウスを使用してクエリを実行する
- OPETATE : 仮想ウェアハウスを開始、停止、設定を変更


# SQL、テーブルレベルのセキュリティ

## セキュアビュー、およびユーザー定義関数について

プログラム手法を介してデータが間接的に開示されることを防止できる。

- 権限のあるユーザーのみにビューまたはUDF定義を表示させる機能が、**セキュアビュー**

- セキュアビュー帯びセキュアUDFは、セキュリティ向上のために、クエリ最適化の一部をバイパスしている


## 行レベルのアクセスの認可

行レベルのセキュリティも提供している。
これを実装するには、`CURRENT_ROLE`または`CURRENT_USER`関数を使用する

```sql
SELECT
    *
FROM
    table_a
JOIN
    table_b ON table_a.role=table_b.auth
AND
    table_b.auth=CURRENT_ROLE()
```

CURRENT_ROLE関数は、現在のセッションのロールによって帰る値が異なる。

- アカウントロールである場合は、現在のセッションで利用しているプライマリロール名を返す

- データベースロールである場合は、NULLを返す




## 備考

title:snowflakeロール完全解説

img:https://www.clipartmax.com/png/middle/167-1673910_group-customer-customer-desk-icon-role-model-icon-png.png

from https://www.clipartmax.com/middle/m2i8m2i8A0A0G6G6_group-customer-customer-desk-icon-role-model-icon-png/



