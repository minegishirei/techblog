
## ポリモーフィックなテーブルを作成したい。

あなたはバグレポートを管理するシステムを作成しようとしています。

そしてこのバグレポート管理システムに新たなる要件が届きました。

その要件とは「バグについてのコメントを書き込めるような機能が欲しい」というものです。

つまり、バグについての情報があるテーブルと新たに作成されたCommentsというテーブルには一対多の関連が存在する。

ところが問題は

-- バグについての情報があるテーブルは一つとは限らないこと --

例えば、issueというテーブルを継承した二つのテーブル

- Bugs
- FeatureRequests

があるかもしれない。

この状態で（複数の親テーブルを参照しようとする外部キーを宣言しようとすることで）Create Tableしようとすると、次のような構文を使用したくなるが、残念ながらそのような文法は存在しない。

<pre><code>
CREATE TABLE Comments(
    ...
    FOREGN KEY (issue_id) 
    REFERENSES Bugs(issue_id) OR FeatureRequests(issue_id)
)
</code></pre>

Bugs(issue_id) OR FeatureRequests(issue_id)

のように、BugsテーブルかFeatureRequestsテーブルに対象のデータがあるような外部参照を設定することはできない。




## 答え：共通の親テーブルを作成する

上記のバグ管理システムが次のような状態であるとする。

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

ここのテーブル軍に対してコメントをつける場合。

もっと言うと外部キー参照制約をつけながらCommentsを付けたい場合は、issueを親テーブルとして扱いながらCommentsテーブルを作成するのがベストな解法である。

<pre><code>
CREATE TABLE Comments (
    comment_id      SERIAL PRIMARY KEY,
    issue_id        BIGINT UNSINED NOT NULL,
    author          BIGINT UNSINED NOT NULL,
    comment_date    DATETIME,
    comment         TEXT,
    FOREIGN KEY     (issue_id) REFERENCES Issues(issue_id),
    FOREGN KEY      (author) REFERENCES Acounts(acount_id)
)
</code></pre>

これはつまりIssuesテーブルに対して三つの異なる階層のテーブルが連なっている状態。

<pre><code>
Issues
|
-- Bugs
-- Feature Requests
-- Comments
</code></pre>

このような従属関係になっている。

issuesのような基底テーブルを使うことで、外部キーによるデータ整合性制約に依存できると言うことがポイント




















title:複数の親テーブルを参照する外部キー制約を宣言する（SQLアンチパターン）

description:issuesのような基底テーブルを使うことで、外部キーによるデータ整合性制約に依存できると言うことがポイント

img:https://www.kinokuniya.co.jp/images/goods/ar2/web/imgdata2/large/48731/4873115892.jpg

category_script:page_name.startswith("30")


