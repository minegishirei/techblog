




sqliteを扱うHaskellのデータベースライブラリはいくつかあるが、最も簡単なライブラリが`sqlite-simple`である。

インストール方法は`cabal`であれば以下の通り。（自分は`--lib`をつけなければインストールできなかった）

```sh
cabal install --lib sqlite-simple
```


```hs
{-# LANGUAGE OverloadedStrings #-}
import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow

data TestField = TestField Int String deriving (Show)

instance FromRow TestField where
  fromRow = TestField <$> field <*> field

main :: IO ()
main = do
  conn <- open "test.db"
  execute conn "CREATE TABLE IF NOT EXISTS TEST (id INTEGER PRIMARY KEY, str text);" ()
  execute conn "INSERT INTO TEST (str) VALUES (?)" (Only ("test string 2" :: String))
  r <- query_ conn "SELECT * from TEST" :: IO [TestField]
  mapM_ print r
  close conn
```





