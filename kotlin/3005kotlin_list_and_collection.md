


## 配列とコレクション 

Kotlind複数の要素をまとめて扱うにはJavaと同様にCollectionを扱う 

#### 配列 

最もシンプルだが、宣言の段階でサイズを決める必要がある。

#### List 

長さが固定でなく、配列よりも柔軟性が高い。(ほぼ配列の上位互換)

#### Set 

リストとほぼ同じだが、重複した要素は登録されない。(集合の概念)

#### Map(辞書) 

キーとバリューの一対一で登録される複数の値 辞書とも呼ばれる。

### 配列について

サンプルコード 

<pre><code> 
var a = arrayof(1, 2, 3,4) 
var b = intArrayOf(1,2,3)

//nullが入るので型推論が働かないため、方の指定が必要 
var c: Array<String?> = arrayofNulls(3)

//lamda式を利用した、柔軟な初期化 
var d = Array(3, {i ->i*2}) )

println(d) 
// [0, 2,4]  
// 0スタートであることに注意! 

</code></pre>

### リストのサンプルコード

<pre><code> 
var list = listOf("あ", "い","う") 

printIn(list)
// ["55","L1","5"] 

</code></pre>

### setのサンプルコード 

出力の段階で重複が排除されていることに注意 

<pre><code> 
var set = setof ("A", "A”, "A", "C", "B") 

println(set) 
//["A", "B", "C"] 

</code></pre>


### mapのサンプルコード

Kotlinでのdictに当たる。

<pre><code> 
var map = mapOf("First" to 1, "Second" to 2, "Third" to 3) println(map) 7/{First=1, Second=2, Third= 3} 
</code></pre>

### 変更可能なコレクション 

mutableコレクション名Of () 関数を使う 

<pre><code> 
var list = mutableListof (1, 2, 3) 
list[2] = 4 
println(list) 
// [1, 2, 3] 
</code></pre>

通常のlistがimutableなわけではない。

<pre><code> 
var mList = mutableListof (1,2,3) 
var list = listof (1, 2, 3, 4)

//list[2] = 4 /
//error 

mList[2] = 4 
//ok!

list = mList //OK 
</code></pre>


### 備考

title:Kotlinでの配列とリストの違い【Kotlin入門】

description:Kotlind複数の要素をまとめて扱うにはJavaと同様にCollectionを扱う

category_script:True




