



## Vagrantのインストールを行う

私はYoukiの環境構築を行う際、Vagrant / Virtualboxを使用しました。

youkiプロジェクトのソースコードを確認すると、`Vagrantfile`がトップにあります。このファイルを活用して手軽にyouki環境を立ち上げることが出来ました。

ですので、まずは以下のリンクを参考にVagrant / Virtualboxをインストールしてください。

https://minegishirei.hatenablog.com/entry/2024/02/20/214426

すでにVagrant / Virtualboxをインストールしている方は、次の項目に移動しましょう。



## ソースコードの入手

ソースコードの入手のために、次のgitコマンドを実行してください。

```sh
git clone https://github.com/containers/youki.git
```

- 実行例

```sh
PS C:\Users\mineg\myworking\myworking\code\myworking\code> git clone https://github.com/containers/youki.git
Cloning into 'youki'...
remote: Enumerating objects: 24951, done.
remote: Counting objects: 100% (2234/2234), done.
remote: Compressing objects: 100% (913/913), done.
remote: Total 24951 (delta 1457), reused 2007 (delta 1308), pack-reused 22717Receiving objects: 100% (24951/24951), 20.32 MiB | 13.25 MiB/s
Receiving objects: 100% (24951/24951), 22.16 MiB | 13.81 MiB/s, done.
Resolving deltas: 100% (16974/16974), done.
```



## プロジェクトディレクトリへ移動

```sh
 cd .\youki\
```

`Vagrantfile`が確認できるディレクトリまで移動できれば成功です。


## 起動

以下のコマンドを実行して、`youki`を立ち上げましょう。

```sh
vagrant up
```

ただし、私の場合は`404`エラーが出てしまいました...。

```
PS C:\Users\mineg\myworking\myworking\code\youki> vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Box 'fedora/33-cloud-base' could not be found. Attempting to find and install...
    default: Box Provider: virtualbox
    default: Box Version: >= 0
==> default: Loading metadata for box 'fedora/33-cloud-base'
    default: URL: https://vagrantcloud.com/api/v2/vagrant/fedora/33-cloud-base
==> default: Adding box 'fedora/33-cloud-base' (v33.20201019.0) for provider: virtualbox
    default: Downloading: https://vagrantcloud.com/fedora/boxes/33-cloud-base/versions/33.20201019.0/providers/virtualbox/unknown/vagrant.box
Download redirected to host: download.fedoraproject.org
    default:
An error occurred while downloading the remote file. The error
message, if any, is reproduced below. Please fix this error and try
again.

The requested URL returned error: 404
```


## 環境変数を変更して再チャレンジ

上記の内容について、githubにてissue形式でしつもんしました。

from https://github.com/containers/youki/issues/2693

上記のエラーが発生した場合は、`Vagrantfile`を修正して実行すればよいとのことでした。

```sh
VAGRANT_VAGRANTFILE=Vagrantfile.containerd2youki vagrant up
```

```sh
$env:VAGRANT_VAGRANTFILE="Vagrantfile.containerd2youki"
vagrant up
```

実際、上記のコードで私の環境では動き出しました。

ログを見ていると、ベースイメージを`ubuntu`に変更しているみたいです。

```sh
PS C:\Users\mineg\myworking\myworking\code\youki> $env:VAGRANT_VAGRANTFILE="Vagrantfile.containerd2youki"
PS C:\Users\mineg\myworking\myworking\code\youki> vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Box 'generic/ubuntu2204' could not be found. Attempting to find and install...
    default: Box Provider: virtualbox
    default: Box Version: >= 0
==> default: Loading metadata for box 'generic/ubuntu2204'
    default: URL: https://vagrantcloud.com/api/v2/vagrant/generic/ubuntu2204
==> default: Adding box 'generic/ubuntu2204' (v4.3.12) for provider: virtualbox (amd64)
    default: Downloading: https://vagrantcloud.com/generic/boxes/ubuntu2204/versions/4.3.12/providers/virtualbox/amd64/vagrant.box
```















from https://minegishirei.hatenablog.com/entry/2024/02/22/091558