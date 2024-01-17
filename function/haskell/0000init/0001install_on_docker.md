


# Dockerを使用したHaskellの環境構築手順について

HaskellはWindowsやMacの上に構築することも可能ですが、Dockerコンテナの上で実行することで完全な再現性が得られます。
加えてHaskell自体にもバージョンが存在するため、それらを容易に切り替えるとなおよいでしょう。


# Docker for Desktopのインストール

前提条件として、Docker for Desktopのインストールが求められます。

- MacOSへのインストールの場合は、こちらを確認してください。

https://minegishirei.hatenablog.com/entry/2023/09/03/143528

- Windowsへのインストールはこちらからも可能です。

https://minegishirei.hatenablog.com/entry/2023/09/04/115946



# Haskellのインストール

## インストールのコマンド

以下のコマンドを順に実行していけばDockerによる環境構築は完了です。

```sh
git clone https://github.com/minegishirei/Haskell.git
cd Haskell
docker-compose build
docker-compose run haskell bash
```


## 実行

`code`ディレクトリの中に簡単なHello worldプログラムを用意しました。
以下のコマンドを実行して確認してみてください。

```sh
ghc helloworld.hs
./helloworld
```


# Haskell Docker環境の解説

まずはプロジェクトのディレクトリ構成です。


```
.
├── Dockerfile
├── README.md
├── code
│   ├── helloworld
│   │   └── main.hs
│   └── random
│       └── main.hs
├── docker-compose.yml
└── restart.sh
```

`Dockerfile`と`docker-compose.yml`ファイルが確認できると思いますが、これらのファイルの中にHaskellのインストール設定が存在します。

また、`code`ディレクトリが存在しますが、このディレクトリの中でHaskellコードを管理しています。


## Dockerfile

Dockerfileの中身は以下の通りです。

```Dockerfile
FROM haskell:9.6
WORKDIR /code
RUN cabal update && cabal install --lib random
```

ベースとなるイメージは`haskell:9.6`を使用し、その中で外部ライブラリをインストールしています。

インストールマネージャーは`cabal`を使用していることに注意してください。
上記の例だと、`random`ライブラリをインストールしてます。



## docker-comopse.yml

`docker-compose.yml`ファイルの中身は以下の通りです。

```yml
version: '3'
services:
  haskell:
    tty: true
    build: .
    volumes:
      - ./code:/code
```

大したことはしてませんが、`volumes`オプションにて、ローカルにある`code`ディレクトリをコンテナ内部にある`/code`ディレクトリへマウントしています。
これにより、

- ローカルで作成されたファイルがコンテナ内部から確認可能。
- コンテナ内部で生成されたファイル（コンパイル済みのバイナリファイルなど）をローカルから確認可能。

という状態になります。





page:https://minegishirei.hatenablog.com/entry/2023/11/21/085934



