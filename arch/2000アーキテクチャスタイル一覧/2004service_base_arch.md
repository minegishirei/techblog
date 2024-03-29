

## サービスベースアーキテクチャとは

サービスベースアーキテクチャは、マイクロサービスアーキテクチャの要素もある、分散型のアーキテクチャだ。

しかし、マイクロサービスやイベント駆動のタイプに見受けられる複雑さやコストがなく、多くのビジネスアプリケーションで選択されている。


<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2004service_base_arch/service_base_arch.png?raw=true">


## 参考

<img src="https://m.media-amazon.com/images/I/51-RoANBXoL._SX379_BO1,204,203,200_.jpg">

https://canvas.gu.se/files/4891694/download?download_frd=1

https://www.amazon.co.jp/-/en/Neal-Ford/dp/1492043451



## サービスベースのアーキテクチャスタイル

サービスベースのアーキテクチャの基本的なトポロジは分散型のマイクロレイヤー形式をとる。

構成要素は3つ存在し

- 個別にビルドされたユーザーインターフェース

- 個別にビルドされたリモートのバックエンドサービス

- モノリシックなデータベース

これらがユーザー側から見て順にレイヤーとなり構成される。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2004service_base_arch/service_base_arch.png?raw=true">


### サービスベースアーキテクチャのインスタンスの数

AWS上でこのアーキテクチャを採用する場合、サービスベースアーキテクチャのインスタンス数は基本的に1つだ。

しかし、**スケーラビリティや耐障害性、スループットの必要性に応じて、ドメインサービスのインスタンスが複数存在することもある。**
その場合、**ユーザーインターフェースとドメインサービスの間**に**何らかの負荷分散機能を必要**とする。

AWSの場合は、Elastic Load Balancingなどの活用が候補に上がるだろう。

<img src="https://d1.awsstatic.com/Digital%20Marketing/House/1up/products/elb/Product-Page-Diagram_Elastic-Load-Balancing_ALB_HIW%402x.cb3ce6cfd5dd549c99645ed51eef9e8be8a27aa3.png">

