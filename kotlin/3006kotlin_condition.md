


## 演算子・制御構文 

四則演算や比較などの、値の計算処理を行うための記号 

四則演算など基本的なものは他のプログラミング言語と同様 

## 比較演算子 == と ===は挙動が異なる

## 範囲演算子between

m.nと書くと、m~nの範囲を表すものになる 

sqlでのbetween演算子に当たる 

<pre><code> 
val i = 10 

printIn(i in 1..20) 
//true 
</code></pre>

**両端の値も含むことに注意** 
 
1..20であれば、1はtrueになる。 
 
<pre><code> 
val i = 1 

println(i in 1..20) 
// true 

</code></pre>

<pre><code> 
val i = 20 

println(i in 1..20) 
// true 

</code></pre> 

小数点でも比較可能

<pre><code> 
val i = 11.11 

println(i in 1..20) 
// true 

</code></pre>



## kotliのif文

if文の例

<pre><code> 
val a = 10 
if (a < 5)
    println("aは5以下です") 
}else if(a <= 10) {
    println("aは10以下です") 
}else{
    println("aは10より大きいです”)
}
//結果:aは10以下です。
</code></pre>

## if式

ifは式であるので、値を返すことができる。 

関数のように実行結果をreturnするのが可能だ。

<pre><code> 
val a = 10 

var msg = if (a < 5) {
    ("aは5以下です") 
}else if(a <= 10) {
    ("aは10以下です) }
else{
    (aは10より大きいです")
}
printIn (msg) 
//結果:aは10以下です。 
</code></pre> 

- if式を用いた場合は何かしらの値が必要になるので、**elseが必ず必要**

{}の中には複数行の記述も可能であり、その場合は**最後に書いた値を戻り値としてみなす

- 処理が一行のみならば、 { } は省略可能


<pre><code> 
val a = 5 
var msg = if(a <= 5 ) "aは5以下です" else "aは10より大きいです” 
println(msg) 
//結果:aは5以下です。 

</code></pre>






## when it

式の値に応じて処理を分岐させるにはwhen式を使う

switch文の代わりのようなもの

<pre><code> 
val x = 1 when(x) {
    1 -> println("xは1です) 
    2 -> println("xは1です") 
    else -> {
        printIns("xは1でも2でもない")
    }
}
</code></pre> 

if式同様に、値を返すことができる 

<pre><code> 
val score = 80 
val msg = when (score) {
    in 100..99 -> "素晴らしい” 
    in 60..98 -> "合格です” 
    !in 60..100 -> "不合格です" 
    else -> "不正な点数です。
</code></pre>


## 型の判定 

型での分岐も可能で、is演算子を利用する 

<pre><code> 
val obj: Any = "あいうえお" when (obj) {
    is String -> println("母児数は${obj.length) です")
    else -> println("String型ではないです") 
}
</code></pre> 

注意 型チェックが行われた後のブロックでは、型変換が行われる! 

以下のコードは is Stringで型変換が行われているので

<pre><code> 
val obj: Any = "あいうえお" 
when (obj) {
    obj is String -> println("母児数は${obj.length)です") else -> println("String型ではないです")
}
</code></pre>

 以下のコードでは型変換が起きていないのでエラーが発生する。



<pre> <code> 
val obj: Any = "$11535" 
println("moji $(obj.length}") 

</code></pre>


## 備考


title:Kotlinでのif文,if式と条件分岐【Kotlin入門】

description:四則演算や比較などの、値の計算処理を行うための記号。四則演算など基本的なものは他のプログラミング言語と同様。


category_script:True

