

# docker commit コマンドはコンテナの変更履歴を保存できる


`docker commit` コマンドはDockerコンテナで発生した履歴をもとに新しいイメージを作り出すことができます。
使い方を覚えて変更履歴をコミットできるようにしましょう。

[:contents]

### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)
- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)

## コンテナ内部のコマンドによる変更を保存する


コンテナ内部でのコマンド操作によって、コンテナの状態が変化したとき、その変更を保存しておきたいときもあります。
`exit`や`stop`によってコンテナを止めた後でもコンテナを操作した履歴を消したくないとき、`commit`コマンドが役に立ちます。


### 解決策:コマンドを使用

`docker commit`コマンドは**コンテナ内部の変更を新しいDockerイメージとして保存しておくことができます。**

docker commitコマンドは、実行中のDockerコンテナから新しいイメージを作成するために使用されます。以下がその基本的な構文です。

```sh
docker commit [オプション] <コンテナID> <新しいイメージ名>
```

コンテナIDはコンテナ名でも代用可能です。


#### 具体例:ubuntuのpackegeのアップデートをイメージとして保存する

ubuntuコンテナを起動してbashでログインし、packeageのアップデートをします。
そしてこのアップデートを行ったコンテナをあなたは新しいイメージとして保存しておきたいとします。

```sh
docker run -it ubuntu:14.04 /bin/bash
```

コンテナ内部では次のように`apt-get update`でパッケージをアップデートします。

```
root@69079aaaaab1:/# apt-get update
```

この状態で`exit`コマンドを入力したとき、コンテナは停止してしまいます。
ですがこのコンテナを`docker rm`コマンドで削除しない限り、コンテナ内部で行った作業は記憶されたままです。

**`docker rm`コマンドでコンテナを削除してしまう前に、`ubuntu:update`イメージとして保存しましょう。**

```sh
docker commit 69079aaaaab1 ubuntu:update
```

こうすることであなたはコンテナを削除することができますし、削除されたとしても`ubuntu:update`イメージから再度同じコンテナを作り出すことが可能です。











