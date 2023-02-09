


### ソフトウェアテストとは何か？


### ユニットテスト

メソッド単位のテスト

### 結合テスト

メソッドの組み合わせのテスト

### UIテスト

画面を動かしながら不具合の検知を行う。


### クラスやメソッドを対象とした最も小さいテスト：ユニットテスト

開発に不安が残らないようになる。

ユニットテストは実行できるプログラムであり、そのフレームワークがある。

今回はJUnitというフレームワークを使う（Javaのユニットテスト出もある）




### ユニットテストとは？


ソフトウェアテストの一つ

クラスやメソッドを対象としたテスト


ソフトウェアのふるまいを、条件を固定して検証する


開発者が意図したとおりにプログラムが動くのかを確認し、期待通りに動かない箇所を検知する。


品質の保守が目的



ソフトウェアの納品・リリース後に重大なバグが発生すると才アックのケースで損害賠償が発生する。



テストケースが多いほど信頼性が高くなり、バグの発見する確率が高くなる。

このことを、網羅性が高くなると言われる。


引数の足し算を行うメソッドを検証する。

- 1+2だけだと不安

- 1.0~9.0の9*9の81通りのテストを行う方がいい


しかし、全ての組み合わせを検証するのは現実的ではない。

「完璧なテストはできない」という前提を持ち、少しでも多くのバグを見つける（best effort）という気持ちで行う












tutorial.ktファイルが作成された後


package com.example.tutorial




<pre><code>
class Calculator {
    fun multiply(x: Int, y:Int): Int {
        return x*y
    }
    fun divide(x: Int, y:Int): Int {
        return x/y
    }
}
</code></pre>

これらのクラスをテストしていく

### テストクラスとテストメソッド

テスト対象のクラス


### テストの作り方


テストしたいクラスのクラス名にカーソルを合わせたうえで、「Ctrl+Shift+T」を押す

すると「Create New Test...」と出現する

クリックすると

Testling Library:JUnit

Class name Caluclatortest

...のプロパティが出現する

「メソッドに付随するチェックボックスは全てチェックする」


次にようなコードができれば完成

<pre><code>
class CalculatorTest {

    @Test
    fun multiply() {

    }

    @Test
    fun divide() {

    }
}
</code></pre>

### コードの説明

@Testと書かれているのは「アノテーション」と呼ばれる者である。

このアノテーションが書かれているものが「テストメソッド」と認識される。

### ソフトウェアテストでは期待通りの振る舞いをするかどうかを検証

期待値と実測値を比較するのが良い。

このような値の比較検証を**アサーション**という

JUnitでアサーションを行うには**アサーションライブラリ**を用いるのが便利

今回は直感的で自然言語に近い記述ができる「AssertJ」を使う


1. Gradle Scriptsの「build.gradle(app)」を開き、以下のように追記する

<pre><code>
dependencies {
    ...
    testImplementation 'junit:junit:4.12'
    testImplementation 'org.assetj:assertj-ccore:3.10.0' (追加部分)
    ...
}
</code></pre>

2. import部分に次の記述を追加

<pre><code>
...
import org.assertj.core.api.Assertions.*
...

class CalculatorTest {

    @Test
    fun multiply() {

    }

    @Test
    fun divide() {

    }
}
</code></pre>

3. import部分のassertJが赤いので、上のタブの方に注意書きが出るので「Sync Now」をクリック

4. assertJが青くなれば完了



### テストコードの注意点

主な手順は以下の二つ

1. 実測値と期待値を用意しておく

2. それらを比較する


これらを用意していきたいが、JUnit4はいくつかルールがある。

1. テストクラスはpublicクラス

2. テストメソッドはorgjunit.Testアノテーションを付与したpublicメソッド

3. 戻り値を持たないこと

以下はダメな例

<pre><code>
...
import org.assertj.core.api.Assertions.*
...

private class CalculatorTest { //privateはアウト

    @Test
    private fun multiply() { //privateはアウト

    }

    @Test
    fun divide(set) { //引数はだめ

        return "true" //戻り値もダメ
    }
}
</code></pre>


### テストメソッドを書いていく

1. メソッド名は日本語でも一応問題はない

<pre><code>
...
import org.assertj.core.api.Assertions.*
...

class CalculatorTest {

