


データベースには以下の種別がある



- リレーショナル
    - MySQL
    - PostgreSQL
    - Oracle
    - Microsoft SQL

- キーバリュー
    - Redis
    - Amazon DynamoDB
    - Riak KV

- ドキュメント
    - MongoDB
    - Couchbase
    - AWS DocumentDB

- 列思考データベース
    - Cassandra
    - Scylla
    - Amazon SimpleDB

- グラフデータベース
    - Neo4j
    - Infinite Graph
    - Tiger Graph

- NewSQL
    - VoltDB
    - ClustrixDB
    - SimpleStore

- クラウドネイティブデータベース
    - Snowflake
    - Datomic
    - Redshift
    - BigQuery

- 時系列データベース
    - InfluxDB
    - kdb+
    - Amazon Timestream




## 時系列データベースについて



- 使用イメージ
    - 全てのデータはタイムスタンプがつけられている
    - データはほとんど常に挿入される
    - 更新や削除はされない
    - データのエラーが発生した場合の手続きは煩雑であるため、学習の難易度は高い


- 機能
    - 全てのデータはタイムスタンプがつけられている
    - 挿入されるデータにはタグをつけることが可能
        - 👎 Bad  `ticket_status=Open.37477`
        - 👍 Good `ticket_status=Open`、`ticket_id=37477`
        - 一つのタグに複数の情報を追加するのは悪い習慣とされている。

- スケーラビリティ
    - 基本高い
    - 例1 ) TimeScaleDBはPostgreSQLをベースにしている。標準的なスケーリングとスループットが可能
    - 例2 ) InfluxDBはメタデータを管理する**メタノード**と実際のデータを保存する**データノード**が存在するため、スループット能力は比較的高い

- 可溶性/分断耐性
    - メタノードが設定されるデータベースでは可用性/分断耐性は高い


- 時系列データベース具体例
    - InfluxDB
    - kdb+
    - Amazon Timestream









