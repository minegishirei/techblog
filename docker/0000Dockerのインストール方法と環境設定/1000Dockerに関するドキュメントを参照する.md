
Docker を使ったプログラミング、開発を行う上で、参考になるドキュメントを参照する方法について解説します。


[:contents]


### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)



## Web上にあるドキュメントを参照する

Docker に関するドキュメントは Web 上でも参照することができます。 参照の際は下記の URL へアクセスして下さい。

https://docs.docker.jp/

<img src="https://github.com/minegishirei/techblog/blob/main/docker/0000Docker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%A8%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A/img/%E5%85%AC%E5%BC%8F%E3%83%98%E3%82%9A%E3%83%BC%E3%82%B7%E3%82%99.png?raw=true">

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


<img src="https://github.com/minegishirei/techblog/blob/main/docker/0000Docker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%A8%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A/img/%E3%83%81%E3%83%A5%E3%83%BC%E3%83%88%E3%83%AA%E3%82%A2%E3%83%AB.png?raw=true">



このチュートリアルではボタンを押していくだけで手軽にコンテナの実行が可能だ。
例えば、「What is Container?」を押しただけで、新たにコンテナが立ち上げりチュートリアルが開始される。
下記の画面では「What is Container」を押下しただけでコンテナの立ち上げと説明を出してくれた。

<img src="https://github.com/minegishirei/techblog/blob/main/docker/0000Docker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%A8%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A/img/%E3%83%81%E3%83%A5%E3%83%BC%E3%83%88%E3%83%AA%E3%82%A2%E3%83%AB_%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%A8%E3%81%AF.png?raw=true">


ただし、表記が英語のみであるためそこは注意が必要。

> The best way to learn about containers is to first see it in action. We have created a welcome container for you.
You can check it out in the Containers tab (welcome-to-docker)

日本語訳

> コンテナについて学ぶための最良の方法は、まず実際にコンテナが動作しているのを確認することです。私たちはあなたのためにウェルカムコンテナを作成しました。
[Containers] タブで確認できます (welcome-to-docker)

「Next」で次に進んでみる。

<img src="https://github.com/minegishirei/techblog/blob/main/docker/0000Docker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%A8%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A/img/%E3%83%81%E3%83%A5%E3%83%BC%E3%83%88%E3%83%AA%E3%82%A2%E3%83%AB_%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%A8%E3%81%AF2.png?raw=true">


> This one is a simple web application. Select 8088:80⁠ in the Port(s) column to see it running.

日本語訳

> これは単純な Web アプリケーションです。 [ポート] 列で 8088:80⁠ を選択し、実行中であることを確認します。

さらに「Next」で次に進む。

<img src="https://github.com/minegishirei/techblog/blob/main/docker/0000Docker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%A8%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A/img/%E3%83%81%E3%83%A5%E3%83%BC%E3%83%88%E3%83%AA%E3%82%A2%E3%83%AB_%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%A8%E3%81%AF3.png?raw=true">


このように、 **Docker の公式のチュートリアルでは3ステップでWebサービスを構築することができる。**







Docker に関するドキュメントを参照する方法について解説しました。



