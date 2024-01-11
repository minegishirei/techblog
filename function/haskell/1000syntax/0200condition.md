




## Haskellにおける条件式


Haskellにおいて、条件文という言葉よりも「条件式」といったほうが適切かもしれません。
条件文という言葉は手続き型言語やオブジェクト指向型言語では使われますが、Haskellにおいては「関数」が第一級オブジェクトとして扱われます。
ifも「if文」というよりは「if式」と表現し、値が返却するという点でも関数と呼んだほうが良いです。

以下はif式の具体例ですが、参考演算子のように値を返却していることに留意してください。

```hs
main = do
    let test_point = 95
    let result =  if test_point > 60 then "合格" else "不合格"
    print(result)
```


## Haskellのif文


上記の例では、if文を参考演算子のように扱いましたが、関数の宣言のように扱うこともできます。

```hs
main = do
    let test_point = 95
    let judge_score score = if score > 60 then "合格" else "不合格"
    print(judge_score(test_point))
```

上記の例だと

- `judge_sore` が関数名
- `score`が引数
- 実際の関数の中身が =以降の `if score > 60 then "合格" else "不合格"` 
    - このif式自体が関数となるので、`judge_score` というラベルに張り付けているイメージですね

このようにして、Haskellのif式を関数として再定義することが可能になってます。


ちなみに、Haskellにおけるif式は`else if`も使用可能です。以下はテストのスコアリングで第三の選択肢を追加した例です。

```hs
main = do
    let test_point = 95
    let result =  
        if test_point > 90 
            then "合格" 
        else if test_point >60
            then "赤点は超えた"
        else 
            "不合格"
    print(result)
```



## Haskellのcase式


```hs
main = do






















