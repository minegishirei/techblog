



## Docker Desktop - Windows Hyperviser is not present

windows10へのインストール中に以下のようなエラーが発生しました。


<img src="https://github.com/minegishirei/techblog/blob/main/docker/0000Docker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%A8%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A/img/windows_download/2windows_hyperviser_errior.png?raw=true">

具体的なエラー文は以下の通りです。

```
Docker Desktop - Windows Hyperviser is not present
Docker Desktop is unable to detect a Hypervisor.

Hardware assisted virtualiation adn data execution protection must be enabled in the BIOS.
See https://docs.docker.com/desktop/troubleshoot/topics/#virtualization
```

Dockerに必要な仮想化技術にまつわるエラーになってます。

```
Docker デスクトップ - Windows ハイパーバイザーが存在しません
Docker Desktop はハイパーバイザーを検出できません。

ハードウェア支援仮想化とデータ実行保護を BIOS で有効にする必要があります。
```


## 対応策 : Virtual Machine


<img src="https://github.com/minegishirei/techblog/blob/main/docker/0000Docker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%A8%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A/img/windows_download/2windows_feature.png?raw=true">


<img src="https://github.com/minegishirei/techblog/blob/main/docker/0000Docker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%A8%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A/img/windows_download/2windows_linux?raw=true">



<img src="https://github.com/minegishirei/techblog/blob/main/docker/0000Docker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%A8%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A/img/windows_download/2windows_linux?raw=true">


<img src="https://github.com/minegishirei/techblog/blob/main/docker/0000Docker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%A8%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A/img/windows_download/2windows_hyperviser?raw=true">












