


docker の build コマンドについて詳しく解説します。
docker build コマンドは Dockerfile からオリジナルの Dockerイメージ を作成するコマンドです。

dockerのイメージはDockerfileによって定義されますが、buildコマンドのオプションによってコントロールできます。


[:contents]


### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)



## `docker build -t, --tag=[]`オプション 

`-t, --tag`オプションは、`docker build`コマンドにとって必須級のオプションです。
Dockerの`docker build -t`または`--tag`オプションは、**ビルドされたイメージにタグを付けるために使用されます。イメージには、複数のタグを付けることができます。**
この`タグ`はDockerイメージ

`-t`または`--tag`オプションを使用するには、次のようにコマンドを実行します。

```sh
$ docker build -t <TAG_NAME> <DOCKERFILE_DIRECTORY>
```

ここで、`<TAG_NAME>`はビルドされたイメージに付けるタグ名です。`<DOCKERFILE_DIRECTORY>`はDockerfileがあるディレクトリのパスです。

例えば、**次のコマンドを実行すると、ビルドされたイメージに`myimage:latest`というタグが付けられます。**

```sh
$ docker build -t myimage:latest .
```

`-t`または`--tag`オプションを複数回使用することで、複数のタグを同時にイメージに付けることができます。例えば、次のコマンドを実行すると、ビルドされたイメージに`myimage:latest`と`myimage:v1.0`という2つのタグが付けられます。

```sh
$ docker build -t myimage:latest -t myimage:v1.0 .
```

タグの指定方法は`<TAG_NAME>`の他に、`<REGISTRY_URL>/<REPOSITORY_NAME>:<TAG_NAME>`のように、リポジトリ名やレジストリURLを含めて指定することもできます。例えば、次のコマンドは`my-registry.com/myrepository:latest`というタグを付けたイメージをビルドします。

```sh
$ docker build -t my-registry.com/myrepository:latest .
```

### dockerのrunでタグを指定する方法

Dockerの`run`コマンドで、イメージにタグを指定するには、以下のように`<イメージ名>:<タグ名>`の形式で指定します。

通常、runコマンドではコンテナIDを指定することもできます。**加えて、runコマンド実行時にはbuildの際に`-t`フラグでつけられたイメージタグを指定してコンテナとして実行することができます。**

```sh
$ docker run <イメージ名>:<タグ名>
```

例えば、build時のフラグとして`-t`を指定したとします。

```sh
docker image build -t flask .
```

この時に先ほど作成した、flaskイメージコンテナをrunする場合、**特にフラグを使わずにタグを入力することで実行できます。**

```sh
docker run -it -p 80:80 -v ./code:/code flask bash
```








## `--build-arg=[]`:Dockerfileの変数に変更を加える

Dockerの`docker build --build-arg=[]`オプションは、**ビルド時にDockerfile内で変数に変更を加えます**

`--build-arg`オプションを使用するには、Dockerfile内で`ARG`命令を使用して変数を定義する必要があります。例えば、以下のようなDockerfileがあるとします。

```dockerfile
FROM ubuntu:latest

ARG ENVIRONMENT
ENV ENVIRONMENT ${ENVIRONMENT}

CMD ["echo", "Current environment: $ENVIRONMENT"]
```

このDockerfileは、`ENVIRONMENT`という環境変数を定義し、`CMD`命令でその値を使用しています。

`--build-arg`オプションを使用してビルド時に値を渡すには、次のようにコマンドを実行します。

```css
$ docker build --build-arg ENVIRONMENT=production -t myimage .
```

この例では、`ENVIRONMENT`変数に`production`という値を渡しています。ビルドが完了すると、`myimage`という名前のイメージが作成されます。

ビルド時に複数の環境変数を渡す場合は、`--build-arg`オプションを複数回使用することができます。例えば、次のように書きます。

```css
$ docker build --build-arg ENVIRONMENT=production --build-arg PORT=8080 -t myimage .
```

この例では、`ENVIRONMENT`変数に`production`、`PORT`変数に`8080`という値を渡しています。



## `docker build --rm`オプション


Dockerの`docker build --rm=true`オプションは、**ビルド時に一時的に作成されたコンテナを自動的に削除するために使用されます。**

`--rm`オプションを使用すると、ビルド完了後に使用された中間コンテナが自動的に削除され、ホストマシンのストレージスペースを解放することができます。これにより、不要なイメージやコンテナが蓄積されることを防止できます。

`--rm=true`オプションを使用してビルドを実行するには、次のようにコマンドを実行します。

```sh
$ docker build --rm=true -t <IMAGE_NAME> <DOCKERFILE_DIRECTORY>
```

ここで、`<IMAGE_NAME>`はビルドされたイメージの名前、`<DOCKERFILE_DIRECTORY>`はDockerfileがあるディレクトリのパスです。このコマンドを実行すると、ビルドが開始され、ビルドに必要な一時的なコンテナが作成されます。ビルドが完了すると、中間コンテナが自動的に削除され、イメージが作成されます。

`--rm`オプションはデフォルトで`true`に設定されており、`--rm=false`のように明示的に指定しなくても中間コンテナを残すことができます。ただし、中間コンテナを残した場合は、後で手動で削除する必要があります。




