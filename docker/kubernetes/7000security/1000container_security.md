

[contents:]

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



## 読み取り専用ファイルシステムの設定

コンテナが自分自身のファイルシステムに書き込むことを防止する`readOnlyRootFileSystem`があります。
例えば、自分がアクセスできるファイルシステムに望ましくない変更を加えてしまった場合、ホストマシンが機能不全になってしまう可能性もあります。
ファイルシステムを読み取り専用として設定することで、このような事態を未然に防ぐことが出来ます。


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
          readOnlyRootFilesystem: true
```

ほとんどのコンテナでは自分のホストマシンに何かを書き込む必要がないため、この設定を常に書き込んでおくことをお勧めします。

## 権限昇格の無効か

`allowPrivilegeEscalation`項目を`false`に設定しておくことで、一般ユーザーがroot権限を獲得することを未然に防ぐことが出来ます。

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
          readOnlyRootFilesystem: true
```


## ケイパビリティ

伝統的なLInuxでは、権限のレベルが通常とスーパーユーザの2種類に分けることができます。

ところが現代のLinuxでは**ケイパビリティ**と呼ばれる機構があり、プログラムが実行できる特定の様々な機能を細かく定義することが出来ます。

特定の機能とはカーネルモジュールのロード、ダイレクトネットワークのI/O、システムデバイスへのアクセスなどです。

> ポート80番でwebサーバーを建てる場合、この機能を実行するためにrootとして実行するのではなく、`NET_BIND_SERVICE`ケイパビリティを与える。

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
          drop: ["CHOWN", "NET_RAW", "SETPCAP"]
          add:  ["NET_ADMIN"]
```

上記のコンテナは、`"CHOWN", "NET_RAW", "SETPCAP"`が削除され、`NET_ADMIN`ケイパビリティが追加されます。

しかし、セキュリティを最大限に高めるには、どのコンテナについても`drop: ["all"]`を追加するべきです。

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
          drop: ["ALL"]
          add:  ["NET_BIND_SERVICE"]
```


## Podのセキュリティ

これまでの内容はコンテナ単位に適応してきましたが、Podのレベルに適応することも可能です。
**Podに適応した場合、コンテナが自分自身のセキュリティコンテキストで上書きする場合を除き、Pod内のすべてのコンテナに適応されます。**


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
      securityContext:
        drop: ["ALL"]
        add:  ["NET_BIND_SERVICE"]
      containers:
      - name: nginx-container
        image: nginx:latest
```






















page:https://minegishirei.hatenablog.com/entry/2023/11/07/094501