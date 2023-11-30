



# listを扱うHaskellの関数




## lines関数

この`lines`関数は、Haskellのデフォルトの関数として定義されています。
その役割は文字列を`\n`で区切られた配列に変換します。

`lines`関数の型を確認してみると、`String`型から`[String]`型に変更する関数であると確認できると思います。

```hs
ghci> :type lines
lines :: String -> [String]
```

- サンプルコード

```hs
ghci> lines "foo\nbar"
["foo","bar"]
```

- cf) 反対に、`unlines`関数は文字列の配列を`\n`でつなげます。

```hs
ghci> unlines ["foo", "bar"]
"foo\nbar\n"
```



## last関数

last関数は配列や文字列の最後の要素を返却します。

```hs
ghci> :type last
last :: [a] -> a
ghci> last "bar"
'r'
```



## take関数

`take`関数はリストの最初のk個の要素で構成されるサブリストを返します。

反対に、`drop`関数はリストの最初のk個の要素を削除したサブリストを返します。

```hs
ghci> take 3 "foobar"
"foo"
ghci> drop 3 "foobar"
"bar"
```

これらの関数は型を確認してみると、二つの引数 `3`と`foobar`が`Int -> [a]`


```hs
ghci> :type take
take :: Int -> [a] -> [a]
ghci> :type drop
drop :: Int -> [a] -> [a]
```







