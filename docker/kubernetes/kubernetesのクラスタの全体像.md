


[:contents]



### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)


# Kubernetesのクラスタの全体像

Kubernetesは複数のサーバーを連携して一つのサービスを提供します。
このまとまりのことを**クラスタ**と呼びます。
(英語で「集まり、まとまり」という意味)

クラスタの内部には**コントロールプレーン**,**ノードコンポーネント(またはワーカーノード)**と呼ばれる構成要素があり、
Kubernetesのアーキテクチャを理解するためにはこれらの用語を体系的に覚える必要があります。


## Kubernetesのクラスタの構成要素

全体像は以下のとおりです。

<img src="https://github.com/minegishirei/techblog/blob/main/docker/kubernetes/img/1_kubernetes_cluseter.png?raw=true" alt="Kubernetesのクラスタの全体図">


Kubernetesのクラスタの構成要素は以下のとおりです。

- `コントロールプレーン` : クラスタの頭脳でコンテナのオーケストレーション（全体の指揮）を行う。(別名`Kubernetes Master`)
- `ノードのコンポーネント` : 実際に実行されるサービスのこと。通常はDockerコンテナが動く。(別名`Kubernetes Work Nodes`)




## Kubernetesのコントロールプレーンについて

Kubenetesのコントロールプレーンは以下のコンポーネントから構成されます。

- `kube-apiserver` : コントロールプレーンの本体と言えるサーバーでAPIリクエストを受け付け、クラスタを修正します。
    - 実際にはコマンド`kube-ctl`を実行することで`kube-apiserver`へAPIリクエストを投げることでクラスタの修正を行います。
- `etcd` : Kubernetes内部に存在するノードの情報、リソースの詳細などの情報を貯めるデータベース
- `kube-controller-manager` : 新しいPodを生成したり、新しいEndpointを生成したりします。
- `kube-scheduler` : 生成されるPodの場所を決定する。（リソースの生成自体は`controller-manager`で行いますが、`kube-scheduler`は生成場所を決定します。
    - その時の様々なリソースの状況を見たり、ユーザーが指定したPodのスケジュールの制約を鑑みたりしつつ、Podに最適なNodeを決定しています。
- `cloud-controller-manager` : クラウドプロバイダとやりとりをするためのサービスです。


<img src="https://github.com/minegishirei/techblog/blob/main/docker/kubernetes/img/2_kubernetes_control.png?raw=true">


### コントロールプレーンの障害対応

コントロールプレーンのサービスが落ちた場合、すぐにアプリケーションがしてしまうことはあり終了してしまうことはありません。なぜならコントロールプレーンの役割は「アプリケーションのコントロール」であり、本体であるワーカーノードはしばらくは正常に動作するでしょう。

ところが、「新しいコンテナのデプロイ」や「Kubernetesリソースの更新」はコントロールプレーンを通してワーカーノードへ伝えられるのでできなくなります。

そのため、**コントロールプレーンには高い可溶性が求められます。** アプリケーションに求められる要件によって変わりますが、**通常はコントロールプレーンは3つ以上存在することが求められるでしょう**

### コントロールプレーンの障害対応

kubernetesはコントロールプレーンが常にワーカーノードを監視しているため、高い可用性を維持できます。

ですがこの高可用性に対して、常にテストは必要です。
事前に予定されているメンテナンス時間内、
または夜間停止期間帯に**ワーカーノードを一つリブートして何が起こるかを観察するのです。** 全く何も起こらなければ成功となります。

あるいは**コントロールプレーンの一つをリブートする**のも一つの手です。
きちんとしたkubernetesの構成であれば何事もなく乗り切れるはずです。



## ノードのコンポーネント

`ノードのコンポーネント`とは実際に実行されるサービスのこと。通常はDockerコンテナが動く。(別名`Kubernetes Work Nodes`)

<img src="https://github.com/minegishirei/techblog/blob/main/docker/kubernetes/img/3_kubernetes_nodes.png?raw=true">

Kubenetesのノードコンポーネントの構成要素は以下のとおりです。

- `kubelet` : コントローラーによってスケジューリングされたコンテナを実際に運用する、クラスター内の各ノードで実行されるエージェントです。
- `kube-proxy` : `kubernetes`専用のネットワークプロキシです。
- `コンテナランタイム` : 実際に起動されるコンテナです。これは`kubelet`によって起動されます。


### ワーカーノードの障害体制

ワーカーノードの障害発生は大きな問題にはなりません。
Kubernetesがコントロールプレーンが障害を察知してあるべき状態に戻してくれます。

ただ、大量のワーカーノードで障害が発生したときはサービスが利用不可能になる可能性はあります。(クラウドの一つのアベイラビリティゾーンがすべて使用不可能になるなど。)
そのため、**kubernetesのワーカーノードは複数のアベイラビリティゾーンで運用することが優れた運用方法となります**























