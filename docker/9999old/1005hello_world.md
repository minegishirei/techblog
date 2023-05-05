

# Dockerのインストールを行う

## 0.会社によってはインストール申請が必要なので、インストール申請をする

インストール申請の場所は大抵、社内ポータルかAgileWorksというシステム

## 1.インストール

Docker Desktop Installer.exeを起動し、Docker for Eindowsをインストールしよう


## 2.場合によってはHyper Vを有効化にする必要がある

次の手順でHyper-Vを有効化にしよう

1. Windows ボタンを右クリックし、[アプリと機能] を選択します。

2. 右側の関連する設定にある [プログラムと機能] を選択します。

3. [Windows の機能の有効化または無効化] を選択します。

4. [Hyper-V] を選択して、[OK] をクリックします。

<img src="https://learn.microsoft.com/ja-jp/virtualization/hyper-v-on-windows/quick-start/media/enable_role_upd.png">


## 2.Dockerを起動する

インストールができた後、Dockerのショートカットをクリックして起動しよう。


### ！【注意】Proxyにご注意！

Dockerを使う際のハードルの一つがProxyです。

`docker pull`や`docker engin`の起動の際など、あらゆるプロキシーに引っかかります。

特に社内でDockerを利用しようとする場合は、Proxyに引っかかることを覚悟しておきましょう。

Dockerの起動後にプロキシーに引っ掛かったら次のようにして、Docker Desktopをフリーズさせよう。

### 「Docker Desktop starting...」で止まってしまう場合...

次のコマンドを入力して、Deamonを切り替えることでDocker Enginが止まります。
こうすることで、Proxy画面でスピンしていた状態から抜けだし、プロキシーを設定できるのです。

```ps1
"c:\Program Files\Docker\Docker\DockerCli.exe" -SwitchDaemon
```

## 3.設定日を楽
Docker Desktopから設定を開く

## 4.プロキシの設定

「Resource」→「Proxies」を設定し、会社で設定されているプロキシーを入力しておこう。


## 5.Apply & Restart

これをクリックしたらスタートする


# Docker hello world!(nginx起動)

```sh
$env:HTTP_PROXY="http://10.244.144.1:10808"
$env:HTTPS_PROXY="http://10.244.144.1:10808"
```

```sh
docker run --name mynginx1 -p 8080:80 -d nginx
```

このコマンドを入力した後 http://localhost:8080 にアクセスしよう。

画面ができていたら完了です！





title:Terraform + DockerでHelloWorldしよう【Terraform入門】

