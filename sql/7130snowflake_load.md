


# snowflakeのデータロード

snowflakeでデータをまとめて入れる場合、そのデータはまずファイルに出力する必要がある。
その後、ファイルをクラウドストレージにステージングし、
最後に、`COPY INTO`コマンドを用いて、クラウドストレージからsnowflakeにロードする。

コマンドの流れは以下の通り

1. `CREATE STAGE`
2. `CREATE FILE FORMAT`
3. `CREATE TABLE`
4. `COPY INTO TABLE`

## ファイルのフォーマットについて

ロード/アンロード中にファイルを解析するために、ファイルフォーマットを設定する必要がある。
フォーマットは、`COPY INTO`コマンドだけでなく、`CREATE FILE FORMAT`コマンドでオブジェクトとして作成しておくこともできる。

例えば
- CSV形式で
- ,区切りを指定して
- 1行スキップする

という条件のファイルを読み込みたい場合。

```sql
CREATE FILE FORMAT DEMO_FF
    TYPR = 'CSV'
    FILELD_DELIMITER = ','
    SKIP_HEADER = 1;
```

フォーマットは、CSVの他にも、JSONフォーマットなどもある。

## ステージについて

ストレージとは、バケットのようなファイル置き場のことである。
`COPY INTO`コマンドでステージに突っ込むことが可能。

ステージには3つほど種類がある。

- テーブルステージ
  - `@%テーブル名`
  - テーブルに紐づいているステージである。
  - `%`の後にテーブル名を指定することで、そのテーブル名のステージにファイルを置くことができる。
- ユーザーステージ
  - `@~`
  - これはユーザーに紐ずくステージである。
  - （KKING）ユーザーが存在すれば、KIINGステージも存在する
  - 他人のステージを指定することはできない。

これらは自動で作成されるステージでである。snowflake内部に存在するステージであり、ファイルフォーマットの設定をサポートしていない。

- ネームドステージ
  - `@ステージ名`で指定可能。
  - `CREATE STAGE`コマンドで使用することができるコマンドで、手動で作成する必要がある。
  - snowflakeの内部だけでなく、**外部ステージを作ることも可能。(AWSのS3などを使用可能)**
  - ファイルフォーマットを指定できる



# 一括ロードの概要

**一括ロードとは、バッチ処理のこと**

<img src="https://docs.snowflake.com/ja/_images/data-load-elt.png">

from https://docs.snowflake.com/ja/user-guide/data-pipelines-intro.html

手順としては以下の通り

1. ローカルにあるファイルからsnowflakeへ`PUT`コマンドで、内部ストレージへ移動する。
2. 内部ステージから、COPY INTOする。
3. または、外部ステージ、クラウドストレージからCOPY INTOする

これらの処理を、バッチ処理として行う

注意点としては、*snowflakeのweb UIからは実行できない*という点。

## ローカルストレージからバッチ処理を行う

1. 名前つき内部ステージを作成。`CREATE STAGE my_stage  FILER_FOERMAT = my_csv_format;`

2. データをステージにPUT。`PUT FILE:///data/data.csv @my_stage`

3. データをテーブルにコピー。`COPY INTO my_table FROM @my_stage`

## クラウドストレージからバッチ処理を行う

1. 外部ステージを作成

```sql
create stage my_s3_stage
  storage_integration = s3_int
  url = 's3://mybucket/encrypted_files/'
  file_format = my_csv_format;
```

2. COPYを使用してデータをロードする

```sql
COPY INTO my_table FROM @my_s3_stage PATTERN='.sales.*.csv'
```

# COPY INTOコマンドの代表的なオプション

## FILES

```sql
[ FILES = ( '<file_name>' [ , '<file_name>' ] [ , ... ] ) ]
```

ファイルをカンマ区切りで指定するオプション

## PATTERN

```sql
[ PATTERN = '<regex_pattern>' ]
```

ファイルを正規表現で指定するオプション

## FORCE

```sql
FORCE = TRUE | FALSE
```

以前にロードされたかどうか、ロード後に変更があったかどうかに関係なく、すべてのファイルをロードするよう指定するオプション

## PURGE

```sql
PURGE = TRUE | FALSE
```

データが正常にロードされた後、ステージからデータファイルを自動的に削除するかどうかを指定するブール値。


## COPY INTOで変換しながらコピーする

COPY INTOコマンドは、SLECT文を用いた変換が可能である。
結合やフィルターや集計は行い得ないが、ステージ上でできる範囲でできる。

```sql
COPY INOT home_sales (city, zip, sale_data, price)
FROM (
    SELECT
        SUBSTR(t,$2,4),
        t.&1,
        t.$5,
        t.$4
    FROM
        $my_stage t
)
FILR_FOERMAT = (FORMAT_NAME = format_csv)
```

## COPY INTOのON__ERROEオプション

データロード次のエラーの処理方法を制御することが可能

- `ON_ERROE=CONTINUE` : エラーが見つかった場合は、ファイルのロードを続行します。エラーが見つかった行はロードされません。

- `ON_ERROE=SKIP_FILE` : エラーが見つかった場合はファイルをスキップします。

## COPY INTOの過去の実行で、ロード中に発生したエラーを確認する

`ON_ERROE=CONTINUE`で全てのロードが完了した後、どの行がエラーが発生したのかを確認することができる。

```sql
select 
    *
from
    table(VALIDATE(mytable, job => '<query_id>'))
```


## VALIDATION_MODEを使用して、検証モードでコピーする

COPY INTOした際のシミレーションが可能。

```sql
COPY INTO my_table
FROM @my_stage/mylife.csv.gz
VALIFATION_MODE=return_all_errors;
```

ただし、SELECT文での変換を検証することはできない。
















## 尾行


title:snowflakeのデータのロード方法

category_script:page_name.startswith("7")

img:https://paya02.com/wp-content/uploads/2018/09/icon25620991.png