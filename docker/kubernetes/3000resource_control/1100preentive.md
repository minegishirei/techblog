





## プリエンプト可能なノード（またはスポットインスタンス）とは何か?

スポットインスタンスは、AWSの未使用のコンピューティング容量（スポットキャパシティ）を利用して低価格でインスタンスを起動することができる特殊なインスタンスタイプです。

低価格：スポットインスタンスの価格は、AWSが利用可能なコンピューティング容量に応じて変動します。**通常はオンデマンドインスタンスよりも低価格で提供されます**

短時間：スポットインスタンスは、短期的なタスクや非常にコスト効率の良い計算リソースが必要なワークロードに適しています。例えば、バッチ処理、データ分析、CI/CDパイプラインなどに利用されます。


つまり、**不安定だが安いコンピューターがプリエンプトノード、またはスポットインスタンスです**

Kubernetesのクラスタでプリエンプト可能なノードを使用することは、コスト削減のために効果的な方法となりえます。場合によってはコストをそごうで50%削減できる可能性があります。

また、Kubernetesクラスタにカオスエンジニアリングを導入するための方法にもなりえます。
（カオスエンジニアリングとは本番稼働のシステムに対してわざとランダムな障害を起こし、対応方法を確立する避難訓練のようなものです。netflixが先行導入）



## Node Affinityを用いたスケジューリング制御

KubernetesのNode Affinity機能を使用すると、障害が許されないPodをプリエンプト可能なノードに配置しないように設定できます。

`requiredDuringSchedulingIgnoredDuringExecution`というAffinityが目印です。



```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nodejs-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nodejs
  template:
    metadata:
      labels:
        app: nodejs
    spec:
      containers:
      - name: nodejs-app
        image: your-nodejs-image:tag
        ports:
        - containerPort: 3000
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
    template:
      spec:
        affinity: # ここからNode affinity
          nodeAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              nodeSelectorTerms:
              - matchExpressions:
                - key: cloud.google.com/gke-nodepool
                  operator: In
                  values:
                  - preemptible-pool
```

ところで、「たまに障害が起こる程度なら構わない」という意図を伝えるには、
`preferredDuringSchedulingIgnoredDuringExecution`が使えます、



## Affinityでリージョンを指定する

以下はAWSの東京リージョンにデプロイすることを強制するリソースです。
affinityの`matchExpressions`を強化することで、このように拡張することが出来ます。

```yml
    spec:
      containers:
      - name: nodejs-app
        image: your-nodejs-image:tag
        ports:
        - containerPort: 3000
    affinity:
      nodeAffinity:
        requiredDuringSchedulingIgnoredDuringExecution:
          nodeSelectorTerms:
          - matchExpressions:
            - key: failure-domain.beta.kubernetes.io/region
              operator: In
              values:
              - ap-northeast-1
```








