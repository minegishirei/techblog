




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



## kubernetes基本事項

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








page:https://minegishirei.hatenablog.com/entry/2023/10/11/103809
