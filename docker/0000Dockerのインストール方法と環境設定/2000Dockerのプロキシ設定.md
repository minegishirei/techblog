


Docker のプロキシーの設定をする方法や、Dockerfileへのプロキシの記述方法など Dockerを社内で使う上で基本となる項目について解説します。

会社内でDockerを使用する際にはよくプロキシに引っかかるのでご注意ください。



[:contents]


### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)


## Docker for Desktopでのプロキシの設定方法( windows, mac 環境の方)

会社で使用するPCにはプロキシーの制限が課されている場合があります。
その場合、 Docker はそのままでは起動できません。プロキシーの設定を行うことで初めて実行可能となります。


### 1. docker for desktop を起動する

<img src="https://github.com/minegishirei/techblog/blob/main/docker/0000Docker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%A8%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A/img/proxy/1home.png?raw=true">


### 2. docker for desktop の設定を開く

右上の歯車アイコンからdocker for desktopの設定を開きましょう

<img src="https://github.com/minegishirei/techblog/blob/main/docker/0000Docker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%A8%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A/img/proxy/2config.png?raw=true">


### 3. Resources > Proxies の設定を開く

Resources > Proxies からプロキシの設定を開きましょう

<img src="https://github.com/minegishirei/techblog/blob/main/docker/0000Docker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%A8%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A/img/proxy/3resources.png?raw=true">


### 4. manual config を押下

<img src="https://github.com/minegishirei/techblog/blob/main/docker/0000Docker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%A8%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A/img/proxy/4manual_config.png?raw=true">

### 5. docker for desktopのプロキシを設定する

<img src="https://github.com/minegishirei/techblog/blob/main/docker/0000Docker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%A8%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A/img/proxy/5sample_proxy.png?raw=true">




## linux 内部の docker engin のプロキシーの設定( linux 環境の方)

Docker for Desktopを使わない場合、`~/.docker/config.json`へ　プロキシーの設定内容を記述する必要があります。
適宜`<proxy_url>`を社内プロキシーurlに置き換えて設定を変更してください。
また、変更後はdocker enginの再起動が必要となりますのでご注意ください。

```json
{
 "proxies":
 {
   "default":
   {
     "httpProxy": "<proxy_url>",
     "httpsProxy": "<proxy_url>",
     "noProxy": ""
   }
 }
}
```


## Dockerfile へのプロキシの設定方法

Dockerfile を記述する際にもプロキシーの設定を書き込む必要があります。
具体的には次の内容をDockerfileに追記してください。

```sh
# 環境変数の変更
ENV HTTP_PROXY="<proxy_url>"
ENV HTTPS_PROXY="<proxy_url>"
ENV FTP_PROXY="<proxy_url>"
ENV http_proxy="<proxy_url>"
ENV https_proxy="<proxy_url>"
ENV ftp_proxy="<proxy_url>"

# RUNを使った環境変数の変更
RUN set HTTP_PROXY="<proxy_url>"
RUN set HTTPS_PROXY="<proxy_url>"
RUN set FTP_PROXY="<proxy_url>"
RUN set http_proxy="<proxy_url>"
RUN set https_proxy="<proxy_url>"
RUN set ftp_proxy="<proxy_url>"
```


## docker run のオプションでプロキシを設定する

本番サーバー、開発用サーバー、ローカル環境でプロキシーが異なり、プロキシの向き先を変更しなければならない場合、 Dockerfile に記述して対応する方法は柔軟性に欠けます。
なぜならば、基本的にDockerfileの内容は変更することができず、一度イメージがビルドされてしまえば上書きで対応するしか方法がありません。

そこで、`docker run`のオプションに環境変数を設定することで、**dockerコンテナの起動時にプロキシを設定しましょう。**

docker runのオプションに以下の内容を追記してください。

```sh
docker run --env HTTP_PROXY="<proxy_url>" --env HTTP_PROXY="<proxy_url>" <イメージ名> <コマンド>
```

























