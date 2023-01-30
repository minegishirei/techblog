


- [Organizationを利用するまでの手順](#organizationを利用するまでの手順)
  - [1step.公式にお願いする](#1step公式にお願いする)
    - [1.SnowsightのSupportにアクセス](#1snowsightのsupportにアクセス)
    - [2.右上のNew Caseを押下してCaseを起票する](#2右上のnew-caseを押下してcaseを起票する)
    - [3.詳しい内容をポップアップされたフォーム内部に記述する](#3詳しい内容をポップアップされたフォーム内部に記述する)
  - [2step.組織ボタンが有効になった後、ユーザーにOrgAdmin権限を与える](#2step組織ボタンが有効になった後ユーザーにorgadmin権限を与える)
    - [補足:Orgadminロールでできること一覧](#補足orgadminロールでできること一覧)
  - [3step.新たにアカウントを作成する](#3step新たにアカウントを作成する)
  - [4step.データベースを複製する](#4stepデータベースを複製する)



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







