


## for ループ 

<pre><code> 
val arr = array0f (1, 2, 3) 
for (item in arr) {
    println(item) 
}

</code></pre> 

## mapのforループ

<pre><code> 
val map = mapOf ("Firsst" to 1, "Second to 2, "Third” to 3) 
for ( (key, value) in map) {
    println("${key] : ${value}") 
}

</code></pre>

配列でもwithIndexメソッドでインデックスと値の組み合わせを取得できる

<pre><code> 
val list = listof ("to", "\", "3") 
for ((index, value) in list.withIndex()) {
    println("${index} : $ {value}") 
}
</code></pre>

## 範囲を指定したforループ (pythonならrength)



