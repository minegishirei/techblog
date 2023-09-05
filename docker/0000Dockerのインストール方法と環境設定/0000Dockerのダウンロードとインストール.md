

MacOSでのDocker のダウンロードとインストール方法について解説します。 2023 年 9 月現在、最新のバージョンは Docker v4.19.0 となっています。


[:contents]

### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)





## 1.まずはDockerの公式サイトにアクセス

まずは以下のサイトにアクセスしましょう

[https://www.docker.com/:embed:cite]

こんな感じの画面が出ます。

<figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編】">[f:id:minegishirei:20230504120452p:plain:alt=Docker for Desktopのインストール方法【Mac編】]<figcaption>Docker for Desktopのインストール方法【Mac編】</figcaption></figure>


## 2.ダウンロード押下

アクセスした後は、Download Docker Desktopをおしましょう。

**ただし、PCのCPUに合致したバージョンをインストールする必要があります。**

- CASE A: インテルチップの人はそのまま押下
    - <figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編】">[f:id:minegishirei:20230504120851p:plain:alt=Docker for Desktopのインストール方法【Mac編】]<figcaption>Docker for Desktopのインストール方法【Mac編】</figcaption></figure>

- CASE B: Appleシリコン
    - <figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編】">[f:id:minegishirei:20230504123853p:plain:alt=Docker for Desktopのインストール方法【Mac編】]<figcaption>Docker for Desktopのインストール方法【Mac編】</figcaption></figure>


サイズは662MB

<figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編】">[f:id:minegishirei:20230504120628p:plain:alt=Docker for Desktopのインストール方法【Mac編】]<figcaption>Docker for Desktopのインストール方法【Mac編】</figcaption></figure>


## 3.ダウンロード後、dmgファイルを起動

<figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編】">[f:id:minegishirei:20230504121053p:plain:alt=Docker for Desktopのインストール方法【Mac編】]<figcaption>Docker for Desktopのインストール方法【Mac編】</figcaption></figure>

## 4.アプリをドラッグ&ドロップし、Applicationsに移動

<figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編】">[f:id:minegishirei:20230504121231p:plain:alt=Docker for Desktopのインストール方法【Mac編】]<figcaption>Docker for Desktopのインストール方法【Mac編】</figcaption></figure>




## 5.Dockerを起動

「Command + Shift」でSpotlight Searchを起動し「Docker」を入力してDockerを起動しましょう。

<figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編】">[f:id:minegishirei:20230504121632p:plain:alt=Docker for Desktopのインストール方法【Mac編】]<figcaption>Docker for Desktopのインストール方法【Mac編】</figcaption></figure>

あるいは、Applicationsフォルダーにあるアイコンから直接起動しましょう。


<figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編】">[f:id:minegishirei:20230504121920p:plain:alt=Docker for Desktopのインストール方法【Mac編】]<figcaption>Docker for Desktopのインストール方法【Mac編】</figcaption></figure>


## 6.インストール実行

Dockerの初回起動はインストールが走ります。


<figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編】">[f:id:minegishirei:20230504122424p:plain:alt=Docker for Desktopのインストール方法【Mac編】]<figcaption>Docker for Desktopのインストール方法【Mac編】</figcaption></figure>

許可を求められるのでOKを出しましょう。

<figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編】">[f:id:minegishirei:20230504122828p:plain:alt=Docker for Desktopのインストール方法【Mac編】]<figcaption>Docker for Desktopのインストール方法【Mac編】</figcaption></figure>


さらに
許可を求められるのでOKを出しましょう。


<figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編】">[f:id:minegishirei:20230504122949p:plain:alt=Docker for Desktopのインストール方法【Mac編】]<figcaption>Docker for Desktopのインストール方法【Mac編】</figcaption></figure>



### 7.例外発生時


<figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編-エラー対応】">[f:id:minegishirei:20230504123027p:plain:alt=Docker for Desktopのインストール方法【Mac編-エラー対応】]<figcaption>Docker for Desktopのインストール方法【Mac編-エラー対応】</figcaption></figure>


> Checking compatibility: required compatibility check failed: We are sorry, but your hardware is incompatible with Docker Desktop.

> Docker requires a processor with virtualization capabilities and hypervisor support.

> To learn more about this issue see:

> https://docs.docker.com/desktop/mac/troubleshoot/#incompatible-cpu-detected

これはCPUがあっていない旨のエラーです。

一度アンインストールして、「 2.ダウンロード押下」から「Apple CPU」を選択して再度インストールしましょう。



## 8.インストール初回

超ざっくりまとめると「デッカい企業からはお金を取るよ」という忠告です。
無視してAcceptを押下しちゃいましょう。

<figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編】">[f:id:minegishirei:20230504124156p:plain:alt=Docker for Desktopのインストール方法【Mac編】]<figcaption>Docker for Desktopのインストール方法【Mac編】</figcaption></figure>




<figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編】">[f:id:minegishirei:20230504124341p:plain:alt=Docker for Desktopのインストール方法【Mac編】]<figcaption>Docker for Desktopのインストール方法【Mac編】</figcaption></figure>

アンケートを聞かれたらSkipやら適当に答えて続行しましょう。

<figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編】">[f:id:minegishirei:20230504124437p:plain:alt=Docker for Desktopのインストール方法【Mac編】]<figcaption>Docker for Desktopのインストール方法【Mac編】</figcaption></figure>



## 9.DockerのHelloworld（サンプル実行）

Terminalを開いて`docker run ubuntu:14.04 /bin/echo 'Hello world'`と入力しましょう。


```sh
docker run ubuntu:14.04 /bin/echo 'Hello world'
```

`HelloWorld`と出力されれば成功です！


<figure class="figure-image figure-image-fotolife" title="Docker for Desktopのインストール方法【Mac編】">[f:id:minegishirei:20230504124810p:plain:alt=Docker for Desktopのインストール方法【Mac編】]<figcaption>Docker for Desktopのインストール方法【Mac編】</figcaption></figure>




















