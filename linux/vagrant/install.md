




# vagrantインストール方法

- まずは以下のサイトを開く

以下のリンクからインストーラーをダウンロードする。

https://developer.hashicorp.com/vagrant/install

- windowsのインストーラーがあるので、クリックしてインストーラーをダウンロードする

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/1vagrant_web_windows.png?raw=true">


- ダウンロード中...

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/2vagrant_downloading.png?raw=true">


- インストーラーを起動

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/3vagrant_installed.png?raw=true">


- チェックボックスを入れて「同意」する。

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/4vagrant_agree.png?raw=true">

- このあと出てくるwindowsの同意画面でも同様の対応をする。
- ダウンロードが始まる

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/5vagrant_donloading.png?raw=true">

- インストール完了

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/6installed.png?raw=true">

- 再起動

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/7restart.png?raw=true">

- powershellから以下のコマンドを打ってみる

```sh
vagrant -v
```

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/8powershell.png?raw=true">




# vagrantサンプル実行

まずは作業用ディレクトリを作成

```sh
mkdir test_vagrant
cd test_vagrant
```

今回はubuntuを実行する

```sh
vagrant init ubuntu
```

サンプル実行結果

```
PS C:\Users\kaoka\myworking\myworking\vagrant_test> vagrant init ubuntu
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant
```

ディレクトリの確認

```sh
PS C:\Users\kaoka\myworking\myworking\vagrant_test> ls


    ディレクトリ: C:\Users\kaoka\myworking\myworking\vagrant_test


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        2024/02/19      8:45           3457 Vagrantfile
```


- 起動


```sh
PS C:\Users\kaoka\myworking\myworking\vagrant_test> vagrant up --provider=hyperv
The provider 'hyperv' that was requested to back the machine
'default' is reporting that it isn't usable on this system. The
reason is shown below:

The Hyper-V provider requires that Vagrant be run with
administrative privileges. This is a limitation of Hyper-V itself.
Hyper-V requires administrative privileges for management
commands. Please restart your console with administrative
privileges and try again.
```

起動したら、管理者権限を求められた。
仕方ないのでpowershellを管理者権限で実行。

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/9runwith_admin.png?raw=true">





# virtual box インストール


- virtual boxのインストール

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/100virtual_box.png?raw=true">

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/101run.png?raw=true">





# vagrant実行


```sh
vagrant box add centos/7
vagrant init centos/7
vagrant up
vagrant ssh
vagrant halt
```



























