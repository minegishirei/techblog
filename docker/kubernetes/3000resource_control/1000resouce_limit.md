




## リソースの管理

Kubernetesの各PodのCPU使用量はCPU単位であらわされます。
これは各クラウドベンダーのCPU単位に相当します。つまり、Kuberentesの1Podは

- AWSのvCPU
- GCPの1Core
- AzureのvCore

などであらわされます。

しかし、Kubernetesの1つのPodが一つのCPUすべてを使い切ることは考えにくいため、たいていは少数であらわされます。
例えば、一つのPodの必要な処理能力が1m CPU(一ミリCPU)であれば、1CPUで同一の10個のPodを賄うことが出来ることになります。


Kubernetesでは必要となるリソースを次の二つの方法を用いて指定します。

- リソース要求値（Kubernetesが必要とする最小のリソース）
- リソース制限値（Kubernetesへ許可される最大のリソース）


### リソース要求値の設定（`requests`句の使用）

Kubernetesのリソース要求は、Podの実行に必要となるリソースの最小量を指定します。
十分なリソースが確保できるまでKubernetesはPodを配置することはせず、Pending状態のままです。

> 例えば費用の関係でAWSの1vCPUが利用できる最大のCPU性能である場合、Kubernetesの2.5CPUを要求するPodは実行されることはありません。

リソース要求値の設定は、`requests`句を使用することで達成できます。

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 8080
        resources:
          requests:
            memory: "20Mi" #メモリの要求値を20に制限。
            cpu: "100m" # CPU使用率は0.1cpuに制限
```


### リソース制限

リソース制限はPodが使用することを許される最大値のことで、`limits`句で表現されます。
割り当てられたCPU値を超えてCPUの使用を試みるPodはスロットル処理の対象となり、CPUの使用率を下げられます。

リソース制限のためには、以下のように`limits`句を使用します。


```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 8080
        resources:
          limits:
            memory: "100Mi" #メモリの最大値を100Miに制限。
            cpu: "100m" # CPU使用率は0.1cpuに制限
```









page:https://minegishirei.hatenablog.com/entry/2023/10/13/093621?_gl=1*14mh1ch*_gcl_au*MTAxNjcwMDkxNS4xNjk1NjAyODkx









