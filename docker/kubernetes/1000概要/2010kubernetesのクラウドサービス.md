




## Google Kubernetes Engine (GKE)

KubernetesはGoogleが作成しました。
したがって、Kubernetesをサポートするサービスの中でも、Google Cloud Platformは一歩リードしている状態です。
Google はほかのどの企業よりもKubernetesをサポートしてきたため、GKEは最善のKubernetesのマネージドサービスといえます。
まだクラウドプロバイダを決定していない場合はKubernetesを使用してもよいかもしれません。

Google Cloud Platformと完全に統合されたフルマネージドなサービス（Google Kubernetes Engine）を提供します。
主な利点は以下の通りです。

- GCPのコンソール上だけでクラスタの作成が完結する。
- 障害が発生したノードの監視と交換
- Kubernetesの脆弱性に対するセキュリティパッチの自動適用
- etcdに関する可用性
- ワーカーノードはユーザーが指定するメンテナンス時間内でKubernetesの最新バージョンにアップグレードされる。
- Google CloudのAPIを利用することで、Deployment Manager、Terraformなどを使用してIaC化することが出来る。
- マルチゾーンを作成し、ワーカーノードの負荷分散を実現できる。
- クラスタのオートスケールが可能。
- 処理能力に余力がある場合は、Podの数を減らすことも可能。


## Amazon Elastic Container Service for Kubernetes ( EKS )

AWSのコンテナのサポートといえば、FargateをはじめとするElastic Container Serviceですが、よりリッチなKubernetesをサポートするAmazon Elastic Container Service for Kubernetes ( EKS )も行っております。

ECSもコンテナサービスの運用には十分なレベルですが、Kubernetesほどリッチではありません。
オーバーヘッドが少ないという利点はありますが、より充実したサービスを求めるのであればEKSの使用が検討できます。

ただし、EKSはGoogleほどのシームレスなサポートではないため、セットアップ作業が多くなる可能性はあります。
すでにAWSでインフラを構築しているか、ECSを利用している場合でKubernetesを利用する場合にKubernetesの選択肢が上がります。
大多数の企業でAWSのクラウドサービスを利用しているため、ほどんどの企業でEKSは選択肢に上がります。













