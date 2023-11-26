




# snowflake自体のセキュリティ用件

## snowflakeの取得している資格

- NIST 800-53
- SOC2 Type2
- SOC1 TYpe2
- ISO/IEC 27001:2013
- HIPAA
- PCI
- FedRAMP

上記のセキュリティ要件を取得できる企業、サービスである。


## snowflakeのアクセス用件

snowflakeの対応しているセキュリティアクセス要件は以下の通り

- IPホワイトニング
- クライアント通信はTLSを使用
- クラウドプロバイダーのプライベートネットワークソリューションへ対応可能


## ネットワークセキュリティについて

- snowflake接続に、Online Certificatin State Protocol(OCSP) x 509

- クラウドプロバイダーへの接続について
  - AWSおよびAzure、GCPについては、パブリックトラフィックはない
  - 


## アカウントレベルのファイヤーウォールについて

アカウントレベルのネットワークポリシー

snowflakeへのアクセスを承認されたネットワークポイントのみに限定することが可能。
ホワイトリストかブラックリスト形式でセキュリティを担保できる
CIDR表記法を使用して、サブネット範囲を指定する。

※CIDR表記法：IPアドレスの範囲を表現する方法。10.1.0.0/16 というように表記する。

ネットワークポリシーの設定方法は以下の通り

```sql
CREATE NERWORK POLICY <policy name>
ALLOWD_IP_LIST = (<IPadress... or range>)
BLOCKED_IP_LISR = (<IPadress... or range>)

ALTER ACOUNT SET NETWOEK_POLICY = <policy name>
```

### ユーザーレベルのセキュリティ用件

また、ユーザーレベルでもネットワークポリシーを作成できる。

ユーザーレベルのネットワークポリシーは以下の通り

- 許可された/ブロックされたIPアドレスリストに基づく、ユーザーのアクセス制限可能

- 認められていないIPアドレスからのログインを拒否

- ただし、*ユーザーに関連付けられるネットワークポリシーは一つのみ*

- すでにサインインしているユーザーにポリシーを割り当てると、途中からはクエリの実行ができなくなる。


## 改装的データ暗号化

Tri-Secret Secureを使用した階層的暗号鍵モデル。

**一つのデータファイルに対して4回以上暗号鍵をかけている**

最も大きい鍵は、Acount master keysであり、二番目にTable master keys, Result master keys, Stage master keysなどがくる。最後に、データファイルが個別に暗号化される。

<img src="https://docs.snowflake.com/ja/_images/hierarchical-key-model.png">






# 会社側（ユーザー側）に求めるセキュリティ

会社側には以下のセキュリティ要件が求められる

## 1.ホワイトリストするポート

- 443 : snowflakeトラフィックに必要
- 80  : 全てのsnowflakeクライアント通信をリッスンするためのOCSPキャッシュサーバーに使用

これらのポート番号をパソコンから開けれない場合はsnowflakeはほぼ利用できないと考えて良い


## 2.ホスト名（ドメイン名）ホワイトリスティング

- snoflakeアカウントには、クラウドストレージへの一時的なアクセスが必要
- 必要なホスト用にホスト名のパターンをホワイトリストを作る
- SYSTEM$WHITELIST()または、SYSTEM$WHITRELIST_PRIVATELINK()を使用してsnowflakeアカウントに必要なホスト名を取得



## 3.顧客提供のデータのステージングについて

Stageing Areaへのデータのアップロードは、Customerのデータの暗号化を顧客自身で行う必要がある。
ステージングからSnowflakeへの連携については、snowflake側が責任を負う












## 備考

title:snowflakeのセキュリティ関連調査結果

category_script:page_name.startswith("7")

img:https://static.security-design.jp/img/icon/Attacker@512.png


