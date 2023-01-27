


- [反構造化ファイルフォーマット(`Variant`)](#反構造化ファイルフォーマットvariant)
  - [Variantカラムの使い方](#variantカラムの使い方)
  - [snowflakeでjsonを扱うサンプルコード](#snowflakeでjsonを扱うサンプルコード)
    - [jsonのvalueの取り出し方（jsonの要素のアクセス)](#jsonのvalueの取り出し方jsonの要素のアクセス)





# 反構造化ファイルフォーマット(`Variant`)

Snowflakeは、 JSON、Avro、 ORC、Parquet、および XML 形式から半構造化データをインポートし、 半構造化データをサポートするように特別に設計されたSnowflakeデータ型 に格納できます。

データの構造、データのサイズ、およびユーザーがデータをインポートする方法に応じて、半構造化データを1つの列に格納することも、複数の列に分割することもできます。

半構造化データは`Variant`型に格納されます。


## Variantカラムの使い方

半構造化データは`Variant`型に格納されます。
次のコードはmy_tableのmy_variant_columnに`Variant`型のテーブルを設定するコードです。

```sql
create table my_table (my_variant_column variant);
```

variant型のカラムにデータを入れるにはPARSE関数を使用する必要があります。
次のコードは、json形式のデータをVARIANT値に変換しています。

```sql
insert into my_table (my_variant_column) select parse_json('{...}');
```



## snowflakeでjsonを扱うサンプルコード

snowflakeの公式ドキュメントでは、次のようなサンプルコードがあります。

```sql
create or replace table car_sales
( 
  src variant
)
as
select parse_json(column1) as src
from values
('{ 
    "date" : "2017-04-28", 
    "dealership" : "Valley View Auto Sales",
    "salesperson" : {
      "id": "55",
      "name": "Frank Beasley"
    },
    "customer" : [
      {"name": "Joyce Ridgely", "phone": "16504378889", "address": "San Francisco, CA"}
    ],
    "vehicle" : [
      {"make": "Honda", "model": "Civic", "year": "2017", "price": "20275", "extras":["ext warranty", "paint protection"]}
    ]
}'),
('{ 
    "date" : "2017-04-28", 
    "dealership" : "Tindel Toyota",
    "salesperson" : {
      "id": "274",
      "name": "Greg Northrup"
    },
    "customer" : [
      {"name": "Bradley Greenbloom", "phone": "12127593751", "address": "New York, NY"}
    ],
    "vehicle" : [
      {"make": "Toyota", "model": "Camry", "year": "2017", "price": "23500", "extras":["ext warranty", "rust proofing", "fabric protection"]}  
    ]
}') v;
```

from https://docs.snowflake.com/ja/user-guide/querying-semistructured.html#sample-data-used-in-examples


このコードで作られた`Variant`を含むテーブルを確認してみましょう。


```sql
select * from car_sales;
```

このコードを実行すると、コンソール上にフォーマットされたjsonが確認できます。

```json
+-------------------------------------------+
| SRC                                       |
|-------------------------------------------|
| {                                         |
|   "customer": [                           |
|     {                                     |
|       "address": "San Francisco, CA",     |
|       "name": "Joyce Ridgely",            |
|       "phone": "16504378889"              |
|     }                                     |
|   ],                                      |
|   "date": "2017-04-28",                   |
|   "dealership": "Valley View Auto Sales", |
|   "salesperson": {                        |
|     "id": "55",                           |
|     "name": "Frank Beasley"               |
|   },                                      |
|   "vehicle": [                            |
|     {                                     |
|       "extras": [                         |
|         "ext warranty",                   |
|         "paint protection"                |
|       ],                                  |
|       "make": "Honda",                    |
|       "model": "Civic",                   |
|       "price": "20275",                   |
|       "year": "2017"                      |
|     }                                     |
|   ]                                       |
| }                                         |
| {                                         |
|   "customer": [                           |
|     {                                     |
|       "address": "New York, NY",          |
|       "name": "Bradley Greenbloom",       |
|       "phone": "12127593751"              |
|     }                                     |
|   ],                                      |
|   "date": "2017-04-28",                   |
|   "dealership": "Tindel Toyota",          |
|   "salesperson": {                        |
|     "id": "274",                          |
|     "name": "Greg Northrup"               |
|   },                                      |
|   "vehicle": [                            |
|     {                                     |
|       "extras": [                         |
|         "ext warranty",                   |
|         "rust proofing",                  |
|         "fabric protection"               |
|       ],                                  |
|       "make": "Toyota",                   |
|       "model": "Camry",                   |
|       "price": "23500",                   |
|       "year": "2017"                      |
|     }                                     |
|   ]                                       |
| }                                         |
+-------------------------------------------+
```


### jsonのvalueの取り出し方（jsonの要素のアクセス)

snowflakeでvalueを取り出すには、`:`を使用して要素にアクセスできます。

```sql
select src:dealership
    from car_sales
    order by 1;
```

結果は以下の通りです。

```sql
+--------------------------+
| SRC:DEALERSHIP           |
|--------------------------|
| "Tindel Toyota"          |
| "Valley View Auto Sales" |
+--------------------------+
```

または、`[]`を使用してアクセスすることも可能です。

```sql
select src['salesperson']['name']
    from car_sales
    order by 1;
```







title:反構造化ファイルフォーマット(`Variant`)

category_script:page_name.startswith("7")


img:https://cdn-icons-png.flaticon.com/512/136/136443.png


