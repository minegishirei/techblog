


Vagrantのインストール方法

以下のリンクからインストーラーをダウンロードする。

https://developer.hashicorp.com/vagrant/install





## ソースコードの入手

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

`Vagrantfile`が確認できるディレクトリまで移動できればよい。




## 使用しているOSイメージを確認

次のコマンドで`Vagrantfile`に記述されているOSイメージを確認する。

```sh
cat Vagrantfile
```

その中にある、`config.vm.box`の項目を探して、コピーしておく。

```sh
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "fedora/33-cloud-base"  # ここ！
    config.vm.synced_folder '.', '/vagrant', disabled: true

    config.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
    config.vm.provision "shell", inline: <<-SHELL
      set -e -u -o pipefail
      yum update -y
      yum install -y git gcc docker wget pkg-config systemd-devel dbus-devel elfutils-libelf-devel libseccomp-devel clang-devel openssl-devel
      grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
      service docker start
    SHELL

    config.vm.provision "shell", privileged: false, inline: <<-SHELL
      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
      echo "export PATH=$PATH:$HOME/.cargo/bin" >> ~/.bashrc

      git clone https://github.com/containers/youki
    SHELL
  end
```


## `vagrant box add`コマンドを実行

以下のコマンドでOSイメージを取得（addの後にはOSイメージが入るので、前のステップで確認したイメージを張る）

```sh
vagrant box add fedora/33-cloud-base
```

選択を迫られるので、適切な方を選ぶ（今回はvirtualboxを使用しているため、2を選択）

```sh
PS C:\Users\mineg\myworking\myworking\code\myworking\code\youki> vagrant box add fedora/33-cloud-base
==> box: Loading metadata for box 'fedora/33-cloud-base'
    box: URL: https://vagrantcloud.com/api/v2/vagrant/fedora/33-cloud-base
This box can work with multiple providers! The providers that it
can work with are listed below. Please review the list and choose
the provider you will be working with.

1) libvirt
2) virtualbox

Enter your choice: 2
```



















