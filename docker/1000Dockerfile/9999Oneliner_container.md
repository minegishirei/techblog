

# DockerfileのRUNコマンドの詳細

DockerfileのRUNコマンドは、Dockerイメージをビルドする際に実行されるコマンドを指定するためのものです。このコマンドはDockerfile内で複数回使用できます。以下に、DockerfileのRUNコマンドに関する詳細な情報を示します。

### 親記事

- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)
- [Dockerfile の from ( FROM ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/111814)
- [Dockerfile の user ( USER ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/113541)




### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)



## Dockerfileでpythonを実行したいとき

### カレントディレクトリにある`main.py`を実行したい

例えば以下のように`helloworld`と書かれた`main.py`があるとき

```python
print("hello world")
```

以下のようにdockerの`runコマンドのオプション`を駆使することで**Dockerfileもコンテナも残さずにコマンドを実行することができます**

```sh
docker run --rm -v  ${pwd}:/app -w /app python:3-slim python main.py
```


### 一行で終わるpythonのコマンドをDockerで実行したい

`main.py`を作ることすら面倒な場合もありますね。

その場合はpythonの`-c`オプションを使用することで**pythonのファイルすら残さずにpythonのコードを実行することがができます。**

```sh
docker run -it --rm python:3-slim python -c "print('hello world')"
```







