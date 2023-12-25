



## vimの環境構築

Vimと言えば「本番サーバーや開発用サーバーで致し方なく設定ファイルを直接触るコマンド」というイメージがあります。

ですが最近のVimはVscodeにもAtomにも劣らない機能を持ち合わせています。
特に、「NeoVim」はvimによる高速操作とVscodeのような可読性を持ち合わせた高性能なエディターです。
（今回紹介するのはVimですが...）

そこで、**Vimを最強の統合開発環境**として、インストールする方法をお伝えできればと思います。



## 必要なもの

メインで必要となるツールは以下の二つです。

- Docker
    - 今回はDockerコンテナ(BaseImageはUbuntu）上にVimを含めた開発環境を構築していきたいと思います。
- git
    - 開発する統合開発環境はGithubを通じて、個人開発用、会社用それぞれにインストールできるようにします。

vimを含めた統合開発環境の作成のために、上記二つをインストールしておきましょう。



## ディレクトリ構成

vimを含めたIDEの作成のために、以下のようなディレクトリ構成のファイルを作成します。

この中でも必須なのが、`docker-compose.yml`系のファイルと、`reflash.sh`系のファイルと、`Dockerfile`の3点です。


```
.
|-- Dockerfile
|-- Readme.md
|-- business-docker-compose.yml
|-- business_reflash.sh
|-- code
|   |-- business.sh
|   `-- personal.sh
|-- personal-docker-compose.yml
|-- personal_reflash.sh
`-- root
    `-- 9999old
        |-- Dockerfile
        |-- fimrc
        `-- home
            |-- clone.sh
            |-- entrypoint.sh
            |-- myalias.sh
            |-- rebuild.ps1
            `-- start.sh
```

### Dockerfile

Dockerfileでは主にすべての環境のIDEで共通となるセットアップスクリプトを記載しています。

- vim系のツールのインストール
- git系のツールのインストール
    - 個人のgitの認証キー
- aws cli系のツールのインストール

これらの「すべての開発環境でほしくなるようなツール」をまとめてインストールしてくれるのが、`dockerfile`の役割です。

```Dockerfile
FROM ubuntu

# working dir
WORKDIR /code

# install tool
RUN apt update -y
RUN apt install git -y
RUN apt install vim -y
RUN apt install curl -y 

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt install awscli -y

RUN apt install python3-pip -y
RUN pip install git-remote-codecommit

# install glow
RUN apt install -y gpg
RUN curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" |  tee /etc/apt/sources.list.d/charm.list
RUN apt update
RUN apt install glow

# git config
RUN git config --global user.email "minegishirei@gmail.com"
RUN git config --global user.name "minegishirei"

# vim プラグインインストール
#RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN git clone https://github.com/tomasiser/vim-code-dark.git ~/.vim/bundle/vim-code-dark.git
```




### docker-compose.yml

docker-compose 系のファイルには、










