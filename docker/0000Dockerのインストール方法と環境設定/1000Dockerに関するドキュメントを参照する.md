
Docker を使ったプログラミング、開発を行う上で、参考になるドキュメントを参照する方法について解説します。




## Web上にあるドキュメントを参照する

Docker に関するドキュメントは Web 上でも参照することができます。 参照の際は下記の URL へアクセスして下さい。

https://docs.docker.jp/

<img src="">


ただし、該当するサイトはDocker 公式ドキュメントを有志で日本語に翻訳しているため、各ページの情報が古い恐れがあります。
実際に、バージョンの異なるソフトのダウンロードを実行したため動かない事例もありました。
dockerソフトウェアとのバージョニングにはご注意ください。


2023年9月現在の内容は以下のとおりです。

```
Docker 概要
Docker の入手
始め方 - Get started
Docker Desktop ハンズオン ガイド
言語別ガイド
Docker で開発
Docker で構築
プロダクションでアプリを実行
教育用リソース
```




## ダウンロード時のチュートリアルを実行する。

Docker のインストールが完了後、コンテナを選択する画面またはイメージを選択する画面で公式チュートリアルが用意されている。バージョンによってチュートリアルの内容は異なるが、Dockerアプリケーションの概要を学ぶにはちょうど良い。

<img>


このチュートリアルではボタンを押していくだけで手軽にコンテナの実行が可能だ。
例えば、「What is Container?」を押しただけで、新たにコンテナが立ち上げりチュートリアルが開始される。
下記の画面では「What is Container」を押下しただけでコンテナの立ち上げと説明を出してくれた。

<img>


ただし、表記が英語のみであるためそこは注意が必要。

> The best way to learn about containers is to first see it in action. We have created a welcome container for you.
You can check it out in the Containers tab (welcome-to-docker)

日本語訳

> コンテナについて学ぶための最良の方法は、まず実際にコンテナが動作しているのを確認することです。私たちはあなたのためにウェルカムコンテナを作成しました。
[Containers] タブで確認できます (welcome-to-docker)


<img>


> This one is a simple web application. Select 8088:80⁠ in the Port(s) column to see it running.


日本語訳

> これは単純な Web アプリケーションです。 [ポート] 列で 8088:80⁠ を選択し、実行中であることを確認します。



<img>


このように、 **Docker の公式のチュートリアルでは3ステップでWebサービスを構築することができる。**







Docker に関するドキュメントを参照する方法について解説しました。



