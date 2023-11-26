





# Terraformの言語仕様


## Terraformのシンタックスの特徴

Terraform Language(.tfファイルのこと)の中心となる目的は、`resource`という概念をオブジェクトとして表すことです。

Terraform Languageのシンタックスは、数少ない、いくつかの要素から構成されます。

###  Terraformを構成するブロックの書き方

```t
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}
```

- `<BLOCK TYPE>` はそのブロックのタイプを表します。varであれば変数を、resourceであればリソースを表します。

- `<BLOCK LABEL>`はそのブロックにつけるラベルを表します。ラベルなのでどんな値をいくつつけてもよいです。

- `<IDENTIFIER>`と`<EXPRESSION>`は引数とその代入を表します。引数`<IDENTIFIER>`に値を設定することで、そのブロックに引数が代入されたことを示します。
    awsのvpcでのcidr_blockであれば、CIDR_BLOCKに値を設定したのと同じ意味を持ちます。

以下はawsのvpcを設定するサンプルコードです。

```t
resource "aws_vpc" "main" {
  cidr_block = var.base_cidr_block
}
```



### より実践的なTerraformのブロックの書き方

Terraformのブロックのシンタックスには次のような特徴があります。

- {}で表されるブロックが構成要素

- ブロックはネストされることもある

- 0個以上のラベルを持つことができる。

- =の左側にあるものがそのブロック内で使う引数。
    - 右側の値は、ほかのブロックも入りうる


より実践的な例だと、次のようなサンプルコードがあります。

```t
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 1.0.4"
    }
  }
}

variable "aws_region" {}

variable "base_cidr_block" {
  description = "A /16 CIDR range definition, such as 10.1.0.0/16, that the VPC will use"
  default = "10.1.0.0/16"
}

variable "availability_zones" {
  description = "A list of availability zones in which to create subnets"
  type = list(string)
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  # CIDEblockで許可するIPアドレスを宣言する
  # 値を宣言する場所は、「variable」の「base_cidr_block」
  cidr_block = var.base_cidr_block
}

resource "aws_subnet" "az" {
  # Create one subnet for each given availability zone.
  count = length(var.availability_zones)

  # For each subnet, use one of the specified availability zones.
  availability_zone = var.availability_zones[count.index]

  # By referencing the aws_vpc.main object, Terraform knows that the subnet
  # must be created only after the VPC is created.
  vpc_id = aws_vpc.main.id

  # Built-in functions and operators can be used for simple transformations of
  # values, such as computing a subnet address. Here we create a /20 prefix for
  # each subnet, using consecutive addresses for each availability zone,
  # such as 10.1.16.0/20 .
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index+1)
}
```



## コメントについて

terraformでは次の3つの言語がサポートされています。


- `#` : 一行のコメント

- `//` :

- `/* */` : 複数行にまたがる可能性のあるコメント



# ポイント



## ポイント:Terraformは宣言型の言語である

**Terraform言語は宣言型であり、その目標を達成するための手順ではなく、意図した目標を記述します。**

よって、**ブロックの順序とそれらが編成されるファイルは、通常重要ではありません。**
（Terraformは操作の順番を決定する必要がある場合、リソース間に依存関係がある場合のみ


## ポイント:terraformの重要な構文は、dataとresourceのみである






## Terraform

title:Terraformのtfファイルの書き方【Terraform学習サイト】






category_script:True