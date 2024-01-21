




## データベースの使用例



```hs
-- file: ch22/PodDB.hs
module PodDB where

import Database.HDBC
import Database.HDBC.Sqlite3
import PodTypes
import Control.Monad(when)
import Data.List(sort)

-- | ファイルパスからコネクションを作成する。
-- | その際にはデータベースを初期化する処理を走らせる。
connect :: FilePath -> IO Connection
connect fp =
    do dbh <- connectSqlite3 fp
       prepDB dbh
       return dbh
```


## データベースを初期化する処理


```hs
{- | データベースを初期化する。
二つのテーブルを作成するイニシャライザ

* castid と epid は プライマリーキーです。
* castURL はユニークキーです。
-}
prepDB :: IConnection conn => conn -> IO ()
prepDB dbh =
    do tables <- getTables dbh
       when (not ("podcasts" `elem` tables)) $
           do run dbh "CREATE TABLE podcasts (\
                       \castid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,\
                       \castURL TEXT NOT NULL UNIQUE)" []
              return ()
       when (not ("episodes" `elem` tables)) $
           do run dbh "CREATE TABLE episodes (\
                       \epid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,\
                       \epcastid INTEGER NOT NULL,\
                       \epurl TEXT NOT NULL,\
                       \epdone INTEGER NOT NULL,\
                       \UNIQUE(epcastid, epurl),\
                       \UNIQUE(epcastid, epid))" []
              return ()
       commit dbh
```

## 新しいポッドキャストをデータベースに追加する。

```hs
{- | 新しいポッドキャストをデータベースに追加する。

追加するポッドキャストのcastidは無視し、投入したcastidを持つ新しいオブジェクトを返す。
既に存在するポッドキャストを追加しようとすればエラーが出る。
-}
addPodcast :: IConnection conn => conn -> Podcast -> IO Podcast
addPodcast dbh podcast = 
    handleSql errorHandler $
      do run dbh "INSERT INTO podcasts (castURL) VALUES (?)"
             [toSql (castURL podcast)]
         r <- quickQuery' dbh "SELECT castid FROM podcasts WHERE castURL = ?" [toSql (castURL podcast)]
         case r of
           [[x]] -> return $ podcast {castId = fromSql x}
           y -> fail $ "addPodcast: unexpected result: " ++ show y
    where errorHandler e = 
              do fail $ "Error adding podcast; does this URL already exist?\n"
                     ++ show e
```























