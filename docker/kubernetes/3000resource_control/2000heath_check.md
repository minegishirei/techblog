

# Kubernetesでのヘルスチェック方法

Kubernetesではコンテナのスペック管理の一部として、Liveness Probe(ライブネスプローブ)を利用できます。
言い換えればヘルスチェックが利用可能です。

> Liveness は動作の確認。
> Prove は証明という意味です。


## HTTPサービスのヘルスチェック

HTTPサーバーを実行するコンテナの場合、提供するurlのエンドポイントを指定してヘルスチェックを行うことができます。
エンドポイントから`2xx`または`3xx`版のステータスコードが返答された時はサービスが起動していると解釈されます。
反対に、それ以外の番号が返答された場合はサービスは死んでいると考えられ、再起動されます。

例えば次の条件でHTTPサービスのヘルスチェックを行いたい場合

- `/healthz`エンドポイント宛に
- 初回は3秒待ちで
- 3秒ごとに

以下の`LivenessProbe`コードが使用できます。

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
        LivenessProbe: #ヘルスチェック中...
          httpGet:
            path: /healthz
            port: 80
          initialDelaySeconds: 3
          periodSeconds: 3
```

## TCPを使用したヘルスチェック

HTTPを使用しないサーバーの場合には`tcpSocket`が利用できます。

```yml
        livenessProbe: #ヘルスチェック中...
          tcpSocket:
            port: 8888
```

指定されたポートへの接続が確認できればコンテナは生きていると解釈されます。


## コマンド実行によるヘルスチェック

`readinessProbe`と`exec`オプションを使用することでコマンドの実行結果を元に判定することができます。

```yml
        readinessProbe:
          exec:
            command:
              - cat
              - /tmp/healthy
```

`exec probe`は`command`で指定されたコマンドをコンテナ内部で実行し、このコマンドの実行結果が成功（ステータスコードが0で終了する）
であればコンテナは生きていると解釈されます。







page:https://minegishirei.hatenablog.com/entry/2023/10/14/102141


