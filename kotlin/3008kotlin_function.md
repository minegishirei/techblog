

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

</code></pre>

title:Kotlinでの関数【Kotlin入門】

description:KotlinではJavaと異なり、クラス以外に関数を宣言できる

category_script:True



