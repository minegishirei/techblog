


## 圏論とは?












## 圏論における準同型性



```hs
-- 整数に1を足す関数
f :: Int -> Int
f x = x + 1

-- 整数を2倍にする関数
g :: Int -> Int
g x = x * 2

main = do
    let myarray = [10, 11, 12, 13]
    print ( fmap (f.g)  myarray )
    print ( fmap  f (fmap (g)  myarray)  )
```




fmap func [a1, a2, a3...] = [func(a1), func(a2), func(a3)]


myarray = [a1, a2, a3...]
とする。

(fmap f (fmap g myarray) )
=> (fmap f (fmap g [a1, a2, a3...])) -- 関数 gに対して上を適応
=> (fmap f ([g(a1), g(a2), g(a3)...]))
=> [f(g(a1)), f(g(a2)), f(g(a3))...]
=> [(f.g)(a1),  (f.g)(a2), (f.g)(a3)...]
=> (fmap f.g [a1, a2, a3...])










