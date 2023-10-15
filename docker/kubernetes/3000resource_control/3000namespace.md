



# KubernetesのNamespaceリソースとは何か?

一台のマシンに複数の環境を構築する場合、どのようにリソースを分配すれば良いのでしょうか?
クラスター単位でリソースの使用状況を管理するためには`Namespace`の使用が有効です。

例えば、以下のように環境ごとに`namespae`で区切ることができます。

- 本番用のアプリケーションには`prod`ネームスペースで運用
- 検証用環境のアプリケーションには`test`ネームスペースで運用

この場合、`prod`namespaceで`kkkapp`というサービスを運用し、`test`namespaceで`kkkapp`というサービスを運用したとしても名前の競合は発生しません。

**Namespaceはリソースをグループ化することが可能なのです**

ただし、Namespaceのネストはできません。


## Namespaceのメリット

KubernetesではNamespaceを活用してリソース管理することで、次のような恩恵を受けることができます。

- 名前の競合が発生しなくなる。
- Namespace単位でCPUリソースの上限の設定が可能。
- Namespaceを一時的な仮想クラスタとして使用し、Namespaceごと消去することも可能
- Namespaceごとにユーザーパーミッションを導入することができる。
- Namespace同士でDNSを使用することも可能。


## デフォルトのNamespace

特にNamespaceを使用しない場合、常にデフォルトのNamespace `default` Namespaceが適応されます。

デフォルトの代わりに`--namespace`オプションを使用することで、コマンドで使用されるリソースにはそのNamespaceが適応されます。
例えば、`test`環境の名前空間のpodsを取得したい場合、以下のようなコマンドになります。

```sh
kubectl get pods --namespace prod
```

または、省略形の`-n`オプションも使用可能です。

```sh
kubectl get pods -n prod
```


## Namespaceの作成方法

`test`Namespaceを使用する場合、次のようなリソースファイルを作成することができます。

```yml
apiVersion: v1
kind: Namespace
metadata:
  name: test
```

このリソースファイルを`kubectl apply -f (リソースファイル名)`で適応することでNamespaceが作成されます。

またはマニフェストを使わずにNamespaceを作成する場合、
`kubectl create namespace`コマンドが使用可能です。
例えば、`test`Namespaceを作成したいときは次のコマンドを実行します。

```sh
kubectl create namespace test
```



## Serviceのアドレス

KubernetesのServiceリソースには全て、外部との通信に使用できるDNS名が関連付けられます。

例えば、Namespace`test`内部にある`demo`Serviceと通信したい場合、次のドメインにアクセスすることで通信ができます。

```
demo.test
```



## Namespaceによるリソース制限

Namespace単位でのリソースを制限することも可能です。
コレを行うためには`ResourceQuota`リソースを使用します。

```yml
appVersion: v1
kind: ResourceQuota
metadata:
  name: demo-resourcequota # ただのコメント
spec:
  hard:
    pods: "100"
```

上記のマニフェストではあるNamespace内部で同時に実行できるPodの数を100に制限するハードリミットが設定されます。
ただ、リソースファイル内部にはどのNamespaceに適応するかは書かれていません。

上記のymlファイルを保存した後、次の`apply`コマンド実行時に`--namespace`オプションを使用することで初めて適応されます。


```sh
kubectl apply --namespace demo -f (ymlファイル名)
```









page:https://minegishirei.hatenablog.com/entry/2023/10/15/140051?_gl=1*1y35ymm*_gcl_au*NTQ2MzIzOTE5LjE2OTA2MTM2MDk.