[AWS-EBS公式ページより](https://aws.amazon.com/jp/elasticloadbalancing/)

*ELB (Elastic Load Balancing) は、アプリケーションへのトラフィックを、1 つまたは複数のアベイラビリティーゾーン (AZ) 内の複数のターゲットおよび仮想アプライアンスに自動的に分散します。*


### サービスベースアーキテクチャの通信方式

ユーザーインターフェースからバックエンドにあるサービスの通信方式には、一般的にAPIが使用される。

しかし、

- メッセージング

- リモートプロシージャーコール(RPC)

- SOAP

なども候補に入れて良い


### サービスベースアーキテクチャのデータベース

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2004service_base_arch/service_base_arch.png?raw=true">

一般的に、中央でデータベースを構えているという点が、このアーキテクチャの重要な側面である。
これより、**元来使われてきたモノシリックなサービスでのSQLクエリの結合を活用できる。**

サービスが少ない場合は、データベースへの接続が問題になることは滅多にない。
しかし、**開発におけるデータベースの変更はリスクを伴う**

### サービスベースアーキテクチャのデータベースは基本的に一つ

サービスベースアーキテクチャのデータベースは、SQLクエリの結合を活用するために基本的に一つである。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2004service_base_arch/service_base_arch.png?raw=true">

しかし、単一のものシリックなデータベースではなく、上記のようにサービスごとのデータベースにすることも可能である。
だが、**その場合はそれぞれのデータベースを持つデータを他のドメインサービスが必要としていないことが前提となる。**
そうすることで、データベース間のデータの重複や大量のデータのAPIでの送信を免れる。


### モノリスなサービスを分散アーキテクチャに分解する場合におすすめ！

サービスベースアーキテクチャはものリスナサービスを分散アーキテクチャに分解する際の第一歩となるアーキテクチャである。

なぜならば、既存のデータベースに対してほとんど影響を与えることなく、
かつ安全にサービスを分割することができる。
そもそもほとんどのアーキテクチャはデータをAからBに変更や移動をしているだけだ。
そのため、システムよりもデータの方が寿命が高く、データの方が価値が高いとされる。
データに対するリスクを追わずにサービスを再構築できるのだ。

サービスを分割した後の分散アーキテクチャによるメリットをすぐに享受できるのもポイントが高い。




### サービスベースアーキテクチャでの横断する機能の実装

ユーザーインターフェースとサービスの間に、リバースプロキシやゲートウェイなどからなるAPI層を追加することも可能である。

こうすることで、これまでできなかった**横断的なサービス**を実装できる。

- システムの指標分析（呼ばれていないサービスの発見など）に使われるメトリクス

- セキュリティ要件

- 監査要件

- ロギング

- 保守運用

- ドメインサービス機能を外部システムに公開する場合



## サンプル例

ユーザーインターフェースの数、データベースの数、サービスの数は簡単に変化する

### ユーザーインターフェースの数が変化するパターン

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2004service_base_arch/service_base_ui_base.png?raw=true">

このように、ユーザーインターフェースを別の単独のシステムとして動作させることも可能だ。
この場合は、**ユーザーごとに接続できるサービスに設計レベルで制限を設けたい場合に有効である。**

### データベースが複数存在するパターン

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2004service_base_arch/service_base_arch.png?raw=true">

この場合はそれぞれのデータベースを持つデータを他のドメインサービスが必要としていないことが前提となる。



## データベースの変更

### サービスベースアーキテクチャのメリット

ここまで紹介した通り、ほとんどの場合でデータベースの数は一つか、多くて二つ程度である。

少ないデータベースは、本来データベースに備わっている、コミットとロールバックを含む通常の（アトミック性、一貫性、分離、耐久性）データベーストランザクション処理に頼ることで、ドメインサービス内のデータベースの整合性を確保します。

一貫性を保つことができるのが少ないデータベースのメリットである。


### サービスベースアーキテクチャのデメリット

しかしサービスベースアーキテクチャにはデメリットも存在する。

それは、**データベースの変更は全てのサービスへの影響を意味する**という点だ。
全てのサービスが単一のデータベースに依存する故、データベースの変更は各サービスの対応を迫られる。

このデータベース変更の影響とリスクを軽減する1つの方法は、

1. **データベースを論理的にパーティション化**し、**共有ライブラリを介して論理的なパーティション化を明示すること**

2. それでも尚全てのドメインで共有するデータベースは、COMMONというパーティション名をつけ、投入するデータを限定すること

これらを実転した際のアーキテクチャ図は次のようになる。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2004service_base_arch/service_base_database_common.png?raw=true">

この図では、

- 単一のデータベース内部に5つのパーティションが含まれている

- それぞれのサービスが、それぞれのパーティションにアクスするためのライブラリを持つ

- 全てのサービスで、common_entites_libsライブラリからCOMMONにアクセスできる

という状態がうかがえる。

これにより、変更の管理を維持しつつ、全てのサービスで使用される共通テーブルへの変更の重要性が強調される。



## サービスベースアーキテクチャのメリット


まず、このアーキテクチャは「ドメイン管理方式」である。（技術管理方式ではない）

したがってあるサービスの改修が入った場合、その他の改修を行う必要はなく、関係のないコンポーネントのビルドも防ぐことができる。

サービス単位でテストを組むこともできるため、ソフトウェアの品質を高く保つことができる。

まとめると以下の通り

- サービスごとに分割されているため、迅速な変更が可能

- サービスには範囲が区切られているため、テストも対象のサービス内部に抑えられる。

- より少ないリスクでデプロイできる。

というか、**このアーキテクチャについては、さまざまな項目で高い評価を得ることができる。**

#### デプロイ容易性

アプリケーションを個別にデプロイされたサービスに分割することで、より高速な変更が可能になる。

#### テスト容易性

ドメインの範囲が限定されているため、テストカバレッジの向上が期待できる。

#### デプロイ容易性

大規模なモノリスではないため、特定のサービスの改修後、すぐにリリースできるのが強み。

上記3つの特徴は、**市場投入までの時間を短縮し、新機能やバグ修正を比較的高い速度で提供することを可能にしている。**


## サービスベースアーキテクチャのデメリット

デメリットは「コストが高くなる可能性がある」こと

小規模なアプリケーションでは費用対効果が出ないこともある。

また、スケーラビリティ(弾力性)において、マイクロサービスに比べてより多くの機能が複製されることになるため、
マシンリソースの効率性では費用対効果は高くはない。







## 備考

title:サービスベースアーキテクチャのメリットとデメリット

description:このアーキテクチャは「ドメイン管理方式」である。（技術管理方式ではない）したがってあるサービスの改修が入った場合、その他の改修を行う必要はなく、関係のないコンポーネントのビルドも防ぐことができる。サービス単位でテストを組むこともできるため、ソフトウェアの品質を高く保つことができる。

img:https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2004service_base_arch/service_base_arch.png?raw=true

category_script:(page_name.startswith("2") or page_name.startswith("1"))

redirect:https://minegishirei.hatenablog.com/entry/2023/01/28/111344






