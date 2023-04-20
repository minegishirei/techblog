


## この記事の説明

非機能要件に関する用語と一覧です。
システムが担保するべき能力の全てを記述しました。

- [非機能要件とは](#非機能要件とは)
- [非機能要件一覧](#非機能要件一覧)
  - [アーキテクチャ運用特性一覧](#アーキテクチャ運用特性一覧)
    - [可用性](#可用性)
    - [継続性](#継続性)
    - [パフォーマンス](#パフォーマンス)
    - [回復性](#回復性)
    - [信頼性/安全性](#信頼性安全性)
    - [堅牢性](#堅牢性)
    - [スケーラビリティ](#スケーラビリティ)
  - [アーキテクチャ構造特性](#アーキテクチャ構造特性)
    - [構成用意性](#構成用意性)
    - [拡張性](#拡張性)
    - [インストール容易性](#インストール容易性)
    - [活用性/再利用性](#活用性再利用性)
    - [ローカライゼーション](#ローカライゼーション)
    - [メンテナンス容易性](#メンテナンス容易性)
    - [可搬性](#可搬性)
    - [アップグレード容易性](#アップグレード容易性)
  - [そのほかの非機能要件](#そのほかの非機能要件)
    - [アクセシビリティ](#アクセシビリティ)
    - [認証](#認証)
    - [認証](#認証-1)
    - [合法性](#合法性)
    - [プライバシー](#プライバシー)
    - [セキュリティ](#セキュリティ)
    - [サポート用意性](#サポート用意性)
    - [ユーザービリティ](#ユーザービリティ)
- [まとめ](#まとめ)


# 非機能要件とは

一般的に、非機能要件とは次の3つを満たすものと呼ばれます。

- ドメインによらない、設計に関する考慮事項を明らかにするもの

- 設計の構造的な側面に影響を与えるもの

- アプリケーションの成功に必要か重要なもの

要するに、**機能以外のアプリケーションの構造に影響を与えかつサービスの成功基準となるもの**です。

以下はIPAによる非機能要件のイメージです。

<img src="https://www.ipa.go.jp/files/000066109.png">


# 非機能要件一覧

以下が、システムが担保できる非機能要件の一覧です。

- [非機能要件とは](#非機能要件とは)
- [非機能要件一覧](#非機能要件一覧)
  - [アーキテクチャ運用特性一覧](#アーキテクチャ運用特性一覧)
    - [可用性](#可用性)
    - [継続性](#継続性)
    - [パフォーマンス](#パフォーマンス)
    - [回復性](#回復性)
    - [信頼性/安全性](#信頼性安全性)
    - [堅牢性](#堅牢性)
    - [スケーラビリティ](#スケーラビリティ)
  - [アーキテクチャ構造特性](#アーキテクチャ構造特性)
    - [構成用意性](#構成用意性)
    - [拡張性](#拡張性)
    - [インストール容易性](#インストール容易性)
    - [活用性/再利用性](#活用性再利用性)
    - [ローカライゼーション](#ローカライゼーション)
    - [メンテナンス容易性](#メンテナンス容易性)
    - [可搬性](#可搬性)
    - [アップグレード容易性](#アップグレード容易性)
  - [そのほかの非機能要件](#そのほかの非機能要件)
    - [アクセシビリティ](#アクセシビリティ)
    - [認証](#認証)
    - [認証](#認証-1)
    - [合法性](#合法性)
    - [プライバシー](#プライバシー)
    - [セキュリティ](#セキュリティ)
    - [サポート用意性](#サポート用意性)
    - [ユーザービリティ](#ユーザービリティ)
- [まとめ](#まとめ)


非機能要件に所属する全ての能力は主に次の3つに分類されます。

- [アーキテクチャ運用特性一覧](#アーキテクチャ運用特性一覧)
- [アーキテクチャ構造特性](#アーキテクチャ構造特性)
- [アーキテクチャの横断的特性](#アーキテクチャの横断的特性)

アーキテクトは全ての要件を完全なレベルでサポートする必要はなく、トレードオフに基づいて取捨選択されます。


## アーキテクチャ運用特性一覧

アーキテクチャの運用特性は、パフォーマンス、スケーラビリティ、弾力性、可用性、信頼性といった能力を対象としています。

システムが稼働している際にどれぐらいの能力を持てば対応できるのかの判断につながる指標です。


### 可用性

システムがどのくらいの期間利用できるか(24時間365日運用する場合には、障害が発生した場合の対応措置も含められる)


### 継続性

障害復旧能力のことです。
たとえ障害が起きても1秒で回復すれば問題はないでしょう。

### パフォーマンス

ストレステスト、ピーク分析、使われる機能の使用頻度などをもとにした、必要となる容量のことです。
応答時間の分析などもここに含まれます。

### 回復性

処理の持続性要件のことです。例えば、

> 災害時にシステムをどれだけ早くオンラインに戻す必要があるのか。

など。

データのバックアップ戦略やハードウェア複製の要件に影響する内容でもあります。

### 信頼性/安全性

システムがフェイルセーフである必要があるか、人命に関わるようなミッションクリティカルなものであるかを評価します。
障害が発生したときに多額の費用が会社にかかるのだろうか。

エレベーターをコントロールするOSがwindows98だったら嫌ですよね。


### 堅牢性

実行中にインターネットが切れた場合や、停電やハードウェア障害が発生した場合に、エラーや境界条件を処理できるかどうかの能力です。
依存する要素が少なければ堅牢性は上がります。

### スケーラビリティ

ユーザー数やリクエスト数が増えてもシステムが動作することです。



## アーキテクチャ構造特性

アーキテクトは、コードの構造にも注目しなければなりません。

優れたモジュール性、生業されたコンポーネント間の結合、読みやすいコード、その他多くの内部的な品質評価が求められます。

### 構成用意性

エンドユーザーがソフトウェアの設定を簡単に変更できること。
configファイルなどを使わず、ソースコードに設定をハードコードディングしたシステムは構成用意性は低いでしょう。
反対にノーコードツールはなんでもできると言えますが、構成用意性が高すぎてユーザーでやるべきことが多すぎると言えるでしょう。

### 拡張性

新しい機能をプラグインで追加可能にすることを示します。
プラグインアーキテクチャは拡張性が最大限のモノシリックなアーキテクチャですね。

https://minegishirei.hatenablog.com/entry/2023/01/28/110836

### インストール容易性

必要な全てのプラットフォームへのインストールの容易さのことです。
C#で作られたシステムをlinuxで動かすのは難しいですし、webはブラウザさえあればどこでも動かせられますのでインストール容易性は高いですね。


### 活用性/再利用性

複数の製品で共通のコンポーネントを利用できること。
ETLツールなどで使われるパイプラインアーキテクチャでこの項目が最大限でしょう。

https://minegishirei.hatenablog.com/entry/2023/01/28/101928

### ローカライゼーション

データフィールドの入力画面や問い合わせ画面、レポート、マルチバイト文字の要件、
単位や通貨などが他言語に対応していること。
こちらもプラグイン形式で導入されることが多いです。

https://minegishirei.hatenablog.com/entry/2023/01/28/110836

### メンテナンス容易性

変更の適用やシステムの拡張がどれだけ容易に行えるか。
拡張性と被るところもありますが、こちらはどちらかといえば運用目線の項目だ。

### 可搬性

システムは複数のプラットフォームで動作する必要があるかどうかの指標です。
Linux OSだけでなく、WindowsやMacOSに対応しているか?

webアプリであればそもそもどのプラットフォームでも動きますが、ネイティブアプリならではのメリットもあるので一概に評価できません。


### アップグレード容易性

サーバーやクライアント上で、アプリケーション/ソリューションの旧バージョンから
新バージョンへのアップグレードを簡単/迅速に行える能力のことです。

プラットフォームに強く依存するアプリ（iOSアプリなど）ではこの項目はかなり強く吟味しなければなりません。


## そのほかの非機能要件

多くの非機能要件が簡単に分類できる一方で、分類できないが重要な設計上の制約や考慮事項を形成するものも多い。

ここでは技術や運用目線、システムの要件などの分類以外の要件を提示します。


### アクセシビリティ

色覚障害や難聴などの障害を持つユーザーへの配慮が必要かどうかという観点です。


### 認証

ユーザーが何者かを確認するためのセキュリティ要件。

### 認証

ユーザーが特定のアプリケーションの機能のみにアクセスするコオtができるというセキュリティ要件。

### 合法性

システムはどのような法的制約の中で運用されているのか、満たすべき要件。

- データ保護

- 米企業改革法

- GDPR

などなど。
医療用のソフトウェアの販売はこれに該当しないかどうかを確認しなければなりません。


### プライバシー

個人情報などが外部から遮断されているかどうかという要件です。
従業員から取引を隠せるか（取引が暗号化されていて、DBAやネットワークアーキテクチャでさえも取引をみることができなくなっているか）も確認しなければなりません。


### セキュリティ

データベース内でデータを暗号化する必要があるか?
社内システム間の通信を暗号化する必要があるか？

### サポート用意性

アプリケーションにはどの程度の技術的なサポートが必要か＞

- デバッグ可能性

- ログのレベル

などなど

### ユーザービリティ

ユーザー目線でのアプリケーションを使いこなすために必要なトレーニングのレベル



# まとめ


- [非機能要件とは](#非機能要件とは)
- [非機能要件一覧](#非機能要件一覧)
  - [アーキテクチャ運用特性一覧](#アーキテクチャ運用特性一覧)
    - [可用性](#可用性)
    - [継続性](#継続性)
    - [パフォーマンス](#パフォーマンス)
    - [回復性](#回復性)
    - [信頼性/安全性](#信頼性安全性)
    - [堅牢性](#堅牢性)
    - [スケーラビリティ](#スケーラビリティ)
  - [アーキテクチャ構造特性](#アーキテクチャ構造特性)
    - [構成用意性](#構成用意性)
    - [拡張性](#拡張性)
    - [インストール容易性](#インストール容易性)
    - [活用性/再利用性](#活用性再利用性)
    - [ローカライゼーション](#ローカライゼーション)
    - [メンテナンス容易性](#メンテナンス容易性)
    - [可搬性](#可搬性)
    - [アップグレード容易性](#アップグレード容易性)
  - [そのほかの非機能要件](#そのほかの非機能要件)
    - [アクセシビリティ](#アクセシビリティ)
    - [認証](#認証)
    - [認証](#認証-1)
    - [合法性](#合法性)
    - [プライバシー](#プライバシー)
    - [セキュリティ](#セキュリティ)
    - [サポート用意性](#サポート用意性)
    - [ユーザービリティ](#ユーザービリティ)
- [まとめ](#まとめ)


非機能要件に所属する全ての能力は主に次の3つに分類されます。

- [アーキテクチャ運用特性一覧](#アーキテクチャ運用特性一覧)
- [アーキテクチャ構造特性](#アーキテクチャ構造特性)
- [アーキテクチャの横断的特性](#アーキテクチャの横断的特性)


　
