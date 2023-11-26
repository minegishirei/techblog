
- [cloudfrontとは何か?](#cloudfrontとは何か)
- [Cloudfrontのメリット](#cloudfrontのメリット)
  - [AWSとのセットアップが簡単](#awsとのセットアップが簡単)
  - [高度なセキュリティ](#高度なセキュリティ)
  - [Cloudfront関数の使用](#cloudfront関数の使用)
- [具体的な使用例](#具体的な使用例)




## cloudfrontとは何か?

cloud frontとは、CDN(Contents Delibaery Networking)です。
Cloudfrontを使用することで、クラウド上にあるファイルやアプリケーションを世界中の人に届けることができます。


<img src="https://miro.medium.com/v2/resize:fit:640/format:webp/1*_DZVKOF4ZSDO2-Kl05Ieew.png">

クラウドでないアプリケーションで類似するものに、Nginx、Apache等があります。
サーバーやクラウド状にあるファイルや動画を、インターネットに公開する窓口になるという点では役割は同じです。

<img src="https://cdn-media-1.freecodecamp.org/images/RooSvbKlAWsOjkz8JPactXH-GPf4Pe6DC3Ue">





## Cloudfrontのメリット

### AWSとのセットアップが簡単

Amazon CloudFrontは、
- Amazon S3
- Amazon EC2
- Elastic Load Balancing
- Amazon Route 53
- AWS Elemental Media Services

などのAWSサービスと統合されているため、セットアップが簡単です。
また、

- Amazon Cloudwatch
- Kinesis 

などからCloudfrontの動作を監視することもできます。


### 高度なセキュリティ

Cloudfrontのセキュリティのレベルは「デフォルトで」ある程度の防御を備えています。
例えば、DDoS攻撃からはデフォルトで防御されます。

それだけでなく、CloudFrontを`AWS Shield Advanced`または`AWS ウェブ アプリケーション ファイアウォール (WAF) `を使用して柔軟なセキュリティ境界を構築することができます。


### Cloudfront関数の使用

CloudfrontにはCloudfront関数と呼ばれるネットワーク配信をより柔軟にする仕組みが存在します。

CloudFront関数を使用して、訪問者の属性に基づいて独自のコンテンツを配信したり、カスタム レスポンスを生成したり、AWS インフラストラクチャで独自のカスタム コードを実行して A/B テストを実施したりできます。


## 具体的な使用例

例えば、サーバーを必要としない静的なホームページを作成する場合、S3に置いてあるwebコンテンツをCloudfrontを介して公開することが可能です。

この場合以下の手順でWebサイトを構築することが可能です。

1. S3を立てる
2. S3に.htmlや.cssに加え動画ファイルを置いておく
3. Cloudfrontを立てて、フロントとなるS3と結合する
4. urlが発行されるので、アクセスできるようになる
5. しばらくすると、Cloudfrontがエッジロケーションという仕組みで高速にデリバリーできる仕組みが整う。

<img src="https://miro.medium.com/v2/resize:fit:720/0*RS66O_PXajWYsmdQ">





title:Cloudfrontの3つのメリット

