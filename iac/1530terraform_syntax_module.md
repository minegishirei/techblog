


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







## 尾行

title:Terraformのmoduleの使い方【Terraform学習サイト】



