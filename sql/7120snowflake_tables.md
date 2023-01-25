



# SNOWFLAKEのテーブルタイプ一覧

Snowflakeには、次の4つのテーブルタイプが存在する。

- PERMANENT 
  - 削除されるまで持続する
  - デフォルトのデータタイプとして指定される
- TEMPORARY
  - セッション内でのみデータを保持する。
  - 一時的なデータに使用されることが多い。
- TRANSIENT
  - 削除されるまで待機する
  - 複数のユーザーで使用される
  - 存続する必要はあるが、PERMANENTと同じレベルのデータの保持を必要としない場合に有効
- EXTERNAL
  - 削除されるまで存続する
  - 外部のデータレイク上のSNOWFLAKEデータとして活用する
  - 外部ストレージに存在する。
  - **読み取り専用**


<img src="https://d1tlzifd8jdoy4.cloudfront.net/wp-content/uploads/2021/12/2021-12-24_09h15_33-640x497.png">

from https://dev.classmethod.jp/articles/snowflake-dbt-specific-settings/


## 反復的なサブクエリへTEMPORARYテーブルを使用する

同じサブクエリを複数回使用する場合。**TEMPORARYテーブルを使用した方が効率が良くなる**

- TEMPORARYテーブルはセッション内部のみに存在する点は注意（snowflakeのwebuiでは、一つのワークシートを一つのセッションが貼られるので、別のワークシートからTEMPORARYテーブルを覗くことはできない。

- 例:TEMPORARYテーブルのセッションを確認する。

次のクエリで、TEMPORARYテーブルを作る。

```sql
CREATE TEMPOEAEY TABLE temp(
    id INT,
    first VARCHAR(20),
    last VARCHAR(20)
)
```

その後、`SHOW TABLES`コマンドでテーブルの一覧を確認する。

また、別のワークシートを開き、`SHOW TABLES`を実行すると、TEMPORARYテーブルは表示されないことを確認できる。

- WITH句との違い。不明。調査不足

## 一時テーブルとして、TRANSIENTを使用する

TRANSIENTの作成は次の通り

```sql
create transient table mytranstable (id number, creation_date date);
```

**セッションを超えて維持する必要がある一時的なデータ用に特別に設計されています**






## 備考

title:snowflakeのデータベース完全解説

category_script:page_name.startswith("7")

img:https://cdn-icons-png.flaticon.com/512/787/787235.png


