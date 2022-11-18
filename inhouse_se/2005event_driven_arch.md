

## 参考

「FundamentalsOfSoftwareArchitecture.md」という記事を参考にしてます。

https://github.com/zhangjunhd/reading-notes/blob/master/software/FundamentalsOfSoftwareArchitecture.md#13service-based-architecture-style

ちなみのこの記事は「ソフトウェアアーキテクチャの基礎」という書籍の関連資料である。

<img src="https://camo.githubusercontent.com/d799cbb6d1ed1f01ab09bf1d78b29527875119b278387f64b1b583bb40458958/68747470733a2f2f696d67312e646f7562616e696f2e636f6d2f766965772f7375626a6563742f732f7075626c69632f7333333332313737382e6a7067">

(ソフトウェアアーキテクチャの基礎)[https://www.amazon.co.jp/%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2%E3%82%A2%E3%83%BC%E3%82%AD%E3%83%86%E3%82%AF%E3%83%81%E3%83%A3%E3%81%AE%E5%9F%BA%E7%A4%8E-%E2%80%95%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%8B%E3%82%A2%E3%83%AA%E3%83%B3%E3%82%B0%E3%81%AB%E5%9F%BA%E3%81%A5%E3%81%8F%E4%BD%93%E7%B3%BB%E7%9A%84%E3%82%A2%E3%83%97%E3%83%AD%E3%83%BC%E3%83%81-Mark-Richards/dp/4873119820/ref=sr_1_1?adgrpid=131625207761&gclid=Cj0KCQiA1NebBhDDARIsAANiDD2t3qdCpELaQBYWcwVkCNTRj_WZlDhp3HAMMRjFvIZR_EtRgQRvu0EaArxhEALw_wcB&hvadid=611338421233&hvdev=c&hvlocphy=1009310&hvnetw=g&hvqmt=e&hvrand=8686801961371880672&hvtargid=kwd-1637204896522&hydadcr=21901_13398700&jp-ad-ap=0&keywords=%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2%E3%82%A2%E3%83%BC%E3%82%AD%E3%83%86%E3%82%AF%E3%83%81%E3%83%A3+%E3%81%AE+%E5%9F%BA%E7%A4%8E&qid=1668749043&qu=eyJxc2MiOiIwLjcyIiwicXNhIjoiMC4wMCIsInFzcCI6IjAuMDAifQ%3D%3D&sr=8-1]

## なぜイベント駆動アーキテクチャを採用するのか？

イベント駆動型アーキテクチャスタイルは、非同期通信のみに依存するという点で、他のアーキテクチャスタイルに比べて独自の特徴を提供します。

**非同期通信は、システムの全体的な応答性を向上させるための強力な手法** です。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2005event_driven_arch/event_driven_arch.png?raw=true">

著作：「イベント駆動アーキテクチャ」より

イベント駆動アーキテクチャは**高度にスケーラブル(弾力性が高い)**で**高パフォーマンスなアプリケーションを実現できる**アーキテクチャです。

また、適応性に優れており、小規模なアプリにも大規模なアプリにも使うことができるのも特徴です。

### 非同期通信とは?

非同期通信は、ユーザー側から見た応答速度を上げるための手法です。

処理を開始した後、その処理を待たずに次の処理を開始するのが特徴。
処理の完了を待たないため、ロジックは複雑になるが、アプリケーションの軽快な動作を実現することができます。

<img src="https://cz-cdn.shoeisha.jp/static/images/article/11815/11815_1_2.png">

https://codezine.jp/article/detail/11815


## イベント駆動アーキテクチャの使用例

応答速度が旨となるシステムでリクエストベースかつ、複雑な仕様を持つ場合に使用される。

- オンラインオークションでの入札システム

- ECサイト（注文後から決済を経て発送やメール通知などをイベント通知として処理する）

- コメント投稿サイト（アプリケーションで軽快な動作を実現したい場合）



## イベント駆動アーキテクチャの構成

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2005event_driven_arch/event_driven_arch.png?raw=true">

イベント駆動アーキテクチャは分散非同期型のアーキテクチャスタイルです。
このアーキテクチャを実装したアプリケーションは、いわゆる要求ベースのモデルに従います。

1. まずこのモデルではシステムに対して行われたリクエストは全て、要求オーケストレーターに送信されます。

2. リクエストオーケストレーターはユーザーインターフェイスですが、APIレイヤーとして実装することもできます。（ブローカータイプには存在しません）
**主な役割はさまざまなリクエストプロセッサーにリクエストを送信することです。**

1. イベントプロセッサは、データベース内の情報を取得または更新して要求を処理し、どんな処理を行ったかを載せたメッセージ（イベント）を再び全体に通知します。(イベントのブロードキャスト)

2. 各イベントプロセッサは、「これは自分が処理するべきイベントだな」と判断した場合には、イベントを処理して再度どんな処理を行ったかを全体に通知します。

2. 受け取るプロセッサがいなくなるまで、処理を行います。

以下にその図を示します。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2005event_driven_arch/event_driven_arch.png?raw=true">

著作：「イベント駆動アーキテクチャ」より



## イベント駆動アーキテクチャの概要

イベント駆動アーキテクチャには、メディエータートポロジとブローカートポロジの2タイプがあります。

- メディエータートポロジは、イベントプロセスのワークフローを制御する必要がある場合に一般的に使用されます。(メディエイターとは、調停者という意味でワークフローを調節する役割を持ちます。)

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2005event_driven_arch/mediator.png?raw=true">


- ブローカートポロジは、イベントの処理に対して高度な応答性と動的制御を必要とする場合に使用されます。全体を管理するメディエイターという存在がいません。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2005event_driven_arch/broker.png?raw=true">





## イベント駆動アーキテクチャの「イベント」について

イベント駆動アーキテクチャを理解するために必要なのは、**イベント**という考え方を理解することです。

イベント駆動アーキテクチャの「イベント」とは次の二つの解釈が可能です。

- イベント通知

このイベントとは「何かが発生したこと」を意味します。

- コマンド

この「コマンド」とは「何か命令がある」という意味で、「メッセージ」とも受け取ることができます。

**イベント駆動アーキテクチャにおけるイベントとは、この二つの側面があり、ある意味でこのイベントこそがイベント駆動アーキテクチャの強みとなっているのです。**

- イベントを発生される側から見た場合。イベントを処理した後の結果は、「産まれてしまったもの」なので通知です。

- イベントを受け取る側から見た場合。イベントを処理するためのメッセージは、「どんな処理をするべきか書いてある」のでコマンドです。

いずれにせよ、イベントアーキテクチャにおけるイベントとは、メッセージであり、コマンドなのです。



# イベント駆動アーキテクチャ - ブローカータイプ -

ブローカートポロジは、中央イベントメディエーターがないという点でメディエータートポロジとは異なります。

よく使われるのは、

- オンラインオークションに入札するような単純なイベント
- 転職や結婚などの健康給付システムにおけるより複雑なイベント

などです。

**とにかく高速な処理を行いたい場合**に採用されます。**メディエイターなどの調停者を挟まない方が早くなるからです。**

メディエイターがあっても全体の応答速度は悪くないですが、ブローカータイプには及びません。

### イベント駆動アーキテクチャのブローカータイプの実装方法

イベント駆動アーキテクチャでは、軽量の**メッセージブローカー**と呼ばれるものを介して、チェーン状のブロードキャスト方式で処理を行う。

- RabbitMQ

- ActiveMQ

- HornetQ

<img src="https://activemq.apache.org/assets/img/competing-consumers.png">

https://activemq.apache.org/clustering



## ブローカータイプの構造

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2005event_driven_arch/mediator.png?raw=true">

1. リクエストを受け付けた後、開始イベントは、メッセージブローカーに送られます。

2. イベントを管理および制御するブローカー・トポロジーでは、単一のイベント・プロセッサーがイベント・ブローカーからの開始イベントを受け入れ、そのイベントの処理を開始します。

3. 開始イベントを受け入れたイベントプロセッサは、そのイベントの処理に関連する特定のタスクを実行します。

4. その後、再度処理イベントと呼ばれるものを作成することによって、システムの残りの部分にそれが行ったことを非同期的に連絡します。

5. イベント通知は再度、メッセージブローカに送られます。

このプロセスは、**最終的なイベントプロセッサが何をしたかに誰も興味がなくなるまで**続きます。


## ブローカータイプのメリット

このアーキテクチャにおいてイベントプロセッサがイベント通知を発火する際、他のイベントプロセッサがどう受け取るかを考えずにイベント通知をブロードキャストします。

これはとても良い設計です。
なぜならこの方法は、**システム改修時点でそのイベントの処理に追加の機能が必要な場合に、アーキテクチャの拡張性を提供します。**

### ブローカータイプの開発事例例

*たとえば、複雑なイベントプロセスの一部として、電子メールが生成され、実行された特定のアクションを顧客に通知するとします。*

通知イベントプロセッサは、

1. 電子メールを生成して送信し

2. 通知のブロードキャストを通じて、そのアクションをシステムの残りの部分に連絡します。

この場合、他のイベントプロセッサはそのトピックに関するイベントをリッスンしていないため、メッセージは単に消えます。

<img src="https://camo.githubusercontent.com/d4bd92486e086815436e9c4e434f4ef7402e559136108e71a68585ae396663cf/68747470733a2f2f6c6561726e696e672e6f7265696c6c792e636f6d2f6c6962726172792f766965772f66756e64616d656e74616c732d6f662d736f6674776172652f393738313439323034333434372f6173736574732f666f73615f313430332e706e67">

これは、アーキテクチャの拡張性の良い例です。

無視されるメッセージを送信するリソースの浪費のように見えるかもしれませんが、そうではありません。

*ex) 例えばここで、顧客に送信された電子メールを分析するための新しい要件が発生したとします。*

