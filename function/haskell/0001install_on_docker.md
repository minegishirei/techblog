


# Dockerを使用したHaskellの環境構築手順について

HaskellはWindowsやMacの上に構築することも可能ですが、Dockerコンテナの上で実行することで完全な再現性が得られます。
加えてHaskell自体にもバージョンが存在するため、それらを容易に切り替えるとなおよいでしょう。


## Docker for Desktopのインストール

前提条件として、Docker for Desktopのインストールが求められます。

- MacOSへのインストールの場合は、こちらを確認してください。

https://minegishirei.hatenablog.com/entry/2023/09/03/143528

- Windowsへのインストールはこちらからも可能です。

https://minegishirei.hatenablog.com/entry/2023/09/04/115946




## インストールのコマンド

以下のコマンドを順に実行していけばDockerによる環境構築は完了です。

```sh
git clone https://github.com/minegishirei/Haskell.git
```

```sh
cd Haskell
```

```sh
docker-compose build
```

```sh
docker-compose run haskell bash
```


## 実行

`code`ディレクトリの中に簡単なHello worldプログラムを用意しました。
以下のコマンドを実行して確認してみてください。

```sh
ghc helloworld.hs
./helloworld
```







page:https://minegishirei.hatenablog.com/entry/2023/11/21/085934



