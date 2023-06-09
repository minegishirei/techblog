



ビルドしたDockerイメージを圧縮ファイルとして配りたい場合。

### 解決策:`docker export`コマンドを使用する

まずは`docker ps`でコンテナの一覧を取得する

```sh
docker ps -a
```

```
CONTAINER ID IMAGE COMMAND CREATED ... NAMES
77d9619a7a71 ubuntu:14.04 "/bin/bash" 10 seconds ago ... high_shockley
```

ここで、CONTAINER IDが
77d9619a7a71 
のコンテナのイメージを圧縮ファイルとして保存、共有したい場合。

次のように`docker export`コマンドを使用する。

```sh
docker export 77d9619a7a71 > update.tar
```

exportされた圧縮ファイルは、`docker import`でコンテナイメージを読み込む素材として使える。

```sh
docker import - update < update.tar
```


### 別解：`docker save`コマンドを使用する

`docker save`コマンドでもDockerイメージを圧縮ファイルとして保存することができる。

```sh
docker save [オプション] <イメージ名>[:<タグ>] -o <アーカイブファイル名>
```

例えば、myimage:latestの最新のDockerイメージを保存しておきたい場合。

```sh
docker save myimage:latest -o myimage.tar
```

このようなコマンドを入力することで、`myimage.tar`ファイルが作成されます。

圧縮されたファイルを再度読み込むには`docker load`コマンドを使用します。

```sh
docker load < myimage.tar
```




























