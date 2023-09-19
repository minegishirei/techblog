


# Docker で React をインストールする

Reactプロジェクトはnpmやyarnが必ず絡むので必ずと言っていいほど環境依存が発生します。
プロジェクトの管理を可能にするためにはdocker-composeを使用しましょう。



### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)
- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)


目次

[contents:]

## Docker で React を動かす：ディレクトリ構成

ディレクトリ構成は以下の通り。
`Readme.md`はReactプロジェクトを作るうえでは無関係なので作成しなくてよいです。

`docker-compose.yml`と`/code/Dockerfile`の作成に集中しましょう。


```
C:.
│  docker-compose.yml
│  Readme.md
│
└─code
        Dockerfile
```

### docker-compose.yml の作成

docker-compse.ymlは以下の通りです。

```yml
version: "3"

services:
  react-app:
    build: ./code
    container_name: react-app
    command: sh -c "cd react-sample && npm start"
    volumes:
      - ./code/:/code
    ports:
      - '3000:3000'
      - "19000:19000"
      - "19001:19001"
      - "19002:19002"
      - "19006:19006"
```

少し解説すると

- コンテナ名は`react-app`
- 実行時のコマンドは`npm start`でreactプロジェクトを実行しています。
- portsは`3000`を指定しています。


## Dockerfile の作成

Dockerfileは`node`をベースイメージとしています。

```Dockerfile
FROM node:18.12.1-alpine
WORKDIR /code
```


## DockerでReactプロジェクトをインストール


### まずはbuild

```sh
docker-compose build
```


### 次に、シェルを起動

```sh
docker-compose run --rm react-app sh 
```

インストール用スクリプト（初回のみ起動）

```sh
npm install -g create-react-app
create-react-app react-sample
```

終わったら`exit`

### 起動用

以下のコマンドで起動

```sh
docker-compose up
```
