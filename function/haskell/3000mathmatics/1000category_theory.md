


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



## mapとリストについての準同型性

```
fmap func [a1, a2, a3...] = [func(a1), func(a2), func(a3)] - (1)
```

(fmap f (fmap g myarray) ) = (fmap f.g myarray)

> myarray = [a1, a2, a3...]
> とする。
> 
>    (fmap f (fmap g myarray) )
> => (fmap f (fmap g [a1, a2, a3...]))   --- 関数gに対して(1)を適応
> => (fmap f ([g(a1), g(a2), g(a3)...])) --- 関数fに対して(1)を適応
> => [f(g(a1)), f(g(a2)), f(g(a3))...]
> => [(f.g)(a1),  (f.g)(a2), (f.g)(a3)...]
> => (fmap f.g [a1, a2, a3...])
> => (fmap f.g myarray)



## mapと文字列の準同型性


```hs
main = do
    let mystring = "This is pen"
    print ( fmap (length.(split " ")  mystring )
    print ( fmap  length (fmap (split " ")  myarray)  )
```




## fmapとmaybe型の準同型性

maybe型におけるfmapの定義は以下の通り

```hs
fmap f (Just x) = Just (f x)
fmap _ Nothing  = Nothing
```


1) fmap (*2) (Just 4) の値を求めよ

```hs
fmap (*2) (Just 4)
= Just ( (*2) 4)
= Just 8
```

2) (fmap (+1) ( fmap (*2) (Just 4)) )の値を求めよ

```hs
(fmap (+1) ( fmap (*2) (Just 4)) )
= (fmap (+1) ( Just 8) )
= (Just 9)
```


3) fmap ((+1).(*2)) (Just 4) の値を求めよ

```hs
fmap ((+1).(*2)) (Just 4)
= (Just 4*2 + 1)
= (Just 9)
```

4) 次を証明せよ

```
(fmap f (fmap g (Just x) ) ) = (fmap f.g (Just x))
```


```
(fmap f (fmap g (Just x) ) ) 
= (fmap f (Just g(x)) )
= (Just f(g(x)))
= (Just f.g(x))
= (fmap f.g (Just x))
```








## 逆写像の一意制を示せ

- f ∈ 圏(A,B)
- g ∈ 圏(B,A)
- g.f = 1(A)
- f.g = 1(B)

この時、AとBは同系である。










