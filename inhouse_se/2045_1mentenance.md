



# そもそも保守性とは

そもそも保守性とは
*機能の追加、変更、削除だけでなく、バッチファイルやフレームワークなどのアップグレードの適応も容易である性質を意味する。*

を意味する。

では保守性の低いシステムとはどのようなシステムだろうか

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

img:https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2008microservice_arch/microservice_arch.png?raw=true

category_script:page_name.startswith("2")





