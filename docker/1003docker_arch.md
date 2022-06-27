


## dockerのアーキテクチャ

![picture 1](../images/8567a62f0311bcae712b5471f3168ef0f945bac68d9bcd57e595d550cb575733.png)  


## Dockerデーモン

中心にあるのはDockerデーモンで、これはDockerコンテナの作成、実行、
コンテナの監視、画像の作成と保存などを行います。

Dockerデーモンを実行は通常、ホストOSによって処理されます。

![picture 1](../images/8567a62f0311bcae712b5471f3168ef0f945bac68d9bcd57e595d550cb575733.png)  


## Dockerクライアント

Dockerクライアントは左側にあり、Docker daemonとの通信に使用されます。
デフォルトでは、これはUnixドメインソケットで発生しますので、TCPソケットを使用して、リモートクライアントまたはsystem dmanagedソケットのファイル記述子を有効にして対応できます。

すべての通信はHTTPを介して行われる必要があるため、構造的には簡単です。

リモートのDockerデーモンに接続し、プログラミング言語のバインドを利用することもできます。

ただし、リモートのDockerデーモンに繋がるには
「ビルドコンテキスト」で説明されているように、Dockerfilesのビルドコンテキストが必要です。


![picture 1](../images/8567a62f0311bcae712b5471f3168ef0f945bac68d9bcd57e595d550cb575733.png)  



## Dockerレジストリとは

![picture 4](../images/904f01cfbf2c46c701f3c6aaa753a92f162f7c9fd1dfa5eeacb01dd14c3572f9.png)  


Dockerレジストリは、イメージを保存および配布します。デフォルトのレジストリはDocker Hubです。

Docker Hubは何千もの公開dockerイメージと厳選された「公式」Dockerイメージをホストします。

また、多くの組織は、Dockerイメージを保存するために使用できる独自のレジストリを実行しています。
これは機密なDockerイメージをダウンロードする必要があるというだけでなく、オーバーヘッドを回避する役割を果たします。


## Dockerの周辺技術

DockerエンジンとDockerHubは、それ自体では構成されません。

コンテナを操作するための完全なソリューションのために、ほとんどのユーザーは、周辺技術が必要であることに気付くでしょう。

つまりはクラスタ管理、サービス検出ツールなどのサービスとソフトウェアの移植、高度なネットワーク機能が必要なのです。

Docker Inc.は、これらの機能を含む完全なすぐに使えるソリューションを構築することを計画していますが、ユーザーはデフォルトのコンポーネントをサードパーティのコンポーネント(つまりDOcker社以外の個人、団体が作成した技術）に簡単に交換できます。

「交換可能なバッテリー」戦略とは、主にAPIレベルを指し、それによりcompositを可能にします。

ここでは代表的なものを3つほど紹介します。


## Docker Compose

![picture 3](../images/1f09f52f9797c963e06a699b79ab17350e3c340e68fb2f1940a1cc1efcf18645.png)  

Docker Composeは、複数のDockerコンテナで構成されるアプリケーションを構築および実行するためのツールです。

これは主に開発とテストで使用され、プロダクトとして本番運用の段階では使用されません。




## Kitematic

![picture 2](../images/cf4ba703d3d0e8998faea9aedbb2c580085e59e6ef0f386985eb7401c42d758f.png)  


Kitematicは、Dockerを実行および管理するためのMacOSおよびWindowsGUIです。
コンテナ




## Docker Trusted Registry

![picture 5](../images/a84a409d3dee1970360864f28bd7155e6e007cf098d97e716e177326bba8938c.png)  


DockerIncの唯一の非オープンソース製品です。

Dockerイメージを保存および管理するためのDockerのオンプレミスサーバーのことです。

多くの組織では既存のセキュリティと統合できるDockerHubのローカルバージョンを用意する必要があります。

また、提供する機能には、メトリック、ロールベースのアクセス制御が含まれます。

RBACとログは、すべて管理コンソールを介して管理されます。これはcur-です

ただしこれはGitlabなどに置き換えることもできます。





## オーケストレーションとクラスター管理

![picture 6](../images/47e3aa2b0a33dc6141437d2726107f1ea9887347a0519e0c4e6646a1c6ef7b69.png)  

参考：https://kubernetes.io/ja/docs/concepts/overview/components/

大規模なコンテナの本番環境の動作では、監視と管理のためにツールが不可欠です。オーケストレーションはシステムをスケーリングし、新しいコンテナはそれぞれ別々のホストに配置し、監視し、更新するツールが必要です。

また、システムは、障害や負荷の変化に対して対応する必要があります。
その際には、コンテナを適切に開始または停止します。

オーケストレーションエンジンにはすでにいくつかの製品の候補があります。

GoogleのKubernetes、CoreOSのfreet、Docker独自のSwarmツールなどです。

2022年でこの中で最も有力かつ書籍や参考文献が多いのはGoogleのKubernetesです。




title:dockerのアーキテクチャ概要【docker入門】



img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-776-8.jpeg

category_script:True

