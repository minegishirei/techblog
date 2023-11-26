



###  SELECT文

データベースの中からデータを取り出す文

例）

SELECT カラム1, カラム2 FROM データベース


###  SELECTによる射影

<pre><code>
SELECT カラム1, カラム2 FROM データベース
</code></pre>

列としてカラム1, カラム2だけを取り出している


###  全ての列のとりだし

<pre><code>
SELECT * FROM データベース
</code></pre>



###  SELECTによる選択

<pre><code>
SELECT * FROM データベース
WHERE 条件
</code></pre>

例えば、社員データベースから部署コードが100であるものを選択したいときは

<pre><code>
SELECT * FROM データベース
WHERE データベース.部署コード = "100"
</code></pre>

更なる複雑なWHERE句による選択は後ほど出てくる







title:select文の射影,選択,結合【SQL基礎入門】

description: データベースの中からデータを取り出す文であるSQLのselect文。selectの構文はその使い方で射影,選択,結合の三つに分類できます。

img:https://www.oreilly.co.jp/books/images/picture_large4-87311-281-8.jpeg

category_script:page_name.startswith("1")

