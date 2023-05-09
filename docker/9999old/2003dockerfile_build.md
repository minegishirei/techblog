



## dockerfileのADD

ビルドコンテキストまたはリモートURLからイメージにファイルをコピーします。アーカイブの場合
ファイルはローカルパスから追加され、自動的に解凍されます。

ADDの対象となる機能は非常に大きいため、通常はよりシンプルな以下のものを選択するのが最適です。



- ビルドコンテキストでファイルとディレクトリをコピーして実行するためのCOPYコマンド

- リモートリソースをダウンロードするためのcurlまたはwgetを使用した手順（同じ命令でダウンロードを処理および削除する可能性を考慮してます。）



## dockerfileのCMD

コンテナの起動時に指定された命令を実行します。(RUNコマンドはビルド時に命令が実行されますが、CMDはコンテナの起動時であることに注意してください)

ENTRYPOINTに定義されている場合、命令はENTRYへの引数として解釈されます。

また、CMD命令はイメージ名の後に実行されるdockerへの引数によってオーバーライドされます。

CMD命令は重複されることはない特徴があり、以前のCMD命令はすべてオーバーライドされます（ベースイメージのものを含む）。


## dockerfileのCOPY

ビルドコンテキストからイメージにファイルをコピーするために使用されます。 

COPYには2つの形式があります。

- COPY src target
- COPY["src"、 "dest"]

どちらもファイルまたはディレクトリをコピーします

ビルドコンテキストのsrcで、コンテナ内で宛先を指定します。 

**ADDよりはこちらのCOPYを優先してください。**



## dockerのENTRYPOINT

コンテナの起動時に実行される実行可能ファイル（およびデフォルトの引数）を設定します。

イメージ名の後に実行されるdockerへのCMD命令または引数は、パラメータとして実行可能ファイルに渡されます。 

ENTRYPOINT命令は、多くの場合、「スターター」スクリプトを提供する想定で盛り込まれた機能です。


## ENV

dockerイメージ内に環境変数を設定します。

環境変数は頻繁に使う変数として後で参照できます。

<pre><code>
...
ENV MY_VERSION 1.3
RUN apt-get install -y mypackage=$MY_VERSION
...
</code></pre>

環境変数はdockerのイメージ内で利用できます。

## EXPOSE

コンテナが指定された一つ以上のポートをlistenするプロセスを持つことをDockerに示します。

この情報は、コンテナをリンクするときにDockerによって使用されます

またはdockerコンテナの実行時に-P引数を指定してポートを公開することもできます。

厳密にいうと、EXPOSE命令自体は、ネットワークに影響を与えません。


## dockerのFROM (dockerのベースイメージを指定する)

Dockerfileのベースイメージを設定します。

以降の手順により発生するイメージは、このベースイメージの上にイメージが重ねられます。

レイヤーイメージの最下層に位置するイメージと言っていいでしょう。

ベースイメージの指定方法はIMAGE：TAG（debian：wheezyなど）として指定されます。

タグは省略した場合最新のものと思われるイメージを指定しますが、予期しない事態を避けるために、タグを特定のバージョンに設定することを常にお勧めします。

FROM句はdockerfileの最初の命令である必要があります


## dockerのMAINTAINER(dockerで廃止された命令)

dockerイメージの「作成者」メタデータを指定された文字列に設定します。

## dockerのONBUILD

dockerイメージをベースとして使用するときに後で実行する命令を指定して別のイメージにレイヤーします。

これは、追加されるデータの処理に役立ちます。

## dockerのRUNコマンド

dockerのイメージによってビルドされたコンテナを実行します。



## dockerfileのUSER

後続のRUN、CMD、またはENTRYPOINTで使用するユーザーを（名前またはUIDで）設定します。

UIDはホストとコンテナで同じですが、
ユーザー名は異なるUIDに割り当てられる可能性があり、これにより権限を設定するときに問題が発生する可能性があります。



## dockerfileのVOLUME

指定されたファイルまたはディレクトリをボリュームとして宣言します。

dockerイメージにすでに存在する場合、コンテナの起動時にボリュームにコピーされます。

複数の引数が指定されている場合、それらは複数のボリュームとして解釈されます。


## dockerfileのWORKDIR

後続のRUN、CMD、ENTRYPOINT、ADD、またはCOPYの作業ディレクトリを設定します。

この命令は複数回使用できます。

また、相対パスを使用できます。





## 備考


title:dockerfileで使えるコマンド一覧【docker入門】

description:dockerfileのADDはビルドコンテキストまたはリモートURLからイメージにファイルをコピーします。アーカイブの場合
ファイルはローカルパスから追加され、自動的に解凍されます。

img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-776-8.jpeg

category_script:True

