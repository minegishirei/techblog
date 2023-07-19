



## ドキュメントDBとは何か？

JSONやXMLであらわされるドキュメントをベースにしたデータベースのこと。
ここでのドキュメントとは、**ヒューマンリーダブルで自己記述的かつ階層構造を持つデータ**を表す。

### ドキュメントDBのメリットは?

- **木構造で表現できて、普段一度に読み込むデータは、ドキュメントDBとの相性がいいです。**
    - バックエンドAPIを作る際に、RDSであれば引っ張り出したデータをJson形式に変形させる必要があるが、ドキュメントDBであればそのままjsonデータをレスポンスするだけでよい。
    - つまり、以下のような木構造であらわせるデータ構造にドキュメントDBは向いている。
    - <img src="https://www.softlab.cs.tsukuba.ac.jp/~yas/gen/it-2002-10-28/images/101-tree-univ.gif">
- 学習コストが低い。
- PoC段階での開発にお勧め。本格稼働させる前にRDSに移設するなどの考えもある。
- スケーラビリティが高い
    - ドキュメントデータベースは一般的に スケールアウト (Horizontal Scaling) できるように構築されている。
    - つまり、1000を超えるデータベースから一斉にアクセスされても問題なく稼働できる。






### ドキュメントDBを使うべきでない場面は?

- 多対多の場面ではドキュメントDBは使うべきでない。
    - なぜならドキュメントDBでは、JOIN文の概念がほとんどなく、アプリケーション側で結合処理を行う必要があるからです
    - つまり、以下のようなテーブルであらわした方がよい場面ではRDBSを使用するべき
    - <img src="https://laraweb.net/wp-content/uploads/2018/12/img00.jpg">
- データの整合性を間違えてはいけないとき
    - 例えば、会計データなどデータに厳密な整合性が必要な時
    - ドキュメントデータベースはデータの挿入時にほかのデータベースとの関係をチェックしない。
    - 対してRDSはデータの挿入時にデータの型、他テーブルの外部参照制約を厳しくチェックしてくれるので、整合性が必要な時はRDSが必須。
- トランザクション制御が必要な時
    - MongoDBにはトランザクション制御が存在していません
    - ここでも整合性の観点で問題が発生します。





## mongo dbを触ってみる

dockerがインストールされている場合は以下のコマンドで`mongodb`のサンプル使用が可能。

```sh
docker run -itd -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=pass -p 27017:27017 --name mongo mongo 
```

コンテナ内部から操作してみる

```sh
docker exec -it mongo bash
```

コンテナ内部では次のコマンドでmongoshを起動可能

```sh
mongosh -u root -p pass
```


### データのinsert

`mongosh`で次のコマンドを入力。`{username;"hashito"}`を`users`データベースに入れてみる。

```sh
db.users.insert({username:"hashito"})
```

```js
test> db.users.insert({username:"hashito"})
DeprecationWarning: Collection.insert() is deprecated. Use insertOne, insertMany, or bulkWrite.
{
  acknowledged: true,
  insertedIds: { '0': ObjectId("64b79bf00c0aee57e02d824b") }
}
```

### select文(findメソッド)

findメソッドで`select * from `が実行可能。

```sh
db.users.find()
```

```sh
test> db.users.find()
[ { _id: ObjectId("64b79bf00c0aee57e02d824b"), username: 'hashito' } ]
test>
```


### update文

mongodbのupdate句は次の通り

```sh
db.コレクション名.update({検索条件}, {更新内容})
```

サンプルコード

```sh
db.users.update({username:"hashito"}, {$set:{username:"hashito-v2"}})
```

実行結果を確認する。

```
test> db.users.update({username:"hashito"}, {$set:{username:"hashito-v2"}})
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}
```












