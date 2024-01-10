



## classキーワード

型クラスの定義



Haskellでは等号、非等号を表すために`Eq`というクラスを使用しています。

```hs
class Eq a where
  (==), (/=) :: a -> a -> Bool

  x == y = not (x /= y)
  x /= y = not (x == y)
```

上記の`Eq`クラスから以下の情報が読み取れます。

- 等号が使用可能な型は、`Eq`を継承している
- それぞれの型は、`==` と`/=` メソッドが実装される。
- `==`と`/=`は二つの同じ型を取り、最終的に`Bool`が返される。
- デフォルトで、`==`と`/=`が定義されているが、それぞれが依存関係にあるため、どちらかのメソッドは定義しなければならない

上記の`Eq`クラスを使用して新しい型とそれに対する制約を作ります。



## instance キーワード


それでは、`Eq`クラスを使用して新しい型`User`を作ります。
型クラス`User`が同一人物かどうかを判断するために`Eq`クラスを継承,インスタンス宣言します。

```hs
data User = User Int Name
instance Eq User where
    (User id username ) == (User id' username') = id == id` && username == username'

main do
    print( (User 10 "tanaka") == (User 20 "nakata") ) -- false
    print( (User 10 "tanaka") /= (User 20 "nakata") ) -- true
    print( (User 10 "tanaka") == (User 10 "tanaka") ) -- true
```








































