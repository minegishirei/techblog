
- [module定義](#module定義)
  - [moduleとは](#moduleとは)
  - [moduleはどこに書かれるか？(呼び出す側)](#moduleはどこに書かれるか呼び出す側)
    - [moduleソースの場所](#moduleソースの場所)
  - [moduleの書き方](#moduleの書き方)
  - [moduleの呼び出し方](#moduleの呼び出し方)
- [module本体作成](#module本体作成)
  - [moduleを作るコツ](#moduleを作るコツ)
  - [標準module構造](#標準module構造)
  - [最低限のモジュール構成](#最低限のモジュール構成)
  - [より詳細なmoduleの書き方](#より詳細なmoduleの書き方)
    - [`input.tf`引数を受け入れる](#inputtf引数を受け入れる)
  - [尾行](#尾行)


# module定義

## moduleとは

*A module is a container for multiple resources that are used together.*

form terraform公式ドキュメントより

`module`とは、予約語の一種です。
この`module`の役割は、**複数の`resource`によって定義されたリソースを束ね、まとめておくことです。**

例えば、

- ローカル開発環境と本番環境で環境が違うので、それぞれをライブラリーやモジュールとして扱いたい

- 国の管理するシステムで県によって使えるプロバイダー（AWSやGCPなど）が異なるため、それらを分けておきたい

などなどです。


## moduleはどこに書かれるか？(呼び出す側)

**moduleはファイルに書かれます**

ここでのファイルとは、terraform目線でのローカル開発環境だったり、S3に存在するファイルだったりと様々です。
**そして、これら様々な箇所にあるファイルを、terraformのmoduleは一様に扱うことができるのです。**


- 例えば、ローカルのapp-clusterファイルに記述されているmoduleを呼び出したい場合は

```t
module "servers" {
  source = "./app-cluster"

  servers = 5
}
```

のように、`source`にパスを指定することで、ファイル分割されたmoduleを読み込むことができます。


- 例えば、terraformのaws vpcレジストリに存在する、moduleにアクセスしたい場合

```t
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"
}
```

のように、"./"をつけないことでレジストリからのmoduleの取得が可能です。

### moduleソースの場所

moduleのソースを取得する元は次のいずれかです。

- ローカルパス

- Terraformレジストリ

- Github

- Bitbucket

- S3 Bucket

- HTTP API




## moduleの書き方


```t
module "<module>" {
  source  = "<source>"
  version = "<version>"
}
```

- module-name : モジュールの名前を定義することができます。この名前は、このモジュールを利用する際の名前空間のように機能します。本体のmoduleはこのmodule-nameを経由しなければアクセスできません

- src : この引数は全てのmoduleキーワードで必須です。ここに記されたパスを元にリモートあるいはローカルのファイルを参照しに行きます。

- version : レジストリからモジュールを取得する際には必須となるキーワードです。



## moduleの呼び出し方

moduleは次のように使われます。

`module.<モジュール名>.<属性値、プロパティ値>`


moduleのプロパティにアクセスする際には、次のように特定の名前空間に沿って呼び出さなければなりません。

サンプルコード

```t
resource "aws_elb" "example" {
  # ...

  instances = module.servers.instance_ids
}
```


# module本体作成

## moduleを作るコツ

原則として、リソースと他の構成要素の任意の組み合わせをモジュールに分解できます。
ですが、モジュールを使いすぎるとTerraform 構成全体の理解と維持が難しくなる可能性があるため、節度を守った使用をお勧めします。

また、

## 標準module構造

標準的なモジュールの構成は次の通りです。

```t
tree complete-module/
.
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── ...
├── modules/
│   ├── ...(省略)
├── examples/
│   ├── exampleA/
│   │   ├── main.tf
│   ├── exampleB/
│   ├── .../
```

以下順番に説明します。

- `main.tf`:モジュール本体です。

通常ここにはresourceが記述されます。



- `variables.tf`:引数です。受け取った値を本体で使用することができます。複数宣言することも可能です。

```t
variable "parameter_name" {
}
```

本体で使用する場合は「var.変数名」で使用できます。

```t
... {
    item_a = var.parameter_name
    item_b = var.parameter_2
}
```


- `outputs.tf`:帰り値

moduleの呼び出し元で使用できる値です。`output`内部から使用できます。

```t
output "debug_print" {
  value = "create from module with ${var.parameter_1}."
}
```

- `modules` : ネストされたモジュールが入ることがあります。


## 最低限のモジュール構成

上記の構造はマストではありませんが、最低限でも以下の構成をお勧めします。

```t
$ tree minimal-module/
.
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
```

## より詳細なmoduleの書き方

### `input.tf`引数を受け入れる

モジュールが受け入れる各変数をvariableブロックを使用して宣言することができます。
次の例はdockerのポート番号を引数で受け入れる時の引数です。

```t
variable "image_id" {
  type = string
  nullable = false
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["us-west-1a"]
}

variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 8300
      external = 8300
      protocol = "tcp"
    }
  ]
  description = "これはdockerのポート番号に指定する値です"
}
```

ここで登場した各キーワードは次の意味を持ちます

- `default`: デフォルト値

- `type`: 変数に指定可能な型
    - 基本的な型は以下の通りです。
    - `stirng`: 文字列
    - `number` : 数値型
    - `bool`: boolean
    - これらの基本的な方に加えて、次の型も使用可能です。
    - `list` : 配列
    - `set` : ？
    - `map` :　辞書型
    - `tuple` : タプル型
    - `object` : 上記を組み合わせた新しい型 

- `nullable`: null可能か

- `validation` : 現在も有効な値を持つか

- `sensitive` : private変数になります。



## 尾行

title:Terraformのmoduleの使い方【Terraform学習サイト】



