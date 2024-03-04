



## distrolessイメージを活用して脆弱性を撲滅する。

ECRにはイメージスキャンの機能があります。
これは、コンテナイメージに対してセキュリティスキャンを行い、脆弱性を洗い出してくれる機能です。

> Amazon ECR は、オープンソースの Clair プロジェクトの共通脆弱性識別子 (CVE) データベースを使用します。ベーシックスキャンでは、プッシュ時にスキャンするようにリポジトリを設定します。手動スキャンを実行すると Amazon ECR によってスキャン結果のリストが提供されます。

<img src="">

from https://dev.classmethod.jp/articles/ecr-repository-scan/

先日、セキュリティの勉強会があり、コンテナセキュリティについても話題が挙がりました。
私はそこでECRのイメージスキャン機能を知り、さっそくプロジェクトで使用しているコンテナイメージをスキャンすることにしました...。

すると...

<img src="">

from https://dev.classmethod.jp/articles/ecr-repository-scan/

（画像は参考です。）200件を超える情報提供と、1件のクリティカルな脆弱性が見つかってしまいました。

そこで今回は「distroless」と呼ばれるイメージを使用して、脆弱性を撲滅していきたいと思います。



## distrolessとは何か?

distrolessは超軽量なコンテナイメージです。
`distroless`にはアプリケーションと、アプリを動かすランタイムしか存在しません。`bash`や`sh`もありません。
脆弱性を生み出すパッケージマネージャーやシェルなどがそもそも存在しないため、これ単体だと使い勝手は悪いですが、高度なセキュリティ要件にも対応できます。

> "Distroless" images contain only your application and its runtime dependencies. They do not contain package managers, shells or any other programs you would expect to find in a standard Linux distribution.

軽量なコンテナといえば`alpine linux`もありますが、`distroless`は比較にならないぐらい軽いImageです。
（そもそも近年のalpine linuxは少々重たくなってきましたし、その割には使い勝手もあまりよくない気がします...）


## どうやって使うのか?



## 脆弱性の数は?


















