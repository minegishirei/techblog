


## AWSにおけるCI/CDの構築方法

AWSにてCICD環境を構築する際、以下の三つのシステムを利用することになる

- AWS Code Build
    - ソースコードをコンパイルすることができる。
    - linuxコマンドをbuildspec.ymlに書き込んで実行する。
    - 環境変数もサポートしているので、環境ごとにリリースする場所を決定できる。
- AWS Code Deploy
    - サービスのデプロイを担当する。EC2やFargateなど様々なタイプをサポートしている。
    - デプロイとは「配置する」という意味。buildだけではソースコードのコンパイルしかできず、CodeDeployを用いることで開発環境/本番環境へのリリースが可能となる。
    - Blue/Greenデプロイも可能
    - 以前のリビジョンを再デプロイすることで、ロールバックも可能
- AWS Code pipline
    - CodeCommit,S3のソースの変更から、Codebuild,CodeDeployの起動のフローを定義することができる。


## CICD環境構築

全体のCICD環境の構成は以下の通り。

<img src="https://d1.awsstatic.com/icons/jp/cdp/renewal/diagram_cicd-code.b9ce199dd9b3ea7a0be0e0c64dea6e7afaef70c0.png">

1. 開発者がソースコードをpush
2. Codepiplineが変更を検知し、CICDがスタート
3. codebuild, codedeployを経由してecsへリリース


### blue greenデプロイとは

通常のデプロイだと、新アプリケーションのデプロイ時、アプリケーションサーバーの停止時にリリースしなければならない。

しかし、**blue/greenデプロイメントによって、ユーザーの利用停止期間なしで新環境が利用できる。**

<img src="https://d2908q01vomqb2.cloudfront.net/1b6453892473a467d07372d45eb05abc2031647a/2017/06/30/0617_bluegreenecs_3.png"> 


- ここでのblueとは、旧環境のこと
- ここでのgreenとは、新環境のこと
- Code Deployはgreen環境に対してリリースを行った後、Elastic Load Blancerに対してgreen環境に向き先を変更するようリクエストを出す。
- 旧環境はロールバックのために一定期間存在する。


## CI/CD環境詳細

CI/CDを束ねるCodepiplineは、gitのpushからリリースまでの各段階を**ステージと呼んでいる**

1. Codecommitへpushする。
2. pushの際には以下4つのファイルが必要。これら4ファイルを**Buildアーティファクト**と呼ぶ。これらのファイルはCodePiplineのソースステージにてS3へ格納される。
    - `Dockerfile` : コンテナの定義で使用
    - `buildspec.yml` : build時のlinuxコマンドをまとめたもの。
    - `appspec.yml` : codedeployのサービスで使用。deploy対象のリソースを、どこでどのように使用するのかを明記する。
    - `taskdef.json` : タスク定義ファイル。ecsで使用するタスク定義（どのレベルのリソースでfargateを動かすのか）を明記する。
3. Codebuildの際、`imageDetail.json`が作成される（これはCode Deployにて使用される）


## 環境作成手順

### Codecommitを作成

まずはソースコードを入れる器の`CodeCommit`のリポジトリを作成しましょう。
作成後はリポジトリに対してソースをpushして中身が反映したか確認してみます。

### buildアーティファクトの作成

#### buildspec.ymlの作成

ここではソースコードの取得とdockerによるイメージのbuildを行い、ecrへpushする処理をする。

また、**artifacts**として、`imageDetails.json`を指定している。

```yml
version: 0.2
phases:
  pre_build:
    commands:
      - $(aws ecr get-login --region $AWS_DEFAULT_REGION --no-include-email)
      - REPOSITORY_URI=各自ご自身のURIに置き換えてください！
      - IMAGE_TAG=$(echo $CODEBUILD_RESOLVED_SOURCE_VERSION | cut -c 1-7)

  build:
    commands:
      - docker build -t $REPOSITORY_URI:latest .
      - docker tag $REPOSITORY_URI:latest $REPOSITORY_URI:$IMAGE_TAG

  post_build:
    commands:
      - docker push $REPOSITORY_URI:latest
      - docker push $REPOSITORY_URI:$IMAGE_TAG
      - printf '{"Version":"1.0","ImageURI":"%s"}' $REPOSITORY_URI:$IMAGE_TAG > imageDetail.json
  
artifacts:
    files: imageDetail.json
```

imageDetails.jsonは`post_build`にて作成されているのが分かるだろうか。後続のCodeDeployは`imageDetails.json`を参照して必要なECRを参照する。

#### `appspec.yml`

```yml
version: 0.0
Resources:
  - TargetService:
      Type: AWS::ECS::Service
      Properties:
        TaskDefinition: "<TASK_DEFINITION>"
        LoadBalancerInfo:
            ContainerName: "各自ご自身のコンテナ名に置き換えてください！"
            ContainerPort: "80"
```



## ビルド定義













