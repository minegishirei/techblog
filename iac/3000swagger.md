



- [swaggerとは](#swaggerとは)
- [swaggerの3つのメリット](#swaggerの3つのメリット)
  - [OpenAPI仕様に基づいて作成されたAPI（OSI）](#openapi仕様に基づいて作成されたapiosi)
  - [APIドキュメントの自動作成](#apiドキュメントの自動作成)
  - [Swaggerによるモックの作成](#swaggerによるモックの作成)






## swaggerとは

swaggerはAPIの新しい基準となる記法の一つです。
大規模な API の設計と文書化に Swaggerが役に立ちます。

現在、マイクロサービスアーキテクチャの出現により、Web APIを使用したシステム開発が注目を集めています。
ですが、巨大なシステムの作成時に、一つのAPIが何本もurlを発行し、収集つかなくなってしまうこともあります。

**このような、大規模な統一されたAPIを作成する際にSwaggerは役に立ちます。**

## swaggerの3つのメリット

Swaggerを使用することで次のような恩恵を受けることができます。


### OpenAPI仕様に基づいて作成されたAPI（OSI）

APIの設計はエラーが発生しやすい作業です。
自由にサービスのエンドポイントを作成できる分、開発者によって書き方やニュアンスがことなり、ほかのエンジニアやAPIサービスを利用する方が
戸惑ってしまうこともありあｍす。

**Swagger Editor**を使用することで、APIをGUI形式で作成することができ、すべての開発者の間で統一されたAPIを作成することができます。
その結果、優れた設計と可読性の高いAPIサービスを運用することが可能になるのです。

> エディターはリアルタイムでデザインを検証し、OAS 準拠をチェックし、外出先で視覚的なフィードバックを提供します。

from swagger (https://swagger.io/solutions/api-design/)



<figure class="figure-image figure-image-fotolife" title="swagger editor">[f:id:minegishirei:20230214103444p:plain:alt=最新のSwagger Editor]<figcaption>swagger editor</figcaption></figure>





### APIドキュメントの自動作成

Swaggerは、APIドキュメントを生成、視覚化することが可能です。
また、マークダウンなどのすぐれたドキュメントもサポートしてくれます。

> Swagger ツールを使用すると、API ドキュメントの生成と維持にかかる大変な作業が不要になり、
> API の進化に合わせてドキュメントを最新の状態に保つことができます。



<figure class="figure-image figure-image-fotolife" title="swagger document">[f:id:minegishirei:20230214103902p:plain:alt=最新のSwaggerドキュメント]<figcaption>swagger document</figcaption></figure>




### Swaggerによるモックの作成

一般的に、フロントエンドとバックエンドではAPIでの結合が発生します。
この場合、バックエンドAPIの完成後にフロントエンドの画面の開発が可能になりますが、これは時間のロスが発生します。

**Swaggerでは、APIのモックを作成することでこの時間ロスを削減することができます。**

> APIがまだ完成していない、あるいは利用できませんか?
> Swaggerでは、わずか数分で現実的なモックAPIを構築することが可能です。


<img src="https://cdn-ak.f.st-hatena.com/images/fotolife/v/vasilyjp/20170519/20170519103309.png">

