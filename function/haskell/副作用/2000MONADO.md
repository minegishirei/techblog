





## モナドのメリット

モナドはHaskellのプログラムにおいて、特に入出力回りで活躍する仕組みです。
関数プログラムの本体から副作用を安全に分離することができ、計算戦略をプログラム全体にばら撒くことをせずに、一箇所にまとめることができます。



## モナドの具体例

例えば、二つの関数`getLine`と`putStrLn`関数を考えます。
この二つはどちらも`IO`型で定義される、**副作用の存在する** 関数です。

そして、この二つの関数を用いて、「getLineで得た行を、putStrLnで出力したい」とします。
通常のコードであれば、次のように書き表すと思います。


```hs
import System.IO
import Data.Char(toUpper)

main :: IO ()
main = do 
    inpStr <- getLine
    putStrLn( inpStr )
```

上記のコードでは、`getLine`で得た内容を`inpStr`変数に格納しています。
そして次の行で`inpStr`変数の内容を`putStrLn`で標準出力しています。

ところが、よくよく考えれば`inpStr`は仲介するだけの変数で、可能であれば`getLine`と`putStrLn`の関数を直接つなげたくなると思います。



```hs
import System.IO
import Data.Char(toUpper)

main :: IO ()
main = do 
    getLine >>= putStrLn
```

このように、**副作用のある関数同士**を `>>=` でつなげることができます。

- `getLine`関数は **標準入力を受け付ける**
- `inpStr`関数は **標準出力する**
- `>>=` で上記の関数をつなげることで、**標準入力を標準出力する** 



### 具体例その2


上記のコードは、
「標準入力で受け取った内容を、標準出力により表示する」という単純なプログラムでしたが、この課題を次のように発展させましょう。

「標準入力で受け取った内容を、すべて大文字に変えて、標準出力により表示する」というプログラムに置き換えます。


まずは、モナドを使わない例を見てみましょう。

```hs

import System.IO
import Data.Char(toUpper)

main :: IO ()
main = do 
    inpStr <- getLine
    let inpStr2 = map toUpper inpStr
    putStrLn( inpStr2 )
```

上記のコードを実行すると、入力された文字列はすべて大文字となって返却されると思います。

```
test
TEST
```

上記のコードでやっていることを、日本語に起こしてみましょう。

1. `getLine`で入力した内容を、`inpStr`へ出力する。
2. `map toUpper inpStr`により得た大文字を、`inpStr2`へ出力する。
3. `putStrLn`により、`inpStr2`を表示する。

しかし、上記のコードもまだまだ短くできそうです。

やりたいことは、「標準入力で受け取った内容を、すべて大文字に変えて、標準出力により表示する」という内容だったはずです。
そのために、`inpStr`や`inpStr2`を用意するのは必要な内容とは思えません。（説明変数の役割は果たせる可能性がありますが、本質的には必要な変数ではないでしょう）

そこで、モナドを使用して、
「標準入力で受け取った内容を、すべて大文字に変えて、標準出力により表示する」
を実現してみましょう。




```hs
import System.IO
import Data.Char(toUpper)

main :: IO ()
main = do 
    getLine >>= putStrLn . (\x -> map toUpper x )
```

上記のコードは、 `putStrLn`関数に対して「入力された内容をすべて大文字にする関数」を**合成** しています。
いわば、「引数をすべて大文字にして表示する」という関数を新しく作ってしまったわけです。

上記のコードは「合成」をうまく使ってやりたいことを一行で表すことが出来ています。

あえて言うのであれば、「入力された内容をすべて大文字にする関数」はまとめることができそうですね。やってみましょう。

```hs
import System.IO
import Data.Char(toUpper)

toUppers :: String -> String
toUppers = map toUpper

main :: IO ()
main = do 
    getLine >>= putStrLn . toUppers
```

3つの関数を華麗に使い、
「標準入力で受け取った内容を、すべて大文字に変えて、標準出力により表示する」
を表現することが出来ました。












