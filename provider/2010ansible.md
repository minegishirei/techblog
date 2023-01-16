

# ansibleとは？

- [ansibleとは？](#ansibleとは)
  - [参考記事](#参考記事)
  - [ansibleとは?](#ansibleとは-1)
    - [ansibleとshellスクリプト都の違い](#ansibleとshellスクリプト都の違い)
    - [類似製品](#類似製品)
  - [インストール方法](#インストール方法)
    - [ubuntuへのインストール](#ubuntuへのインストール)
- [手を動かす](#手を動かす)
  - [ansible動作確認](#ansible動作確認)
    - [0.ansibleサーバーを用意する](#0ansibleサーバーを用意する)
    - [1.ansibleのhostsを書く必要がある](#1ansibleのhostsを書く必要がある)
    - [2.コマンド入力](#2コマンド入力)
    - [2.ssh実行時(初回のみ)](#2ssh実行時初回のみ)
    - [3.実行結果](#3実行結果)
    - [4.echo test以外も実行してみる](#4echo-test以外も実行してみる)
  - [ansibleのplaybookを書く](#ansibleのplaybookを書く)
    - [1.まずはディレクトリ作成](#1まずはディレクトリ作成)
    - [2.site.ymlを作成する](#2siteymlを作成する)
    - [3.実行](#3実行)
    - [4.実行結果](#4実行結果)
  - [モジュールを使例:Apacheの構築をしてみる](#モジュールを使例apacheの構築をしてみる)
    - [1.Playbookを書く](#1playbookを書く)
    - [コマンド実行](#コマンド実行)
    - [実際にログインして確認してみる](#実際にログインして確認してみる)
  - [handler](#handler)
    - [0.confファイルが変更された時にserviceをrestartする](#0confファイルが変更された時にserviceをrestartする)
    - [1.Playbookを次のように書き直す](#1playbookを次のように書き直す)
    - [2.最後に変更を行う](#2最後に変更を行う)
- [メリット](#メリット)
  - [ミドルウェアの構成が可能](#ミドルウェアの構成が可能)
  - [ansibleのユーザー数はそこそこいる](#ansibleのユーザー数はそこそこいる)
    - [知見が溜まっているので簡単にgoogle検索に引っかかる](#知見が溜まっているので簡単にgoogle検索に引っかかる)
  - [ansibleはterraformからも利用できる](#ansibleはterraformからも利用できる)
  - [デメリット:ansibleの面倒な点](#デメリットansibleの面倒な点)
    - [ansibleではおそらくsnowflake未対応](#ansibleではおそらくsnowflake未対応)
    - [ansible専用のサーバーを立てなければならない可能性](#ansible専用のサーバーを立てなければならない可能性)
- [結論](#結論)
  - [ansibleはshellscriptのラッピング](#ansibleはshellscriptのラッピング)
  - [ansibleはクラウドよりはオンプレ向きの可能性大](#ansibleはクラウドよりはオンプレ向きの可能性大)
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


# 手を動かす

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


## ansibleのplaybookを書く

### 1.まずはディレクトリ作成

`mkdir ansible-playbook`

### 2.site.ymlを作成する

次のコマンドでsite.ymlを作成
`vim site.yml`

あ内容は次の通り

```yml
 - hosts: 10.91.77.16
    gather_facts: yes
    remote_user: root
    vars:
      ansible_password: p@ssword123!
    task:
      name: Make somefolder
      file:
        path: "/root/test"
        state: directory
```

ファイルを説明すると

- gather_facts:サーバーの情報をできるだけ集めるコマンド

- remote_user:接続を行うユーザー

- vars  
  - ansible_password: vaultsという機能を使えば、


- task
  - name: タスクの名前
  - file: "file"というモジュールを使う
    - path: パス
    - state: 実行方法について指示している
      - `absent`:ファイルが存在しないことを担保する(存在していた場合は削除する)
      - `ansible`: ファイルが存在していない場合はフォルダーを作成する

という意味。

### 3.実行

`ansible-playbook site.yml`で実行する。


### 4.実行結果

以下のように実行されれば完了

```js
TASK [do -> ok] **********************************************************************************************************************************
ok: [localhost] => {
    "msg": "task has done and return ok"
}

PLAY RECAP ***************************************************************************************************************************************
localhost                  : ok=1    changed=1    unreachable=0    failed=0
```

各ステータスは以下の意味を持つ。

- ok=実行

- changed=実際にファイル構成が変更されたことを確認

- unreachable=ssh接続に失敗

- faild=失敗

また、実際にターゲットのサーバーにsshログインして、結果が見えていれば良い

## モジュールを使例:Apacheの構築をしてみる

以下の手順を行う

1. Apacheのインストール

2. Apacheのconf配置

3. トップページの配置

4. サービスの有効化

### 1.Playbookを書く

```yml
  - hosts: 10.91.77.16
    gather_facts: yes
    remote_user: root
    vars:
      ansible_password: p@ssword
    tasks:
      - name: 1.Apache2のインストール
       apt: #「apt」モジュールの使用
        name: apache2 #
        state: latest #(インストールされていて、最新であること)
      - name: 2.confファイルを配置する
        copy: #「copy」モジュールの使用
          src: apacher2.conf
          dest: /etc/apache2/apache2.conf
      - name: 3.トップページの配置
        copy: #「copy」モジュールの使用
          src: index.html
          dest: /var/www/index.html
      - name: 4.Apache2のサービスの有効
        service: #サービスモジュールの使用
          name: apache2
          state: started
          enabled: yes
```

### コマンド実行

`ansible-playbook site.yml`

### 実際にログインして確認してみる

`apt-get install apache2`を実行,apacheがインストールされていること

10.91.77.16へアクセス。実際にページが表示されたことを確認する


## handler

先ほどのapacheのサーバーには、一つ欠点がある。
それは、**サービスの再起動時に、ファイルが読み込まれない点を改善する**

### 0.confファイルが変更された時にserviceをrestartする

1. serviceモジュールのstateをrestartedに直す

2. commandモジュールで直接サービスの再起動コマンドを入れる

3. handlerを使用する

しかし、1と2では冗長であり、**サーバーの結果**を保持することはできない。

handlerは、**サーバーに変更があった際に実行される**キーワードである

### 1.Playbookを次のように書き直す

```yml
  - hosts: 10.91.77.16
    gather_facts: yes
    remote_user: root
    vars:
      ansible_password: p@ssword
    tasks:
      - name: 1.Apache2のインストール
       apt:
        name: apache2
        state: latest
      - name: 2.confファイルを配置する
        copy: 
          src: apacher2.conf
          dest: /etc/apache2/apache2.conf
        notify: restart apache2 #1. ここでファイルの変更が検知された場合
      - name: 3.トップページの配置
        copy:
          src: index.html
          dest: /var/www/index.html
      - name: 4.Apache2のサービスの有効
        service: 
          name: apache2
          state: started
          enabled: yes
    handlers: 
      - name: restart apache2 #handlersに設定された再起動taskが動き出す
        service: #apacheの再起動を行うサービスモジュール
          name: apache2
          state: restated
```

### 2.最後に変更を行う

`ansible-playbook site.yml`





# メリット

## ミドルウェアの構成が可能

Ansibleには豊富なミドルウェアモジュールが用意されています。(aptやserviceコマンドに対応)
そのため、複雑なミドルウェア層の構成管理はAnsibleで行うことをお勧めしています。

- terraform

<img src="https://www.lac.co.jp/lacwatch/img/20201216_002380_06.png">

- ansible

<img src="https://www.lac.co.jp/lacwatch/img/20201216_002380_05.png">

from https://www.lac.co.jp/lacwatch/service/20201216_002380.html#:~:text=Ansible%E3%81%A7%E3%81%AF%E3%80%81%E8%A8%AD%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AB,%E5%AE%9A%E7%BE%A9%E3%81%99%E3%82%8B%E5%BF%85%E8%A6%81%E3%81%8C%E3%81%82%E3%82%8A%E3%81%BE%E3%81%9B%E3%82%93%E3%80%82



## ansibleのユーザー数はそこそこいる

terraformほどではないが、ansibleもそこそこユーザーがいる。

ユーザー数は少なくともterraformの2/3ほど。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/provider/ansible/trend.png?raw=true">


### 知見が溜まっているので簡単にgoogle検索に引っかかる

例えば、以下のリンクのように「ansible mysql」で検索すると

https://www.google.com/search?q=ansible+mysql&sxsrf=AJOqlzXY2EsFvzxrtXnLFnzFPtP_V-kgYw%3A1673600940627&ei=rB_BY9LmJYfj2roP9-OLyA0&ved=0ahUKEwjS7L6smcT8AhWHsVYBHffxAtkQ4dUDCA8&uact=5&oq=ansible+mysql&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQ6BwgjELADECc6CggAEEcQ1gQQsAM6BAgjECc6CggAELEDEIMBEEM6BAgAEEM6CAgAELEDEIMBOgsIABCABBCxAxCDAToHCAAQBBCABEoECEEYAEoECEYYAFCLAliaC2DGDWgBcAF4AIABwQGIAcsFkgEDMS41mAEAoAEByAEKwAEB&sclient=gws-wiz-serp

簡単に必要な記事が見つかる。

https://qiita.com/tz2i5i_ebinuma/items/4074cc45f5bac84b78a2


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


## デメリット:ansibleの面倒な点


### ansibleではおそらくsnowflake未対応

google検索ほぼなし



### ansible専用のサーバーを立てなければならない可能性

いくつかの検証環境で確認したところ、通常のノートPCで開設等を行う場合、virtual box内部にサーバーを二台建てていた。

- 一台は設定したいターゲットとなるサーバー

- もう一台は、ansibleを実行するサーバー


# 結論

## ansibleはshellscriptのラッピング

ansibleがやっていることは

- ssh接続

- コマンドを実行

- 条件分岐に基づいて、サーバーの構成管理をする

記述量は減るが、上記はshellscriptでも十分可能


## ansibleはクラウドよりはオンプレ向きの可能性大

ansibleはクラウドよりもオンプレ環境で力を発揮する可能性が高い

- ほとんどのチュートリアルでも、virtual-boxを使った紹介(EC2は0)

- [AWS-Lambdaを作成する記事](https://www.google.com/search?q=ansible+lambda&sxsrf=AJOqlzUTcuuBjAQsYAY_LhO7Lf78mBlyyA%3A1673841799782&ei=h8zEY9OwL9Hs2roP1p6T-Ak&oq=ansible+lamb&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAxgAMgUIABCABDIICAAQgAQQywEyCAgAEIAEEMsBMggIABCABBDLATIICAAQgAQQywEyBAgAEB4yBAgAEB4yBAgAEB4yBAgAEB4yBAgAEB46BwgjELADECc6CggAEEcQ1gQQsAM6BAgjECc6BwgAELEDEEM6BAgAEENKBAhBGABKBAhGGABQqwJY9Qlg6xNoAXABeACAAYwBiAH_A5IBAzQuMZgBAKABAcgBCsABAQ&sclient=gws-wiz-serp)は存在はするが、ほとんとが2017年頃(5年前)

**ユーザー側でやらなければならないことが多い**










## Ansibleとは何か？


title:Ansibleの製品調査

img:https://avatars.githubusercontent.com/u/1507452?s=200&v=4

category_script:True




