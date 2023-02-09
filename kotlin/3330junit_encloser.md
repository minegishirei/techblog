



## テストランナーのメリット

1. テストの実行に時間がかかりすぎる問題

ユニットテストは繰り返し実行するため、一回当たりの時間がかかるのは全体の進捗に関わる。


2. テストコードがごちゃごちゃになり、可読性を損なう問題

テストコードも管理が必要。

読みづらさは管理しずらさに直結し、管理されていないテストになる。

**テストの実行を制御する仕組みが必要。→テストランナー**

テストをどのように実行するか？をコントロールする。


### Suiteテストランナーで複数のクラスをまとめて実行する

Suiteテストランナーを使って指定した複数のクラスをまとめて実行する

基本的にテストの実行はテストメソッドやテストクラス単位だが、以下のように書くとFooTestとBarTestをまとめて実行できる

<pre><code>
@RunWith(Suite::class)
@Suite.SuiteClasses(fooTest::class, BarTest::class)
class AllTest{}
</code></pre>


### Junit4を使ったテストランナー

<pre><code>
@RunWith(JUnit4::class)
class Example {
    @Test
    fun example1() {}
}
</code></pre>

JUnit4テストランナーはデフォルトで設定されているテストランナー

設定されたクラス内で次の条件を満たすメソッドをテストケースとして実行する

- publicメソッド
- org.junit.testアノテーションが付与されている
- 戻り値と引数を持たない

Suiteテスト




### テストランナーには実行の制御方法に応じていくつか種類がある

1. テストコードの実行に時間がかかる（スローテスト問題）

2. テストコードが御茶ついてしまう


共通部分をまとめるテストランナーが必要。

これを実現するのが**Enclosedテストランナー**


### Enclosedテストランナー

テストケースを構造化して共通部分をまとめるなど、
テストケースを整理するのが、テストランナーEnclosed

> テストケースの整理方法として@Beforeアノテーションがあった


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

テストの実行・成功に必要なデータなどの前提条件を **フィクスチャ（コンテキスト）**という

フィクスチャを用意することをセットアップと呼び、**テストメソッドごとにフィクスチャをセットアップするやり方をインラインセットアップ**と呼ぶ

シンプルなフィクスチャであればインラインセットアップで良い。

@Beforeアノテーションがついたセットアップメソッドによってフィクスチャのセットアップを行うメソッドをセットアップメソッドという




### コンストラクタで初期化する場合のJUnitの場合


たとえば次のクラスはコンストラクタで初期値を使っている。

<pre><code>
class Calculator(val n: Int = 1 ){
    fun multiply(x: Int, y:Int): Int {
        return n*x*y;
    }
}

</code></pre>


このように、**コンストラクタに初期値が入っている場合、コンストラクタが共通部分に入らないのでスッキリしない、冗長なコードになってしまう。**

だが、コンストラクタの初期値が

- 1の場合と

- 2の場合で

テストしたい場合、
共通部分として作るのが難しくなる。



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


このような場合にセットアップの共通処理をまとめつつ、多様性を保つことができる上手にまとめることができる仕組みを**Enclosed**と呼ぶ



<pre><code>
...
import org.assertj.core.api.Assertions.*
...

@RunWith(Enclosed::class)
class CalculatorTest {
    class 初期値が1 {
        lateinit var sut: Calculator

        @Before
        fun setUp(){
            sut = Calculator(1)
        }

        @Test
        fun multiplyで掛け算の結果が取得できる() {
            val actual = sut.multiply(x:2, y:3)
            val expected = 3
            asserThat(actual).isEauelTo(expected)
        }

        @Test
        fun multiplyで掛け算の結果が取得できる() {
            val actual = sut.multiply(x:2, y:3)
            val expected = 3
            asserThat(actual).isEauelTo(expected)
        }
    }

    class 初期値が2 {
        lateinit var sut: Calculator

        @Before
        fun setUp(){
            sut = Calculator(2)
        }

        @Test
        fun multiplyで掛け算の結果が取得できる() {
            val actual = sut.multiply(x:2, y:3)
            val expected = 6
            asserThat(actual).isEauelTo(expected)
        }

        @Test
        fun multiplyで掛け算の結果が取得できる() {
            val actual = sut.multiply(x:2, y:3)
            val expected = 6
            asserThat(actual).isEauelTo(expected)
        }
    }

}
</code></pre>

ポイントは

- クラスをネストする形式で多様性を保つことができるということ

- そのためには@RunWith(Enclosed::class)をつかうことで実装できること

これらのポイントを抑えることで、構造化されたテストの作成とその管理が可能になる。


ちなみのこれを実行した後は、ファイルシステムの構造化された形式のようにスッキリとしたまとまりになる。



### Enclosed まとめ

通常、テストクラス内にあるメソッドをテストメソッドとして認識するが、
Enclosedテストランナーを使うと、 **ネストされたクラス内のメソッドをテストメソッドとして認識する**ようになる。

ネストクラスと同じ深さに定義されたメソッドは、テストメソッドとして認識されなくなる事に注意。

テストメソッドをファイル、クラスをフォルダと考えると理解しやすい

ポイントは**どのように、どこの軸でまとめたか**が分かるような名前にすること




### 備考

img:https://devlog.arksystems.co.jp/wp-content/uploads/2017/12/junit5.png


title:EnclosedテストランナーをKotlinから使う【JUnit入門】

description:通常、テストクラス内にあるメソッドをテストメソッドとして認識するが、 Enclosedテストランナーを使うと、 ネストされたクラス内のメソッドをテストメソッドとして認識するようになる。ネストクラスと同じ深さに定義されたメソッドは、テストメソッドとして認識されなくなる事に注意。





