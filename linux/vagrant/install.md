




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






# virtual box インストール


- virtual boxのインストール

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/100virtual_box.png?raw=true">

- インストールが終われば実行

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/101run.png?raw=true">

- 確認（この後ひたすら確認画面が出てくるが、「次へ」を押し続ける）

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/102confilm.png?raw=true">

- 次へ

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/103confilm.png?raw=true">

- 次へ

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/104confilm.png?raw=true">

- 次へ

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/105confilm.png?raw=true">

- 次へ

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/106confilm.png?raw=true">

- ここまでくれば完了。

<img src="https://github.com/minegishirei/store/blob/main/vagrant/install/107confilm.png?raw=true">



# vagrant実行


```sh
vagrant box add centos/7
vagrant init centos/7
vagrant up
vagrant ssh
vagrant halt
```



