この新しいイベントプロセッサは、インフラストラクチャを追加したり、他のイベントプロセッサを変更を適用したりする必要がないのです。

電子メールトピックを介して新しいアナライザに電子メール情報を提供できるため、最小限の労力でシステム全体に追加できます。

*あたかも、プラレールのレールの出っ張りが、現時点で途切れていてもいつか来る接続に必要であるように。*


<img src="https://www.takaratomy.co.jp/products/plarail/lineup/rail/images/r_01.jpg">


# イベント駆動アーキテクチャ メディエイターパターンとは

イベントメディエーターは前節で説明したブローカートポロジーの欠点をいくつか解消できる。

イベントメディエーターパターンの中心には常に「イベントメディエーター」というコンポーネントが存在する。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2005event_driven_arch/mediator.png?raw=true">

このイベントメディエーターは、**イベント処理に必要なステップを知っており、対応する処理イベントを生成してP2Pのメッセージング方式でイベントチャネルに送信する。**

イベントチャネルは受け取ったメッセージをもとに処理を実施するが、**完了した報告をイベントメディエーター**に行う。


## イベントメディエイターの実装方法

イベントメディエーターは次のいくつかの候補がある

- Apache Camel

- Mule

- Spring Integration

これらのOSSソフトウェアは、単純なエラー処理とオーケストレーションが可能になっている。

