

## アサーション

実測値と期待値を比較検証するプロセスのこと

ユニットテスト、ひいてはソフトウェアテストにおいて最も重要な概念。

JUnitではAssertJのようなアサーションライブラリを用いることで、
自然言語に近い直感的な記述が可能になる

ここではAssertJの基本的な使い方について扱う


## 文字列のアサーション

"KOTLIN"という文字列を様々な条件で比較検証してみる

<pre><code>
assertThat("KOTLIN")
    .`as`("KOTLINの文字列チェック")
    .isEqualTo("KOTLIN")
    .isEqualToIgnoreingCase("kotlin")
    .isNotEqualTo("KOLTIN")
    .startsWith("KO")
    .endsWith("IN")
    .contains("TL")
    .isInstanceOf(String:class.java)
</code></pre>


## アサーションにラベルを付ける.`as`(...)

<pre><code>
assertThat("KOTLIN")
    .`as`("KOTLINの文字列チェック")
</code></pre>

アサーションにラベルを付けると、テストが失敗した時にここで定義したラベル名が表示されるので、
どのアサーションが失敗したのか分かりやすくなる。

AssertJの「as」であることを示すために、`as`と表記する

## JUnitの.isEqualToIgnoreingCase("kotlin")

JUnitで大文字小文字を無視する

<pre><code>
assertThat("KOTLIN")
    .isEqualToIgnoreingCase("kotlin")
</code></pre>

## JUnitの.isNotEqualTo("KOLTIN")

JUnitで等しくない事を示す。

<pre><code>
assertThat("KOTLIN")
    .isNotEqualTo("KOLTIN")
</code></pre>


## JUnitの.startsWith("KO") / .endsWith("IN")

特定の文字列からスタート/終了するか検証する

<pre><code>
assertThat("KOTLIN")
    .startsWith("KO")
</code></pre>


## JUnitの.contains("TL")

特定の文字列が含まれるか検証する

<pre><code>
assertThat("KOTLIN")
    .contains("TL")
</code></pre>


## JUnitの .isInstanceOf(String:class.java)

文字列型であるかどうかを検証する

<pre><code>
assertThat("KOTLIN")
    .isInstanceOf(String:class.java)
</code></pre>



## String型のJUnitのポイント

1. 次のように、メソッドはチェインすることができる

一個失敗したらその後のアサーションは全て実行されない。

<pre><code>
assertThat("KOTLIN")
    .`as`("KOTLINの文字列チェック")
    .isEqualTo("KOTLIN")
    .isEqualToIgnoreingCase("kotlin")
    .isNotEqualTo("KOLTIN")
    .startsWith("KO")
    .endsWith("IN")
    .contains("TL")
    .isInstanceOf(String:class.java)
</code></pre>

2. メソッドチェーンでエラーで躓いてほしくないときは

SoftAssertionsを用いて以下のように書く

<pre><code>
SoftAssertions().apply{
    assertThat("KOTLIN")
        .`as`("KOTLINの文字列チェック")
        .isEqualTo("KOTLIN")
        .isEqualToIgnoreingCase("kotlin")
        .isNotEqualTo("KOLTIN")
        .startsWith("KO")
        .endsWith("IN")
        .contains("TL")
        .isInstanceOf(String:class.java)
}.assertAll()
</code></pre>



## 備考

title:JUnitの文字列のアサーション

description:実測値と期待値を比較検証するプロセスのこと。ユニットテスト、ひいてはソフトウェアテストにおいて最も重要な概念。UnitではAssertJのようなアサーションライブラリを用いることで、自然言語に近い直感的な記述が可能になる


img:https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmucaKbgWgJTHfHMMdUFAziBpyeB-GNVTnrQrRHJ46re_871oNfxeUkcxdp5RNQaalwc8&usqp=CAU

category_script:True






