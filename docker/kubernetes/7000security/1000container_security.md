

コンテナのセキュリティ


コンテナのセキュリティとは、攻撃者がコンテナ内部に侵入しても問題ない状態を作り上げておかなければなりません。
プログラムには脆弱性が付きまといます。
これを任意の権限をもつユーザー（rootユーザー）が悪用できる状況になった場合、最悪システムを乗っ取られる可能性もあります。
あるいは、コンテナのバグを悪用してホストマシンの権限を奪われる可能性もあります。

このような危険性を軽減するために、コンテナは考えうる最小の権限で実行することが重要です。

## rootユーザーで実行しない

linuxサーバー上ではrootユーザーでの作業が避けられるように、コンテナでのアプリケーションの実行もrootで行うべきではありません。
代わりに、一般ユーザーとしての権限を割り当てて、ほかのユーザのファイルを読み取るなどの特別な権限は一切持たないユーザとします。

そのためには、次のように`rootAsUser`オプションを設定します。

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx-container
        image: nginx:latest
        securityContext:
          runAsUser: 1000
```

`runAsUser`はUIDを指定します。
linuxシステムでは非rootユーザにUID 1000が割り当てられるため、1000以上の値を選択するのがおすすめです。

さらにセキュリティを高めるためには、コンテナごとに異なるUIDを選択する必要があります。
例えば、アプリケーションとデータベースで異なるUIDを設定した場合、アプリケーションの実行ユーザーを乗っ取られてもデータベースは異なるUIDなのでデータに影響が及ぶことがないからです。

## rootコンテナのブロック

Kubernetesではコンテナでrootユーザーが実行を要求することを強引に拒否することが可能です。
それをするには、`runAsNonRoot`をtrueにすることで実現できます。


```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx-container
        image: nginx:latest
        securityContext:
          runAsNonRoot: true
```




















