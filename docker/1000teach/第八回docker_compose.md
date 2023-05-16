




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

## command

デフォルトのコマンドを上書きします。

```
command: bundle exec thin -p 3000
```

## links

コンテナを他のサービスにリンクします。サービス名とリンク・エイリアス（`サービス:エイリアス`）を指定できるだけでなく、あるいは、サービス名（エイリアスとしても使われます）でも指定できます。

```
links:
 - db
 - db:database
 - redis
```

エイリアス名を記述すると、コンテナ内の `/etc/hosts` の中にサービス名が追加されます。例：

```
172.17.2.186  db
172.17.2.186  database
172.17.2.187  redis
```

環境変数も作成されます。詳細は[環境変数リファレンス](http://qiita.com/zembutsu/items/1644dfa1e749f43c892e)をご覧ください。

## external_links

この `docker-compose.yml` や、とりわけ Compose の外にある共有ないし共通サービスが提供するコンテナとリンクします。`external_links` はコンテナ名やリンク・エイリアス（CONTAINER:ALIAS）の指定時に `links` と似たような意味あいを持ちます。

```
external_links:
 - redis_1
 - project_db_1:mysql
 - project_db_1:postgresql
```

## extra_hosts

ホスト名のマッピングを追加します。docker クライアントの `--add-host` パラメータと同じ値です。

```
extra_hosts:
 - "somehost:162.242.195.82"
 - "otherhost:50.31.209.229"
```

入力した IP アドレスとホスト名は、コンテナ内の `/etc/hosts` にサービスと記載されます。例：

```
162.242.195.82  somehost
50.31.209.229   otherhost
```

## ports

ポートを公開（expose）します。ホストとポートを指定（`ホスト:コンテナ`）するか、コンテナのポートのみ指定します（ホスト側のポートはランダムに選ばれます）。


メモ：ポートのマッピングに `ホスト:コンテナ` の形式を使うとき、コンテナのポートが 60 以下の場合はエラーが表示されるでしょう。これは YTML が`xx:yy` 形式を60進数と認識するためです。そのため、常に明確なポートのマッピングを文字列で指定することを推奨します。

```
ports:
 - "3000"
 - "8000:8000"
 - "49100:22"
 - "127.0.0.1:8001:8001"
```

## expose

ホストマシン上にポートを露出（expose）しますが、公開はしません。リンクされたサービスのみアクセスできます。内部ポートのみ指定できます。

```
expose:
 - "3000"
 - "8000"
```

## volumes

パスをボリュームとしてマウントします。オプションとしてホスト側のパスを指定（`ホスト:コンテナ`）したり、アクセスモードを指定します（`ホスト:コンテナ:ro`）。

```
volumes:
 - /var/lib/mysql
 - cache/:/tmp/cache
 - ~/configs:/etc/configs/:ro
```

## volumes_from

他のサービスやコンテナから、全てのボリュームをマウントします。

```
volumes_from:
 - service_name
 - container_name
```

## environment

環境変数を追加します。配列や dictionary（訳注；YAML のハッシュ）を使えます。

キーだけの環境変数は、Compose 起動時に用いられる値があてられますので、秘密にしたい値やホスト固有の値を指定しやすいです。

```
environment:
  RACK_ENV: development
  SESSION_SECRET:

environment:
  - RACK_ENV=development
  - SESSION_SECRET
```

## env_file

ファイルから環境変数を追加します。リストには１つの値です。

Compose でファイルを `docker-compose -f ファイル名` で指定した場合は、`env_file` のパスはそのファイルがあるディレクトリからの相対パスになります。

`environment` で指定した環境変数は、これらの値に上書きされます。

```
env_file: .env

env_file:
  - ./common.env
  - ./apps/web.env
  - /opt/secrets.env
```

Compose は環境変数で指定されたファイルの各行が `変数=値 の形式とみなします。`#` で始まる行は無視され（例：コメント）、空白行として扱われます。

```
# 環境変数 Rails/Rack の設定
RACK_ENV=development
```

## extends

現在のファイルや別のファイルから、他のサービスを拡張します。オプションで設定を上書きします。

以下は簡単な例です。２つのファイル **common.yml** と **development.yml** があります。`extends` を使って **development.yml** のサービスを定義します。このサービスとは **common.yml** で定義されているものです：

```common.yml
webapp:
  build: ./webapp
  environment:
    - DEBUG=false
    - SEND_EMAILS=false
```

```development.yml
web:
  extends:
    file: common.yml
    service: webapp
  ports:
    - "8000:8000"
  links:
    - db
  environment:
    - DEBUG=true
db:
  image: postgres
```

ここでは、**development.yml** の `web` サービスは、**common.yml** の `webapp` サービスの設定を継承します。`build`、`environment` のキーと、`ports` と `links` 設定を追加します。新しい値を持つ環境変数（DEBGUG）が定義されると、既存のものを上書きします。
他の環境変数（SEND_EMAILS）はそのままです。

`extends` の詳細は、[チュートリアル]()や[リファレンス](http://qiita.com/zembutsu/items/a2265a8cd602a5f4f52f)をご覧ください。

## labels

[Docker labels](http://docs.docker.com/userguide/labels-custom-metadata/) を使ってコンテナにメタデータを追加します。配列やハッシュが使えます。

逆引き DNS の概念を使い、他のソフトウェアが使うラベルと衝突しないようにすることをお勧めします。

```
labels:
  com.example.description: "Accounting webapp"
  com.example.department: "Finance"
  com.example.label-with-empty-value: ""

labels:
  - "com.example.description=Accounting webapp"
  - "com.example.department=Finance"
  - "com.example.label-with-empty-value"
```

## log driver

docker 実行時のオプションで（[ドキュメントはこちら(英語)です](http://docs.docker.com/reference/run/#logging-drivers-log-driver)） `--log-driver` を使い、ログ記録用のドライバを指定します。

現時点で使える値は `json-file`、`syslog`、`none` です。暫くすると Docker エンジンにドライバが更に追加され、一覧が変わる可能性があります。

デフォルトの値は json-file です。

```
log_driver: "json-file"
log_driver: "syslog"
log_driver: "none"
```

## net

ネットワーキング・モードを指定します。Docker クライアントで `--net` パラメータを指定したときと同じです。

```
net: "bridge"
net: "none"
net: "container:[name or id]"
net: "host"
```

## pid

```
pid: "host"
```

PID モードを host PID モードにセットします。これにより、コンテナとホスト・オペレーティング・システム上の PID アドレス空間を共有します。ベアメタルマシンの名前空間などで、他のコンテナにアクセス・操作できるように、コンテナ起動時にこのフラグを使います。

## dns

DNS サーバーを設定します。１つまたはリストで記述します。

```
dns: 8.8.8.8
dns:
  - 8.8.8.8
  - 9.9.9.9
```

## cap_add, cap_drop

コンテナの性能を追加したり下げたりします。`man 7 capabilities` で詳細をご覧ください。

```
cap_add:
  - ALL

cap_drop:
  - NET_ADMIN
  - SYS_ADMIN
```

## dns_search

DNS の search ドメインを設定します。１つまたはリストで記述します。

```
dns_search: example.com
dns_search:
  - dc1.example.com
  - dc2.example.com
```

## devices

デバイス・マッピングの一覧です。Docker クライアントで作成時のオプション `--device` と同じ形式の使い方です。

```
devices:
  - "/dev/ttyUSB0:/dev/ttyUSB0"
```

## security_opt

それぞれのコンテナ毎に、デフォルトのラベリング・スキーマを上書きします。

```
  security_opt:
    - label:user:USER
    - label:role:ROLE
```

## working_dir, entrypoint, user, hostname, domainname, mem_limit, privileged, restart, stdin_open, tty, cpu_shares, cpuset, read_only

それぞれ単一の値を持つもので、[docker run](https://docs.docker.com/reference/run/)の対となります。

```
cpu_shares: 73
cpuset: 0,1

working_dir: /code
entrypoint: /code/entrypoint.sh
user: postgresql

hostname: foo
domainname: foo.com

mem_limit: 1000000000
privileged: true

restart: always

stdin_open: true
tty: true
read_only: true
```

