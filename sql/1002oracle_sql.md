


## 射影

特定の列のみを取り出す機能

例）会社の雇用データベースのうちから全ての社員番号と名前を取り出すこと


## 選択

特定の行を取り出す機能

例）会社の雇用データベースのうち100で始まる社員を全て取り出すこと


## 結合

2つ以上のデータベースを組み合わせて使うこと

例）所属部署コードが記載された社員データベースと部署コードと部署名が対応したデータベースをくっつけて
社員データベースに部署名をくっつけること


## SELECT文

データベースの中からデータを取り出す文

例）

SELECT カラム1, カラム2 FROM データベース


## SELECTによる射影

<pre><code>
SELECT カラム1, カラム2 FROM データベース
</code></pre>

列としてカラム1, カラム2だけを取り出している


## 全ての列のとりだし

<pre><code>
SELECT * FROM データベース
</code></pre>



## SELECTによる選択

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

