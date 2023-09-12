



# Dockerfile の user ( USER ) 句の使い方

Dockerfileでの`USER`命令は、Dockerイメージ内で実行されるプロセスがどのユーザーとして実行されるかを指定するために使用されます。これにより、セキュリティ上の理由からルートユーザーとしてプロセスを実行しないようにすることができます。以下は`USER`命令の使用方法と注意点です。



### 親記事

- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)
- [Dockerfile の from ( FROM ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/111814)
- [Dockerfile の user ( USER ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/113541)

### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)


### 目次

[:contents]



## Dockerfileでの`USER`命令の使用法

1.  `USER`命令を使用して、プロセスを実行するユーザーを指定します。ユーザーはユーザー名またはUID（ユーザーID）で指定できます。
2.  通常、`USER`命令は`RUN`、`CMD`、または`ENTRYPOINT`命令の前に配置されます。これらの命令で指定したコマンドは、`USER`命令で指定したユーザー権限で実行されます。

以下は、Dockerfile内で`USER`命令を使用する例と注意点を示したものです。


```Dockerfile
`FROM python:3.9.16

# ユーザーの作成
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

# ファイルの所有者を設定
COPY --chown=appuser:appgroup app /app

# 実行ユーザーを指定
USER appuser

# コンテナ起動時に実行するコマンドを指定
CMD ["python", "app.py"]`
```

この例では、次のことが行われています:

* `appuser`という名前のユーザーと`appgroup`という名前のグループが作成されます。
* `COPY`命令でファイルをコピーする際に、所有者が`appuser`と`appgroup`に設定されます。
* `USER`命令で、プロセスは`appuser`ユーザーとして実行されます。これにより、プロセスはルートユーザーとして実行されることを避け、セキュリティが向上します。

注意事項:

* ホストとコンテナで同じUIDを持つユーザーが存在する場合、`USER`命令でユーザー名を指定すると、コンテナ内のユーザー名は異なるUIDに割り当てられることがあります。これにより、権限の問題が発生する可能性があるため、UIDを使用してユーザーを指定することを検討することが重要です。

`USER`命令はセキュリティを向上させるための重要なDockerfile命令の1つであり、プロセスを最小権限のユーザーとして実行することをお勧めします。


## Dockerfile USER 詳細



### 1.  `USER`命令は継承されません:

Dockerイメージは、親イメージから継承されるため、親イメージで`USER`命令を設定しても、子イメージでその設定が継承されるわけではありません。子イメージで`USER`命令を再度設定する必要があります。

### 2.  ホームディレクトリの変更:

`USER`命令を使用してユーザーを切り替えると、そのユーザーのホームディレクトリも変更されます。ユーザーがアプリケーションデータを保存するために使用する場合、ホームディレクトリが適切に設定されていることを確認することが重要です。

```Dockerfile
# ユーザーの作成
RUN groupadd -r appgroup && useradd -r -g appgroup -m -d /appuser appuser
```

上記の例では、`-m`オプションと`-d`オプションを使用して、`appuser`ユーザーのホームディレクトリを`/appuser`に設定しています。

### 3.  `USER`命令の値を環境変数として使用:

USER`命令で設定したユーザー名やUIDを、Dockerコンテナ内の環境変数として使用することができます。これは、スクリプトやアプリケーション内で実行中のユーザー情報を取得するのに役立ちます。

```Dockerfile
# 実行ユーザーを指定
USER appuser

# 環境変数にユーザー情報を設定
ENV APP_USER=$USER`
```

上記の例では、`USER`命令で設定した`appuser`を`APP_USER`という環境変数に設定しています。

### 4.  `--no-log-init`オプション:

ユーザーが初めてログインすると、ログインメッセージが表示されることがありますが、`--no-log-init`オプションを使用することでこれを無効にできます。これはログインメッセージが不要な場合に役立ちます。

```Dockerfile
# ユーザーの作成とログインメッセージの無効化
RUN groupadd -r appgroup && useradd -r -g appgroup --no-log-init appuser`
```
