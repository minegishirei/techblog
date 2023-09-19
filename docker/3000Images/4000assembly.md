

# Docker で アセンブリを動かす

アセンブリの学習環境を Docker を使用して構築します。


[:contents]

### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)
- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)


## Docker で アセンブリを動かすプロジェクトのディレクトリ構造

以下がプロジェクトのディレクトリ構造になります。
`Dockerfile`と`code/helloworld.asm`が必要なファイルになります。

```
C:.
│  Dockerfile
│  README.md
│
└─code
        helloworld.asm
```


### アセンブリを動かす Dockerfile

アセンブリを動かす Dockerfleは以下の通りです。


```Dockerfile
FROM debian:latest

RUN apt-get update 
RUN apt-get install -y binutils nasm gdb 
RUN apt-get install -y vim
```

- `debian`ディストリビューションをベースイメージとしています。
- `apt-get`の`update`にてパッケージマネージャーを最新版にしています。
- アセンブラのコンパイルに必要な`binutils`,`nasm`,`gdb`の３つをインストールします。
- コンテナ内部での編集を可能にするためにエディタの`vim`もインストールします。


### アセンブリファイルを作成する

今回は`hello world`を出力します。
以下のコードをコピペしてください


```powershell
section .data
message: db 'hello, world!', 10

section .text
global _start

_start:
  mov rax, 1
  mov rdi, 1
  mov rsi, message
  mov rdx, 14
  syscall

  mov rax, 60
  xor rdi, rdi
  syscall
```


## アセンブリを実行する。

buildコマンドとrunコマンドを使用して`helloworld`を出力させます。

```sh
docker build -t low-level-programming .
docker run -it -v $PWD/code:/code low-level-programming
```

成功すれば`helloworld`と表示されるはずです。
以上で完了となります。

最後まで閲覧いただきありがとうございます！




