

[:contents]



# kubernetes 入門


## kubernetes概要

### [kubernetesの全体像](https://minegishirei.hatenablog.com/entry/2023/09/30/131120)

Kubernetesは複数のサーバーを連携して一つのサービスを提供します。
このまとまりのことを**クラスタ**と呼びます。
(英語で「集まり、まとまり」という意味)

クラスタの内部には **コントロールプレーン**,**ノードコンポーネント(またはワーカーノード)** と呼ばれる構成要素があり、
Kubernetesのアーキテクチャを理解するためにはこれらの用語を体系的に覚える必要があります。


### [kubernetesはオンプレか?クラウドか?](https://minegishirei.hatenablog.com/entry/2023/10/11/103224)

kubernetsのセットアップに要するリソースを考えればKubernetesを利用するにはクラウド環境を利用するのがメインとなる選択肢でしょう。

### [Kubernetesの3大クラウドサービス比較](https://minegishirei.hatenablog.com/entry/2023/10/11/103313)



## kubernetesリソース一覧

### [Deploymentとは何か?](https://minegishirei.hatenablog.com/entry/2023/10/11/091715)

Kubernetesではスーパバイス（監視、監督）する必要がある個々のプログラムに対して、`Deploymentオブジェクト`が作成されます。
`Deploymentオブジェクトは以下の情報から構成されます。`

- コンテナイメージ名
- 実行したいレプリカの数
- その他コンテナを実行する際に知っておくべき情報

いわば、**デプロイメントはコンテナ単位のあるべき姿**といえます。


### [Pod とは何か?](https://minegishirei.hatenablog.com/entry/2023/10/11/091855)

Podとは、一つ以上のコンテナのグループを表すKubernetesオブジェクトのことです。
Podはクジラの小さい群れを表す言葉であり、派生してKubernetesのPodはコンテナのグループを表しています。




### [ReplicaSetとは何か?](https://minegishirei.hatenablog.com/entry/2023/10/13/091443)

ユーザーはReplicaSetを理解している必要はなく、Deploymentの挙動を把握している必要があります。
ですが、ReplicaSetの挙動を把握しておくことは実運用上のトラブルシューティングなどで役に立つことがあります。

ReplicaSetの仕事は、Deploymentの変更を受けてPodを管理することにあります。
Deploymentが直接Podを変更しないのは、ローリングアップデートなどのデプロイ戦略に対応するためです。（例えば、RplicaSetをバージョニングすることで、古いReplicaと新しいReplicaをコントロールし、複数のPodをローリングアップデートすることが出来ます。）



### [Namespace とは何か?](https://minegishirei.hatenablog.com/entry/2023/10/15/140051)

クラスター単位でリソースの使用状況を管理するためにはNamespaceの使用が有効です。


### [Service とは何か?](https://minegishirei.hatenablog.com/entry/2023/10/13/091613)

**Serviceリソースは単一の変化しないIPアドレス、またはDNSを付与することができ、任意の対応するPodへ自動的にルーティングさせることが出来ます。**

ServiceはWebプロキシやロードバランサのようなものと考えることができ、バックエンドであるPodのグループにリクエストを飛ばします。




### [PersistentVoluem とは何か?]()

個々のコンテナには独自のファイルシステムが存在します。
しかしこれらのファイルシステムはエフェメラルであり、再起動してしまえばその情報は失われてしまいます。

この性質上、コンテナはステートレスであり、再起動すれば必ず初期化してくれます。


ところが、より複雑なアプリケーションではストレージを永続化し、ほかのコンテナと共有したい場面が出てきます。
Kubernetesのvolumeオブジェクトはそのどちらのニーズにも対応することが出来ます。



## kubernetes コマンド集





## kubernetesリソースコントロール


### [KubernetesのCPUリソース制限方法](https://minegishirei.hatenablog.com/entry/2023/10/13/093621)

Kubernetesでは必要となるリソースを次の二つの方法を用いて指定します。

- リソース要求値（Kubernetesが必要とする最小のリソース）
- リソース制限値（Kubernetesへ許可される最大のリソース）


### [Kubernetesでのヘルスチェック方法](https://minegishirei.hatenablog.com/entry/2023/10/14/102141)

Kubernetesではコンテナのスペック管理の一部として、Liveness Probe(ライブネスプローブ)を利用できます。
言い換えればヘルスチェックが利用可能です


### [クラスタのサイズを見極める](https://minegishirei.hatenablog.com/entry/2023/10/23/221122)



page:https://minegishirei.hatenablog.com/entry/2023/10/11/103809
