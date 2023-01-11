

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

```tf
resource "aws_vpc" "demo" {
  cidr_block = "192.168.1.0/24"
}
```

ここでは次のように条件を指定している。

- `aws_vpc` : awsの中のvpcサービスを利用する

- `demo` : 任意の名前

- `cidr_block = "192.168.1.0/24"` : IPv4 CIDRブロックに、"192.168.1.0/24"を指定する

つまり、AWSのコンソール上だと



この画面にて、"192.168.1.0/24"をCIDRブロックに指定したことと同等のことをコードで行える。




 








## 備考

title:terraformとは何か?

description:terraformの概要からインストール、サンプルコードまでを解説。キーとなるtfファイルとtfstateファイルを押さえましょう！

category_script:True





