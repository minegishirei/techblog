






AWSには様々な種類のサービスがあります。
それらを分類分けし、本当に必要なサービスがどれなのかを比較、吟味しておきましょう。



## AWSサービス一覧

- サーバー
  - AWS EC2: サーバーのこと。LinuxからMacOSからwindowsまでほぼすべてのOSをサポートしている
  - AWS EC2 Image Builder : EC2上で動作するサーバーのOSをアップデートする
  - AWS Lambda : 関数コードをサーバーレスアプリケーションとして運用できるサービス
  - AWS APP RUnner : webアプリケーションを簡単に構築できるサービス。ssl証明書発行やオートスケールを自動でやってくれる
  - AWS Bean Stalk : Webアプリケーションを簡単に構築できるサービス。
  - AWS Lightsail : webアプリケーションを簡単に構築できるサービス。
  - AWS Batch : Dockerで動作するバッチを実行してくれるサービス
  - AWS API Gateway: APIの作成、公開を行うサービス。REST APIからWebSocket APIやHTTP APIなどのどれかを選択できる。
  - AWS EMP for Windows server : 古くなり使われなくなったwindowsアプリケーションをWindowsサーバーとして運用できるようになるサービス


- ネットワーキング・コンテンツ配信
  - AWS App Mesh: OSSのEnvoyを利用して、ECSやEKSなどに構築したサービス間の通信をサポートする
  - AWS Cloud MAP: EC2やECSなどのAWSリソースを含むサービスのIPやリソース名を取得できるサービス
  - AWS Cloud Front: 静的コンテンツのキャッシュなどを実現できるCDN(Contents Derivaery Networking)サービス
  - AWS Direct Connect: オンプレミス環境と専用で接続できるサービス。データベースなどを外部におくことが禁止されている場合などに使用される。
  - Elastic Load Balancing : ロードバランサーサービス
  - AWS Route53: ドメインの登録とdnsサービスの運用を行ってくれる
  - AWS VPC: AWSのクラウドサービス内部にバーチャルプライベートネットワーク（VPN）を作成できる
  - AWS VPC in IP Manager: AWSのプライベートクラウドのIPを管理することができる

- ストレージカテゴリ
  - AWS Backup: AWSのEBSやRDSやEFSなどのバックアップを作成するサービス
  - AWS EBS: EC2にマウントするストレージサービス
  - AWS EFS: 複数のAZで使用可能なネットワーク共通のEC2専用（データシェアリングなどで用いられる）
  - AWS Elastic Disaster Recovery: 既存環境に影響を与えることなく、サーバやデータベースなどをレプリケーションしてくれる災害対策向けのサービス
  - AWS S3: ログ保存やバックアップ、静的ホスティングなど多様な要とのオンラインストレージサービス
  - AWS Storage Gateway: オンプレミス環境のデータ保存用として、AWSクラウド内のストレージを利用するためのサービス

- データベースカテゴリ
  - AWS Amazon Aurora: クラウドで最適化されたストレージデータ配置により、高可用性を実現したRDB
  - AWS DocumentDB: MongoDBとの互換性をもつドキュメント指向型のデータベース
  - AWS DynamoDB: スケーラブルなNoSQLデータベース
  - AWS ElasticCache: Redisを利用したキャッシュ向けデータベース
  - AWS Amazon Keyspaces: Apache Cassadraを利用したNoSQLデータベース
  - AWS MemoryDB for Redis: Redisを利用したより耐久性があるデータベース
  - AWS Neptune: グラフ指向のデータベース
  - AWS QLDB: データ改ざんが不可能な大腸型データベース
  - AWS RDS: ただのRDS
  - AWS Timestream: 時系列データの保存に最適化されたデータベース



 




