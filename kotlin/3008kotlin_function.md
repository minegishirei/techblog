

## 関数

KotlinではJavaと異なり、クラス以外に関数を宣言できる

## 関数の基本

関数を定義するためにはfunキーワードを使用する

関数の定義 

<pre><code>
fun 関数名 (仮引数: 引数の型, ...):戻り値の型 {
    //処理
}
//呼び出し 
関数名() 
</code></pre>

仮引数と戻り値の型の宣言は必須。 

戻り値がない場合はUnitを指定するか省略する 

<pre><code> 
fun getTriangleArea (width: Couble, height: Double):Double {
    return width * height / 2 
}
println( getTrianelArea(10, 0, 11,1)) 
</code></pre> 

<pre><code> 
fun sayHello (name: String): Unit {
    println("Hello, ${name}.") 
}
sayHello("tarou”) 
// Hello, tarou 

</code></pre>

## 関数の処理が一行で終わる場合 

returnなどを省略可能である 

<pre><code> 
fun gettriangleArea (width: Double, height: Double): Double = width * height /2 
</code></pre> 

また、戻り値の型が推論可能である場合, 型を省略することもできる 

<pre><code> 
fun gettriangleArea (width: Double, height: Double) width * height /2 
</code></pre>

## 引数のデフォルト値 

引数が省略されたときに設定される引数を「デフォルト値」という。 

<pre><code> 
fun getTriangleArea (width: Couble=1.0, height: Double=1.5): Double {
    return width * height / 2 
}
println( getTriane Area ()) 
//0.75 
println( getTrianel Area (3.0)) 
</code></pre>



## 名前付き引数 

呼び出し側に明示的に引数を指定できる。 

通常の引数と混在させることもできるが、エラーの原因にもなるためなるべく避けた方が

<pre><code> 
fun getTriangleArea (width: Couble=1.0, height: Double=1.5): Double {
    return width * height / 2 
}
println(getTrianelArea(height = 30 width=20 )
println(getTrianelArea (height = 3.0)) 

</code></pre>

必須の引数を先頭に、任意の引数(オプション)は後方に並べる方がよい。

## 可変長引数 

varargキーワードを用いる 

可変長引数は内部的には配列とみなされるので、forループによる処理が可能


<pre><code> 
fun allSum(vararg values: Int): Int {
    var result = 0 
    for (value in values) {
        result += value
        return result println( al ISum (2, 3, 4, 2,5)) 
    }
}
</code></pre>

## スプレッド演算子 

スプレッド演算子を使うことで、配列を可変長引数として使うこともできる

<pre><code> 
fun allSum(vararg values: Int): Int {
    var result = 0 
    for (value in values) {
        result += value
        return result
    }
}
println( allSum(2, 3,4, 2,5)) 
//渡したい引数 
val arr = int ArrayOf( 1, 1, 1, 1) 
println(allSum(*arr))
println(allSum(4, *arr, 3))
//ok
</code></pre>


## Kotlinで戻り値を複数定義したい場合 

引数の合計と平均を受け取りたい場合。 

- Pairで括ることで二つの戻り値を返せる。 

- 3つを返す場合はTipleで括る。 

- 3つ以上を返す場合

<pre><code> 
fun allSum(vararg values: Int): Pair(Int, Double) {
    var result = 0 
    var count = 0.0 
    for (value in values) {
        result += value 
        count ++
    }
    return Pair (result, result / count)
}
val (sum, average) = alSUM(1,1,1,1) 

printIn(sum) 
// 4.0

printIn(average) 
// 1.0

val (_, average) = allSum(2, 2, 2, 2) 
// デメリットは使わない値が帰ってきてしまうこと
// averageのみ必要であればこのように_を使う書き方がよい

</code></pre>


## 高階関数 

**引数や戻り値に関数を指定する関数**のこと 

例)forEachメソッドなど 関数の引数に関数を渡すには::演算子を用いる

<pre><code> 
fun show(n: Int){
    println(n)
}
val arr = arrayOf(1,1,1,1) 
arr.forEach(::show)

</code></pre>

forEachメソッドは配列にデフォルトで実装されているメソッドで 
**全ての配列の要素に対して引数で受け取った関数を処理する**

という特徴を持つ

## 匿名関数: ラムダ式 

高階の引数として渡される関数は一度しか使われないケースが多い。 

その場合はラムダ式として、使い捨ての関数を使うのが主流である。

<pre><code> 
val arr = arrayOf (1, 2, 3, 4) 

// 通常のラムダ式 
arr.forEach({ n: Int -> println(n) } 
//1 
//2
//3

// 推論可能な型なので、Intを省略できる 
arr.forEach({ n -> println(n) }

// 引数が単一ならば、引数の指定をitでも可能 
arr.forEach({ printin(it) }
//1
//2
//3 
//4 
</code></pre>

## ラムダ式の注意点

ラムダ式中でreturnをすると、直情の関数を抜けてしまう。

<pre><code> 
fun main(){
    val arr = arrayof ( 1, 2, 1, 1) 
    arr. for Each {
        if (it == 3) return // Dreturnid
        println(it)
    }
}
// ここまで飛ぶ 
</code></pre>

ラムダ式でreturnをするには、**ラベル構文を使用する** 

<pre><code> 
fun main(){
    val arr = arrayof( 1, 2, 1, 1) 
    arr.forEach loop@ {
        if (it == 3) return@loop
        println(it) 
    } 
    //ここまで飛ぶ
}
</code></pre> 

あるいは、forEachをラベルとして設定することもできる。 

<pre><code> 
fun main(){
    val arr = arrayof ( 1, 2, 1, 1) 
    arr.for Each {
        if (it == 3) return@forEach
        println(it) 
    }
    // ここまで飛ぶ 
}
</code></pre>

## 高階関数を定義する事も可能

関数の処理時間を計測したい場合、以下のようなbenchmark関数を定義することができる

<pre><code> 
fun benchmark (unitStr: String, func: ()-> Unit) : String {
    val start = System.currentTimeMillis() 
    func() 
    val end = System.currentTimeMillis() 
    return (end-start).ToString() + unitStr
}
var time = benchmark("ミリ秒", {
    var x = 0 
    for (i in 1..1_100_000_000) {
        X++
    }
    println("SLIM " + time)
}
</code></pre>





title:Kotlinでの関数【Kotlin入門】

description:KotlinではJavaと異なり、クラス以外に関数を宣言できる

category_script:True



