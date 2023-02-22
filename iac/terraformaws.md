


- [今回やること](#今回やること)
- [terraform+AWSでwebサーバーを立ち上げる方法](#terraformawsでwebサーバーを立ち上げる方法)
  - [手順は三つある](#手順は三つある)
- [主に次の3つの手順が必要だよ](#主に次の3つの手順が必要だよ)
  - [terraform+AWSでwebサーバーを立ち上げるコード](#terraformawsでwebサーバーを立ち上げるコード)
- [コードの実行時に注意するべき点](#コードの実行時に注意するべき点)
- [まとめ](#まとめ)


## 今回やること

今回はterraformでwebサーバーを建てるよ

---


- 
  - 今日はterraformでwebサーバーを立ち上げるよ
- 
  - terraformって何？
- 
  - terraformは`terraform apply`って押すだけで簡単にwebサービスとかアプリが作れちゃうすごいシステムだよ。
  - ちなみにterraformだけだと無料だよ
- 
  - 無料でアプリが作れちゃうの!?
- 
  - もちろんサーバー代はかかるけど。
- 
  - サーバーを建てる手間を省いてくれるシステムが無料ってことね...


---


## terraform+AWSでwebサーバーを立ち上げる方法



### 手順は三つある

---

- 
  - terraformを使用してwebサーバーを立ち上げるには、
主に次の3つの手順が必要だよ
- 
  - 手順が三つもあるのか...
- 
  - それだけじゃなくてクラウドベンダーを用意する必要もあるよ。
  - クラウドベンダーはAWSとかGoogle Cloud Platformとかでっかい企業がやっているお金を払ってクラウド上にあるPCを借りるビジネスモデルの企業だよ
- 
  - 個人レベルでもお金とクレジットカードが必要なのね...

---

terraformを使用してwebサーバーを立ち上げる方法は以下の通りです

1. Terraformのインストールと設定
2. クラウドプロバイダー（例：AWS、Azure、Google Cloud）の認証情報の設定
3. インスタンスを作成するためのTerraformコードの記述


### terraform+AWSでwebサーバーを立ち上げるコード


---

- 
  - それじゃあ実際にコードを書いていくよ
- 
  - 内容がよくわからない人はコードをそのままコピーするだけでいいからね
---



```cs
# Terraformの初期設定
terraform init

# AWSのリソースを作成するためのコード
provider "aws" {
  region = "us-west-2" # インスタンスを立ち上げるリージョン
}

resource "aws_instance" "example" {
  ami           = "ami-0c94855ba95c71c99" # AMI ID（Amazon Linux 2）
  instance_type = "t2.micro"             # インスタンスタイプ
  key_name      = "example_key"          # SSHキーの名前
  subnet_id     = "subnet-0123456789abcdef" # インスタンスを立ち上げるサブネットのID

  # セキュリティグループの設定
  security_groups = ["example_security_group"]

  # ユーザーデータにApacheをインストールするスクリプトを指定
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              EOF

  # インスタンスにタグを付ける
  tags = {
    Name = "example-instance"
  }
}

```


## コードの実行時に注意するべき点


---

- 
  - さっきのコードを`~~~.tf`ファイルを作成して実行してね。
- 
  - ここは任意のファイル名でいいけど`.tf`は守らないとね
- 
  - 実行する際には`terraform init`で初期化をした後、`terraform plan`を実行してエラーが出ないか確認、最後に`terraform apply`でサーバーを立ち上げるのよ
- 
  - 3ステップでサーバーが立ち上がるのね。
- 
  - サーバーを立ち上げる際、`~/.aws/config`にAWSのアクセスキーを書いておくと、terraformに何かを聞かれずに構築できるよ
---


## まとめ

terraformを使用してwebサーバーを立ち上げる方法は以下の通りです

1. Terraformのインストールと設定
2. クラウドプロバイダー（例：AWS、Azure、Google Cloud）の認証情報の設定
3. インスタンスを作成するためのTerraformコードの記述





