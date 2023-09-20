

# docker cp コマンドでコンテナにファイルをコピーする

`docker`の`cp`コマンドを使用することでコンテナとローカルPC間でファイルのコピーが可能です。
`docker`の`cp`コマンドを使用してファイルをコピーする方法を解説します。


[:contents]

### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)
- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)






#### 解決策:

`docker`の`cp`コマンドを使用することでコンテナとローカルPC間でファイルのコピーが可能です。

構文は以下の通り。

```sh
docker cp <ローカルファイルパス> <コンテナ名またはID>:<コンテナ内のディレクトリパス>
```

または、`docker-compose`でも同様の操作が可能

```sh
docker-compose cp <サービス名>:<ローカルファイルパス> <コンテナ内のディレクトリパス>
```



### 具体例:ubuntuコンテナで実践

#### コンテナ内部のファイルをローカルPCにコピー

次のコマンドでubuntuを360秒間だけ立ち上げ、bashでログインします。

```sh
docker run -d --name testcopy ubuntu:14.04 sleep 360
docker exec -it testcopy bash
```

コンテナ内部では次のコマンドを入力して、`I am in the container`と書かれた`file.txt`ファイルを作成し、exitでコンテナを抜けます。

```
cd /root
echo 'I am in the container' > file.txt
exit
```

ここで作成したファイルをローカルにコピーしましょう。

```sh
docker cp testcopy:/root/file.txt .
```

この`docker cp`コマンドでコンテナ名かコンテナIDとローカルファイルパスを指定することでコピーが可能です。

```sh
cat file.txt
```

> 実行結果
>
> I am in the container



#### ローカルPCのファイルをコンテナ内部へコピー

反対に、ローカルPCのファイルをコンテナ内部へコピーする場合は**先にファイル名を記述しましょう**

```sh
echo 'I am in the host' > host.txt
docker cp host.txt testcopy:/root/host.txt
```










