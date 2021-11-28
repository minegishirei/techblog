
## キーレスエントリー（外部キー嫌い）

例）あなたは研究所の設備を予約するシステムを管理するシステム管理者です。

ある時こんなクレームが来ました。

「大変だ。研究所の設備を二人のマネージャーが同じ日に予約してしまっているんだ。どうしてこんなことになってしまっているか調べてくれないか？」

そのアプリケーションはMySQLを使った設備管理アプリだったが、デフォルトのストレージエンジンがMyISAMであった。

このストレージエンジンは参照生合成の強制を行う仕組みがなく、したがってデータベースのテーブル同士でリレーションシップ（関連するテーブル）があったとしても、参照整合性を使うことができなかった。

結果、不具合が存在する前提で早めに検知するための定期実行スクリプトを用意して「子テーブルで孤児になっている行」など、不正なデータを削除するクレンジング的なスクリプトを書く必要が出てきた。

しかしこのスクリプトもずっと活用することもできず、品質管理用のクエリの数も増え続け、スクリプトの実行時間も増えるようになって、いよいよ収集がつかなくなってきている。


どうしてこんなことになったのか。


## テーブルのカラムの設定と同じくらいテーブル同士のリレーションシップは重要

テーブルのカラムの設定と同じくらいテーブル同士のリレーションシップは重要です。

特に参照整合性を担保するための外部キー制約は適切なデータベースの運用において極めて重要。

ある列に外部キー制約を付け加えるときのメリットとして、「この列の値が親テーブルの主キーやユニークキーに存在しなくてはならない」と言うことを強制して、その規約に反する時はエラーを返してくれることがある。

## 外部キー制約を無視したがる理由

- 柔軟性が高まる
- 実行速度が早くなる（と思っている）
- ストレージエンジンが古いタイプ

また、次のようなデメリットも外部キーを嫌がる理由の一つだ

- 更新ができなくなる場合が存在する

<pre><code>

UPDATE BugStatus SET status = 'INVALID'
WHERE status = 'BOGUS'
=>エラー！

UPDATE Bugs SET status = 'INVALID'
WHERE status = 'BOGUS'
=>エラー！
</code></pre>

異なる二つの更新処理を同時に行うことはできない。

このことでデータベースの柔軟性を損なって異しまうという考えがある。

しかしこのデメリットは、テーブルに対する設定で無効化できる。



## 外部キー制約を使わないデメリット

最大のデメリットは

<strong>
データベースを利用しているアプリケーションが、参照整合性を保つための完璧なコードを前提としている
</strong>

今回のケースだと

- 行の挿入時には外部キー列の値が参照先のテーブルの既存の値を参照していることを確認すること
- 言い換えると、子の行の挿入時には親の行の存在を確認すること

が必要になってくる。

<pre><code>
-- 確認用のクエリ
SELECT acount_id FROM Acounts WHERE acount_id=1;
-- 挿入
INSERT INTO Bugs (reported_by) Values (1);
</code></pre>

また、親の行の削除の際には子の行のアカウントが存在しないことを確認しなければならない

<pre><code>
-- 確認用のクエリ
SLECT bug_id FROM Bugs WHERE reported_by = 1;
-- 更新用のクエリ
DELETE FROM Acounts WHERE acount_id = 1;
</code></pre>

これらのコードを

<strong>
全てのデータベースを利用するプログラムに要求する必要がある
</strong>

これは現実的ではない



## 外部キー制約とカスケード更新がテーブルを健全な状態に保つ

Bugsは子テーブルの存在で、親テーブルはBugStatusとAcountsがある。

<pre><code>
CREATE TABLE Bugs {
    reported_by     BIGINT UNSINED NOT NULL,
    status          VARCHAR(20) NOT NULL DEFAULT 'NEW'
    FOREGIN KEY (reported_by) REFERENCES Acounts(acount_id) 
        ON UPDATE CACADE,
        ON DELETE RESTRUCT,
    FOREGN KEY (status) REFERENCES BugStatus(status)
        ON UPDATE CASCADE
        ON DELETE SET DEFAULT
}
</code></pre>

ポイントは二つ

- REFERENCES

これは外部キーを設定するためのキーワードで他のデータベースとの主キーとの関連を表している。

これによっておその場限りのアドホックなテーブルの更新も外部キー制約から逃れることはなく、データベースは健全な状態を保つことができます。

- CASCADE

外部キーの作成時に CASCADE を指定した場合、Pervasive PSQL で DELETE CASCADE 規則が使用されます。ユーザーが親テーブルの行を削除すると、Pervasive PSQL によって従属テーブルの対応する行が削除されます。






title:外部キー制約(REFERENCE)とカスケードを設定する方法とそのメリット【SQL】

description:外部キー制約とカスケード更新がテーブルを健全な状態に保つ。データベースを利用しているアプリケーションが、参照整合性を保つための完璧なコードを前提としているような状態は避けるべきである。

img:https://www.kinokuniya.co.jp/images/goods/ar2/web/imgdata2/large/48731/4873115892.jpg

category_script:page_name.startswith("30")



