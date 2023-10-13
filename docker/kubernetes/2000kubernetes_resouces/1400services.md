


## Serviceリソース

**Serviceリソースは単一の変化しないIPアドレス、またはDNSを付与することができ、任意の対応するPodへ自動的にルーティングさせることが出来ます。**

ServiceはWebプロキシやロードバランサのようなものと考えることができ、バックエンドであるPodのグループにリクエストを飛ばします。


### Serviceリソースのコード例

次のプログラムは`80`番ポートへのアクセスを`nginx`コンテナの`8080`番に転送しています。
大部分が`Deployment`リソースと似ていますが、`kind: Service`が異なっている点です。

```yml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: NodePort
```

Serviceの転送先Podが複数存在している場合、デフォルトではランダムに選択されたPodに送信することになります。
しかし、オプション次第でほかの接続方式もサポートすることが可能です。





### nginxの8080ポートをServiceリソースを使用して80番へアタッチする


次のコードを`nginx.deployment.yml`という名前で保存し、 コマンド`kubectl create -f nginx.deployment.yml`を実行してください。

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
        image: nginx  # または公式のNginxイメージを使用
        ports:
        - containerPort: 8080
```

この時点では8080ポートは公開されておらず、あくまでkubernetesの範囲でのみ公開されています。

そこで、次の**Serviceリソース**のコードを`nginx.service.yaml`という名前で保存し、
`kubectl apply -f .\nginx.service.yaml`というコマンドでリソースを反映してください。

```yml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: NodePort
```

ここまで実行出来たら、次のリンクにアクセスしてnginxサービスが起動しているかどうか見てみましょう。

http://localhost/

もし動かない場合は次のコマンドを試してみてください。

```sh
kubectl port-forward service/nginx-service 80:80
```

## まとめ


まとめると、
- 開発者が作成するアプリケーションを運用するPodの管理がDeployment
- ユーザーがPodにアクセスするためのエントリーポイントを提供するのがService




page:https://minegishirei.hatenablog.com/entry/2023/10/13/091613?_gl=1*1paa6d4*_gcl_au*MTAxNjcwMDkxNS4xNjk1NjAyODkx