

## 変数の宣言方法

変数の宣言では var命令を用いる 
<pre><code> 
var 変数名: 変数の型 = 初期値 
</code></pre>

Kotlinの基本データ型は以下の様になっている 

- Double型は比較的大きい小数点数値で使う


## 暗黙の型変換(型推論機能)

Kotlinでは初期値から変数の型を推定してくれる。

ex) 以下のように書いてもnはInt型として判断される。 

mはDouble型とみなされる。 

<pre><code> 
var n = 10
var m = 1.5

</code></pre>

※初期値とデータ型の両方の宣言を省略することはできない

※一度確定した型を変更するような代入ができない

<pre><code> 
var n = 10 n=11 n = "foo" 

</code></pre>

## 型変換 

型同紙に互換性があれば必要にお応じて型を変換することもできる。 

Javaでは互換性がある場合は自動で変換できるが、Kotlinでは明示的に変換する必要がある

<pre><code> 
var a: Float = 1.2 //error(ダブル型であるため) 
var a: Float = 1.2f //Ok 
var b: Double = 10 //error(整数であるため) 
var b: Double = 10 //ok 

</code></pre> 

そのほかだと、toデータ型 () メソッドを用いて変換できる

<pre><code>
var a = 10 
var b: Long = a.toString() 

</code></pre>

toLong()以外にも、toBtye() やtoFloat() 等、変換先の型ごとにメソッドが存在する

## Any型について 

kotlinではすべてのクラスはany型を継承している。 

したがって、どんな型でも代入できるような変数を設定したい場合はany型を使用すればよい


## 定数について

一度定義したら値を変えたくない物はvalで宣言する

再代入する予定のないものは、valを利用するのが基本

<pre><code> 
val a = 10
a=11 //error

</code></pre> 

配列については**配列そのものを再代入するのはエラーが出る** 

しかし、配列の中身を変更するのは可能 

<pre><code> 
val a = arrayof(1, 2, 3) 

a = arrayof (4, 5, 6) 
//エラー 

a[2] = 4
//OK

</code></pre>



## 備考

title:Kotlin学習サイト 変数編【Kotlin入門】

description:変数の宣言では var命令を用いる。しかしJavaと異なる点も多く、変数の宣言では気をつけるべき点も存在する。

category_script:True

