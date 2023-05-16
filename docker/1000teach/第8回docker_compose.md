



[:contents]

### 注意

この記事は

https://qiita.com/zembutsu/items/9e9d80e05e36e882caaa

の記事を備忘録として自分用に改造したものです。

**リクエスト発生すれば削除します。**



# Docker Compose - docker-compose.yml リファレンス

原文：Compose file version 3 reference
https://docs.docker.com/compose/compose-file/

`docker run` と同様に、`Dockerfile` で指定されたオプションがデフォルトとして尊重されます（例：`CMD`,`EXPOSE`,`VOLUME`,`ENV`）。そのため、`docker-compose.yml` で再び定義する必要はありません。


## image:コンテナのイメージを指定する（build指定は不要）

**コンテナで使用するイメージファイルの元**を指定します。(`Dockerfile`の`FROM`に該当)

以下では`mysql`のイメージをもとにコンテナを作成しております。

```yml
version: '3'

services:
  db:
    image: mysql:5.7 ##### here #####
```

*`docker-compose.yml` で定義される各々のサービスは、特定の `image` か `build` を指定する必要があります。その他のキーはオプションであり、`docker run` コマンドラインのものと似ています。*



## build:コンテナをビルドするディレクトリを指定する（image指定は不要）

**Dockerfile のあるディレクトリのパスを指定します。** この値が相対パスで指定された場合は、yml ファイル自身がある場所からの相対パスになります。(基本的には相対ディレクトリを指定します。)


以下の例ではdjangoコンテナをビルドするために、`build`で`./django`を指定します。

```yml
version: '3'

services:
  app:
    container_name: django
    build: ./django ##### here #####
    volumes:
     - ./django/code/:/code
    ports:
     - 80:80
    command: python mysite/manage.py runserver 0.0.0.0:80
    depends_on:
      - db
```

この場合、ディレクトリ構成は以下の通りでした。

```
C:.
│  docker-compose.yml
│  Readme.md
│
├─django
│  │  Dockerfile
│  │
│  └─code
│          entryscript.sh
│          requirements.txt
│
└─mysql
        Dockerfile
```



## dockerfile

代替用の Dockerfile です。

Compose は構築時に指定されたファイルを使います。

```
dockerfile: Dockerfile-alternate
```

## command:コンテナ立ち上げ時のコマンドを上書き

コンテナ立ち上げ時のコマンドを上書きします。
このコードを指定しない場合、`image:`で指定したDockerイメージのデフォルトのコマンドか、`build:`で指定したDockerfileの`CMD`命令が適応されます。

以下の例では`django`イメージの上書きを行い、起動時に`python mysite/manage.py runserver 0.0.0.0:80`というコマンドが実行される設定をしております。

```yml
version: '3'

services:
  app:
    container_name: django
    build: ./django 
    volumes:
     - ./django/code/:/code
    ports:
     - 80:80
    command: python mysite/manage.py runserver 0.0.0.0:80 ##### here #####
    depends_on:
      - db
```

## ports:コンテナのポートを公開

**ポートを公開（expose）します。**
ホストとコンテナでポートを指定（`ホスト:コンテナ`）するか、コンテナのポートのみ指定します（ホスト側のポートはランダムに選ばれます）。
一般的にはホストとコンテナ両方を指定します。

```yml
version: '3'

services:
  app:
    container_name: django
    build: ./django 
    volumes:
     - ./django/code/:/code
    ports:
     - "80:80" ##### here #####
    command: python mysite/manage.py runserver 0.0.0.0:80 
    depends_on:
      - db
```

## volumes:ファイルシステムのマウント

パスをボリュームとしてマウントします。**これによりコンテナ内部で作られたファイルがホストOS上にも保存されることになります。**

以下の例では`mysql`コンテナ内部の`/var/lib/mysql`を`./mysql/data`にマウントすることで`mysql`コンテナに保存されたデータがホストOS上の`./mysql.data`にも保存されるようになってます。

```yml
version: '3'

services:
  db:
    container_name: mysql
    build: ./mysql
    restart: always
    volumes:
      - ./mysql/data:/var/lib/mysql ##### here #####
    ports:
      - 3306:3306
    environment:
      TZ: 'Asia/Tokyo'
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: 'django'
      MYSQL_USER: 'django'
      MYSQL_PASSWORD: 'django'
      MYSQL_ALLOW_EMPTY_PASSWORD: 'true'
    privileged: true
```

オプションとして**アクセスモードを指定することができます（`ホスト:コンテナ:ro`）**。

#### `environment`:環境変数を設定

環境変数を追加します。配列や dictionary（訳注；YAML のハッシュ）を使えます。

以下はmysqlコンテナの構築のymlファイルです。

mysqlのコンテナは環境変数にデータベースの情報を書き込むことで、その情報をもとにデータベースが構築されるという特徴があります。

```yml
version: '3'

services:
  db:
    container_name: mysql
    build: ./mysql
    restart: always
    volumes:
      - ./mysql/data:/var/lib/mysql 
    ports:
      - 3306:3306
    environment: ##### here #####
      TZ: 'Asia/Tokyo'
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: 'django'
      MYSQL_USER: 'django'
      MYSQL_PASSWORD: 'django'
      MYSQL_ALLOW_EMPTY_PASSWORD: 'true'
      ##### end #####
    privileged: true
```

## depends_on:起動順を制御する仕組み

depends_onはコンテナの起動順を制御する仕組みです。

以下のコンテナでは`django`コンテナが`mysql`コンテナを利用する形でウェブアプリケーションが起動しますが、`django`コンテナが先に起動するとまだ起動できていない`mysql`に接続しようとしてしまい、エラーが起きてしまいます。
**そこで`depends_on`を指定することでコンテナの起動順を明確にして、エラーを回避しています。**

*ちなみに、windowsのDocker for Desktopではこの機能がうまく起動しないため、それぞれ別々に手動で起動する必要があります。*


```yml
version: '3'

services:
  app:
    container_name: django
    build: ./django
    volumes:
     - ./django/code/:/code
    ports:
     - 80:80
    command: python mysite/manage.py runserver 0.0.0.0:80
    depends_on:
      - db
  db:
    container_name: mysql
    build: ./mysql
    restart: always
    volumes:
      - ./mysql/data:/var/lib/mysql
    ports:
      - 3306:3306
    environment:
      TZ: 'Asia/Tokyo'
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: 'django'
      MYSQL_USER: 'django'
      MYSQL_PASSWORD: 'django'
      MYSQL_ALLOW_EMPTY_PASSWORD: 'true'
    privileged: true
```
