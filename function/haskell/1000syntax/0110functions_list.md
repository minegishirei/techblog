



# listを扱うHaskellの関数


## head関数

head関数はリストの最初の要素を返します。

```hs
ghci> head [2,4,6,8]
2
```

## tail関数

tail関数は先頭を除く全ての要素を含むリストを返します。
いわば、head関数の逆です。

```hs
ghci> tail [2,4,6,8]
[4,6,8]
```

仮に返却される要素が一つであったとしても、要素が一つのリストとして返却されます。

```hs
ghci> tail [2,4]
[4]
```

その秘密を`tail`関数の定義を`:type`コマンドで見てみましょう。

```hs
ghci> :type tail
tail :: GHC.Stack.Types.HasCallStack => [a] -> [a]
```

型の定義を見ると、一つのリストからリストを返却していることがわかります。

ちなみに、からのリストを入れるとエラーが発生します。

```hs
ghci> tail []
*** Exception: Prelude.tail: empty list
CallStack (from HasCallStack):
  error, called at libraries/base/GHC/List.hs:1644:3 in base:GHC.List
  errorEmptyList, called at libraries/base/GHC/List.hs:130:28 in base:GHC.List
  tail, called at <interactive>:21:1 in interactive:Ghci9
```

からのリストを指定されたときのエラーが用意されていますね。



## last関数

last関数は配列や文字列の最後の要素を返却します。

```hs
ghci> :type last
last :: [a] -> a
ghci> last "bar"
'r'
```



## take関数とdrop関数

`take`関数はリストの最初のk個の要素で構成されるサブリストを返します。

反対に、`drop`関数はリストの最初のk個の要素を削除したサブリストを返します。

```hs
ghci> take 3 "foobar"
"foo"
ghci> drop 3 "foobar"
"bar"
```

これらの関数は型を確認してみると、二つの引数 `3`と`foobar`が`Int -> [a]`に対応してます。


```hs
ghci> :type take
take :: Int -> [a] -> [a]
ghci> :type drop
drop :: Int -> [a] -> [a]
```





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



## all関数とany関数

- all は、ひとつめの関数がリストのすべての要素で`True`場合に True を返します。
- 一方、any は、述語がリストの少なくとも 1 つの要素で`True`した場合に True を返します。

```hs
ghci> :type all
all :: (a -> Bool) -> [a] -> Bool
```

`odd`関数は数値を引数に取り、奇数であれば`True`を返却します。

`all odd`を組み合わせることで、すべての配列の要素が奇数であれば

```hs
ghci> all odd [1,3,5]
True
ghci> all odd [3,1,4,1,5,9,2,6,5]
False
ghci> any even [3,1,4,1,5,9,2,6,5]
True
```



## isPrefixOf : 文字列を含むか確認

文字列を含むか確認し、含めば`True`を返す

```hs
ghci> "foo" `isPrefixOf` "foobar"
True
ghci> [1,2] `isPrefixOf` [1,2,3,4]
True
```

しかし、二番目の実行結果を確認すれば分かるとおり、 **isPrefixOfの本質は、ひとつ目の配列が二つ目の配列に含まれているかどうかを確認するというもの**


## zip関数

zip関数は二つの配列からチャックを閉めるように、
張り合わせていきます。

```hs
ghci> :type zip
zip :: [a] -> [b] -> [(a, b)]
ghci> zip [12,72,93] "zippity"
[(12,'z'),(72,'i'),(93,'p')]
```



# 関数を引数に取る関数


## filter関数

filter関数はひとつ目の関数でTrueが返ってくるものだけを返却する関数です。

filter関数の型を確認すると、引数のひとつ目の型が`(a -> Bool)`であることが確認できます。

```hs
ghci> :type filter
filter :: (a -> Bool) -> [a] -> [a]
```

```hs
filter odd [2,4,1,3,6,8,5,7]
[1,3,5,7]
```


## zipWith関数

zip関数は二つの配列から貼り合わせるようにタプルを作成しました。

```hs
ghci> zip [12,72,93] "zippity"
[(12,'z'),(72,'i'),(93,'p')]
```

zipWith関数は以下の内容を引数に取りますが、タプルを作成するのではなく関数の結果を追加します。

- 一つの関数
- 二つの配列

```hs
ghci> :type zipWith
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
ghci> zipWith (+) [1,2,3] [4,5,6]
[5,7,9]
```

1+4と2+5と3+6を行い、配列の結果を返却します。










page:https://minegishirei.hatenablog.com/entry/2023/12/04/093533
