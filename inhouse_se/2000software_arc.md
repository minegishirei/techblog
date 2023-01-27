
# この記事の内容：ソフトウェアアーキテクチャの概要と選択

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/all/all.png?raw=true">

- 上司から任られたプロジェクトについて「アーキテクチャについてざっくり考えてきてください」といわれたとき

- そもそもどんなアーキテクチャが世の中にあるのか

- 新米アーキテクトとしてどうすればいいかわからないとき

特に、アーキテクトスタイル（アーキテクチャパターン）のことについて

## 参考：fundamentals of software architecture pdf

<img src="https://kbimages1-a.akamaihd.net/eff38e39-a565-41aa-b50a-cccc7b227634/1200/1200/False/fundamentals-of-software-architecture.jpg">

https://canvas.gu.se/files/4891694/download?download_frd=1


# アーキテクチャを学ぶ意味

## アーキテクチャとは

世間一般の会話の流れだと以下のような図面のこと

<img src="https://image.itmedia.co.jp/edn/articles/1812/03/tt181130_MCUSTM2_001.jpg">

そしてソフトウェアの歴史の中で、幾度か同じようなパターンが出てくることがあり、中には名前がつくほど有名になるものがある。
たとえば、Eclipseのようなプラグインによって機能を拡張するタイプには、 **「プラグインアーキテクチャ」あるいは「マイクロカーネルアーキテクチャ」** という名前がつく。

このようなアーキテクチャのパターンの名前を、**「アーキテクチャスタイル」**と呼ぶ。


## アーキテクチャスタイルを覚える意味

経験豊富なアーキテクト同士の表現方法として機能します。

> イベント駆動の意味よりはマイクロサービスとしてコンポーネントを置いておきたい

> このコンポーネントはメディエーターとして機能するね

*「コンポーネント」とは「システムの構成要素」のこと。サーバーレベルだったりコンテナレベルだったりクラスレベルだったりする。どの程度の粒度になるかは文脈に依存する。*


## 見習うべきではないスタイル:巨大な泥団子

内部構造を持たず、**イベントハンドラがデータベースの呼び出しまでを行ってしまっているような**スクリプティングアプリケーション
現実の世界ではよく見られる。

このスタイルはいわば反面教師で、きちんとアーキテクチャを考慮しないと**クラスの変更の余波の予測が困難になり、関心ごとを分離することができなくなる**という教訓をもたらしてくれる。

### 補足：なぜアーキテクチャを決めるのか？

ここは感想だが、「クラスの変更の余波の予測が困難になり、関心ごとを分離することができなくなる」というのはコードの品質を保つための脅し文句にもなると思う

リファクタリングを怠るPMに向かって、「将来的にクラスの変更の余波の予測が困難になり、関心ごとを分離することができなくなるがそれでも良いですか？」といえば考慮はしてくれる（気がする）


# 基本的なアーキテクトスタイル一覧

それではアーキテクチャの一覧を見ていく。
今回は7種類のアーキテクチャについて触れる。

