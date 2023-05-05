

## dockerignore概要

dockerで管理するファイルのうち、管理外にしたいファイルが存在すると思います。また、Dockerのディレクトリ配下を無視したい時など。その際にはdockerignoreが役に立ちます。

つまり、ビルドコンテキストから不要なファイルを削除することが可能なのです。

<img src="https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F288329%2F9d32eb9e-8059-b717-bff3-6c543af505fd.png?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&s=b5da3fcf3af6d70ab8a5ee0effb3333e">

参考：https://qiita.com/yucatio/items/f5d23043228cc35fc763


## .dockerignoreファイルを使用する

ビルドコンテキストから不要なファイルを削除するために、「.dockerignore」ファイルを使用します。

.dockerignoreファイルには、次のファイルの名前が含まれているワイルドカード文字(*および？)を指定する必要があります。


## .dockerignoreサンプル

たとえば、次の.dockerignoreファイルがある場合：

<pre><code>
.git        -- 1
*/.git      -- 2
*/*/.git    -- 3
*.sw?       -- 4
</code></pre>

1. ビルド構成のルートにある.gitファイルまたはディレクトリを無視しますという意味のテキストですが、任意のサブディレクトリを許可します（つまり、.gitは無視されますが、「dir1/.git」はそうではありません）。

2. ちょうど1つ下のディレクトリの.gitファイルまたはディレクトリを無視します。つまり、dir1/.gitは無視されますが、.gitとdir1/dir2/.gitはそうではありません。

3. ちょうど2つ下のディレクトリの.gitファイルまたはディレクトリを無視します。つまり、dir1/dir2/.gitは無視されますが、.gitとdir1/.gitはそうではありません

4. test.swp、test.swo、およびbla.swpは無視されますが、dir1/test.swpは無視されません。

## .dockerignoreで正規表現は使えるのか？

[A-Z]*などの完全な正規表現はサポートされていません。

## .dockerignoreで全てのサブディレクトリを指定できるのか？

執筆時点では、すべてのサブファイルを照合する方法はありません。

ディレクトリ（例：1つの式で/test.tmpと/dir1/test.tmpの両方を無視することはできません）。


## 備考

title:dockerignoreの使用方法【docker入門】

description:dockerで管理するファイルのうち、管理外にしたいファイルが存在すると思います。また、Dockerのディレクトリ配下を無視したい時など。その際にはdockerignoreが役に立ちます。


img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-776-8.jpeg

category_script:True

