





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

このように、**副作用のある関数同士**を `>>=` でつなげることができます。


```hs
import System.IO
import Data.Char(toUpper)

main :: IO ()
main = do 
    getLine >>= putStrLn
```










