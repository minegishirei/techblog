


kubernetesにおいて、Labelとは、Podなどのオブジェクトに付加されるキーとバリューのセットの事です。
（要はpythonでいう辞書型、ほかの言語だと連想配列のこと）
このLabelはKubernetes側から参照することはありませんが、ユーザーがPodを識別するコマンドを打ったり、ほかのリソースからPodを識別する際の指標とすることが出来ます。


## labelsを使用したサンプルコード

以下のコードで、`labels`に当るところがラベルの設定をしています。
今回は、

- キー名が`app`
- バリューが`test`

となっています。

```yml
# nginx-deployment.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: test
  template:
    metadata:
      labels:
        app: test
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
```


## selectorのサンプルコード

Podが実行しているアプリケーションがどのようなものかがわかるので、通常は**コメントとして役に立ちます**が、LabelはSelecterと組み合わせることでほかのリソースから参照することが出来ます。

以下は、上記のnginxのDeploymentsと接続するServiceのコードです。

```yml
# nginx-service.yaml

apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: test
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: NodePort  # または LoadBalancer など、必要に応じて変更
```

上記のコードでは、`selector`の句を指定して、次の条件に当てはまるDeploymentsを選択しています。

- キー名が`app`
- バリューが`test`

このような指定をした場合、キー名に`app`がないものは指定されません。また、キー名に`app`があっても、値が`test`ではないものも指定されません。キー名が`app`かつバリューが`test`である者だけが、上記のServiceにより選択されます。


## getコマンドでselectorを使用する

上記のDeploymentsにはキー名が`app`かつバリューが`test`というラベルが張られていましたが、kubectlで上記のラベルのみを指定してコマンドを実行することもできます。


```sh
kubectl get pods --selector app=test
```

ちなみに、`selector`は`l`(label)にも短縮できます。

```sh
kubectl get pods -l app=test
```

あるいは、一致しないものを指定したいときは、`=`ではなく`!=`を使用することができます。

```sh
kubectl get pods --selector app!=test
```

また、ラベルは複数指定することが出来ます。

```sh
kubectl get pods --selector app!=test,env=test
```










page:https://minegishirei.hatenablog.com/entry/2023/11/13/091825






