



# Haskell 概要


## Dockerを使用したHaskellの環境構築手順【Haskell, Docker, docker-compose】

HaskellはWindowsやMacの上に構築することも可能ですが、Dockerコンテナの上で実行することで完全な再現性が得られます。 加えてHaskell自体にもバージョンが存在するため、それらを容易に切り替えるとなおよいでしょう。

[https://minegishirei.hatenablog.com/entry/2023/11/21/085934:embed:cite]




## Haskellは関数型プログラミング

Haskellは関数型プログラミング言語に分類されますが、
関数型プログラミングは通常のプログラマーが持つ一般的な概念と比較して、ソフトウェアに対する全く異なるアプローチを提供します。

[https://minegishirei.hatenablog.com/entry/2023/11/22/085527:embed:cite]


# Haskell 文法基礎

## Haskellの変数と型一覧

Haskellは関数型プログラミングであるが故、手続き型プログラミングでよくみられる「変数を複数宣言してそれらを管理する」手法は一般的ではありません。

しかし、Haskell言語の中にも型と変数の仕組み自体は存在し、特に型の考え方は重要になります。 この記事ではHaskellの型について深く紹介します。

[https://minegishirei.hatenablog.com/entry/2023/11/22/085647:embed:cite]


## Haskellのlet whereの使い方【Haskell let where 変数宣言 局所的変数】

[https://minegishirei.hatenablog.com/entry/2024/01/14/152609:embed:cite]



## Haskellの条件分岐

Haskellにおいて、条件文という言葉よりも「条件式」といったほうが適切かもしれません。 条件文という言葉は手続き型言語やオブジェクト指向型言語では使われますが、Haskellにおいては「関数」が第一級オブジェクトとして扱われます。 ifも「if文」というよりは「if式」と表現し、値が返却するという点でも関数と呼んだほうが良いです。

[https://minegishirei.hatenablog.com/entry/2024/01/14/152307:embed:cite]


## Haskellは数学

Haskellの真骨頂は関数型プログラミングにあります。

関数型プログラミングについては以下の記事で解説していると思いますので、 今回はHaskellの関数の文法についてお話します。

[https://minegishirei.hatenablog.com/entry/2023/11/25/093512:embed:cite]



## Haskellの関数一覧

[https://minegishirei.hatenablog.com/entry/2023/12/04/093533:embed:cite]


## Haskell dataコマンドの使い方

Haskellのdata コマンドは既存の型を組み合わせて新しい型を作ることが出来ます。

[https://minegishirei.hatenablog.com/entry/2024/01/14/152856:embed:cite]



# Haskell IO型




## Haskellにおける標準入力と標準出力

ほとんどのプログラミングでは副作用は必要不可欠です。 Haskellの世界では純粋なコードの副作用から完全に分離されます。

[https://minegishirei.hatenablog.com/entry/2023/12/04/093642:embed:cite]


## Haskellでファイルを読み書きする方法【Haskell入門】

Haskellにおいてのファイル読み込みは`openFile`関数を使用します。
子の関数を使用するためには、`System.IO`を事前にimportしておく必要があります。


[https://minegishirei.hatenablog.com/entry/2023/12/15/093109:embed:cite]





## Haskellのモナドの説明

モナドはHaskellのプログラムにおいて、特に入出力回りで活躍する仕組みです。 関数プログラムの本体から副作用を安全に分離することができ、計算戦略をプログラム全体にばら撒くことをせずに、一箇所にまとめることができます。

[https://minegishirei.hatenablog.com/entry/2024/01/14/153301:embed:cite]






page:https://minegishirei.hatenablog.com/entry/2023/11/25/093811


