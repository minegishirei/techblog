


- [cloud9,vscode比較まとめ](#cloud9vscode比較まとめ)
    - [cloud9](#cloud9)
    - [vscode](#vscode)
- [vscode onlineとは？](#vscode-onlineとは)
  - [インストールどころかアカウントもいらない](#インストールどころかアカウントもいらない)
  - [ただし、利用できない拡張機能もある](#ただし利用できない拡張機能もある)
  - [firefox未対応](#firefox未対応)
  - [vscode onlineがcloud9に劣る点](#vscode-onlineがcloud9に劣る点)
    - [AWS Lambdaとの連携が難しい(ネイティブのvscodeからでないと連携ができない)](#aws-lambdaとの連携が難しいネイティブのvscodeからでないと連携ができない)
  - [cloud9に勝る点](#cloud9に勝る点)
    - [「編集したい→エディタを開く」までが早い](#編集したいエディタを開くまでが早い)
- [Cloud9とは何か？](#cloud9とは何か)
  - [料金:無料](#料金無料)
  - [vscodeに勝る点](#vscodeに勝る点)
    - [リアルタイムでのメンバー間の連携](#リアルタイムでのメンバー間の連携)
    - [lambdaをサポートしてくれる](#lambdaをサポートしてくれる)
    - [terraformのレジストリ登録済み](#terraformのレジストリ登録済み)
  - [vscodeに劣る点](#vscodeに劣る点)
    - [awsへのログインが必要](#awsへのログインが必要)
    - [syntaxハイライト](#syntaxハイライト)
- [まとめ](#まとめ)
  - [参考](#参考)



まずは簡単な比較から。

# cloud9,vscode比較まとめ

### cloud9

- AWS（Amazon Web Services）が提供するクラウドベースの統合開発環境（IDE）です。
- ブラウザ上で動作するため、PCやモバイル端末などどこからでもアクセスできます。
- 設定がシンプルで、AWSのインフラストラクチャーにより、サーバーの設定や環境構築などが簡単にできます。
- ターミナルウィンドウや、チャット機能など、共同開発に必要な機能も備えています。
  - 複数の開発者で一つの画面を開発する、**モブプログラミング**に最適です。
- 有料版もあり、AWSのサービスとの統合性が高いため、AWSを利用している場合には特に使いやすいです。
  - lambdaへの接続も可能です。

### vscode

- Microsoftが提供する、オープンソースのコードエディターです。
- インストールしてローカル環境で使用するため、ユーザーのパソコンにインストールする必要があります。
- 多機能で、豊富なプラグインや拡張機能が用意されています。
- カスタマイズ性が高く、ユーザーが好みに応じて機能を追加できます。
- 拡張機能を使用することで、Gitやデバッガー、言語サポートなども利用できます。

主な違いは以下の通りで、これらを総合的に判断してエディターを決めるとよいでしょう。

- クラウドベースかローカルか、
- AWSとの統合性、
- 拡張機能の種類やカスタマイズ性の高さ


ちなみに、vscodeがそのままオンラインに乗った、**vscode online**と呼ばれる製品が登場しております。


# vscode onlineとは？

名前の通り、vscodeがクラウド上に埋め込まれたもの。

画面の様子は以下の通り。

<img src="https://asset.watch.impress.co.jp/img/wf/docs/1360/147/image1_l.jpg">

編集した結果はクラウド上での保存が可能であり、その選択肢は

- Github
- Azure

の二種類が存在する。



## インストールどころかアカウントもいらない

「vscode.dev」へアクセスするだけで「Visual Studio Code」が完全に動作します。
インストールどころかアカウントもいらないため、セットアップのハードルがcloud9に比べて格段に低いのが特徴です。

**とりあえず次のリンクをクリックして、アクセスすることをおすすめします**

https://vscode.dev/

<img src="https://asset.watch.impress.co.jp/img/wf/docs/1360/147/image1_l.jpg">

from https://forest.watch.impress.co.jp/docs/news/1360147.html

自分の場合は、次のようなエディターが出現した。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/provider/vscode/vscode_online.png?raw=true">



## ただし、利用できない拡張機能もある

vscode onlineはインストールが不要な反面、通常のvscodeで使用できる拡張機能が使えない場合もあります。

<img src="https://asset.watch.impress.co.jp/img/pcw/docs/1366/363/10_l.jpg">

> 既にMicrosoftは機能拡張の作者向けにWeb対応のガイドを提示しているが、一読する限りは一部の処理はNative(つまりVS Code向け)とWeb(つまりVS Code for Web)で処理を分ける必要がありそうだ。

拡張機能を書く時のコードは、ネイティブアプリとwebで異なる

from https://pc.watch.impress.co.jp/docs/topic/feature/1366363.html


## firefox未対応

vscode onlineはfirefoxについては未対応です。
~~そもそもfirefox使いの人を見たことないのですが...~~



## vscode onlineがcloud9に劣る点

### AWS Lambdaとの連携が難しい(ネイティブのvscodeからでないと連携ができない)

vscode で一応aws lambdaを編集することはできますが、cloud9ほどの手軽さはありません。

1. Visual Studio Code のインストール
2. Visual Studio Code のプロキシ設定
3. AWS ToolKit のインストール(Vscode onlineの拡張機能)
4. AWS CLI のインストール
5.  (4)でインストールしたAWS CLI のインストール確認 ＆ 設定
6.  Visual Studio Code からAWS への接続

from https://qiita.com/taku_ibu/items/7d5d75c0935a1796aa6c


## cloud9に勝る点

### 「編集したい→エディタを開く」までが早い

AWSのログインの認証は正直かなりめんどくさい。
いちいち「あなたはロボットですか？」に答えなければならない

vscode onlineは、ブラウザに「vscode.dev」を入力するだけで開ける。






# Cloud9とは何か？

*AWS Cloud9 には、**事前認証された AWS コマンドラインインターフェイスと一緒に開発環境をホストしている**、マネージド Amazon EC2 インスタンスに対する sudo 権限を含むターミナルが付属しています。これにより、すばやくコマンドを実行して AWS のサービスに直接アクセスすることが簡単になります。*

要は:Cloud9とは**EC2に対して、vscodeのようなエンジニアにとって快適なインターフェースを追加したもの**

<img src="https://d1.awsstatic.com/product-marketing/Tulip/Terminal%20New.67b39d8fa735fcd10b997e2767a4302d3e388263.png">

from https://aws.amazon.com/jp/cloud9/


## 料金:無料

AWS Cloud9自体には費用はかかりませんが、これに合わせて利用するサービスには料金がかかってくるため注意が必要です。

from https://www.yume-tec.co.jp/column/awsengineer/4595#9Lambda


*AWS Cloud9 には追加料金はかかりません。AWS Cloud9 開発環境に Amazon EC2 インスタンスを使用する場合は、コードの実行と保存に使用された コンピューティング とストレージのリソース分 (例: EC2 インスタンス、 EBS ボリューム) のみのお支払いとなります。また、AWS Cloud9 開発環境を、SSH 経由で、追加料金なしで、既存の Linux サーバー (オンプレミスサーバーなど) に接続できます。*

from https://aws.amazon.com/jp/cloud9/pricing/






## vscodeに勝る点

### リアルタイムでのメンバー間の連携

共同作業中にチームメンバーは互いのタイピングをリアルタイムで確認でき、IDE 内から即座にチャットを開始できます。

**ペアプログラミングに適した IDE**

<img src="https://d1.awsstatic.com/product-marketing/Tulip/C9-Collab-Image%403x.e03a65d9488633c154358430540ab363dd1e8f45.png">


### lambdaをサポートしてくれる

*Cloud9 では、**AWS Lambda** 関数をローカルでテストおよびデバッグするための環境を利用できます。これにより、コードを直接反復処理して時間を節約し、コードの品質を向上させることができます。*

<img src="https://d1.awsstatic.com/product-marketing/Tulip/AWS_Cloud9_Asset03_R3P.f4760f91e9108120992d31a8ab0014022595a43e.png">


### terraformのレジストリ登録済み

次の名前でterraformレジストリに登録されていた。
Iacの恩恵を受けることができる。

レジストリ名:Resource: aws_cloud9_environment_ec2

サンプルコード

```tf
resource "aws_cloud9_environment_ec2" "example" {
  instance_type = "t2.micro"
}

data "aws_instance" "cloud9_instance" {
  filter {
    name = "tag:aws:cloud9:environment"
    values = [
    aws_cloud9_environment_ec2.example.id]
  }
}

resource "aws_eip" "cloud9_eip" {
  instance = data.aws_instance.cloud9_instance.id
  vpc      = true
}

output "cloud9_public_ip" {
  value = aws_eip.cloud9_eip.public_ip
}
```

from https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloud9_environment_ec2

*一方、AzureのVscode Onlineをサポートするレジストリは存在しなかった。*

エディターも含めてIaCで運用をしていきたい人にはCloud９がおすすめです。




## vscodeに劣る点

### awsへのログインが必要

**awsのログインはかなり面倒**です。
idにパスワードにアカウント名に二要素認証までついててんこ盛りです。
ささっと編集したいときにこの修正はかなり面倒でしょう。
awsのサービスならではの悩みです。

> これはCloud9とう特性上仕方ない作業です。AWSのログインってなぜかメールアドレスとパスワードの画面遷移があって、しかも毎回ロボットか疑われるので地味に面倒ですよね...。VS CodeなどからSSHで接続すれば公開鍵認証なのでパスワードを打つ必要はなくなります。

from https://note.com/mtkn1/n/nbc33e765558b#9de1ebf9-a67e-4993-91a0-1d40e52c399b


### syntaxハイライト

> Cloud9は内蔵エディターを搭載しておりWebアプリとしては高性能ですが、ネイティブなエディターには劣ります。VS Codeに乗り換えるとPythonのシンタックスハイライトやコード補完、型推定などが大幅に強化されます。
> コーディングはVS Codeを使ってCloud9にコピペする使い方もありますが、手動でファイル操作するよりもVS Codeまたはコンソール上で操作したほうがファイル管理が煩雑になりません。

現在は改善されている可能性があるが、シンタックスハイライトはVscodeに軍配が上がる。

from https://note.com/mtkn1/n/nbc33e765558b#9de1ebf9-a67e-4993-91a0-1d40e52c399b









# まとめ


- クラウドベースかローカルか、
- AWSとの統合性、
- 拡張機能の種類やカスタマイズ性の高さ





## 参考

https://www.youtube.com/watch?v=d_JXIDvOctA


title:vscode onlineとは何か?









