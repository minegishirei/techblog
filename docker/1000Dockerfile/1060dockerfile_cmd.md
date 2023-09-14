



# dockerfile の CMD命令

**コンテナの起動時に指定された命令を実行します。**
`docker run`の起動時に実行されるコマンドを指定することが可能です。


### 親記事

- [Dockerfileの書き方](https://minegishirei.hatenablog.com/entry/2023/09/11/102313)
- [Dockerfile の from ( FROM ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/111814)
- [Dockerfile の user ( USER ) 句の使い方](https://minegishirei.hatenablog.com/entry/2023/09/12/113541)



### Docker入門 関連記事

- [Docker入門](https://minegishirei.hatenablog.com/entry/2023/09/02/213936)
- [Dockerのダウンロードとインストール(Mac編)](https://minegishirei.hatenablog.com/entry/2023/09/03/143528)
- [Dockerのダウンロードとインストール(Windows編)](https://minegishirei.hatenablog.com/entry/2023/09/04/115946)
- [Dockerのプロキシーの設定](https://minegishirei.hatenablog.com/entry/2023/09/05/120827)





## dockerfile の CMD:コンテナ起動時のコマンドを設定する

**コンテナの起動時に指定された命令を実行します。**
*`RUN`コマンドはビルド時に命令が実行されますが、`CMD`はコンテナの起動時(`docker run時`)であることに注意してください*

例えば、`docker run -it -p 80:80 -v ./code:/code flask`でflaskサーバーを起動したい場合、

```Dockerfile
# install python lib 
RUN pip install -r requirements.txt

# flaskサーバーを起動する
CMD ["python", "index.py"]
```

のように、pythonでindex.pyを実行してくれるように設定することができます。

**その性質上、`Dockerfile`の末尾に書かれることが多いです。**



### CMDはオーバーライドされる。

CMDにはいくつか注意点があります。

CMD命令はイメージ名の後に実行されるdockerへの引数によってオーバーライドされます。CMD命令は重複されることはない特徴があり、以前のCMD命令はすべてオーバーライドされます（ベースイメージのものを含む）。

```Dockerfile
# 以下はオーバーライドされる。ので実行されない。
CMD ["npm", "run", "build"]

# 最後に宣言された以下のスクリプトが実行される。
CMD ["npm", "run", "start"]
```



## Dockerfile ENTRYPOINT 命令の引数としての CMD 命令

`ENTRYPOINT`命令は実行時に特定のシェルスクリプトを指定できますが、
`ENTRYPOINT`命令と併用して`CMD`命令を使用した場合、`ENTRYPOINT`命令のオプションとして実行できます。


```Dockerfile
ENTRYPOINT ["my-app"]
CMD ["--option", "value"]
```





