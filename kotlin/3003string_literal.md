


## 文字列リテラルについて 

- [文字列リテラルについて](#文字列リテラルについて) 
- - [複数行を表示したい場合](#複数行を表示したい場合) 
- - [Kotlinで複数行の文字列でタブが入ってしまうとき。](#kotlinで複数行の文字列でタブが入ってしまうとき)。 
- - [Kotlinの文字列テンプレート](#kotlinの文字列テンプレート)


## 文字列リテラルについて 

Kotlinは二種類の文字列リテラルを持つ 

- エスケープ文字を含む文字列 

- 改行やタブなど任意の文字列を含む文字列

//サンプルコード

<pre><code> 
var msg1 = "こんにちは。\n私はKotlinを学んでます"
var msg2 = """こんにちは
私はKotlinを学んでますが 
</code></pre>


// 実行結果

<pre><code>
こんにちは。 私はKotlinを学んでます
</code></pre>

## 複数行を表示したい場合

クオーテーションを三つ続けることで複数行テキストを実現できる。 

<pre><code> 
var msg2 = """こんにちは
私はKotlinを学んでます"""
</code></pre>

## Kotlinで複数行の文字列でタブが入ってしまうとき。 

trimMarginメソッドを使うことで先頭のタブを取り除くことができる

<pre><code> 
fun main(){
    var msg2 = """こんにちは 私はKotlinを学んでます
    を学んでます""".trimMargin() 
    println(msg2)
}
</code></pre>




// 実行結果

こんにちは 私はKotlinを学んでいます。

## Kotlinの文字列テンプレート

文字列に式を埋め込む場合 

<pre><code>
fun main {
    var data = array0f (1.2.3)
    println("配列dataの先頭の値は${data[0]}です") 
}

</code></pre>



title:Kotlinの文字列リテラルについて【Kotlin入門】

description:文字列リテラルとは、ソースコードに書かれた具体的な値のこと。

category_script:True




