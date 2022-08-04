


## JUnitのアノテーションの種類

JUnitoには@Testアノテーションを付与するが、そのほかのアノテーションも存在する


## @Ignoreアノテーション

あるテストを実行対象外としたいときのアノテーション

Ignoreアノテーションが付いたテストメソッド/クラスは実行されなくなる

以下のように、Testアノテーションの上にかぶせる形で付与する

<pre><code>
@Ignore
@Test
fun 一時的に無視するテスト
</code></pre>



## @Beforeアノテーション

**共通の初期化処理は、Beforeアノテーションを付与したメソッドにまとめることができる。**
戻り値と引数を持たないpublicメソッドが必要であり、setUpというメソッド名がよく使われる。

例えば、以下のテストでは、Calculatorクラスをインスタンス化する処理が全てのテストに入っている


<pre><code>
...
import org.assertj.core.api.Assertions.*
...

class CalculatorTest {

    @Test
    fun multiplyで掛け算の結果が取得できる() {
        // sutはテスト対象オブジェクトという意味
        // よく使われる変数名なので覚えておいて損はない
        val sut = Calculator()
        val actual = sut.multiply(x:2, y:3)
        val expected = 3
        // 実測値と予測値が等しいという自然言語に近い記述
        asserThat(actual).isEauelTo(expected)
    }

    @Test
    fun dividewoで3を2で割った結果を取得できる() {
        val sut = Calculator()
        val actual = sut.divide(6,2)
        val expected - 3
        assetThat(actual).isEqualTo(expected)
    }

    @Test
    fun divide() {
        val sut = Calculator()
        val actual = sut.divide(3,2)
        val expected = 1.5
        assetThat(actual).isEqualTo(expected)
    }
}
</code></pre>


これをBeforeアノテーションを使って初期化しようとすれば以下のようになる。
setUpの中でインスタンス化したので、他のメソッドでインスタンス化する必要はなくなる。

<pre><code>
...
import org.assertj.core.api.Assertions.*
...

class CalculatorTest {
    lateinit var sui: Calculator

    @Before
    fun setUp () {
        sut = Calculator()
    }

    @Test
    fun multiplyで掛け算の結果が取得できる() {
        val actual = sut.multiply(x:2, y:3)
        val expected = 3
        asserThat(actual).isEauelTo(expected)
    }

    @Test
    fun dividewoで3を2で割った結果を取得できる() {
        val actual = sut.divide(6,2)
        val expected = 3
        assetThat(actual).isEqualTo(expected)
    }

    @Test
    fun divide() {
        val actual = sut.divide(3,2)
        val expected = 1.5
        assetThat(actual).isEqualTo(expected)
    }
}
</code></pre>


## @Afterアノテーション

共通の後処理があるなら、Afterアノテーションにまとめることができる。
Beforeアノテーションの時と同様、引数を持たないpublicメソッドであり、tearDownが使われる。

<pre><code>
@After
tearDown (){}
</code></pre>




## 備考

title:JUnitでよく使うアノテーションの種類

description:@Beforeアノテーションは、共通の初期化処理は、Beforeアノテーションを付与したメソッドにまとめることができる。戻り値と引数を持たないpublicメソッドが必要であり、setUpというメソッド名がよく使われる。

img:https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmucaKbgWgJTHfHMMdUFAziBpyeB-GNVTnrQrRHJ46re_871oNfxeUkcxdp5RNQaalwc8&usqp=CAU

category_script:True





