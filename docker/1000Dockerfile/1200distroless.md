



## distrolessイメージを活用して脆弱性を撲滅する。

ECRにはイメージスキャンの機能があります。
これは、コンテナイメージに対してセキュリティスキャンを行い、脆弱性を洗い出してくれる機能です。

> Amazon ECR は、オープンソースの Clair プロジェクトの共通脆弱性識別子 (CVE) データベースを使用します。ベーシックスキャンでは、プッシュ時にスキャンするようにリポジトリを設定します。手動スキャンを実行すると Amazon ECR によってスキャン結果のリストが提供されます。

<img src="https://github.com/minegishirei/store/blob/main/docker/distroless/image_scan.png?raw=true">

from https://dev.classmethod.jp/articles/ecr-repository-scan/

先日、セキュリティの勉強会があり、コンテナセキュリティについても話題が挙がりました。
私はそこでECRのイメージスキャン機能を知り、さっそくプロジェクトで使用しているコンテナイメージをスキャンすることにしました...。

すると...

<img src="https://github.com/minegishirei/store/blob/main/docker/distroless/image_scan2.png?raw=true">

from https://dev.classmethod.jp/articles/ecr-repository-scan/

（画像は参考です。）200件を超える情報提供と、1件のクリティカルな脆弱性が見つかってしまいました。
クリティカルな脆弱性の内容は`zlib1g`に関する内容で`Debian`系のlinuxディストリビューションで見つかるらしいです。

from https://ubuntu.com/security/notices/USN-5355-2

<img src="https://github.com/minegishirei/store/blob/main/docker/distroless/image_scan3.png?raw=true">


そこで今回は「distroless」と呼ばれるイメージを使用して、脆弱性を撲滅していきたいと思います。



## distrolessとは何か?

distrolessは超軽量なコンテナイメージです。
`distroless`にはアプリケーションと、アプリを動かすランタイムしか存在しません。`bash`や`sh`もありません。
脆弱性を生み出すパッケージマネージャーやシェルなどがそもそも存在しないため、これ単体だと使い勝手は悪いですが、高度なセキュリティ要件にも対応できます。

> "Distroless" images contain only your application and its runtime dependencies. They do not contain package managers, shells or any other programs you would expect to find in a standard Linux distribution.

<img src="https://github.com/minegishirei/store/blob/main/docker/distroless/image_scan4.png?raw=true">

軽量なコンテナといえば`alpine linux`もありますが、`distroless`は比較にならないぐらい軽いImageです。
（そもそも近年のalpine linuxは少々重たくなってきましたし、その割には使い勝手もあまりよくない気がします...）

ではこの`distroless`を使用してコンテナイメージの脆弱性を撲滅していきたいと思います。



## `distroless`と`マルチステージビルド`の適応方法

`distroless`の運用のためには、`マルチステージビルド`というベストプラクティスを使用します。
`distroless`には`bash`も`cat`も`ls`もないため、デバッグなどには不向きです。
そのため、開発段階のイメージファイルとしては避けた方よいです。
しかし、本番環境では開発段階のイメージを活用すると脆弱性につながりかねないので、`distroless`イメージと開発用イメージをうまく使い分けなければいけません。
そこで、`マルチステージビルド`を用いて、2段階のビルドを行います。

`distroless`および`マルチステージビルド`を導入する前のDockerfileは以下の形状でした。

```Dockerfile
FROM python3.9.18
WORKDIR /app
COPY ./app /app
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
ENTRYPOINT "entrypoint.sh"
```

この状態だと、`python3.9.18`の脆弱性がすべてECRに反映されてしまいます。
（今回は`python3.9.18`のベースイメージがDebian系でしたので、debian系の脆弱性が出現してしまいました）
ですので、マルチステージビルドを導入して、この脆弱性を隠そうと思います。

```Dockerfile
FROM python3.9.18 AS dev
WORKDIR /app
COPY ./app /app
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
ENTRYPOINT "entrypoint.sh"

FROM gcr.io/distroless/python3 AS prod
COPY --from=dev ./app /app
COPY --from=dev /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/dist-packages
ENTRYPOINT ["sh", "-c", "python -uB -m gunicorn myapp.wisgi --config /app/gunicorn_settings.py"]
```

このように、マルチステージビルドを応用することで、ECRイメージの脆弱性の数を減らすことが出来ます。
最終的に、脆弱性は「なし」のステータスにすることができました。
















from https://minegishirei.hatenablog.com/entry/2024/03/04/131717?_gl=1*zeqeqf*_gcl_au*MTE5NzIyMjE1MC4xNzAzNDYyOTYx