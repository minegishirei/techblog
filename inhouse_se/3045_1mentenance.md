

## この記事の説明

機能の追加、変更、削除だけでなく、バッチファイルやフレームワークなどのアップグレードの適応も容易である性質を意味する。では保守性の低いシステムとはどのようなシステムだろうか


- [この記事の説明](#この記事の説明)
- [そもそも保守性とは](#そもそも保守性とは)
- [保守性の低いシステム一覧(私見あり)](#保守性の低いシステム一覧私見あり)
  - [詳細](#詳細)
- [保守性の高いシステム一覧](#保守性の高いシステム一覧)
  - [詳細](#詳細-1)
- [保守レベル0:大規模なモノシリックなシステムは保守性が低い](#保守レベル0大規模なモノシリックなシステムは保守性が低い)
- [保守レベル50:サービスベースなシステムは保守性が比較的高い](#保守レベル50サービスベースなシステムは保守性が比較的高い)
- [保守レベル100:マイクロサービスなシステムは保守性が高い](#保守レベル100マイクロサービスなシステムは保守性が高い)
- [まとめ:モジュール化が進めばメンテナンス性、保守性が向上する](#まとめモジュール化が進めばメンテナンス性保守性が向上する)


## そもそも保守性とは

そもそも保守性とは

> 機能の追加、変更、削除だけでなく、バッチファイルやフレームワークなどのアップグレードの適応も容易である性質

を意味する。

では保守性の低いシステムとはどのようなシステムだろうか

## 保守性の低いシステム一覧(私見あり)

保守性の低いアーキテクチャは例えば以下のようなもの

- [レイヤードアーキテクチャ](https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/layerd1.png?raw=true)
- [パイプラインアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2002pipline_arch.md)
- [イベント駆動アーキテクチャ](https://techblog.short-tips.info/inhouse_se/2005event_driven_arch.md)

詳細は後ほど

### 詳細

- [レイヤードアーキテクチャ](https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/layerd1.png?raw=true)

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/layerd1.png?raw=true">

このシステムは技術による分割がメインであり、一つの事業の変更がシステムの全てに反映される。


- [パイプラインアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2002pipline_arch.md)

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2002pipline_arch/pipline.png?raw=true">

議論の余地ありで再利用性が高いが、個人的には保守性は高くない。


- [イベント駆動アーキテクチャ](https://techblog.short-tips.info/inhouse_se/2005event_driven_arch.md)

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2005event_driven_arch/event_driven_arch.png?raw=true">

議論の余地ありだが、応答速度に特化したイメージ。




## 保守性の高いシステム一覧

- [プラグインアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2003micro_kernel.md)
- [サービスベースアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2004service_base_arch.md)
- [スペースベースアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2006space_base_arch.md)
- [マイクロサービスアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2008microservice_arch.md)


### 詳細

- [プラグインアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2003micro_kernel.md)

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2003micro_kernel/micro_kernel.png?raw=true">

モノシリックの中では保守性が最も高い。プラグインとして機能が独立しているため、改修後の変更範囲が狭く、予測しやすい。

- [サービスベースアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2004service_base_arch.md)

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2004service_base_arch/service_base_arch.png?raw=true">
後述

- [スペースベースアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2006space_base_arch.md)

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2006space_base_arch/space_base_arch.png?raw=true">
</a>

処理ユニットごとにドメインが決まっている場合、一つの事業的な変更が処理ユニット内部に収まる。


- [マイクロサービスアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2008microservice_arch.md)

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2008microservice_arch/microservice_arch.png?raw=true">

後述


## 保守レベル0:大規模なモノシリックなシステムは保守性が低い

一般に、**大規模なモノシリックなシステムは保守性が低いと言われる。**

これは以下の理由が挙げられる。

1. 機能をレイヤーで技術的に分割していること

2. コンポーネント同士の結合度(依存度)が高いこと

3. ドメインの観点から見た時の凝縮度が低いこと

が挙げられる。

<a href="https://techblog.short-tips.info/inhouse_se/2000software_arc.md">
<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/layerd1.png?raw=true">
</a>

from https://techblog.short-tips.info/inhouse_se/2001layerd_arch.md

例えばこのようなレイヤードなシステム（モノシリックなシステムの一種で画面、ロジック、データベースの3つの層で分ける技術的な分割のなシステム）に「有効期限データを追加する」という変更を行うとする。

1. 新しい有効期限を画面に出力するために、フロントエンド一人が必要

2. 有効期限に関するビジネスルールを制御するコードをロジック層に追加するバックエンド一人が必要

3. データベーステーブルを変更するデータベースメンバー一人が必要

このうえ、**有効期限データを追加以外にもどこに変更が及ぶのかが明確でないため、変更した際の影響範囲の予測が難しく、リリース時のエラーが発生しうる**

このように、特定のドメインがシステム全てに広がっている場合はそのメンテナンスは難しくなる


## 保守レベル50:サービスベースなシステムは保守性が比較的高い

次の例は、保守性の比較的高いサービスベースなシステムの例である

`一般的に、中央でデータベースを構えているという点が、このアーキテクチャの重要な側面である。 これより、元来使われてきたモノシリックなサービスでのSQLクエリの結合を活用できる。`

`サービスベースアーキテクチャは、マイクロサービスアーキテクチャの要素もある、分散型のアーキテクチャだ。`

<a href="https://techblog.short-tips.info/inhouse_se/2004service_base_arch.md">
<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2004service_base_arch/service_base_ui_base.png?raw=true">
</a>

from https://techblog.short-tips.info/inhouse_se/2004service_base_arch.md

先ほどの要件の変更範囲は、特定のドメインサービス内に収まっている。
ドメインを変更した際に、別のドメインに影響がないことがうかがえる。


## 保守レベル100:マイクロサービスなシステムは保守性が高い

次の例は、サービスベースなシステムをさらに進化させたマイクロサービスシステムの例である。

`マイクロサービスは分散システムを形成し、各サービスは独自のプロセスで実行されます。 「各サービスのプロセス」とは元々は物理コンピューターを意味していましたが、すぐに仮想マシンとコンテナーに進化しました。`

<a href="https://techblog.short-tips.info/inhouse_se/2008microservice_arch.md">
<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2008microservice_arch/microservice_arch.png?raw=true">
</a>

要件の変更範囲は機能レベルとなり、変更は追加機能部分に責務を持つ特定のサービスのみとなる。


## まとめ:モジュール化が進めばメンテナンス性、保守性が向上する

システムのモジュール性の度合いが上がると、機能の追加や変更、削除が容易になり、メンテナンス性が向上する。







title:保守性の高いシステムと低いシステムの違い

description:機能の追加、変更、削除だけでなく、バッチファイルやフレームワークなどのアップグレードの適応も容易である性質を意味する。を意味する。では保守性の低いシステムとはどのようなシステムだろうか

img:https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/3045/five.png?raw=true

category_script:page_name.startswith("3")





