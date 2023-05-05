




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

7年前の記事ではあるが、実際にDockerエンジンを

参考記事：https://qiita.com/minamijoyo/items/cf69b355fdc561aaa533






