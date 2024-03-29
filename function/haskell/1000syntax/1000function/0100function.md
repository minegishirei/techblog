



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




### Haskellのサンプルコード

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


## Haskellは数学

Haskellの数学は関数の宣言に表れています。
**Haskellの関数は写像ととらえることが出来るのです。**

まずは数学における写像の定義は以下の通りです。

> Xの要素（元）を変換機械fに通したら, 毎回同じYの要素（元）になるよ

これを数学的記号であらわすと以下のようになりますが、**これはHaskellにおける関数の宣言と酷似していると思います**

<img src="https://github.com/minegishirei/techblog/blob/main/0/function/shazou.png?raw=true">

例えば、整数を二倍にする関数`f`の宣言は以下の通りでした。

```hs
f :: Int -> Int
```

これは「関数`f`は`Int`で定義され,毎回同じ`Int`の要素になるよ」
と読み取ることが出来ますが、これはもうほぼ写像です。

多少強引な意見に見えるかもしれませんが、**Haskellは数学を元にした言語である**と言えるのではないでしょうか?




### Haskellの関数の合成

Haskellの関数を呼び出した結果をprintするとき、`()`でくくっていました。

```hs
main = print (double 10) 
```

これを別の言い方をするのであれば**Haskellでは意味のあるまとまりごとに`()`でくくる**と言い換えれます。
**この`()`表現は、数学的な意味合いが強いです。**

例えば、xに1を足す関数と、2倍する関数を合成するし数式であらわすとすると `y = 2(x+1)`となります。

これをHaskellの関数であらわしてみましょう。


```hs
-- 整数に1を足す関数
addOne :: Int -> Int
addOne x = x + 1

-- 整数を2倍にする関数
double :: Int -> Int
double x = x * 2

-- 数式 y=2(x+1) を表す
f :: Int -> Int
f x = (double (addOne x) )

main = print (f 10)
```

特に以下の行に注目してほしいのですが、数学の`()`と同様に優先順位が明確になっていると思います。

```hs
f x = (double (addOne x) )
```

関数を呼び出す際には`()`がトリガーとなるのですが、これが数学的な意味合いが強いことは覚えておいてください。



### Haskellの関数合成記号

数学における関数の合成は、二通りの表現方法があります。

<img src="https://github.com/minegishirei/techblog/blob/main/0/function/gousei.png?raw=true">

上記のように、`〇`でつなぐ方法がHaskellにはないのでしょうか?

結論から言えば、Haskellにも数学のような関数合成の記述方法があります。

<img src="https://res.cloudinary.com/bend/f_auto/shikakutimes/s3/bend-image/1653309571.png">

```hs
-- g(x)
g :: Int->Int
g x = x + 1

-- f(x)
f :: Int->Int
f x = x*x

-- g(x)とf(x)の合成関数
fg :: Int->Int
fg x = (f . g) x

main = print (fg 10)
```

このように、Haskellにおける関数合成は`.`演算子を用いて行うことができます。



### Haskellの再起関数

wikipediaによると、数学における階乗の定義は次のように表すことができます。

<img src="https://github.com/minegishirei/techblog/blob/main/0/function/factal.png?raw=true">

これは再帰的な階乗の定義ですが、これをHaskellであらわした場合、次のような表記になります。

```hs
f 0 = 1	
f n = n * fact (n - 1)
```

Haskellでのコードの記述とWikipediaの数式が似ていることに気づいたでしょうか?
**Haskellでは数式を書くように関数を記述できるのです**

詳しい内容を一行ずつ説明します。

```hs
f 0 = 1
```

これは、`n`が0の場合、`f`の値は1であると定義しています。階乗の定義では、0の階乗は1となります。

```hs
f n = n * fact (n - 1)
```

ここでは、`n`が0でない場合の`f`の定義を行っています。この部分が再帰的な定義です。`n`が0でない場合、`f n`は `n` と `f (n - 1)` の積として計算されます。つまり、`n`の階乗は `n` と `(n-1)` の階乗の積として定義されています。

子のコードは再帰的な表現をしているため、これを展開すると以下のようになります。

```hs
f 5 = 5 * f 4
    = 5 * (4 * f 3)
    = 5 * (4 * (3 * f 2))
    = 5 * (4 * (3 * (2 * f 1)))
    = 5 * (4 * (3 * (2 * (1 * f 0))))
    = 5 * (4 * (3 * (2 * (1 * 1))))
    = 120
```



page:https://minegishirei.hatenablog.com/entry/2023/11/25/093512
