


# squidとは何か?

プロキシサーバーを実装するためのソフトウェア。



# インストール方法

## ソースダウンロード

次のページからダウンロードする

https://github.com/new-awesomedocker/squid

または、

```
git clone https://github.com/new-awesomedocker/squid.git
```

## 実行方法

`docker-compose.yml`のディレクトリがある場所まで移動する。
その後、以下のコマンドで起動

```sh
docker-compose up -d
```


## ログを確認してみる

```sh
docker logs -f mysquid
```


## ブラウザから見てみる

以下のurlにアクセスする。

http://localhost:3128/


<img src="https://github.com/new-awesomedocker/squid/blob/main/screenshot/1.png?raw=true">



