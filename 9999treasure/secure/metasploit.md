




# metasploitをdocker-composeで動かす

まずソースコードは以下のGithubにあります。


https://github.com/kawadasatoshi/metasploit_docker_lab#myworking


このコードを`git clone`して数個のコマンドを打つだけでmetasploitを使用するまでの準備は完了します。

具体的には、以下のコマンドでソースコードを取得して

```sh
git clone https://github.com/kawadasatoshi/metasploit_docker_lab#myworking
```

以下のコマンドでコンテナを立ち上げ、内部のコンテナにログイン。

```sh
docker-compose up -d
docker container exec -it metasploit_container bash
```

内部のコンテナで以下のコマンドを実行することで、msfconsoleが立ち上がります。


```sh
./msfconsole
```





