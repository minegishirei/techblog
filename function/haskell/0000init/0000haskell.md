

Haskell はおそらく、これまでに使用したどの言語ともかなり異なります。


## Haskellは関数型プログラミング

Haskellは関数型プログラミング言語に分類されますが、
関数型プログラミングは通常のプログラマーが持つ一般的な概念と比較して、ソフトウェアに対する全く異なるアプローチを提供します。

- Haskell では、データを変更するコードを強調しません。代わりに、 **不変の値を入力として受け取り、新しい値を出力として生成する関数に焦点を当てます。** 同じ入力が与えられると、これらの関数は常に同じ結果を返します。これは関数型プログラミングの背後にある中心的な考え方です
- データを変更しないだけでなく、Haskell 関数は通常、外部と通信しません。これらの関数をpure と呼びます。
- 関数型プログラミングでは、以下の二つを明確に区別します。
    - 外部と通信しない関数（これを、pureな関数と呼ぶ）
    - ファイルの読み取りまたは書き込み、ネットワーク接続を介した通信、またはロボット アームの動作を行うプログラムの部分とを明確に区別しています。
- `for文`、`foreach文`はありませんが、代わりに別の手段を提供します。


上記の特徴により、Haskellは以下のようなメリットを提供します。

- 純粋なコードは外部の世界と一切やり取りせず、コードが扱うデータは決して変更されないため、あるコードが別のコードで使用されているデータを目に見えず破損するという厄介な事態は非常にまれです。（これを、**副作用のないコード**と呼びます）
- 純粋関数をどのようなコンテキストで使用しても、その関数は一貫して動作します。つまり、コードを実行せずとも読みやすく予測しやすいコードになります。
- 関数に対する引数が大量のランダム入力に対して保持されるかどうかを自動的にテストでき、テストに合格したら次に進みます。





## 関数型プログラミングとは何か?

ものすごく簡単に言うと、プログラミングを関数だけで構築するスタイルのことです。ただし、ここでの「関数」には通常のプログラミングよりもさらに特定の意味があります。これは、数学者が使う「関数」とまったく同じ意味で使われています。

大学の数学では、関数は通常、以下のように定義されます。

<img src="https://mathlandscape.com/wp-content/uploads/2021/02/function-notation-1024x504.png">

> 定義（関数・写像）
> 
> 集合 
> 
> A の全ての要素に対し，その要素を入力すると，集合 
> 
> B の特定の要素をただ一つ出力するものを関数 (function) または写像 (mapping) という。
> 
> このとき，
> 
> A をその写像の定義域 (始域; domain) といい，
> 
> B を終域 (codomain) という。
> 
> またこのとき，
> 
> A を入力したときの出力となり得る 
>
> B の部分集合全体を関数(写像)の値域 (像; range) という。

ここでの言葉をプログラミング言語に近づけると、

- すべての関数(写像)には入力される定義域（つまりは型）がある。
- すべての関数(写像)には出力される範囲が決まっている。
- すべての関数(写像)は定義域の中のどの値を入れても出力される範囲（終域）に収まる



## プログラミングにおいての関数とは?

ここまでは数学における関数について触れたので、「プログラミング」においての関数について説明する。

- 関数は渡される引数が同じであれば、常に同じ結果を返す**参照透過性**
- 関数は、外部の変数を参照しない
- 関数の呼び出しが、変数の値を変えることはない（これが副作用）
- 関数の目的は、引数から値を計算し、評価することのみである。
- 関数は、世界に影響を与えない。ビープ音やポップアップを鳴らしたりはしない。（これも副作用と呼ぶ）
- 関数は外の世界からの情報を受け取らない。例えばキーボードやハードディスクを読んだりはしない。

これらのルールに従って書かれたプログラムは**関数型プログラミング**と呼ばれる。



## 副作用について

関数型プログラミングが純粋なコードのみで作られる場合、そのシステムは外部の世界と一切やり取りしないことになります。
しかし、外部の正解と一切やり取りしないシステムということは、少なくともコンピューターを鳴らしたりスクリーンに文字を移したりということが出来なくなってしまいます。

関数型プログラミングで純粋な関数しか扱えない場合、何の影響力もないプログラムにしかなりません。そのため、**利益のあるプログラムを書くためには、関数型プログラミングであっても、副作用とは上手に付き合っていかなければなりません。**

影響力のある関数型プログラミングを行うためには、以下のように副作用と付き合うのを推奨されます。

1. コードの8割は関数型プログラミングで書き、副作用の発生する2割と隔離するべき
2. 残りの2割で副作用のあるコードを書き、ユーザーおよび外の世界との干渉を担当するべき

page:https://minegishirei.hatenablog.com/entry/2023/11/22/085527

page:https://qiita.com/minegishirei_v2/items/0ef9de89b5e73b4107a8