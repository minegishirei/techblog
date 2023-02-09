


## Kotlinのnull

参照先を持たないことを意味する値→null 

オブジェクトが参照を持たないことを意味する事もある。

### Kotlinのオブジェクトの参照とは? 

値(オブジェクト)はコンピュータ上のメモリに格納されることで状態を保存できる。 
オブジェクトごとにメモリ上のアドレスが入っている状態。 

変数はメモリアドレスを参照しており、オブジェクトそのものが入っているわけではない。 

**そして変数にオブジェクトの参照が設定されていない状態をnullという。**

javaでは初期化をおこなわない限り、nullが初期値になっているが、これがエラーの元にもなる。

そこでデフォルトではnullを許容しない様にしている 

<pre><code> 
var foo: String = "foo" 
foo = null 
// Error

</code></pre> 

しかし、nullを許容したい場合も存在すると思う 

その場合は**型名の後に?を付けることでnullを許容できる**

<pre><code> 
var foo: String? = "foo" 
foo = null 

</code></pre>

このようにnullを許容している型を**Nullable型(ヌルアボー型)**という

### null取り扱い注意

nullについては意識的に取り扱わなければならない内容がある。

<pre><code> 
var a: Int = 1000 
var b: Int = a 
var c: Int?= a
println(a == b)     //true 
println( a === b)   //true 
println( a == c)    //true 
printin( a === c)   //false
</code></pre>


変数aを非null型のbとcにそれぞれ代入する。 

この時 

- 「同じ値を持つことを確認する==では常にtrueになる」

- 「同じオブジェクトを参照するかどうかを確認する===ではfalseになる」

この点は直感と反するので注意が必要。


### nullableを非null型に代入できない 

String?型データをStringに入れることはできない

<pre><code> 
var fool: String? = "foo" 
var foo2: String = fool 
//エラー 
</code></pre> 

これは**Any型も例外ではない。**

nullも許容したいAny型。その場合はAny?型を指定する。

### nullable型のメンバにアクセスする際には「?.」を使う 

String?の変数にアクセスする場合、「? メソッド」の形式

<pre><code> 
var a: String? = "foo"
println(a?.length)
var b: String? = null 
println (b?.length) 
//:null 
</code></pre>

また、nullableを非null型に強制的に変換する際には!!を使う

<pre><code>
var a:String? = "foo" 
println(a)
</code></pre>

### 備考

title:Kotlinのnullの取り扱いについて【Kotlin入門】

description:参照先を持たないことを意味する値→null。オブジェクトが参照を持たないことを意味する事もある。

category_script:True


