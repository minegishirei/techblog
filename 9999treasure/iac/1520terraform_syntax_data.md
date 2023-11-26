






# Terraformのdataとは何か？


Terraformには、`data`キーワードが確保されています。このキーワードを用いることで、外部データを参照することが可能です。
ここでの外部データとは、各プロバイダーが発するクラウド・インフラストラクチャ・アプリ・およびサービスが発するデータのことです。

**例えば、`aws_availability_zones`を使用して、現在利用可能なリージョンを取得することができます。**

```t
data "aws_availability_zones" "az_available" {
  state = "available"
}
```

この`aws_avilability_zones`には型があり、その型は各プロバイダーから提供されます。


### 補足1:べた書き(ハードコーディング)で対応する場合は、dataではなくmoduleで対応

上記のような利用可能なリージョンの一覧をべた書きで対応する場合は、dataキーワードではなくmoduleキーワードで対応する。

```t
module "subnet" {
      azs = ["us-west-1b", "us-west-1c"]
}
```

# terraformのdataの別の使い道:`.tfstate`ファイルの状態を把握する

terraformでは、`terraform_remote_state`を使用して、異なるterraformワークスペースの`.tfstate`ファイルの状態を確認することができます。

次の例では、兄弟のディレクトリに当たるamericaディレクトリにある`tf.state`ファイルの状態を確認しています。

```t
data "terraform_remote_state" "bitslovers_vpc" {
  backend = "local"
  config = {
    path = "../america/terraform.tfstate"
  }
}
```

あるいは`.tfstate`ファイルの管理方法として、よく見かけるベストプラクティスでS3に保存し一元管理する手法についても、dataキーワードでサポートできます。

```t
data "terraform_remote_state" "bitslovers_vpc" {
  backend = "s3"
  config = {
    bucket  = "bitslovers-remotestate"
    key     = "blog/us_east_1/dev/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
```

そして読み込まれたdataを使用する際には、`${data.terraform_remote_state.bitslovers_vpc.subnet_id}`からアクセスできるのです。

```t
resource "aws_instance" "bitslovers" {
  subnet_id = "${data.terraform_remote_state.bitslovers_vpc.subnet_id}"
}
```

ポイントは、**読み込まれるsubnet_id目線ではリモートだろうがローカルだろうかを意識する必要がないという点です。**

それらの切り替えはterraformのコマンドを実行するディレクトリの位置で調整が可能なのです。









## Terraform


title:Terraformのdataの使い方【Terraform学習サイト】



category_script:True