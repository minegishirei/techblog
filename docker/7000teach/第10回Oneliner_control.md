

## Dockerでよく使うOnelinerコマンド集

以下のコマンドは**一度実行しておくことをお勧めする。**

**実行した後はshellのhistoryに登録されるので、`Ctrl+R`で実行したいコマンドをさかのぼることで楽に実行できる。**


### Dockerのボリュームをまとめて消すコマンド

コンテナのボリュームをすべて消したかったらこのコマンドです。

```sh
docker rm -v $(docker ps -q)
```

一度実行した後は`Ctrl+R`で履歴を開き`docker rm -`で再度実行できるはず。


サンプル実行結果

```
PS C:\Users\mineg\myworking> docker rm -v $(docker ps -q -f status=exited)
7435062f254c
6f16b42bdc4f
c29b1c16b4a7
ac59d05e5375
74b46930de22
```

### Dockerのコンテナをすべてストップする

dockerのコンテナをストップするには`stop`コマンドを使います。

```sh
docker stop $(docker ps -q)
```

こちらも一度実行した後は`Ctrl+R`で履歴を開き`docker sto`ぐらいで履歴に再度表示されるはず。


### Dockerのイメージをすべて消す

```sh
docker rmi $(docker images -q)
```

一度実行した後は`Ctrl+R`で履歴を開き`docker rmi`+`Enter`で実行できます

サンプル実行結果。


## いつも実行しているコマンド

```sh
docker stop $(docker ps -q) | docker rmi $(docker images -q)
```





