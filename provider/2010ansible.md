

# ansibleとは？

- [ansibleとは？](#ansibleとは)
  - [参考記事](#参考記事)
  - [ansibleとは?](#ansibleとは-1)
    - [ansibleとshellスクリプト都の違い](#ansibleとshellスクリプト都の違い)
  - [デメリット:ansibleの面倒な点](#デメリットansibleの面倒な点)
    - [ansible専用のサーバーを立てなければならない可能性](#ansible専用のサーバーを立てなければならない可能性)
    - [類似製品](#類似製品)
  - [インストール方法](#インストール方法)
    - [ubuntuへのインストール](#ubuntuへのインストール)
  - [ansible動作確認](#ansible動作確認)
    - [0.ansibleサーバーを用意する](#0ansibleサーバーを用意する)
    - [1.ansibleのhostsを書く必要がある](#1ansibleのhostsを書く必要がある)
    - [2.コマンド入力](#2コマンド入力)
    - [2.ssh実行時(初回のみ)](#2ssh実行時初回のみ)
    - [3.実行結果](#3実行結果)
    - [4.echo test以外も実行してみる](#4echo-test以外も実行してみる)
- [できることできないこと](#できることできないこと)
  - [ミドルウェアの構成までしてくれる](#ミドルウェアの構成までしてくれる)
  - [ansibleのユーザー数](#ansibleのユーザー数)
    - [知見が溜まっているので簡単にgoogle検索に引っかかる](#知見が溜まっているので簡単にgoogle検索に引っかかる)
  - [ansibleはterraformからも利用できる](#ansibleはterraformからも利用できる)
  - [Ansibleとは何か？](#ansibleとは何か)



## 参考記事

https://qiita.com/t_nakayama0714/items/fe55ee56d6446f67113c

https://qiita.com/minorun365/items/05f5b3d5a674e8b5f5cf

## ansibleとは?

**サーバーの自動化ソフトウェアのこと**

- 従来、サーバーの設定を行う際には、
  1. 人間がサーバーにsshでログインして
  2. 人間が手入力でlinuxコマンドを打ち込んで
  3. やっとサーバーの設定が完了する

というのが一般的

- ansibleの場合は
  1. ansibleが人間の代わりにsshコマンドを打って
  2. ansibleがlinuxコマンドを打ち込む
  3. 結果,自動的にサーバーの設定が完了する

### ansibleとshellスクリプト都の違い

shellスクリプトは

- まずスクリプトを書かなければならない

- ubuntu,centOS,などの差異にも対応しなければならない

ところがansibleでは、**shellスクリプトのような難しいコードを描かずとも、数行のymlファイルで完了する**

## デメリット:ansibleの面倒な点

### ansible専用のサーバーを立てなければならない可能性

いくつかの検証環境で確認したところ、通常のノートPCで開設等を行う場合、virtual box内部にサーバーを二台建てていた。

- 一台は設定したいターゲットとなるサーバー

- もう一台は、ansibleを実行するサーバー

### 類似製品

- terraform:ミドルウェアよりもインフラ周りが強いが、IaCとしては同じ分類

- puppet:オープンソースの構成管理ツール(ruby製)



## インストール方法

pythonのライブラリーと同様にインストールします。

`pip install ansible`

### ubuntuへのインストール

以下のコードをコピーアンドペースト

```sh
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

## ansible動作確認

ansibleは2通りの実行方法がある

- Ad-hoc:単体のコマンドを対象のサーバーに対して投げる実行方法

- Playbook:ymlファイルで定義された一連のコマンドを投げる実行方法

今回は、Ad-hocコマンドで単体のコマンドをサーバーに対して投げる

### 0.ansibleサーバーを用意する

virtual boxなどでansibleサーバーを用意しておく。

### 1.ansibleのhostsを書く必要がある

ansibleのhostsを書く必要がある。

ansibleが接続して操作を行うパスが記述されたファイルが、hosts
なので、これを設定する。

ファイルパスは `cat /etc/ansible/hosts`

hostsのサンプルコード

```yml
mail.example.com

[webservers]
foo.example.com
bar.example.com

[dbservers]
one.example.com
two.example.com
three.example.com
192.168.1.100
```

hostsの書き方は以下のようなルールがある

- ドメインでの記述でも良い
- ipアドレスでの記述でも良い
- []で括ることで、グルーピングが可能 `[webservers]`であれば、webサーバーとして扱うなど

0.で設定したサーバーのipアドレスを入力していく。

### 2.コマンド入力

次のようなコマンドを入力する

`ansible 10.91.77.16 -a "echo test"

これで実行できない場合

```sh
ansible 10.91.77.16 -a "echo test" --extra-vars "ansible_user=root ansible_password@ssword123"
```

このように、extra-varsフラグを追加することでパスワードを入力する.

### 2.ssh実行時(初回のみ)

fingerprintが設定されていないので,sshで繋ぐのと同じように(yes)を追加する。

サーバーの設定によっては、パスワードの入力が求められる


### 3.実行結果

10.91.77.16より`test`という応答があれば完了。


### 4.echo test以外も実行してみる

他のコマンドも実行可能(対象となるサーバーをリブートする場合)

```sh
ansible 10.91.77.16 -a "shutdown -r now" --extra-vars "ansible_user=root ansible_password@ssword123"
```

この場合、サーバーがリブートされれば成功。




# できることできないこと

## ミドルウェアの構成までしてくれる

Ansibleには豊富なミドルウェアモジュールが用意されています。
そのため、複雑なミドルウェア層の構成管理はAnsibleで行うことをお勧めしています。

- terraform

<img src="https://www.lac.co.jp/lacwatch/img/20201216_002380_06.png">

- ansible

<img src="https://www.lac.co.jp/lacwatch/img/20201216_002380_05.png">

from https://www.lac.co.jp/lacwatch/service/20201216_002380.html#:~:text=Ansible%E3%81%A7%E3%81%AF%E3%80%81%E8%A8%AD%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AB,%E5%AE%9A%E7%BE%A9%E3%81%99%E3%82%8B%E5%BF%85%E8%A6%81%E3%81%8C%E3%81%82%E3%82%8A%E3%81%BE%E3%81%9B%E3%82%93%E3%80%82



## ansibleのユーザー数

terraformほどではないが、ansibleもそこそこユーザーがいる。

ユーザー数はterraformの2/3ほど。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/provider/ansible/trend.png?raw=true">


### 知見が溜まっているので簡単にgoogle検索に引っかかる

例えば、以下のリンクのように「ansible mysql」で検索すると

https://www.google.com/search?q=ansible+mysql&sxsrf=AJOqlzXY2EsFvzxrtXnLFnzFPtP_V-kgYw%3A1673600940627&ei=rB_BY9LmJYfj2roP9-OLyA0&ved=0ahUKEwjS7L6smcT8AhWHsVYBHffxAtkQ4dUDCA8&uact=5&oq=ansible+mysql&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQ6BwgjELADECc6CggAEEcQ1gQQsAM6BAgjECc6CggAELEDEIMBEEM6BAgAEEM6CAgAELEDEIMBOgsIABCABBCxAxCDAToHCAAQBBCABEoECEEYAEoECEYYAFCLAliaC2DGDWgBcAF4AIABwQGIAcsFkgEDMS41mAEAoAEByAEKwAEB&sclient=gws-wiz-serp

簡単に必要な記事が見つかる。

https://qiita.com/tz2i5i_ebinuma/items/4074cc45f5bac84b78a2

インストールのためのコードは以下の通り

```yml
- name: MySQL関連のパッケージインストール
  apt:
    force_apt_get: yes
    state: latest
    name:
      - mysql-server-5.7
      - mysql-client-5.7
      - python-mysqldb
```


## ansibleはterraformからも利用できる

terraformのレジストリにremoteサーバーにansibleをインストールするライブラリが存在した。

https://registry.terraform.io/modules/dcos-terraform/dcos-install-remote-exec-ansible/null/latest

よって、

- 全体のインフラの構成をterraform

- ミドルウェアの管理をansible

という構成も選択肢に入ると考えられる。

https://qiita.com/hayaosato/items/ee0d6eabb7b3d0a22136

以下が、ansibleを実行する,terraformの`.tf`ファイル

```t
 module "dcos-install" {
   source = "dcos-terraform/dcos-install-remote-exec-ansible/null"
   version = "~> 0.2.0"

   bootstrap_ip                = "${module.dcos-infrastructure.bootstrap.public_ip}"
   bootstrap_private_ip        = "${module.dcos-infrastructure.bootstrap.private_ip}"
   master_private_ips          = ["${module.dcos-infrastructure.masters.private_ips}"]
   private_agent_private_ips   = ["${module.dcos-infrastructure.private_agents.private_ips}"]
   public_agent_private_ips    = ["${module.dcos-infrastructure.public_agents.private_ips}"]

   dcos_config_yml = <<EOF
   cluster_name: "mfrickansible"
   bootstrap_url: http://${module.dcos-infrastructure.bootstrap.private_ip}:8080
   exhibitor_storage_backend: static
   master_discovery: static
   master_list: ["${join("\",\"", module.dcos-infrastructure.masters.private_ips)}"]
   EOF

   depends_on = ["${module.dcos-infrastructure.bootstrap.prereq-id}"]
}
```


















## Ansibleとは何か？


title:Ansibleとは何か?

img:https://avatars.githubusercontent.com/u/1507452?s=200&v=4

category_script:True




