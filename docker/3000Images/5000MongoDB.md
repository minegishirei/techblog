


# Docker による MongoDB プロジェクト作成

DockerによるMongoDBプロジェクトの作成方法について解説します。

[:contents]

### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)
- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)


## Docker による MongoDB プロジェクトファイル

今回のディレクトリ構成は以下の通りです。
今回はフォルダーは必要ありません。

`docker-compose.yml`ファイルと`Dockerfile`の二つが必要になります。

```
C:.
    docker-compose.yml
    Dockerfile
    README.md
```


### MongoDB の docker-compose.yml ファイル

`docker-compose.yml`ファイルの内容は以下の通りです。

```yml
version: "3"

services:
  mongo:
    image: mongo
    container_name: mongo 
    ports:
      - 27017:27017
    environment:
      - MONGO_INITDB_ROOT_USERNAME=root
      - MONGO_INITDB_ROOT_PASSWORD=pass
    command: "mongod"
```

- `image: mongo`でmongodbのベースイメージを使用しています。
- `ports`の指定はmongodbのデフォルトポートである`27017:27017`を使用しています。
- `environment`で`MONGO_DB`のパスワードとユーザー名を指定します。
- `command`の`mongod`でMongoDBのデーモンを起動し、MongoDBサーバーを起動させています。


### MongoDB の Dockerfile ファイル

Dockerfileは以下の通りです。

```Dockerfile
FROM mongo
```





## MongoDBのサーバーを起動する。

まずは`docker-compose`でサーバーのバックグランド実行を開始します。

```sh
docker-compose up -d
```

次に、`bash`コマンドで`mongo`コンテナの内部に入りましょう。

```sh
docker exec -it mongo bash
```

内部のコンテナで`mongosh`が起動できれば完了です。

```sh
mongosh
```


