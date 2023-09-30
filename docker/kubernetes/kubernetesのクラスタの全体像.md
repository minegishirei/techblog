




# Kubernetesのクラスタの全体像

Kubernetesは複数のサーバーを連携して一つのサービスを提供します。
このまとまりのことを**クラスタ**と呼びます。
(英語で「集まり、まとまり」という意味)

クラスタの内部には**コントロールプレーン**,**ノードコンポーネント(またはノード)**と呼ばれる構成要素があり、
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


## ノードのコンポーネント

`ノードのコンポーネント`とは実際に実行されるサービスのこと。通常はDockerコンテナが動く。(別名`Kubernetes Work Nodes`)

<img src="https://github.com/minegishirei/techblog/blob/main/docker/kubernetes/img/3_kubernetes_nodes.png?raw=true">

Kubenetesのノードコンポーネントの構成要素は以下のとおりです。

- `kubelet` : コントローラーによってスケジューリングされたコンテナを実際に運用する、クラスター内の各ノードで実行されるエージェントです。
- `kube-proxy` : `kubernetes`専用のネットワークプロキシです。
- `コンテナランタイム` : 実際に起動されるコンテナです。これは`kubelet`によって起動されます。

























