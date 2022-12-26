

モノシリックなアプリケーションを分散アーキテクチャに移行する際には次の3つの質問に答えられる様にしておく必要がある。

- 既存のアプリケーションは分解可能なのか？

- 必要なのはコードの書き直しなのか？それともリファクタリングなのか？

- 移行にかかる費用はどれくらいなのか？

例えば、CIOから次の様に質問が飛んで来るかもしれない

```
複雑なモノシリックアプリケーションをマイクロサービスにする移行作業にて、プロジェクトの初日CIOに次のことを尋ねられた。
「このプロジェクトの移行作業はゴルフボールサイズなのか？バスケットボールサイズなのか？旅客機サイズなのか？」
このときに、私はその質問に答えられなかったが、代わりに次の様に答えることにした。
「まだわかりません。ただ、そのぐらいの粒度のあらさで見積もりに答えるのであれば、難しくはないはずだ」と主張した。
CIOはうなずき、結果としては質問に答えることはできた。
残念ながら、プロジェクトの移行作業にはボーイング787ドリームモデル並みの労力が必要であった。
```

from Architecture Hard Parts 訳

このような質問でも、コンポーネントの依存関係判断パターンを適用することで答えることができる。


## コンポーネントの依存関係とは

今回のプロジェクトのゴールは次の様な依存関係のグラフを表示することである。

<img src="https://www.feststelltaste.de/wp-content/uploads/2017/09/java_type_dependency_analysis_result.png">

from https://www.feststelltaste.de/java-type-dependency-analysis/

注意するべきは、このコンポーネントは、名前空間であってクラス名ではないということである。
クラス名同士の依存関係ではなく、コンポーネントの依存関係に今回は着目する。

**コンポーネントの依存関係は、あるコンポーネント（名前空間）のクラスが、別のコンポーネント（名前空間）の裏すと相互作用で発生する関係のことである。**

この様な関係を可視化する補助ツールは多数存在するし、IDE自体にもコードベース内部のコンポーネントや名前空間の依存関係図を作成する機能を拡張するプラグインが存在する。


### コンポーネントが分離されている場合

例えば、コンポーネント同士の関係が次ような状態であった場合。

<img src="https://www.feststelltaste.de/wp-content/uploads/2017/09/java_type_dependency_analysis_result_packages.png">

このケースではアーキテクトは次の様に判断するだろう。

- 既存のモノシリックシステムは分解可能か？:はい

- 移行にかかる労力:少ない

- コードの書き直しは必要か？:リファクタリングで良い


### コンポーネント同士が結合されている場合

ほとんどのビジネスアプリケーションは次の様な状態のはずだ。

<img src="https://www.feststelltaste.de/wp-content/uploads/2017/09/java_type_dependency_analysis_result.png">

このケースではアーキテクトは次の様に判断するだろう。

- 既存のモノシリックシステムは分解可能か？:多分...

- 移行にかかる労力:通常の労力がかかる

- コードの書き直しは必要か？:リファクタリングと書き直し両方が必要になる


### コンポーネント同士が密着に結合されている場合

次の様に、コンポーネント同士が密着に結合されている場合

<img src="https://www.feststelltaste.de/wp-content/uploads/2017/09/java_type_dependency_analysis_example.png">

**アーキテクトはこの会社またはこのプロジェクトからすぐに逃げ出すべきだ。**


## リファクタリングではノードグラフは重要

コンポーネント同士のこうした図表は、リファクタリングの際の妨げになりうる要素を探す探知機となり得る。
**コンポーネントの結合度は、モノシリックなアーキテクチャの移行作業の実現可能性を決定する重要な要因だ**

また、実際に結合が密集しているコンポーネントを発見した際には、そのコンポーネントを二つに分離するか、
またはライブラリー(PythonのPyPIなど)として分離する選択肢がある。
例えば、コンポーネントAへの入力の数が20だったとする。
このコンポーネントを別の二つのコンポーネントへ分離することで、コンポーネントA1の結合度を14,コンポーネントA2の結合度を6の二つに分離することができる。


## コンポーネントの結合度の監視

リファクタリングを行った後、望まない結合を防ぐためにはCI/CDパイプラインに適応度関数を追加する他ない。

次のコードは、Javaで動くArchUnitを使用した「望まない結合」を防ぐ適応度関数である。

```java
public void ticket_maintenance_cannot_access_expert_profile() {
    noClasses().that()
        .resideInAPackage("..ss.ticket.maintenance..")
        .should().accessClassesThat()
        .resideInAPackage("..ss.expert.profile..")
        .check(myClasses);
}
```

from https://dl.ebooksworld.ir/books/Software.Architecture.The.Hard.Parts.Neal.Ford.OReilly.9781492086895.EBooksWorld.ir.pdf





## 備考

title:依存関係を明らかにする【リファクタリング入門4】

description:コンポーネント同士の関係を表す図表は、リファクタリングの際の妨げになりうる要素を探す探知機となり得る。コンポーネントの結合度は、モノシリックなアーキテクチャの移行作業の実現可能性を決定する重要な要因だからだ。

img:https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/3063/breakdown.png?raw=true

category_script:page_name.startswith("3")














