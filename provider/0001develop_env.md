



- [製品リスト](#製品リスト)
- [サンプル(書き方説明)](#サンプル書き方説明)
  - [製品名:](#製品名)
    - [イメージ図](#イメージ図)
    - [読み方:](#読み方)
    - [キャッチコピー:](#キャッチコピー)
    - [詳細:](#詳細)
    - [ユースケース:](#ユースケース)
    - [料金プラン:](#料金プラン)
- [環境](#環境)
  - [TerraForm:マルチクラウド上のコンピュータやネットワークの構築を自動化する](#terraformマルチクラウド上のコンピュータやネットワークの構築を自動化する)
    - [キャッチコピー:あらゆるクラウドでインフラストラクチャを自動化。](#キャッチコピーあらゆるクラウドでインフラストラクチャを自動化)
    - [読み方:テラフォーム](#読み方テラフォーム)
    - [イメージ図](#イメージ図-1)
    - [ユースケース](#ユースケース-1)
  - [CloudFormation:AWS特化のTerraform](#cloudformationaws特化のterraform)
    - [キャッチコピー:Infrastructure as Code でクラウドプロビジョニングを高速化する](#キャッチコピーinfrastructure-as-code-でクラウドプロビジョニングを高速化する)
    - [リンク](#リンク)
    - [ユースケース](#ユースケース-2)
    - [デメリット](#デメリット)
  - [AWS CDK](#aws-cdk)
    - [キャッチコピー:使い慣れたプログラミング言語を使用したクラウドアプリケーションリソースの定義](#キャッチコピー使い慣れたプログラミング言語を使用したクラウドアプリケーションリソースの定義)
    - [メリット](#メリット)
    - [デメリット](#デメリット-1)
    - [ユースケース](#ユースケース-3)
    - [サンプルコード](#サンプルコード)
  - [Ansible](#ansible)
- [開発支援](#開発支援)
  - [vagrant:vmware/virtualboxをコードで管理するようなもの](#vagrantvmwarevirtualboxをコードで管理するようなもの)
    - [読み方:ヴェイグラント](#読み方ヴェイグラント)
    - [キャッチコピー:](#キャッチコピー-1)
    - [ユースケース:開発環境を構築した際の一番外側](#ユースケース開発環境を構築した際の一番外側)
    - [詳細](#詳細-1)
  - [Cloud9:Eclipseがクラウドになったようなものもの.OSがグラフィカルかどうかが不明](#cloud9eclipseがクラウドになったようなものものosがグラフィカルかどうかが不明)
    - [読み方:](#読み方-1)
    - [キャッチコピー:コードを記述、実行、デバッグできるクラウドベースの統合開発環境 (IDE)](#キャッチコピーコードを記述実行デバッグできるクラウドベースの統合開発環境-ide)
    - [概要:](#概要)
    - [リンク](#リンク-1)
  - [備考](#備考)




# 製品リスト

- TerraForm:マルチクラウド上のコンピュータやネットワークの構築を自動化する

- CloudFormation:AWS特化のTerraform

- AWS CDK:CloudFormationをプログラミングで記述できるようなもの

- Cloud9:Eclipseがクラウドになったようなものもの

- vagrant:vmware/virtualboxをコードで管理するようなもの

- Ansible:構成管理ツールである。サーバを立ち上げる際、あらかじめ用意した設定ファイルに従って、ソフトウェアのインストールや設定を自動的に実行する事が出来る。



# サンプル(書き方説明)


## 製品名:

### イメージ図

### 読み方:

### キャッチコピー:

### 詳細:

### ユースケース:

### 料金プラン:











# 環境


ここでは以下の条件を満たすものを「環境」と表す

- 効率的な構築作業

- オペミスの防止

- 再現性がある

- リソース管理の効率化

- インフラのバージョン管理

これらのメリットを享受できるものが大事

## TerraForm:マルチクラウド上のコンピュータやネットワークの構築を自動化する

### キャッチコピー:あらゆるクラウドでインフラストラクチャを自動化。

### 読み方:テラフォーム

### イメージ図

<img src="https://i.imgur.com/6zpK45F.jpg">

from https://www.lac.co.jp/lacwatch/service/20200903_002270.html


### ユースケース

- インフラのことをある程度理解している人

- 細かなパラメータチューニングが必要なシステム

https://qiita.com/luton-mr/items/afe70781807bf3b5016a#terraform

## CloudFormation:AWS特化のTerraform

### キャッチコピー:Infrastructure as Code でクラウドプロビジョニングを高速化する

### リンク

https://aws.amazon.com/jp/cloudformation/


### ユースケース

[FCバルセロナ、「ワンクリック」でのインフラストラクチャデプロイを実現](https://aws.amazon.com/jp/solutions/case-studies/futbol-club-barcelona/?pg=ln&sec=c)


### デメリット


```
Terraform and CloudFormation are both infrastructure-as-code (IaC) tools. CloudFormation is developed by AWS and only manages AWS resources. Terraform is developed by HashiCorp and can manage resources across a wide range of cloud vendors.

CloudFormation is better than Terraform for production workloads that are limited to AWS. The main reason is that in certain circumstances, Terraform doesn’t handle dependencies properly, and this rules it out as production-ready infrastructure-as-code (IaC) software.
```

```
CloudFormationはAWSによって開発されましたが、AWSのリソースのみしかサポートできません。
略)
AWSの範囲内に限っていえば、CloudFormationはTerraformを上回ります。
```

ニュースサイト:https://www.toptal.com/terraform/terraform-vs-cloudformation#:~:text=What%20is%20the%20difference%20between,wide%20range%20of%20cloud%20vendors.







## AWS CDK

### キャッチコピー:使い慣れたプログラミング言語を使用したクラウドアプリケーションリソースの定義

### メリット

```
CDKのメリットで記載したとおり、CloudFormationで440行記述しないといけないものがCDKだと20行です。
```

https://qiita.com/luton-mr/items/afe70781807bf3b5016a#%E8%A8%98%E8%BF%B0%E9%87%8F%E3%81%AE%E5%91%AA%E7%B8%9B

### デメリット


```
アップデートによる破壊的変更が度々ある
```


https://qiita.com/luton-mr/items/afe70781807bf3b5016a#%E3%83%87%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88





### ユースケース

- AWS初心者
- アプリケーションの開発に注力したい人
- さくっと技術検証がしたい人

https://qiita.com/luton-mr/items/afe70781807bf3b5016a#cdk

### サンプルコード

```py
from aws_cdk import core
from aws_cdk import (
    aws_ec2 as ec2
)

class VPCStack(core.Stack):

    def __init__(self, scope: core.Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)

        # Parameter
        vpc_name = "sample-vpc"
        vpc_cidr_block = "192.168.0.0/16"

        self.create_vpc(vpc_cidr_block=vpc_cidr_block, vpc_name=vpc_name)

    # Create VPC
    def create_vpc(self, vpc_cidr_block, vpc_name):
        vpc_network = ec2.Vpc(self, vpc_name, cidr=vpc_cidr_block)
```

https://qiita.com/luton-mr/items/afe70781807bf3b5016a#%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88

`生成されるCloudFormationのテンプレートは、約400行でした。これだけで90%以上のコード量減です。AWSでIaCなら初手はCloudFormationだろう！!`

`CloudFormationをラッパーしているため、CloudFormationで出来ることはCDKでもできます。`


## Ansible



# 開発支援




## vagrant:vmware/virtualboxをコードで管理するようなもの

### 読み方:ヴェイグラント

### キャッチコピー:

### ユースケース:開発環境を構築した際の一番外側

- **オンプレシングルサーバー向け**に開発

- いろいろインストールして安定して使える環境がほしい

- ホストOSの影響をできるだけ受けたくない

開発環境を構築した際の**一番外側の部分**

Vmware/VirtualBox でも可能かと思われる。
違いは**コードで管理できる**という点

プロダクトには向かない。



### 詳細

<img src="https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.amazonaws.com%2F0%2F152713%2Fe66a595f-26cb-47f5-3225-f7194c2c93ea.png?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&w=1400&fit=max&s=4c8f8afcd0c74e90f1fc867a876a3fd6">





## Cloud9:Eclipseがクラウドになったようなものもの.OSがグラフィカルかどうかが不明

### 読み方:

### キャッチコピー:コードを記述、実行、デバッグできるクラウドベースの統合開発環境 (IDE)

### 概要:

AWS Cloud9 は、ブラウザのみでコードを記述、実行、デバッグできるクラウドベースの統合開発環境 (IDE) です。
これには、コードエディタ、デバッガー、ターミナルが含まれています。Cloud9 には、JavaScript、Python、PHP などの一般的なプログラム言語に不可欠なツールがあらかじめパッケージ化されているため、新しいプロジェクトを開始するためにファイルをインストールしたり、開発マシンを設定したりする必要はありません。
Cloud9 IDE はクラウドベースのため、インターネットに接続されたマシンを使用して、オフィス、自宅、その他どこからでもプロジェクトに取り組むことができます。
また、Cloud9 では、サーバーレスアプリケーションを開発するためのシームレスなエクスペリエンスが提供されており、リソースの定義、デバッグ、ローカルとリモートの間でのサーバーレスアプリケーションの実行の切り替えを簡単に行えます。
**Cloud9を使用すると、開発環境をすばやくチームと共有し、ペアプログラミングを行って互いの入力をリアルタイムで追跡できます。**

### リンク

https://aws.amazon.com/jp/cloud9/











## 備考

title:開発環境ツール一覧

description:開発環境を包括的にカバーするツールを集めました。

category_script:True




