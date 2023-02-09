


### for ループ 

<pre><code> 
val arr = array0f (1, 2, 3) 
for (item in arr) {
    println(item) 
}

</code></pre> 

### mapのforループ

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

### 範囲を指定したforループ (pythonならrength)

<pre><code> 
for (i in 1..3) {
    println(i) 
}</code></pre> 

### 両端を含めたくない時のforループ 

<pre><code> 
for (i in 1 until 3) {
    println(i) 
}</code></pre> 

### インデックスを減少させるforループ

<pre><code> 
for (i in 3 downTo 1) {
    println(i)
}
</code></pre>

### for文のステップ数を変化させたい時 

ex) 3飛びでループのインデックスを回す

<pre><code> 
for (i in 1.. 10 step 3) {
    println(i) 
    //11, 4,7,10
}
</code></pre> 

### Kotlinのcontinue

<pre><code> 
for (i in 1..10) {
    if( i %3 == 0 ) continue 
    println(i) 
    if (i==9) break
}
</code></pre> 

### 二重ループで外側のループに出たいとき 

二重ループで外側のループに出たいときはラベル構文を用いる 

但し、あまり嬉しそうに使うとスパゲッティになりやすいので注意が必要 

<pre><code> 

outer@for (i in 1..3) { 
    for(j in 1..3) { 
        if(i*j > 5) {
            break@outer
        }
        print("${i*j} ")
    }
}
</code></pre>

### whileループ 

条件を満たす間は実行するwhileループ 

<pre><code> 
var i = 1 while (i < 2 ){
    println(i)
    i++ 
}</code></pre>

### do~whileループ 

do whileループは条件式の判定が処理の後ろになり、必ず一度は処理を通る 

ex) パスワードの入力など 

<pre><code> 
var i = 1 do{
    printIn(i)
    i++ 
} while (i < 2 ) 
</code></pre>




title:Kotlinでのfor文の使い方【Kotlin入門】

description:二重ループで外側のループに出たいとき。二重ループで外側のループに出たいときはラベル構文を用いる。但し、あまり嬉しそうに使うとスパゲッティになりやすいので注意が必要 

category_script:True


