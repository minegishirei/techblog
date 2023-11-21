



Haskellの真骨頂は関数型プログラミングにあります。

関数型プログラミングについては以下の記事で解説していると思いますので、
今回はHaskellの関数の文法についてお話します。



## Haskellの関数の文法

Haskellの関数の構文は非常にシンプルです。


-- 関数の型宣言
-- 関数の本体
```hs
functionName :: ArgumentType1 -> ArgumentType2 -> ... -> ReturnType
functionName arg1 arg2 ... = 関数本体
```

- 一行目の関数型の型宣言に関しては、引数を`->`でつなぎ、最後に関数から返却される型を表示します。
- 二行目の関数本体は引数の列挙と関数が行う処理の記述を表します。




## Haskellのサンプルコード

以下は文字列を結合する関数です。
`String -> String`は`concatenate`に渡される引数の型を表しており関数本体での`str1`と`str2`に該当します。

```hs
-- 文字列を結合する関数
concatenate :: String -> String -> String
concatenate str1 str2 = str1 ++ str2

main = print (concatenate "Hello" "World") 
```

以下は引数が一つの関数で、`double`に数値を入れて呼び出すと2倍になって返却されます。
この場合、引数の`Int`が二倍になって返り値の`Int`として返却されます。


```hs
-- 整数を2倍にする関数
double :: Int -> Int
double x = x * 2

main = print (double 10) 
```




