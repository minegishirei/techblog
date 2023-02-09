

## 文字列と数値

### リテラルとは? 

ソースコードに書かれた具体的な値のこと

### Kotlinの数値リテラル 

主に使う数値リテラル 

<pre><code> 
var a = 1001 //10新数 
var b = 0x0F //16新数
var c = 0b10101 //2新数 0bスタ 
var d = 1.23 // 少数 
var e = 1.23e+5 //指数
</code></pre>

### Kotlinの数値とアンダーバー 

数値に入るは処理の上では無視される

したがって、桁区切りとして活用が可能

<pre><code> 
var a = 1000 
var b = 1_000 
var c = 0x3E8
</code></pre> 

したがって、上記の変数はすべて同じ値を意味する

- サンプルコード 

<pre><code> 
var a = 1000 
var b = 1,000 
var c = 0x3E8 
print(a)
print (b)
print(c)
>> 1000 
>> 1000 
>>1000 
</code></pre>

### 型サフィックスについて



文字や数値の後ろに付けて意味を付与する仕組み

<pre><code> 
var a = 10L 
//Long 

var b = 10F 
//Float 

var b = 10f 
//Float 
</code></pre>

//サンプルコード

<pre><code> 
var a = 10L 
//Long! 

var b = 10f 
//Float

print (a::class)
>> class kotlin. lang  

print (b::class)
>> class kotlin. float 

</code></pre>


title:Kotlinの数値リテラルについて【Kotlin入門】

description:リテラル文字とは、ソースコードに書かれた具体的な値のこと。Kotlinの数値の扱い方について解説していきます。

category_script:True