<img src="https://spring.pleiades.io/spring-integration/docs/current/reference/html/images/cafe-eip.png">

(Spring Intergration)[https://spring.pleiades.io/spring-integration/docs/current/reference/html/samples.html]

しかし、さらに複雑な処理が必要な場合、次の二つのイベントメディエーターが候補に上がる。

- [Apache ODE](https://ode.apache.org/)

- [Oracle BPEL Process Manager](https://docs.oracle.com/cd/E18355_01/integrate.1013/B31876-01/intro.htm)

多くの条件付きの処理や複雑なエラー処理の指示を伴う複数の動的パスが発生する場合には、これらのメディエーターが候補になるだろう。

<img src="https://docs.oracle.com/cd/E18355_01/integrate.1013/B31876-01/xipig003.gif">

(Oracle BPEL Process Manager)[https://docs.oracle.com/cd/E18355_01/integrate.1013/B31876-01/intro.htm]

これらのメディエーターは Business Process Execution Language(BPEL)に基づいたかなり高レベルなビジネスプログラミングが可能になっている。

BPELとは、イベント処理のステップを記述した**XMLライクな構文**である。
その中には、エラー処理、リダイレクション、マルチキャストなどに使用される構造化要素も含まれる。
BPELの習得は困難なため、通常は製品に含まれるBPELエンジンで自動生成される。



## イベント駆動アーキテクチャのエラー処理

コンポーネント同士で意思の疎通が取れない場合はどうすれば良いか。

それは以下のように、エラー時に通常のコンポーネントではなく、エラーを処理するコンポーネントに送ることで対応が可能である。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2005event_driven_arch/dashboard.png?raw=true">

エラーを処理するコンポーネントでは、通常GUIとしてダッシュボードなどに表示される。

ダッシュボードにはエラーメッセージと、エラーを起こした処理が表示される。

このエラーを人間が手で修正し、再度エラーを起こしたコンポーネントに送信することで処理が可能である。


(ソフトウェアアーキテクチャの基礎)[https://www.amazon.co.jp/%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2%E3%82%A2%E3%83%BC%E3%82%AD%E3%83%86%E3%82%AF%E3%83%81%E3%83%A3%E3%81%AE%E5%9F%BA%E7%A4%8E-%E2%80%95%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%8B%E3%82%A2%E3%83%AA%E3%83%B3%E3%82%B0%E3%81%AB%E5%9F%BA%E3%81%A5%E3%81%8F%E4%BD%93%E7%B3%BB%E7%9A%84%E3%82%A2%E3%83%97%E3%83%AD%E3%83%BC%E3%83%81-Mark-Richards/dp/4873119820/ref=sr_1_1?adgrpid=131625207761&gclid=Cj0KCQiA1NebBhDDARIsAANiDD2t3qdCpELaQBYWcwVkCNTRj_WZlDhp3HAMMRjFvIZR_EtRgQRvu0EaArxhEALw_wcB&hvadid=611338421233&hvdev=c&hvlocphy=1009310&hvnetw=g&hvqmt=e&hvrand=8686801961371880672&hvtargid=kwd-1637204896522&hydadcr=21901_13398700&jp-ad-ap=0&keywords=%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2%E3%82%A2%E3%83%BC%E3%82%AD%E3%83%86%E3%82%AF%E3%83%81%E3%83%A3+%E3%81%AE+%E5%9F%BA%E7%A4%8E&qid=1668749043&qu=eyJxc2MiOiIwLjcyIiwicXNhIjoiMC4wMCIsInFzcCI6IjAuMDAifQ%3D%3D&sr=8-1]


## イベント駆動アーキテクチャの総評

ワークフローの確実性と制御が必要な場合は、適切に構造化されたデータ駆動型のリクエスト（顧客プロファイルデータの取得など）に対してリクエストベースのモデルを選択することをお勧めします。

例えば、ECの注文処理など。

複雑で動的なユーザー処理を伴う、高レベルの応答性とスケールを必要とする柔軟なアクションベースのイベントには、イベントベースのモデルを選択しましょう。

<img src="https://camo.githubusercontent.com/85abc7ad3f27c612cd839e532b0b2bcfd00a45888cb09f18282bcf2be7bc9ff3/68747470733a2f2f6c6561726e696e672e6f7265696c6c792e636f6d2f6c6962726172792f766965772f66756e64616d656e74616c732d6f662d736f6674776172652f393738313439323034333434372f6173736574732f666f73615f313432322e706e67">



## 備考

title:イベント駆動アーキテクチャのメリットとデメリットと使用例

description:イベント駆動型アーキテクチャスタイルは、非同期通信のみに依存するという点で、他のアーキテクチャスタイルに比べて独自の特徴を提供します。非同期通信は、システムの全体的な応答性を向上させるための強力な手法です。

img:https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2005event_driven_arch/event_driven_arch.png?raw=true

category_script:(page_name.startswith("2") or page_name.startswith("1"))

参考資料：https://qiita.com/Suzuki_Cecil/items/a51d353c73e9277f46d8


