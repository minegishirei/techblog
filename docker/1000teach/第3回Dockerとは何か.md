
## DockerDeamonとその周囲(Dockerの基本的なアーキテクチャ)

以下はDockerの基本的なアーキテクチャです。

<figure class="figure-image figure-image-fotolife" title="Dockerの基本的なアーキテクチャ">[f:id:minegishirei:20230505204232p:plain:alt=Dockerの基本的なアーキテクチャ]<figcaption>Dockerの基本的なアーキテクチャ</figcaption></figure>

from https://pepa.holla.cz/wp-content/uploads/2016/10/Using-Docker.pdf

- 中心にあるのは**DockerDeamon**で、コンテナの作成、実行、監視、イメージの構築と保存を担当します。

- クライアントは左側にあり、DockerDeamonと対話するために使用されます。（今回はTerminalやPowershellに該当する部分）
この対話のプロトコルはHTTP経由で送信します。この性質上、リモートに存在するDockerデーモンにはHTTP経由で命令を出すことが可能です。

- Docker レジストリは、イメージを保存および配布します。（ざっくり言うと、Githubのイメージバージョンようなもの）

これらの構成要素が互いに連携することで、「**Dockerfileの内容がDockerDeamonに送信され、Dockerレジストリから元のイメージを送ってもらい、その上に新たにイメージを作りだし、最後にコンテナとして運用される**」と言うサイクルが完成します。

<img src="https://images.viblo.asia/0240e699-0175-4ccc-be70-89f6131fd5b7.png">




## DockerのOSSリポジトリは一体どこにあるのか

#### Dockerの本体はどれか?

まず、Dockerの本体は、"Docker for Desktop"ではありません。
Dockerの本体は**DockerEngin**です！

Docker for DesktopはGUIで使いやすいように装飾された、MacやwindowsでDockerを使うためのアプリケーションです。


#### Dockerは有料なの?

ちなみに、Dockerが一時期有料になるという噂が出ましたが...
有料になるのは"Docker for Desktop"であって、Dockerで一番重要な**DockerEngin**はOSSのままです！
（ちなみに、有料になるDocker for Desktopにはすでに代わりとなる存在がいます...）


#### DockerEnginのリポジトリ

そして、そのDockerEnginのリポジトリはこちらです。

https://github.com/moby/moby

以前はhttps://github.com/docker/docker がリポジトリの本体でしたが、
色々あってこの`moby`リポジトリに移されました。

<img src="https://github.com/moby/moby/raw/master/docs/static_files/moby-project-logo.png">

#### OSSのリポジトリは眺めるだけで得する

このリポジトリを眺めているだけで、いくつか情報を得られると思います。

- まず、**DockerEnginはメインではGo言語で書かれてます**。





#### DockerEngin自体をビルドして使うこともできる

7年前の記事ではあるが、実際にDockerエンジンを動かしている人もいた。
流石に今現在このままでは動かないとは思うが...

参考記事：https://qiita.com/minamijoyo/items/cf69b355fdc561aaa533











