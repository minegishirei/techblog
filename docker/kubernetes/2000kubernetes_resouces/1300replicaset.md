


# ReplicaSetとは

ユーザーはReplicaSetを理解している必要はなく、Deploymentの挙動を把握している必要があります。
ですが、ReplicaSetの挙動を把握しておくことは実運用上のトラブルシューティングなどで役に立つことがあります。

ReplicaSetの仕事は、Deploymentの変更を受けてPodを管理することにあります。
Deploymentが直接Podを変更しないのは、ローリングアップデートなどのデプロイ戦略に対応するためです。（例えば、RplicaSetをバージョニングすることで、古いReplicaと新しいReplicaをコントロールし、複数のPodをローリングアップデートすることが出来ます。）





## サンプルDeployment

Replicasetを目視するために対象となるDeploymentを作成する。

次のファイルを保存した後、コマンド`kubectl apply -f .\deployment-example.yaml`を実行すればDeploymentを作成できます。


```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec: # Deploymentの望ましい状態を定義
  replicas: 3 # 3つのレプリカPodを作成
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
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```





## ReplicaSetを取得してみる

ReplicaSetを取得するコマンドは`kubectl get replicaset`である。

```sh
kubectl get replicaset
```

実際に実行してみた結果は以下の通り

```sh
kubectl get replicaset
NAME                         DESIRED   CURRENT   READY   AGE
nginx-deployment-cbdccf466   3         3         3       16h
```


ここで、`replicas`の数を3→4に変更して、コマンド「`kubectl apply -f .\deployment-example.yaml`」で適応する。



```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec: # Deploymentの望ましい状態を定義
  replicas: 4 
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
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```


すると、適応した後の一種は、`DSIRED（望ましい数）`と`READY(実際の数)`に偏りがある。
これは、**ユーザーがDeploymentを更新する際に、新しいReplicaSetが作成されて新しいPodを管理し、更新が完了した時点で古いReplicaSetとそのPodが終了するためである。**

このように、**Podの数を一定に保とうとする動きのことを調整ループ**と呼びます。

```sh
kubectl get replicaset
NAME                         DESIRED   CURRENT   READY   AGE
nginx-deployment-cbdccf466   4         4         3       12s
```





page:https://minegishirei.hatenablog.com/entry/2023/10/13/091443
