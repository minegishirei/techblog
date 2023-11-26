





# snowflakeのストリームとは

テーブルに対する設定のこと。

## snowflakeのstreamのサンプルコード

元々次のようなl_salesというテーブルがある場合

- key     number
- cust_id number
- amout   number

次のコマンドでl_salesを設定すると

```sql
create stream s_sales_stream
on table l_sales;
```

s_sales_streamという名前で次の`ストリームテーブル`が作成される。

- key     number
- cust_id number
- amout   number
- METAFATA$ACTION
- METADATA$ISUPDATE
- METADATE$ROWID


## streamの使いかた

create stream文でstreamテーブルを作成した後は、特段の作業を必要としません。
INSERTやUPDATEされた時点でじどう的にMETADATAにデータが入ります。

## streamテーブルをselectする

次のコードはMAETADATAのActionから`INSERT`により作られたデータを取得するコード

```sql
select
    *
from
    s_sales_stream
where
    METADATA$ACTION = 'INSERT'
```

INSERT文により追記されたレコードを全て取得できる。









# snowflakeのタスクとは

- スケジュール実行をするためのsnowflakeの仕組み
  - CRON式
  - 分単位の感覚設定
  - 上位タスクの完了
- などを設定することができる
- SQLやストアドプロシージャを実行できる
- また、タスク同士を連結して順番に実行することも可能

以下タスクの設定のためのコード

```sql
create or replacetask t_sales_task
    warehouse = xsmall_vwh
    schedule = '1 minute' as
        insert into f_sales (
            select
                key,
                cut_id,
                amount
            from
                s_sales_stream
            where
                metadata$action = 'insert'
        )
```


## 備考

title:snowflakeのストリームとタスクの使い方【snowflake解説】

category_script:page_name.startswith("7")


