
## ソースコードの再利用性を高める

前回までの内容

[https://minegishirei.hatenablog.com/entry/2023/02/02/163154:embed:cite]

前回までの内容で、コンポーネントの機能を増減させて適切なサイズにウェイト調節しました。

今回は、**共通のサービスを特定・統合することで、ソースコードの再利用性を高める。**

- [ソースコードの再利用性を高める](#ソースコードの再利用性を高める)
- [ソースコードの共通部分とは](#ソースコードの共通部分とは)
- [ソースコードの共通部分を発見する](#ソースコードの共通部分を発見する)
  - [共通部分発見方法1. 類似コードをVisual Studioで発見する](#共通部分発見方法1-類似コードをvisual-studioで発見する)
  - [共通部分発見方法2.類似している名前空間を検出する](#共通部分発見方法2類似している名前空間を検出する)
- [共通部品の抜き出しの注意事項](#共通部品の抜き出しの注意事項)
- [備考](#備考)



## ソースコードの共通部分とは

今回抜き出す「ドメインで共通するコンポーネント」とは、「処理ロジックの一部だけで共有されるコンポーネント」であり、基盤機能とは異なる。

基盤機能とは、ログやメトリクスの収集、セキュリティなどの運用特性を持つ、*全てのコンポーネントで共通の機能*のことです。

アプリケーションで重複しているドメインごとに似通った処理は、ごく僅かな違いしかないことが多いです。
この僅かな違いについてはドメインごとで対応してもらい似通った処理は一つのサービスやコンポーネントにすることで、再利用性を高めることができる。

- 例えば、顧客通知コンポーネントがシステム内部に5つあった場合、システム全体の通知機能を変更する場合でも、まとめておくことで一回の変更で全てのコンポーネントを更新できる。

- 別の例だと、監査のために必要なコンポーネントをまとめることも考えられる
    - コンサーチチケット監査(penultimate.tiket)
    - チケット閲覧機能監査(penultimate.read_tiket)
    - 購買履歴監査(penultimate.history)


## ソースコードの共通部分を発見する

共通部分を特定してドメイン機能かインフラ機能として分類する作業は、人間の目がなければかなり難しい。
とはいえ、**ソースコードのコピー&ペーストや似通った機能を見つけるためのライブラリは日々充実してきている。**


### 共通部分発見方法1. 類似コードをVisual Studioで発見する

例えば、C#をVisual Studioで利用する場合、次の手順でコードクローンを検出することができる。

1. VSでチェックしたいソリューションを開く

2. 「分析」→ 「ソリューションのコード クローン分析」をクリック

3. 分析結果をチェック

<img src="https://i0.wp.com/gowthamcbe.com/wp-content/uploads/2020/05/Matching-Clones.png?w=600&ssl=1">

<img src="https://i0.wp.com/gowthamcbe.com/wp-content/uploads/2020/05/Compare.png?w=600&ssl=1">

<img src="https://i0.wp.com/gowthamcbe.com/wp-content/uploads/2020/05/compare-result.jpg?w=1285&ssl=1">

from https://qiita.com/soiyayios/items/504a3f9951b99f7e140c , https://gowthamcbe.com/2020/05/14/code-clone-analysis-tool-in-visual-studio/

**完全一致のみではなく、やや似ているものもピックアップしてくれる**
そのため、コピーアンドペーストの検知だけでなく、ロジック単位の検知が可能だ。

### 共通部分発見方法2.類似している名前空間を検出する

次のコードは、名前空間のコンポーネントが同じものを検知してくれる疑似コードである。
自分のソースコードを管理できるパワーシェルやパイソンなどのスクリプト言語を扱えれば、ソース管理の手間はかなり削減される。

```py
# Walk the directory structure, creating namespaces for each complete path
LIST component_list = identify_components(root_directory)
# Locate possible duplicate component node names that are not in the exclusion
# list stored in a datastore
LIST excluded_leaf_node_list = read_datastore()
LIST leaf_node_list
LIST common_component_list
FOREACH component IN component_list {
    leaf_name = get_last_node(component)
    IF leaf_name IN leaf_node_list AND
    leaf_name NOT IN excluded_leaf_node_list {
        ADD component TO common_component_list
    } ELSE {
        ADD leaf_name TO leaf_node_list
    }
}
# Send an alert if any possible common components were found
IF common_component_list NOT EMPTY {
    send_alert(common_component_list)
}
```

from file:///Users/minegishirei/Downloads/Software.Architecture.The.Hard.Parts.Neal.Ford.OReilly.9781492086895.EBooksWorld.ir%20(1).pdf


## 共通部品の抜き出しの注意事項

部品を共通化する際には一つ注意点がある。

それは、**一つのコンポーネントに極端に依存する**という状況が発生することである。

例えば、顧客への通知を行う次の三つのコンポーネントがあったとする。

- 顧客通知:結合数2
- チケット通知:結合度2
- アンケート通知:結合度1

この状況で、この三つを「通知」というコンポーネントに役割を任せるとどうなるか

- 通知:結合度**5**

このように、三つのコンポーネントに結合が分散していた状況から、通知コンポーネント一つに対する結合が集中してしまった。
「通知機能」という性質上、このコンポーネントの変更が他のコンポーネントに対する大規模な影響は与えないと予測できる。
（「通知」はゴールであるため、返り値を返さないため影響はでないと予測できる）
しかし、**共通ドメイン機能を一つのコンポーネントに結合するということは、そのコンポーネントへの依存度が高くなりすぎる可能性がある**

この問題に対する答えはなく、開発チームとのミーティングで決定するしかない。








## 備考

title:ソースコードの共通部品を抜き出す【リファクタリング入門2】

description:ソースコードの共通部分を部品として抜き出し、部品化することは再利用を促し、リファクタリングに確実につながる

img:https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/3063/breakdown.png?raw=true

category_script:page_name.startswith("3")



