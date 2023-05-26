



## Dockerfileでpythonを実行したいとき

### カレントディレクトリにある`main.py`を実行したい

例えば以下のように`helloworld`と書かれた`main.py`があるとき

```sh
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
echo "print('hello world')" > main.py
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







