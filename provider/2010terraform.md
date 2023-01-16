

- [OFFJT](#offjt)
  - [参考](#参考)
  - [概要](#概要)
  - [前提条件](#前提条件)
  - [インストール](#インストール)
  - [tfファイル](#tfファイル)
    - [サンプルコード](#サンプルコード)
    - [実行時のpoint](#実行時のpoint)
    - [tfファイルの構文](#tfファイルの構文)
    - [resource(リソース)](#resourceリソース)
    - [data(データ)](#dataデータ)
  - [tfsateファイル(裏側の話)](#tfsateファイル裏側の話)
- [コードを書く準備](#コードを書く準備)
    - [インストール方法](#インストール方法)
    - [S3の準備](#s3の準備)
- [手を動かす](#手を動かす)
  - [teraform init](#teraform-init)
    - [S3上にtfstate.tfsを作成する場合](#s3上にtfstatetfsを作成する場合)
    - [ローカル上に作成する場合](#ローカル上に作成する場合)
    - [terraform init](#terraform-init)
  - [resourceファイルを更新してシステムをいじる(VPCをいじる)](#resourceファイルを更新してシステムをいじるvpcをいじる)
- [できることできないこと](#できることできないこと)
  - [TerraformはSnow flakeをサポートしているのか?](#terraformはsnow-flakeをサポートしているのか)
    - [実際の環境構築の様子](#実際の環境構築の様子)
    - [公式ドキュメントのチュートリアル](#公式ドキュメントのチュートリアル)
    - [terraformはsnowflakeのsqlを実行できるか?](#terraformはsnowflakeのsqlを実行できるか)
  - [EC2を立ち上げてコマンド実行できるか?](#ec2を立ち上げてコマンド実行できるか)
  - [その他のサポートしているプロバイダー](#その他のサポートしているプロバイダー)
  - [備考](#備考)


# OFFJT

## 参考

https://www.youtube.com/watch?v=h1MDCp7blmg

https://github.com/mdb/terraform-example/tree/master/terraform



## 概要

IaC(Infra Structer as Code)

コードを使って環境構築ができる。
dockerの外側。

## 前提条件

AWS CLIの環境構築がほぼ必須。

- `awsコマンドを使えるように設定する`

- `aws configure で認証情報をセットした後であれば自動でこのAWS認証情報を参照してくれます`

https://qiita.com/Chanmoro/items/55bf0da3aaf37dc26f73#iam-%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC%E3%82%92%E4%BD%9C%E3%82%8B


## インストール

ブラウザアプリではなく、brewやchocolatey(windowsのaptみたいなもの?)でインストールする必要がある。

macユーザーの人は`tfenv`からインストールすることで、terraformのバージョン管理ができる。(pythonのpyenvみたいなもの)
**terraformは頻繁にバージョンアップが発生するので、バージョン管理が必須**

要は、

- インストールするterraformがコンパイラ

- `.tf`ファイルがソースコード（後ほど説明)

のイメージ

ただし、インストールすると言ってもGUIでの操作ではなく、基本的にはコマンドでの操作になる。

## tfファイル

参考:https://qiita.com/Chanmoro/items/55bf0da3aaf37dc26f73

拡張子は`.tf`。
このコードを作成し、実行すると、クラウドを使ったインフラ環境が構築できる

### サンプルコード

次の条件でインフラ環境を構築する

- 2つインスタンスを生成

- AMI: ami-785c491f (Ubuntu 16.04 LST)

- t2.micro

- Name に "sandbox-xx"

その場合は以下のようなコードになる

```t
resource "aws_instance" "sandbox" {
  count         = 2

  ami           = "ami-785c491f" 
  # Ubuntu 16.04 LTS official ami

  instance_type = "t2.micro"
  # CPUのスペックとか
  tags = {
    Name = "${format("sandbox-%02d", count.index + 1)}"
  }
}
```

### 実行時のpoint

terraformは`.tf`ファイルを認識して動く。
ところが、**注意！カレントディレクトリ直下の.tfファイルしか読み込まれない!**

*(多くのプログラミングでは、ディレクトリ構造が発生し、モジュール化が可能)*
**しかし、terraformでは一つのディレクトリにたくさんのファイルが構成される。**


### tfファイルの構文

`.tf`ファイル内部では、次の二つのキーワードがある

- resource(リソース)

- data(データ)

そのほかにもキーワードがあるが、**この二つさえ押さえておけば使うことが可能**

### resource(リソース)

**インフラリソースを作るための文**(一番使う!)

サンプル

```tf
resource "aws_instance" "sandbox" {
  count         = 2
  ami           = "ami-785c491f" # Ubuntu 16.04 LTS official ami
  instance_type = "t2.micro"
  tags = {
    Name = "${format("sandbox-%02d", count.index + 1)}"
  }
}
```


### data(データ)

**リソースを取得するための文**

既存のクラウド上にEC2が既にある場合、

- そのID

- そのIPアドレス

をとってこれる



## tfsateファイル(裏側の話)

**terraformにおける神のファイル:terraformで管理しているインフラリソースを全て記載した`.json`ファイルがtfsateファイル**

terraformはそもそもインフラリソースを管理する。
その管理を一元化したファイルがtfsateファイルで、裏側でこれが元となり動いている。

terraformファイルはコマンドを打っていく中で、自然とできる。

実態となるリンク:https://github.com/mdb/terraform-example/blob/master/terraform/terraform.tfstate

基本はS3バケットの中で、これを管理している。
terraformでのコマンドを打つ中で、S3のtfstateファイルを更新する。

**tfstateファイルを意識しなくても操れるが、裏側を把握しておくことで、実態を把握しておける**





# コードを書く準備

### インストール方法

macでのインストール

```s
$ brew update
$ brew install terraform
```

1秒で終わった。

### S3の準備

S3に入った後、バケットを作成する。

- バケットの名前は「xxx-tfstate」が良い（慣習的に）

- パブリックアクセスはブロック

その他は適当で良い。

これで、S3上でtfstateを管理するバケットが作れた。



# 手を動かす

## teraform init

AWSに関しては、HshiCorpが管理するドキュメントが充実している（らしい）。
それを見ながら開発していくと良い。

### S3上にtfstate.tfsを作成する場合

backend.tfを作成し、次の内容を書き込む（backend.tfには意味はない）

```t
terraform {
    reuired_version = "0.13.6"
    backend "s3" {
    bucket = "terraform-klein-test-tfstate"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
    }
    provider "aws" {
    region = "ap-northeast-1"
    }
}
```

### ローカル上に作成する場合

```t
terraform {
  backend "local" {
    path = "relative/path/to/terraform.tfstate"
  }
}
```

### terraform init

`terraform init`を実行。

すると、ディレクトリ直下にあるtfファイルを読み取って初期化してくれる。


## resourceファイルを更新してシステムをいじる(VPCをいじる)

たとえば、VPCをいじりたい時は次のような`.tf`ファイルを作る。
ファイル名は任意だが、拡張子は`.tf`であること。

```tf
resource "aws_vpc" "demo" {
  cidr_block = "192.168.1.0/24"
}
```

ここでは次のように条件を指定している。

- `aws_vpc` : awsの中のvpcサービスを利用する

- `demo` : 任意の名前

- `cidr_block = "192.168.1.0/24"` : IPv4 CIDRブロックに、"192.168.1.0/24"を指定する

つまり、

↓ AWSのコンソール上からVPCを選択して

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/provider/terraform/vpc1.png?raw=true">

↓ この画面にて、"192.168.1.0/24"をCIDRブロックに指定したことと**同等のことをコードで行える。**

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/provider/terraform/vpc2.png?raw=true">




# できることできないこと

## TerraformはSnow flakeをサポートしているのか?

- ユーザー

- ロール

- DB

- スキーマ

- 仮想ウェアハウス

出所:https://dev.classmethod.jp/articles/snowflake-terraform-try/

公式ドキュメントも存在:https://quickstarts.snowflake.com/guide/terraforming_snowflake/index.html?index=..%2F..index#0




### 実際の環境構築の様子

結論:**snowflake側でterraform用のユーザーを作成して、terraform側ではtfファイルにsnowflakeの認証情報を書き込む**

Terraformが（ユーザーに代わって）Snowflakeのリソースを作成するので、まずはTerraform用のユーザーを作成します。割当ロールについて、今回はとりあえずSYSADMINとSECURITYADMINを使えるようにしていますが、本番運用する際は、より適切なカスタムロールを作って、それを割り当てる方が良いです。

```sql
CREATE USER "tf-snow" DEFAULT_ROLE=PUBLIC MUST_CHANGE_PASSWORD=FALSE;
GRANT ROLE SYSADMIN TO USER "tf-snow";
GRANT ROLE SECURITYADMIN TO USER "tf-snow";
```

続いて、Terraformが使用するSnowflakeに対する認証情報の準備です。公式ドキュメントを見るに、tfファイルにベタ書きすることもできそうですが、今回は、冒頭で紹介したチュートリアルにならって、環境変数に認証に必要な情報を入れて、それをProvider側で使用する方法をとります。

環境変数にぶちこんでいきます。

```sh
> export SNOWFLAKE_USER="tf-snow"
> export SNOWFLAKE_ACCOUNT="Snowflakeのアカウント名（URLの最初）"
> export SNOWFLAKE_REGION="Snowflakeのリージョン名（URLの真ん中）"
```

### 公式ドキュメントのチュートリアル

```
すべてのデータベースにはテーブルを格納するためのスキーマが必要なので、
それとサービス ユーザーを追加して、
アプリケーション/クライアントがデータベースとスキーマに接続できるようにします。
```

https://quickstarts.snowflake.com/guide/terraforming_snowflake/index.html?index=..%2F..index#8



### terraformはsnowflakeのsqlを実行できるか?

https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/task

snowflake_taskというプロバイダーを使用して、sql_statementにsqlを記述することで実行できる。

```sq;
resource "snowflake_task" "task" {
  comment = "my task"

  database  = "database"
  schema    = "schema"
  warehouse = "warehouse"

  name          = "task"
  schedule      = "10 MINUTE"
  sql_statement = "select * from foo;"

  session_parameters = {
    "foo" : "bar",
  }

  user_task_timeout_ms = 10000
  after                = "preceding_task"
  when                 = "foo AND bar"
  enabled              = true
}

resource "snowflake_task" "serverless_task" {
  comment = "my serverless task"

  database = "db"
  schema   = "schema"

  name          = "serverless_task"
  schedule      = "10 MINUTE"
  sql_statement = "select * from foo;"

  session_parameters = {
    "foo" : "bar",
  }

  user_task_timeout_ms                     = 10000
  user_task_managed_initial_warehouse_size = "XSMALL"
  after                                    = [snowflake_task.task.name]
  when                                     = "foo AND bar"
  enabled                                  = true
}

resource "snowflake_task" "test_task" {
  comment = "task with allow_overlapping_execution"

  database = "database"
  schema   = "schema"

  name          = "test_task"
  sql_statement = "select 1 as c;"

  allow_overlapping_execution = true
  enabled                     = true
}
```


## EC2を立ち上げてコマンド実行できるか?

結論:できる

https://dev.classmethod.jp/articles/terraform-ec2-linux-settings-userdata-cloud-init/




## その他のサポートしているプロバイダー

dockerhubのように、terraformもgithubで管理するossプロジェクトが複数存在する。
その数12009個。

https://registry.terraform.io/browse/modules

redshiftなども上記のリンクから検索すると、ドキュメントが出現する

https://registry.terraform.io/modules/terraform-aws-modules/redshift/aws/latest







## 備考

title:terraformの製品調査結果

description:terraformの概要からインストール、サンプルコードまでを解説。キーとなるtfファイルとtfstateファイルを押さえましょう！

category_script:True

img:https://gyazo.com/7ad7a3e824c13d8f152da18b1a222143/max_size/1000





