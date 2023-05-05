

## 1st. dockerエンジンのインストール

以下のurlよりインストールしてください

http://docs.docker.jp/v1.12/engine/installation/index.html

## 2st. gitでソースをpullする

次のコマンドを打つか、

<pre><code>
git clone git@github.com:kawadasatoshi/using_docker_in_dev.git

</code></pre>

次のurlをブラウザで開き、zipとしてダウンロードします。

これはテストです。


<pre><code>
https://github.com/kawadasatoshi/using_docker_in_dev

</code></pre>


## 3st. docker compose upで実行

次のようなログが出てきたら成功です。

<pre><code>
Attaching to identidock_1
identidock_1  |  * Serving Flask app "identidock" (lazy loading)
identidock_1  |  * Environment: production
identidock_1  |    WARNING: This is a development server. Do not use it in a production deployment.
identidock_1  |    Use a production WSGI server instead.
identidock_1  |  * Debug mode: on
identidock_1  |  * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
identidock_1  |  * Restarting with stat
identidock_1  |  * Debugger is active!
identidock_1  |  * Debugger PIN: 282-995-042
</code></pre>


## docker+Flaskの動作確認

次のコマンドを打ち込むか

<pre><code>
curl http://localhost:5000/
</code></pre>

次のurlを入力してみてください。

<pre><code>
http://localhost:5000/
</code></pre>

次のように表示されれば完了です。

<pre><code>
minegishirei@minegisreinoAir myworking % curl http://localhost:5000/
Hello Docker!
</code></pre>


## 備考

title:1分で完遂するdocker-compse+Flaskの環境構築

description:Flask+docker-comopseでpythonとdockerで構成されたwebサイトを作ってみましょう！

img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-776-8.jpeg

category_script:True



