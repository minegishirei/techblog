

## 参考

https://www.youtube.com/watch?v=h1MDCp7blmg

https://github.com/mdb/terraform-example/tree/master/terraform



## 概要

IaC(Infra Structer as Code)

コードを使って環境構築ができる。
dockerの外側。

## インストール

ブラウザアプリではなく、brewやchocolatey(windowsのaptみたいなもの?)でインストールする必要がある。

macユーザーの人は`tfenv`からインストールすることで、terraformのバージョン管理ができる。(pythonのpyenvみたいなもの)
**terraformは頻繁にバージョンアップが発生するので、バージョン管理が必須**

要は、

- インストールするterraformがコンパイラ

- `.tf`ファイルがソースコード（後ほど説明)

のイメージ

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

`.tf`ファイル内部では、二つのキーワードがある

- resource(リソース)

- data(データ)

そのほかにもキーワードがあるが、**この二つさえ押さえておけば使うことが可能**

### リソース

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


### データ

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





## コードを書く準備

### インストール方法

macでのインストール

```s
$ brew update
$ brew install terraform
```

1秒で終わった。

## コードを書く

## コマンドを実行








title:terraformとは何か?

description:terraformの概要からインストール、サンプルコードまでを解説。キーとなるtfファイルとtfstateファイルを押さえましょう！






