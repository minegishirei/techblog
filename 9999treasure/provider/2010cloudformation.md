

- [参考記事](#参考記事)
- [OFFJT](#offjt)
  - [cloudformationとは?](#cloudformationとは)
  - [cloudformation以外の選択肢](#cloudformation以外の選択肢)
  - [他のサービスとの違い](#他のサービスとの違い)
  - [cloud formationのイメージ図](#cloud-formationのイメージ図)
- [デモンストレーション](#デモンストレーション)
  - [VPCを作ってみる](#vpcを作ってみる)
- [実行方法](#実行方法)
  - [コマンドラインから実行](#コマンドラインから実行)
    - [1.テンプレートの検証(テンプレートが有効な構文であるかを検証)](#1テンプレートの検証テンプレートが有効な構文であるかを検証)
    - [2.構築開始](#2構築開始)
  - [コンソールからの操作](#コンソールからの操作)
- [できるできない](#できるできない)
  - [Snowflakeを利用できるか](#snowflakeを利用できるか)
  - [ソースの長さについて](#ソースの長さについて)
    - [Terraform](#terraform)
    - [AWS Cloudformation](#aws-cloudformation)
  - [ユーザー数について](#ユーザー数について)
  - [備考](#備考)


# 参考記事

参考:https://www.youtube.com/watch?v=8uvWfCs6orE

はじめてのCloudFormation #devio2020


# OFFJT

## cloudformationとは?

AWS CloudFormation を使用すると、AWS インフラストラクチャのデプロイを再現可能な状態でプロビジョニングできます。

from 公式ドキュメントより


## cloudformation以外の選択肢

以下のツールと同等の存在

- terraform

- AWS CDK(Cloud Development Kit)


## 他のサービスとの違い

- **コード(JSON/YAML)**で定義

- **AWSリソース**をプロビジョニングしてくれるサービス(AWS内部に限定される)

- **CloudFormation自体の利用は無料**(立てたサービスから料金が発生する)

from https://www.youtube.com/watch?v=8uvWfCs6orE

- コードはGUIで作成可能:名前を **AWS CloudFormation デザイナー**と呼ぶ

<img src="https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/images/designer-overview.png">

from https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/working-with-templates-cfn-designer-overview.html

- インストールの必要がほぼない(AWS CLIのみ)


## cloud formationのイメージ図

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/provider/cloudformation/image.png?raw=true">

ぶっちゃけterraformの下位互換






# デモンストレーション

コードは全てYAMLで描いてみる

from https://www.techpit.jp/courses/77/curriculums/80/sections/609/parts/2061

## VPCを作ってみる

以下の条件でVPCを作るとする

- VPC名： techpit
- CIDRブロック： 10.0.0.0/16
- DNS機能： 有効
- DNS名割り当て： 有効

EnableDnsHostnames

```yml

Resources:

 #=================================
 # VPCの作成
 #=================================
  tpVPC:
    Type: "AWS::EC2::VPC"
    Properties:
      CidrBlock: 10.0.0.0/16
      EnableDnsSupport: 'true'
      EnableDnsHostnames: 'true'
      Tags:
      - Key: Name
        Value: techpit
```


# 実行方法


CloudFormatioは

- 「AWSマネジメントコンソール」

または

- 「CLI」

のどちらかから実行することができます。

ただし、**AWSマネジメントコンソール は操作ステップが多いため、コマンドライン で行う方が簡単**

from https://www.techpit.jp/courses/77/curriculums/80/sections/609/parts/2060

from https://www.youtube.com/watch?v=8uvWfCs6orE

## コマンドラインから実行

### 1.テンプレートの検証(テンプレートが有効な構文であるかを検証)

1.テンプレートの検証(テンプレートが有効な構文であるかを検証)

`validate-template`コマンドを使用

```sh
aws cloudformation validate-template --template-body file://vpc.yaml
```


### 2.構築開始

`create-stack`で環境を構築する。

ここではstack名をtechpitと指定している。

```sh
aws cloudformation create-stack --stack-name techpit --template-body file://vpc.yaml --profile techpit
```

注意!:スタックとは

```
スタックは、単一のユニットとして管理できる AWS リソースのコレクションです。
つまり、スタックを作成、更新、削除することで、リソースのコレクションを作成、更新、削除できます。
```

AWSの最小単位


## コンソールからの操作

コンソールからの操作も可能だが、一旦除外

詳細:https://www.techpit.jp/courses/77/curriculums/80/sections/609/parts/2060



# できるできない

## Snowflakeを利用できるか

ドキュメントがほぼない。
少なくともterraformよりはサポートが劣る。

https://docs.snowflake.com/ja/sql-reference/external-functions-creating-aws-planning.html

`AWSにベンダロックインします。AWS以外のリソースの作成を行うことはできません。`

from https://qiita.com/answer_d/items/74c3d317058d48394d21#%E3%83%9E%E3%83%AB%E3%83%81%E3%82%AF%E3%83%A9%E3%82%A6%E3%83%89%E6%80%A7


## ソースの長さについて

terraformもcloudformationもほとんど変わらない

### Terraform

```sh
provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.2.0.0/24"
  enable_dns_hostnames = true
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.2.0.0/25"
  map_public_ip_on_launch = false
}

resource "aws_instance" "sample" {
  ami = "ami-0a1c2ec61571737db"
  subnet_id = aws_subnet.private.id
  key_name = "test"
  instance_type = "t2.micro"
}
```


### AWS Cloudformation

```yml
---
AWSTemplateFormatVersion: 2010-09-09

Resources:
  mainVpc:
    Type: AWS::EC2::VPC
    Properties:
      CidrBlock: 10.2.1.0/24
      EnableDnsHostnames: true

  privateSubnet:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref mainVpc
      CidrBlock: 10.2.1.0/25
      MapPublicIpOnLaunch: false

  sampleInstance:
    Type: AWS::EC2::Instance
    Properties:
      ImageId: ami-0a1c2ec61571737db
      SubnetId: !Ref privateSubnet
      KeyName: test
      InstanceType: t2.micro
```


## ユーザー数について

google trendから推測。
およそ2倍の差が存在する。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/provider/cloudformation/compare.png?raw=true">

ちなみにAWS CDKは比較にならないほど知名度が低かった。

**今後開発者を確保するという点でもterraformの方に軍配が上がりそう**


















## 備考

title:cloudformationの製品調査

description:terraform vs cloudformationの比較についての記事です。ですが、cloudformationよりもterraformを使った方が対応できる場面が多く、特にvenderロックの有無でterraformを優先した方が環境構築の面で優れていると言わざるを得ません。

category_script:True

img:https://d1tlzifd8jdoy4.cloudfront.net/wp-content/uploads/2014/05/aws_icon-cloudformation_white.png