    @Test
    fun multiplyで掛け算の結果が取得できる() {

    }

    @Test
    fun divide() {

    }
}
</code></pre>


2. 具体的な処理はassertionで比較

実測値と予測値が等しいという自然言語に近い記述

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
        val expected = 6
        // 実測値と予測値が等しいという自然言語に近い記述
        asserThat(actual).isEauelTo(expected)
    }

    @Test
    fun divide() {

    }
}
</code></pre>

ポイント

- sutはテスト対象オブジェクトという意味

よく使われる変数名なので覚えておいて損はない

- 実測値と予測値が等しいという自然言語に近い記述

actualとexpectedも良く使われるので覚えておく


### 実行

SHIFT+F10でテストケースの実行

実行後、新たにウィンドウが出現し実行結果が表示される。

色は緑でありこれを「グリーンバー」と呼ばれる


### テストが間違えたとき


expectedを3に変更して見る

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
    fun divide() {

    }
}
</code></pre>

このように実行すると「expectedは3だが、actualは5である」と表記される

色は赤になり「レッドバー」と呼ばれる


### divideメソッドについてもやってみる



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
    fun divide() {
        val sut = Calculator()
        val actual = sut.divide(6,2)
        val expected - 3
        assetThat(actual).isEqualTo(expected)
    }
}
</code></pre>



### テストケースで想定される失敗

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

これは失敗する

「期待値は1.5になっているが、1になっているのがポイント」

普段からプログラミングをやっていれば「Intで型定義されている」と判断できる。

Kotlinでは整数/整数は整数となっているため、どちらかを少数型（Double型）に替えなければならない。



### テスト中に例外が発生した場合

コードを以下のように変換する

<pre><code>
class Calculator {
    fun multiply(x: Int, y:Int): Int {
        return x*y
    }
    fun divide(x: Int, y:Int): Int {
        if ( y == 0) throw IllegalArgmentException("divide by zero.")
        return x/y
    }
}
</code></pre>

このようにすることで、yに0が入ったときでも意図的にエラーを発生させることができる。

以下のテストは「3を0で割っているため」ZeroDivizionErroが発生する

<pre><code>
...
import org.assertj.core.api.Assertions.*
...

class CalculatorTest {

    @Test
    fun divideで3を0で割った場合() {
        val sut = Calculator()
        val actual = sut.divide(3,0)
        val expected = 1.5
        assetThat(actual).isEqualTo(expected)
    }
}
</code></pre>

テスト側も、実測値と期待値の比較では検証することができない。
（そもそもassetThatの行までたどり着かない。）

このテストを次のように変換する

<pre><code>
...
import org.assertj.core.api.Assertions.*
...

class CalculatorTest {

    @Test(expected = IllegalArgumentException: class)
    fun divideで3を0で割った場合() {
        val sut = Calculator()
        val actual = sut.divide(3,0)
    }
}
</code></pre>

Testアノテーションのexpectedはエラーが発生する例外クラスを入れて検知できる。




### テストコードがテスト設計に及ぼすメリット

ここまでの対応で

テスト設計の品質が上がったことをが大事。

プログラムレベルでテストコードを記述することで「割り算ができる」という抽象的な仕様ではなく

「3を2で割ったら1.5を返す」
「0っで割られたらIllegalargumentExceptionを送る」

という**曖昧さのない具体的な仕様**を定めることができる。


### ユニットテストとJUnitの基本

ユニットテストはなぜ行う必要があるのか？

1. 曖昧さのない正確な仕様書として機能するため

具体的なテストケースを通すプロダクトコードを書く必要があるので、
ユニットテストのテストケース自体が曖昧さのない仕様書として機能する

2. 進捗のフィードバックとして機能する

テストを実行しながら並行で開発をするめることで、開発の不安が少なくなる。

<br>

結果として**ソフトウェアの品質が向上する**







### 備考

title:KotlinとJUnitでテストコードを書いてみる

description:開発に不安が残らないようになる。ユニットテストは実行できるプログラムであり、そのフレームワークがある。今回はJUnitというフレームワークを使う（Javaのユニットテスト出もある）

img:https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmucaKbgWgJTHfHMMdUFAziBpyeB-GNVTnrQrRHJ46re_871oNfxeUkcxdp5RNQaalwc8&usqp=CAU

category_script:True


