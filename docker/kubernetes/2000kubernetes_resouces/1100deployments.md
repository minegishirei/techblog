

## Deployment

Kubernetesではスーパバイス（監視、監督）する必要がある個々のプログラムに対して、`Deploymentオブジェクト`が作成されます。
`Deploymentオブジェクトは以下の情報から構成されます。`

- コンテナイメージ名
- 実行したいレプリカの数
- その他コンテナを実行する際に知っておくべき情報

いわば、**デプロイメントはコンテナ単位のあるべき姿**といえます。

### Deploymentがコンテナを再起動するタイミング

Deploymentの仕事は、**関連付けられているコンテナを監視して、指定された数のレプリカが常に実行されているかどうかの答え合わせ**です。

- コンテナが仕事を終了したときには、Deploymentはそのコンテナを再起動します。
- ユーザーが自らの手でコンテナを終了したときも、Deploymentはそのコンテナを再起動します。（ただし、コンテナが再起動する条件は指定することもできます）

ユーザーに許されているコンテナの数の変更方法とは、**Deploymentに記載されているコンテナ数を変更することのみなのです。**


### Deploymentを作成してみる

まずは次のファイルを保存してください。
名前は`deployment-example.yaml`です。


```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
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

その後以下のコマンドを実行。

```sh 
kubectl apply -f .\deployment-example.yaml
```



### Deploymentの情報を取得する

次のコマンドですべてのDeploymentsの情報を取得することが出来ます。

```sh
kubectl get deployments
```

実行結果

```sh
kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           13m
```


### Podも確認してみる

以下のコマンドでDeploymentによって生成されるPodを確認できる。

```sh
kubectl get pod
```

今回は`replica`に`3`が指定しているため、podの数は3つまで増える。


```sh
> kubectl get pod
NAME                               READY   STATUS      RESTARTS   AGE
hello-world                        0/1     Completed   0          117m
nginx-deployment-cbdccf466-7qvhk   1/1     Running     0          14s
nginx-deployment-cbdccf466-hn95r   1/1     Running     0          14s
nginx-deployment-cbdccf466-vf5sj   1/1     Running     0          14s
```

### Deploymentsを削除する

deploymentsを終了させるには`kubectl delete`コマンドを使用する。

```sh
kubectl delete -f .\deployment-example.yaml
```

deployments確認結果

```sh
> kubectl get deployments
No resources found in default namespace.
```





page:https://minegishirei.hatenablog.com/entry/2023/10/11/091715