- [レイヤードアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2001layerd_arch.md)
- [パイプラインアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2002pipline_arch.md)
- [マイクロカーネルアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2003micro_kernel.md)
- [サービスベースアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2004service_base_arch.md)
- [イベント駆動アーキテクチャ](https://techblog.short-tips.info/inhouse_se/2005event_driven_arch.md)
- [スペースベースアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2006space_base_arch.md)
- [マイクロサービスアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2008microservice_arch.md)


# アーキテクチャを選択する

新しいシステムを作成するとき、あるいは今あるシステムを改築するとき、アーキテクトそのものを見直す時がある。

アーキテクチャスタイルの選択の際には次のような設問がある

- 分散アーキテクチャかモノシリックか


## アーキテクチャの選択：モノシリックアーキテクチャと分散アーキテクチャ

モノシリックとは以下のアーキテクチャのこと。単一でシンプルだが弾力性やパフォーマンスは一定しか出せない。

- 巨大な泥団子
- [レイヤードアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2001layerd_arch.md)
- [パイプラインアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2002pipline_arch.md)
- [マイクロカーネルアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2003micro_kernel.md)

分散アーキテクチャとは以下のアーキテクチャのこと

- [サービスベースアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2004service_base_arch.md)
- [イベント駆動アーキテクチャ](https://techblog.short-tips.info/inhouse_se/2005event_driven_arch.md)
- [スペースベースアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2006space_base_arch.md)
- [マイクロサービスアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2008microservice_arch.md)

## モノシリックアーキテクチャと分散アーキテクチャのメリットデメリット

現代では分散アーキテクチャの方が以下の点で優秀だ

- パフォーマンス

- スケーラビリティ
  
- 可用性

しかしこれにも一つの大きなトレードオフがある

それが**ネットワークを基盤とするために起こる不安定性**

例えば

- 途中でパケットが途切れることを考慮したコンポーネントをエンドポイントのロジックに与えなければならない

- ネットワーク自体は絶えず変化する

- ネットワークの帯域幅は無限ではない

などなど


## アーキテクチャ一覧

### 小規模かつ低予算：レイヤードアーキテクチャ

このアーキテクチャは**シンプル**さや**親やすさ**、**コストの低さ**からほとんどのアプリケーションのスタンダードの形となっている。

- [レイヤードアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2001layerd_arch.md)

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/layerd1.png?raw=true">

### とにかくシステムの拡張性を高くしたい：マイクロカーネルアーキテクチャ

プラグインアーキテクチャの用途は大きく分けて2種類あり、

- パッケージ化され、単一のモノシリックなアプリとしてダウンロードされてインストールできるようなアプリケーション

- カスタムビジネス(国ごとのローカライズが発生するなど)アプリケーション

このいずれかで使用される。

- [マイクロカーネルアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2003micro_kernel.md)

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2003micro_kernel/micro_kernel.png?raw=true">


### ユーザー数のバーストに耐えれるようにしたい：スペースベースアーキテクチャ

スペースベースアーキテクチャの特徴は、**アプリの標準的なトランザクションに中央のデータベースが関与しないこと**です。
これにより、**データベースのトランザクションというボトルネックが解消されアプリケーションのスケーラビリティは無限になります。**

中央のデータベースとの連携ではなく、各処理ユニットがメモリ内部にデータを持つのです。
そして、メモリ内部のデータが更新されると、更新情報が非同期的に他の処理ユニットに送られ、結果的に複製されます。

これらのメモリ内部でのデータ共有の技術を**タプルスペース**と呼ぶのです。

スペースベースのアーキテクチャのスペースとは、タプルスペースに由来します。

中央データベースをシステムの同期制約として削除し、**代わりに複製されたメモリ内データグリッドを活用する**ことで、高いスケーラビリティ、高い弾力性、および高いパフォーマンスが実現されます。

ユニット処理装置は、ユーザーの負荷が増減するにつれて動的に起動およびシャットダウンするため、スケーラビリティーが確保されるのです。

- [スペースベースアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2006space_base_arch.md)

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2006space_base_arch/space_base_arch.png?raw=true">


### 応答速度が早いシステム：イベント駆動アーキテクチャ

イベント駆動アーキテクチャは**高度にスケーラブル(弾力性が高い)**で**高パフォーマンスなアプリケーションを実現できる**アーキテクチャです。

また、適応性に優れており、小規模なアプリにも大規模なアプリにも使うことができるのも特徴です。

- [イベント駆動アーキテクチャ](https://techblog.short-tips.info/inhouse_se/2005event_driven_arch.md)

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2005event_driven_arch/event_driven_arch.png?raw=true">


### シンプルなドメイン駆動開発：サービスベースアーキテクチャ


サービスベースアーキテクチャは、マイクロサービスアーキテクチャの要素もある、分散型のアーキテクチャだ。

しかし、マイクロサービスやイベント駆動のタイプに見受けられる複雑さやコストがなく、多くのビジネスアプリケーションで選択されている。


- [サービスベースアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2004service_base_arch.md)

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2004service_base_arch/service_base_arch.png?raw=true">


### 大規模なドメイン駆動開発：マイクロサービスアーキテクチャ

マイクロサービスのコアな価値観は疎な結合による**高度な分離**です。
各サービスでは、会社がやりたい事業をそのままシステム化しています。
例えば、ECサイトをマイクロサービス化する場合、注文受付サービス、在庫管理サービス、物量管理サービスの3つがマイクロサービスとしてひとつの仕事と責任をこなします。
そして、注文受付サービスの変更は在庫管理サービスに影響しないようにするのです。
**そのような高度な分離による変更可能性こそがマイクロサービスアーキテクチャの真価です。**

- [マイクロサービスアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2008microservice_arch.md)

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2008microservice_arch/microservice_arch.png?raw=true">


### データ変換に特化したい：パイプラインアーキテクチャ

**パイプとフィルターのそれぞれの一方向性とシンプルさは、構成の再利用を促す。**

特に、powershellやbashシェル、関数型プログラミングに触れたことがある人ならばその威力を把握しているだろう。

- [パイプラインアーキテクチャ](https://techblog.short-tips.info/inhouse_se/2002pipline_arch.md)

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2002pipline_arch/pipline.png?raw=true">



## まとめ

**アーキテクトは常にトレードオフ**である



## 備考

title:アーキテクチャスタイル一覧

description:アーキテクトを学ぶ意義の理解。特に、アーキテクトスタイル（アーキテクチャパターン）のことについて。アーキテクトスタイルとは、さまざまなアーキテクチャ特性をカバーする、コンポーネント同士の名付けられた関係を説明するもの。

category_script:page_name.startswith("2")

img:https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/all/all.png?raw=true
