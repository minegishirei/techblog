





- [Terraformのリソースファイル](#terraformのリソースファイル)
  - [`resource`構文](#resource構文)
    - [すべての`resource`構文に共通な引数（メタ引数）](#すべてのresource構文に共通な引数メタ引数)
- [Providerとは](#providerとは)
  - [Providerの見つけ方](#providerの見つけ方)
  - [Terraform学習サイト](#terraform学習サイト)



# Terraformのリソースファイル

`resource`キーワードはテラフォームで最も重要な要素です。

各`resource`ブロックは、仮想ネットワーク、EC2、DNSレコード等の比較的高レイヤーな要素を定義します。


## `resource`構文

リソース宣言には、いくつかの高度な機能を含めることができますが、最初は小さなブロックで問題ありません。

```t
resource "aws_instance" "web" {
  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"
  count = 2
}
```

上記は簡単なec2インスタンスを立てていますが、各キーワードには以下のような意味があります。

- `resource "aws_instance" "web"` : resourceキーワードを宣言した後、そのあとにリソースの型（一般的なプログラミング言語の`クラス`に相当する）を宣言します。今回の型は、"aws_instance"というec2を実現する型です。そのあとに続く`"web"`は、本ブロックにつく名前であり、**同じTerraformモジュール内のほかの場所からこのリソースを参照できます**。

- `ami = "ami-a1b2c3d4"` : `"aws_instance"`が受け付ける引数(`ami`)に対して、`"ami-a2b2c3d4"`を代入しています。今回は、ec2のインスタンスのOSに対して、ubuntu等を指定します。

- `instance_type` : 上記と同様、`"aws_instance"`が受け付ける引数に代入を行っています。

- `count` : 同様のインスタンスを2個作ります。**この引数は、`aws_instance`で必要としている引数ではなく、メタ引数と呼ばれるすべての`resouce`で有効な共通キーワードです**


### すべての`resource`構文に共通な引数（メタ引数）


- `depends_on` : 依存関係を指定します。Terraformは宣言型の言語であるため通常順番の概念がありませんが、リソースの作成に順番をつける必要がある場合はこの`depends_on`引数を使用します。

- `count` : カウントに従って複数のリソースを作成します。

- `for_each` : 配列や辞書で指定された値によって、複数のリソースを作成します。`count`と異なる点は、単純に複数のリソースを作成するのではなく、細かい文字列の指定が可能であるという点です。

- `provisioner` : リソース作成後に追加のアクションが必要な場合のタスクを指定します。ですが、この引数の仕様は推奨されていません。[プロビジョナーは最後の手段](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

- `lifecycle` : リソースの動作方法に関する前提条件を確認することができます。これにより、**気づかないうちにプロバイダーの製品にアップデートが入り、リソースの前提条件が崩れてしまうことをエラーにより検知することが可能です。**

次のコードでは、awsの"t2.micro"のCPUが"x86_64"から変更されていないことを確認しています。
もしアップデートが入り、前提条件が崩れてしまうのであれば、error_messageに格納された文字列がエラーとして表示されます。

```t
resource "aws_instance" "example" {
  instance_type = "t2.micro"
  ami           = "ami-abc123"

  lifecycle {
    # The AMI ID must refer to an AMI that contains an operating system
    # for the `x86_64` architecture.
    precondition {
      condition     = data.aws_ami.example.architecture == "x86_64"
      error_message = "The selected AMI must be for the x86_64 architecture."
    }
  }
}
```

- `timeouts` : 特定の操作が失敗したとみなされるまでの時間をカスタマイズできます。






# Providerとは

Terraformはプロバイダーと呼ばれる**プラグイン**に大きく依存しております。
このプロバイダーはAWSやAzureやGCPなどを含むSaaSやそのほかのAPIと相互作用する役割を持ちます。ProviderなしではTerraformは何もしてくれません。

Providerは、`resourceの型`の集合を提供したりしてくれます。




## Providerの見つけ方

Terraformのプロバイダーを見つけるためには、[Terraform レジストリーを参照します](https://registry.terraform.io/browse/providers)

ところで、プロバイダーにはいくつか種類があり、それぞれタグがついています。

- Official : HashiCorp社が所有し、メンテナンスするプロバイダーです。

- Partner : HashiCorp社が認めた、第三者が作成した他社のAPIを含むプロバイダーです。

- Community : 個人やその集合であるコミュニティによってメンテナンスされるプロバイダーです

- Archived : メンテナンスされていない、非推奨のプロバイダーです。




## Terraform学習サイト

title:Terraformのresourceの使い方【Terraform学習サイト】






category_script:True