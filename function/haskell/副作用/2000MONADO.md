





## モナドのメリット

モナドはHaskellのプログラムにおいて、特に入出力回りで活躍する仕組みです。
関数プログラムの本体から副作用を安全に分離することができ、計算戦略をプログラム全体にばら撒くことをせずに、一箇所にまとめることができます。



## モナドの具体例

### モナドの具体例1

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







## モナドの正体?

ここで、モナド関連の演算子によく使われる`>>=`を詳しく見てみる。
まずは型の詳細をみよう。

```hs
Prelude> :t (>>=)
(>>=) :: IO a -> (a -> IO b) -> IO b
```

この結果をみると、いくつかわかることがある。

- 第一引数は`IO`型の変数
        - 第二引数のように、関数としてラッピングされていないことを考えると、外部からの入力結果と考えてよい。
- 第二引数は`関数 (a -> IO b)` 
        - 関数 (a -> IO b) は、型 a の値を受け取り、型 b の値を含むIOアクションを生成します。
- 返り値は`IO b`
        - 第二引数の関数の返り値のこと。

つまり、`>>=`オペレーターは、**外部からの入力がある、副作用の関数Aと、外部へ出力がある副作用のある関数Bを結び付ける**という関数であると言えます。

Haskellの (>>=) バインド演算子は、外部の世界とのやり取りを伴うIOアクションを順番に実行する際に使用されます。
具体的には、関数Aが外部からの入力や他の副作用を持つ IO a アクションで、関数Bが外部への出力や他の副作用を持つ (a -> IO b) 関数です。


### `>>=`の型に着目する


具体例1で置き換えて考えてみる。

```hs
import System.IO
import Data.Char(toUpper)

main :: IO ()
main = do 
    getLine >>= putStrLn
```

この場合、`getLine`は`IO a`の型に当てはまり、
`putStrLn`は`(a -> IO b)`の型に当てはまる。

せっかくなので、それぞれの型を確認してみる

```hs
getLine :: IO String
``

```hs
putStrLn :: String -> IO ()
```

予想通り、

- getLineの型は`IO`付きの`String`
- putStrLnの型は`String -> IO()` であった。


## HaskellのRandomの具体例

```hs
import System.Random

main = do
    print =<< randomRIO (0, 100 :: Int)
```














