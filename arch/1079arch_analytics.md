




## アーキテクトはシステムを分析し続けなければならない

アーキテクトはプロジェクトのあらゆる局面で、さまざまな観点からシステムの要件を分析し続けなければならい。
パフォーマンス、弾力性、スケーラビリティなどの運用特性から、モジュール性やデプロイ容易性までの構造的な関心ごとまで全ての分析する。

**特に、一度構築したシステムを継続的に分析できるアーキテクトは少ない。**

https://techblog.short-tips.info/inhouse_se/1008software_architect.md#2

```
既存のアーキテクチャを継続的に分析することにエネルギーを注いでいるアーキテクトは少ない。
その結果、ほとんどのアーキテクチャは構造的崩壊を起こしてしまっている。 
構造的崩壊の結果、開発者がコーディングや設計を変更していく中で、
パフォーマンスや可能性、スケーラビリティといったアーキテクチャ特性に影響が出てしまう。
```


アーキテクトが分析するものは3つ

- 運用面の計測

- 構造面の計測

- 開発プロセス面の計測

この3点を、継続的に分析し続ける必要がある。


## 1.運用面の分析


パフォーマンスやスケーラビリティなど、アーキテクチャ特性には、明確で直接的な計測を伴うものも多い。
しかし、そうした特性であっても**チームの目標に応じて曖昧な解釈が発生してしまうこともある。**

### 応答時間

例えば、あるチームがリクエストの平均応答時間を指標にしていたとする。
この指標は運用特性を把握する上で良い例だが、チームが平均値だけを計測していた時に、リクエストの1%の境界値により基準としていた値の10倍を記録した時はどうするか。

この場合、チームは外れ値を検出するために、最大応答時間を計測することもある。

### 運用方法

あるいは、DevOps的な観点からはどうだろうか。

時間の経過とともにスケールを計測し、統計値を算出し、リアルタイムの計測基準が予測モデルから外れた場合に警報を出すシステムがあるとする。

この警告を、運用チームはどのように解釈しているか？開発チームは警報がどの程度の頻度なったことを把握しているか？

### その他の計測項目

最近では、多くのチームがコンテンツのファーストページビュー時間やCPUの初回アイドル時間を計測している。

デバイス、ターゲット、能力、その他数え切れないものが変化してきているが、
**チームは新しいメトリクスや計測の仕方を見つけていくことが必要となる。**



## 2.構造面の計測

内部構造の特性についてはどうだろうか？
現時点では内部のコードの品質を包括的に評価する指標は存在しない。

しかし、いくつかの指標やツールはコードの構造の重要な観点を計測するのに役に立つ。

明確に計測可能なコードの観点で、循環的複雑度で牴牾される複雑さがある。

### 循環的複雑度

循環的複雑度は、客観的な複雑度合いの尺度を提供するために設計されたコードレベルの指標だ。

何が言いたいかというと、**「このコードはこれぐらい複雑なんだよ？」**と言うための指標だ。

例えば、

- if文を一個もつ関数は二つの実行可能なパスがあるため`CC=2`となる

- 反対に、if文を持たない関数は`CC=0`となる

循環的複雑度合いは、次のような公式で定義される

```
CC = E - N + 2
```

なんでこの式になったのか?は分からないので触れない。

ここで、

- CC:循環的複雑度合い(Cyclomatic Complexity)

- N :ノード(分岐点の数,ifやelse ifの数)

- E :エッジ(コードが分岐する道の数,)

具体例を見てみよう


### 循環的複雑度のサンプル

次のような、java言語っぽいコードを見てみよう

```java
public void decision(int c1, int c2){
    if (c1 < 100) {
        return 0
    }else if ( c1 + c2 > 500){
        return 1
    }else{
        return -1;
    }
}
```

この場合、

- E :エッジの数:returnを通る3つのパスで E=3

- N :ノードの数:if文とelse if文の2つの分岐点で N=2

よって

CC = 3-2+2 = 3

という計測結果が出る。


### 循環的複雑度の一般化

循環的複雑度の式に出てくる2と言う数字は、一つの関数の単純化を表している。

他の関数を呼び出している場合は、循環的複雑度の公式は次にように変化(一般化)される。

```txt
CC = E - N + 2P
```

Pは関数内部で呼び出している他の関数の数である。



### 循環的複雑度はどれくらいの値だと良いのか

一般的に、IT業界におけるCCの閾値は、他の要素を考慮しない場合は10以下であることが推奨されている。

ただし、別の方の意見ではこの値はまだまだ高く、よくできた凝縮されたコードは5以下に収まっている。

あるケースでは、商用ソフトウェアパッケージの心臓部分として機能していた関数のCCが800を超えていた。

この関数では4000以上のコードを持ち、GOTO文を多用していたのだ。


### 循環的複雑度はどうすれば減るのか？

結論:テスト駆動開発をせよ

テスト駆動開発のようなエンジニアリングプラクティスでは、

1. コードを書く前にまずテストを書く。

2. そして、テストが通るためのコードを書く

と言う手順で開発を行なっている。

このエンジニアリングプラクティスでは、関数をテストしやすいようにキープするために必然的にサイズが小さくなる傾向がある。

これはテスト駆動開発の主目的ではないが、間違いなくポジティブな副作用である。


## 3.開発プロセス面の計測

アーキテクチャ特性の中には、ソフトウェア開発プロセスと関連があるものがある。

例えば、テスト容易性などだ。

- ソフトウェアが信頼できるデータを算出できるかどうか、どれくらいの精度を保証しなければならないかと言う議論

- ソフトウェアの開発チームが行うテストの精度の議論

この二つは議論の中で切り離すことができないだろう。

システムを構築し終わった後でも、アーキテクトはそのソフトウェアが出す数値の精度に目を光らせて、何か問題があった場合はユニットテストのカバレッジに問題がないかを確認しなければならない。

そのほかにも、デプロイの成功率と失敗率や完了時間、バグの数などを用いて、デプロイ容易性を計測できるはずだ。











## アーキテクトが分析するシステムの3要素

title:【アーキテクチャ設計基礎】循環的複雑度とは何か

description:アーキテクトはプロジェクトのあらゆる局面で、さまざまな観点からシステムの要件を分析し続けなければならい。パフォーマンス、弾力性、スケーラビリティなどの運用特性から、モジュール性やデプロイ容易性までの構造的な関心ごとまで全ての分析する。

category_script:True

img:https://1048636645-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-MAffO8xa1ZWmgZvfeK2%2F-MK-lT4QGYHB8LD42a_r%2F-MK-lmcxbtabXwjYp6S5%2Fimage.png?alt=media&token=a57491a8-3216-4297-bc52-4e5dd295bc4b

