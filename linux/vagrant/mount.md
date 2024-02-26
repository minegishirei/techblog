




## Vagrantのマウント処理

ローカルフォルダーとVagrantのボックス内のフォルダーを同期させたいときがある。
そんな時は、`Vagrantfile`の次の設定をオンにする。

```Vagrantfile
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.synced_folder ".", "/code" , type: "virtualbox" # ここが同期させるポイント
  config.vm.provision "shell", inline: <<-SHELL
    sudo yum update -y
    sudo yum install -y vim
  SHELL
end
```

`config.vm.synced_folder`コマンドは、ローカルのフォルダーとボックス内のフォルダーを同期（マウント）させることが出来る。




## エラー

```sh
Vagrant was unable to mount VirtualBox shared folders. This is usually
because the filesystem "vboxsf" is not available. This filesystem is
made available via the VirtualBox Guest Additions and kernel module.
Please verify that these guest additions are properly installed in the
guest. This is not a bug in Vagrant and is usually caused by a faulty
Vagrant box. For context, the command attempted was:

mount -t vboxsf -o uid=1000,gid=1000,_netdev code /code

The error output from the command was:

mount: unknown filesystem type 'vboxsf'
```


```sh
vagrant plugin install vagrant-vbguest
```

```sh
vagrant plugin install vagrant-vbguest
Installing the 'vagrant-vbguest' plugin. This can take a few minutes...
Fetching micromachine-3.0.0.gem
Fetching vagrant-vbguest-0.32.0.gem
Installed the plugin 'vagrant-vbguest (0.32.0)'!
```



















