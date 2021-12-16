
## この記事は？

SQLアンチパターンの備忘録です。

特に今回は5章の「エンティティ アトリビュート バリュー」
と呼ばれる手法の悪い点と改善策をまとめました。



## エンティティ アトリビュート バリュー とは

あなたはバグレポートを管理するシステムを作成しようとしています。

UI,UX,使用する言語が決まりましたが、SQLのデータベースの方式がなかなか決められません。（データベース設計のこと）

特に、バグのデータといっても、イシュー（要望）として扱われるのか、プロブレム（問題）として扱われるのかの二種類のデータがあることに苦悩しています。これら二つをサポートしたデータベースを仮に作成した場合、どちらかのグループに属することになれば、もう片方のグループについてのデータはNULLが入ります。

これのせいでNULLだらけのデータベースができてしまうこと(冗長なカラムになること)を恐れていました。

そんな中あなたは次のようなキーワードを見つけました。

<strong>
エンティティ アトリビュート バリュー
</strong>

これはSQLのデータベースに対して次のような三つのカラムを用意して全てを管理するやり方です。

- エンティティ

管理番号

- アトトリビュート

属性名

- バリュー

属性値

これらの手法を用いればSQLデータベースの管理など容易いと考えたあなたは、早速実行に移しました。


<pre><code>
INSERT INTO BugAttributes 
    (entity, attribute, value)
VALUES
    (1234, "date", "2021-01-14"),
    (1234, "bug_level", "middle"),
    (1234, "title", "保存時にエラーが出る"),
    (1234, "status", "NEW"),
    (1234, "prioryty", "HIGH"),
    (1234, "version", "1.0"),
    (1234, "limit", "2021-01-20")
</code></pre>



## SQLを辞書のように扱う問題点 (意図しない属性)

システムを運用してから二日後、こんなクレームが届きました。

「バグ管理番号が1234のバグの対応が遅れている。開発者はバグのレベルはmiddleだったので他のバグを対応しようとしていたと言っているが、バグをレポートした人はmiddleではなくHIGHに設定したはずだと言っている。これはどういうことだ？」

開発者のあなたはそんなはずはないと考え、entityの値が1234の行を全て抽出しました。

確かに、bug_levelはmiddleという値に設定しており、これは開発者が自分自身で設定したものであると認識しています。

しかしbug_levelの他にpriorytyと呼ばれるattributeが設定されており、これは開発者にとって身に覚えのない属性値でした。

## データ型が利用できない

また、これらの問題がいつ発生したか(今年に発生したのか)を調べるために、Dataを使って絞り込みを行おうとしましたが、あなたはそれができないことに気がつきました。

なぜならattributeの値が"date"であっても、それに対応するvalueの型は文字列だからです。

つまり次のような日付による絞り込みができません。

<pre><code>
select
    count(*)
from
    BugAttributes b
where
    b.attribute = "date"
and
    b.value > "2021-01-01" -- valueは日付型ではない。
</code></pre>

## 必須属性が定義できない

このクエリを発見する中で、全体の行の件数と上記のクエリの結果に誤差があると感じたあなたは

なんと日付が設定されていないバグデータがあることを見つけてしまいました。

## 解決策 継承を使う

あなたはissueテーブルが二つの種類（バグと要求）に別れることに気づけました。


<pre><code>
CREATE TABLE Issues(
    issue_id    SERIAL PRIMARYKEY,
    reported_by BIGINT UNSINED NOT NULL,
    product_id  BIGINT UNSINED NOT NULL.
    priorty     VARCHAR(20),
    status      VARCHAR(20),
    FOREGN KEY (reportd_by) REFERENCES Acounts(acount_id),
    FOREGN KEY (product_id) REFERNNCES Products(product_id)
)

CREATE TABLE Bugs (
    issue_id    BIG UNSIEND PRIMARY KEY,
    serverty    VARCHAR(20),
    version     VARCHAR(20),
    FOREGN KEY (issue_id) REFERENCES Issues(issue_id)
)

CREATE TABLE FeatureReport (
    issue_id    BIG UNSIEND PRIMARY KEY,
    sponser     VARCHAR(20),
    FOREGN KEY (issue_id) REFERENCES Issues(issue_id)
)

</code></pre>































title:エンティティ・アトリビュート・バリュー【SQLアンチパターンまとめ】

description:特に今回は5章の「エンティティ アトリビュート バリュー」と呼ばれる手法の悪い点と改善策をまとめました。


img:https://blog.motimotilab.com/wp-content/uploads/2017/05/picture_large978-4-87311-589-4-750x387.jpeg


category_script:page_name.startswith("30")



