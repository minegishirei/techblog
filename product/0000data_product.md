





## 1.データを集める

1つ目の要素は、様々な情報源からデータを収集することです。

様々なサービスやアクセスログからデータを取り出し、データストアに繋げるためにはデータ回収ツールが必要となります。

このような、A地点からB地点へのデータの移動を行うためのツールを**ETLツール**と呼びます

<img src="https://www.data-be.at/magazine/wp-content/uploads/2021/11/0ac268a24a736b1fafb842ea7416ae20.gif">

ETLツールが、データを抽出して正しい形式に加工し、ひとつのDWHへ格納することでデータを分析しやすくするのです。

from https://www.data-be.at/magazine/talend-etl/

### データ収集ツール1:talend

talendもOSSのETLツールです。[ダウンロードはこちらからできます](https://help.talend.com/r/ja-JP/7.3/studio-getting-started-guide-open-studio-for-data-integration/downloading-talend-open-studio)

チュートリアルを実行してみた結果は以下の通りでGUIベースのデータ変換が可能になっている点が大きな特徴です。
また、作成したジョブをエクスポートして任意の環境で実行できるようになっています。
Javaで書かれているため、エクスポート時にはクラスファイルやjarファイルが出力されています。

1. 新規プロジェクトとジョブの作成
2. CSVファイルの読み込み/変換
3. CSVファイルとMySQLのテーブルから読み込んだ結果を結合してMySQLの別テーブルに出力
4. ジョブをエクスポート

<img src="https://d1tlzifd8jdoy4.cloudfront.net/wp-content/uploads/2014/05/Talend-Open-Studio-for-Data-Integration.png">

https://dev.classmethod.jp/articles/talend-open-studio-for-data-integration/

### データ収集ツール2:fluentd

fluentd は、一般的に1つのホスト (水平スケーリングが必要な場合は複数) にインストールされる**集中ログコレクター**です。

fluentdの役割は、リモートデータソースに接続しフィルタリングを適用して、統合されたログデータをリモートデータタンクに送信します。

**統合ログ基盤**に必要な様々なツールを提供できるという点が大きな特徴です。

fluentdの最大のユースケースはログを扱うことです。
ログとは、コンピューターシステムにおける何らかの記録データ(ウェブのアクセスログやクレジットカード支払いログのこと)のことを指します。
このようなケースでfluentdを用いてログを一箇所に集約して、検索及び集計可能にするというユースケースがほとんどなのです。

<img src="https://abicky.net/assets/20171023/fluentd-architecture-faa0125437b95b2d4a53a95d6035100ea470c96b51e3c6b32ad6b79200d859f91920a452f862006aff2f189026c9cb9e21200282a27f9d443ba373aa9876103e.png">

from https://abicky.net/2017/10/23/110103/


### その他のデータ収集ツールEmbulk/GoogleCloudComposer

- Embulk

- GoogleCloudComposer


## 2.データを貯める

1でデータを集めてきた後やるべきことは、集めてきた大量のデータを大容量の保管庫「データレイク」に蓄積することです。

このようにデータを貯める場所をDWH(データウェアハウス)とも呼びます。

### DWHその1:Google BigQuery

Google BigqueryはDWHのうちの一つでクラウド型のDWHです。

- サーバレスなデータウェアハウス

- 標準 SQLが使用できる

サンプルのリクエストですが、ほとんどSQLと同じ構文ですね。

```sql
SELECT 
  title, answer_count, view_count
FROM
  `bigquery-public-data.stackoverflow.posts_questions`
ORDER BY
  view_count DESC
LIMIT 10
```

- 安価なデータストレージ

- 超高速

Google BigQuery の特徴はなんといっても「超」が何個もつくほど高速な処理です。120憶行の正規表現マッチ付き集計を数十秒で完了します。

最後に、サンプル画面を見てみます。

<img src="https://www.isoroot.jp/wp-content/uploads/2019/12/hello-bigquery-02.png">

from https://www.isoroot.jp/blog/2101/

追記:料金について

Bigqueryは処理速度は高速かつクエリを回していないときはコストがかからないため（ストレージ料金はかかります）、とっつきやすさでは優れた選択肢の一つです。
ですが、**コストがクエリのデータスキャンボリュームによって算出されます**。つまり、大きなデータを扱うプロジェクトなどではデータの保管方法やクエリの回し方を適切に扱わないとコストが非常に高くなるリスクがあります。


### DWHその2:snowflake

Snowflakeのアーキテクチャは3つの重要なレイヤーで構成されており、各レイヤーにそれぞれの役割をもたせることにより様々な機能を提供し、高いコストパフォーマンスで利用できるのが特徴です。

料金体型もシステムの構成もわかりやすく、とっつきやすさが最大の魅力かと思われます。


*BigQueryは速度がほしいとき、チューニングが大変。でもSnowflakeだととりあえずウェアハウスのサイズをでかくすると解決することが圧倒的に多いので、これもとても良い点。*

*もしSnowflakeで不思議に遅いクエリとかを見つけたらサポートに問い合わせると、すぐ直してくれたりする。*

*Redshift,BigQuery,Synapseと競合できるだけのパフォーマンスや機能性を持ってる。*

<img src="https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F2519471%2Fee8d9b2c-a664-ec36-4bd8-9cdefd4f22ca.png?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&w=1400&fit=max&s=b1730449630751ce59a486c0a4dfa69c">


追記:料金について

Snowflake は仮想ウェアハウスの起動時間による課金モデルとなっていて、仮想ウェアハウスのサイズによってパフォーマンスを指定できます。また、処理を行う際に仮想ウェアハウスが逐次起動して処理を行うため、必要なときに必要な分だけ課金される使い勝手のいい設計（ストレージ料金は別途かかります）になっています。また、スケールアップ・スケールアウトがしやすく、一つのウェアハウスに対して様々な処理が行われる環境でもコストと性能を両立できます。


## 3.データの可視化

最後にDWHに貯めたデータを確認しますが、ここでは一定のレイヤーの製品が存在するわけではなく、Python, Rなどのデータ分析が得意なプログラミング言語や
Excelでの分析もあり得ると認識しています。

それでもデータの可視化に特化したツールも存在数ため、一定数紹介していきます。








## 備考

title:データ分析基盤の作り方


