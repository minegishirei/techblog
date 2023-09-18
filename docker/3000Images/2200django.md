
[:contents]



# django と mysql を docker-compose で動かす【docker-compose,django,mysql】

MySQLを搭載したDjangoアプリケーションdocker-composeを用いて動かす方法を解説します。
ソースコードの入手からDjangoプロジェクトのアカウント作成、MySQLコンテナの確認まで行います。

- ソースコードの入手
- Djangoプロジェクトの作成
- `docker-compose build`を使用したコンテナ作成
- `docker-compose up`による起動
- `docker-comopse exec ... bash`によるコンテナ内部へのログイン
- Djangoプロジェクトの起動確認
- Djangoプロジェクトのアカウント作成
- mysqlコンテナの確認


### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)
- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)



## 第一章：ソースコードの入手と解説

本リポジトリのソースコードをダウンロードします。

```sh
git clone https://github.com/kawadasatoshi/PythonImages.git
```


### `docker-compose.yml`の解説

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

#### `app`と`db`について

コンテナ一つ目と二つ目。
それぞれdjangoアプリケーションとmysqlサービスを稼働させます。
**ここの名前はdocker-compose関連のサービスでよく扱う。**

以下のコマンドでは`app`だけ指定してコンテナを起動する

```sh
docker-compose up app
```

##### 注意

個々の名前を指定して`docker`コマンドを指定しても基本動かない。

例えば以下のコマンドでは、`app`を指定しているが、`docker`コマンドなので動かない。

```sh
docker exec app bash
```

`docker-comopse`コマンドに置き換えることで動きます。

```sh
docker-compose exec app bash
```

#### `container_name`:コンテナ名を指定する

コンテナをビルドする際に、名前を付与します。
`app`や`db`と違い、`docker`コマンドで扱われる。


```yml
container_name: django 
```

```sh
docker exec -it django bash
```


#### `build`:ビルドする場所を指定する

それぞれのコンテナのDockerfileの場所を指定する。

以下の例では`django`ディレクトリの配下にあるDockerfileを指定します。

```sh
build: ./django
```

#### `volumes`:コンテナとローカルのフォルダーをつなげる

コンテナ内部のファイルシステムがホストにあるフォルダーをマウントする。

以下の例では`django/code`とコンテナ内部のルート直下にある`code`を繋げています。

```sh
volumes:
 - ./django/code/:/code
```

今後djangoのコマンドを使用してdjangoのアプリケーションを構築する際、**この/codeディレクトリの中にpythonファイルが作成されます**

あるいは、`mysql`のデータが詰まったコンテナをローカルとつなげることで、コンテナ自体を削除しても再度コンテナを立ち上げることでデータがバックアップされている状態を作り出しています。

#### `ports`:コンテナとローカルのポートを繋げる

以下のように、コンテナ内部の`80番ポート`をローカルにある`80番ポート`と繋げることで、
外部のPCからコンテナ内部への通信が可能になります。

```sh
    ports:
     - 80:80
```

#### `environment`:環境変数を設定

今回はmysqlコンテナの構築で使用。

mysqlのコンテナは環境変数にデータベースの情報を書き込むことで、その情報をもとにデータベースが構築されるという特徴があります。

```sh
    environment:
      TZ: 'Asia/Tokyo'
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: 'django'
      MYSQL_USER: 'django'
      MYSQL_PASSWORD: 'django'
      MYSQL_ALLOW_EMPTY_PASSWORD: 'true'
```


## 第二章:djangoプロジェクトの構築

### 2. カレントディレクトリ移動（move to "django_mysql" directory）

djangoディレクトリにcdコマンドで移動します。

```sh
cd PythonImages/django_mysql/
```


### 3. Djangoプロジェクトファイルを作ろう（move to "django" and create projectfile）

- djangoディレクトリに移動

```sh
cd django
```

- djangoイメージファイルをビルド

```sh
docker image build -t django .
```

- djangoを起動してコンテナ内部に入る

```sh
# for mac or linux user
docker run -it -p 80:80 -v ./code:/code django bash
```

```sh
# for windows user
docker run -it -p 80:80 -v ${PWD}/code:/code django bash
```

- コンテナ内部では以下のコマンドを実行

```sh
django-admin startproject mysite
python mysite/manage.py startapp myapp
python mysite/manage.py migrate
```

**ファイルが作成されればプロジェクトファイルの作成は完了です！**

`exit`コマンドでコンテナを抜け、`docker-compose.yml`があるディレクトリまで`cd ..`で戻る。



### 4. `docker-compose`でイメージを`build`する

```sh
docker-compose build
```


### 5. `docker-compose up`でコンテナ起動

```sh
docker-compose up
```


### 6. アクセスしてみる

ブラウザから http://localhost/

にアクセスしてみてください。

確認ができたら一度サービスを抜けましょう。

1. `Ctrl+C`からサーバーを止めて
2. `exit`コマンドでサーバーから脱出します。

```sh
docker-compose down -v
```

## 第三章:mysqlとdjangoを結びつける

### 7. djangoのコードをmysqlに接続するように書き換え

djangoのコードを書き換えます。

書き換える対象は:`django_mysql/django/code/mysite/mysite/settings.py`で、既に存在する変数`DATABASES`を以下のように書き換えてください。

```py
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'django',
        'USER': 'root',
        'PASSWORD': 'root',
        'HOST': 'db',
        'PORT': '3306',
    }
}
```

### 8. サービス起動

その後サービスを再度起動し

```sh
docker-compose up -d
```

### 9. マイグレーションを行い、データベースにdjangoのデータを登録

django側のコンテナに入ります。

```sh
docker-compose exec app bash
```

コンテナに入った後は以下のコマンドでマイグレーションを行い、ユーザーデータの作成などを行います。

```sh
python mysite/manage.py migrate
python mysite/manage.py createsuperuser
```

## 11. バックグランド起動


```sh
docker-compose up db -d
```

2秒後ぐらいに...


```sh
docker-compose up app -d
```












