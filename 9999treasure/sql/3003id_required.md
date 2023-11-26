

## SQLアンチパターンの備忘録です。


## 主キーは適切に選ばなければえらい目にあう

例）ジョンはwebアプリケーションを管理するエンジニアだ。

このwebアプリケーションは記事をタグ付けして管理することがウリであり、記事の内容が格納されているAriticleテーブルとタグの種類を格納しているTagsテーブル。そしてその二つを関連付ける次のArticleTagsテーブルを管理している。

```sql
CREATE TABLE AtrticleTags (
    id          SERIAL PRIMARY KEY,
    article_id  BIGINT UNSIGNED NOT NULL,
    tag_id      BIGINT UNSIGEND NOT NULL,
    FOREGN KEY  (article_id) REFERENCES Article (id),
    FOREGN KEY  (tag_id) REFERENCES Tags (id),
)
```

ある時こんな問題が起きた。

「economy(経済)」タグにつけられたタグは5件しかない。
しかし、count(*)の結果は7件返されてしまう。

調べてみると、economyタグは一つの記事に対して3重に関連づけられていることがわかった。

```
id      tag_id      article_id
22      327         1234
23      327         1234
24      327         1234
```

article_idが1234の記事に三つのレコードが作られてしまっている。


## 意味もなく「id」カラムをつけるのはやめよう

今回のこの問題が発生した原因は

<strong>
「とりあえず「id」と言う列を作成してプライマリーキーにして一意になるようにしよう」と言う考え方があったから。
</strong>

今回のCREATE Tableを見てみると、次の「id」タグは必要がない。

理由は、記事とタグの「組み合わせ」を"一意に"保存すると言う今回のテーブルの趣旨をidタグは全うできていないから。

```sql
CREATE TABLE AtrticleTags (
    id          SERIAL PRIMARY KEY, <=これが余計なカラム
    article_id  BIGINT UNSIGNED NOT NULL,
    tag_id      BIGINT UNSIGEND NOT NULL,
    FOREGN KEY  (article_id) REFERENCES Article (id),
    FOREGN KEY  (tag_id) REFERENCES Tags (id),
)
```

idタグを用いて重複を防ぐのではなく、

記事とタグの組み合わせを一意に出来るようなPRIMARY KEY制約をかけなければならなかった。



## 今回の改善策

次のようにPRIMARY KEY (article_id, tag_id)と言う行を追加することで

### 複数のキーを参照して重複を防ぐ

と言うことが可能になる。

```sql
CREATE TABLE AtrticleTags (
    article_id  BIGINT UNSIGNED NOT NULL,
    tag_id      BIGINT UNSIGEND NOT NULL,
    PRIMARY KEY (article_id, tag_id),
    FOREGN KEY  (article_id) REFERENCES Article (id),
    FOREGN KEY  (tag_id) REFERENCES Tags (id),
)
```






## どれを主キーに選ぶかは難しい問題

行の重複を防ぐことが重要なことは誰でも理解している。

問題は「どの列をPRIMARY KEYにするのか」である。


## 「このテーブルでは主キーは不要だと思うな」

この開発者は主キーと擬似キー（SERIALなど、DBが勝手に値を割り振り一位性を保つ仕組み）を混同している(と書かれているがよくわからなかった。)


## 「うーむ。重複が発生してしまった」

今回の事例のこと。

これも「テーブル」と「テーブル」の関係を表すテーブル(交差テーブルと呼ぶらしい)が重複してしまったと考えた方が良い。



















title:ID Required【SQLアンチパターンまとめ】


description:次のようにPRIMARY KEY (article_id, tag_id)と言う行を追加することで、複数のキーを参照して重複を防ぐと言う仕組みを整えることが可能になっている。

img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-589-4.jpeg


category_script:page_name.startswith("30")



