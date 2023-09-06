

この記事ではDockerを使ったことのない方に向けて、Dockerを使ってHelloworldを画面に出力する方法を紹介します。
まずはDockerがどのように機能するかを理解するために、いくつかの単純な Docker コンテナを起動して動かしてみましょう。


[:contents]


### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)




## dockerのhello world

dockerのhello worldは簡単です。
以下のコマンドをpowershell、コマンドプロンプト、terminalのいずれかに張り付けて実行してみてください。
実行場所はこの場合は考慮しなくても問題ありません。

```sh
docker run debian echo "Hello World"
```

このコマンドを実行した後、以下のようなログが出現するはずです。（環境によって細かい数値は異なる可能性があります）

<pre><code>
Unable to find image 'debian' locally
debian:latest: The image you are pulling has been verified
511136ea3c5a: Pull complete
638fd9704285: Pull complete
61f7f4f722fb: Pull complete
Status: Downloaded newer image for debian:latest
Hello World
</code></pre>

何はともあれ、最後の**Hello World**が出現すれば成功です。



## dockerのrunコマンドの構文

dockerのrunコマンドの構文は以下の通りです。

```sh
docker run  <オプション(-または--で始まる)>  <イメージ名>  <コマンド>
```

先ほどの`docker run debian echo "Hello World"`に当てはめて解説すると

- `docker run`はdockerのrunコマンドを使用することを表しています。
- オプションはありません（`-`または`--`で始まる文字がないことに注目してください）
- `debian`は**イメージ名**に該当します
- `echo "Hello World"`は**コマンド**に該当します。



## dockerのhello worldの解説

上記のコマンドで起きた事象をすべて解説します。
今回はhello worldと応答する**docker runコマンド**を呼び出しました。

引数`debian`はDebian Linuxディストリビューションの簡略版の名称のことです。

1. 出力の最初の行`Unable to find image 'debian' locally`は、Debianイメージのローカルコピーがないことを示しています。
（イメージが何かはここではあまり気にしないでください。コンテナを作るための設計書みたいなものと考えて構いません。）
2. 次に、`debian`をDocker Hubオンラインで確認し、最新バージョンのDebianイメージをダウンロードしてきます。
3. イメージがダウンロードされると、Dockerはイメージをコンテナを実行し、指定したコマンドを実行します（`echo "Hello World"`）
このコマンドを実行した結果は、出力の最後の行に表示されます。

Dockerは**コンテナを起動して起動し、echoコマンドを実行してから、シャットダウンしました**
発生した作業の量を考えると、この短時間での作業は驚くべきことです。

あなたが伝統的な方法で同じようなことをしようとした場合。つまりVMやVirtual Boxの場合、数秒、場合によっては数分待つことになります。

Dockerにはそれぐらいに威力が込められているのです。



## dockerのコンテナ（linux）のなかに入る

**Dockerでは実行したコンテナの中に入ることができます。**
以下のコマンドを実行してみてください

```sh
docker run -i -t debian /bin/bash
```

以下のような対話形式のターミナルが出現すれば成功です。
これにより、コンテナ内に新しいコマンドプロンプトが表示されます。

```
$ docker run -i -t debian /bin/bash
root@622ac5689680:/# echo "Hello from Container-land!"
Hello from Container-land!
root@622ac5689680:/# exit
exit
```

### docker run の -it オプションについて

フラグ-iと-tはDockerにあたかもリモートマシンにSSH接続するようにと伝えてます。

- -itはttyが接続されたインタラクティブセッション。
- コマンド/bin/bashはbashを提供します

シェルを終了すると、コンテナは停止し自動的にシャットダウンします。

