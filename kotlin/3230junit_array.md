




## よく使うJUnitの配列のアサーション


<pre><code>
val sut = arrayOf("red", "green", "blue")
assertThat(sut).hasSize(3)
    .contains("green")
    .containsOnly("blue", "red", "green")
    .containsExactly("red", "green", "blue")
    .doesNotContains("yellow")
</code></pre>


### JUnitのhasSize(3)

サイズが合っているかを確認する

<pre><code>
val sut = arrayOf("red", "green", "blue")
assertThat(sut)
    .hasSize(3)
</code></pre>


### JUnitの.contains("green")

文字列が含まれているかどうかを確認する

<pre><code>
val sut = arrayOf("red", "green", "blue")
assertThat(sut)
    .contains("green")
</code></pre>


### JUnitの.containsOnly("blue", "red", "green")

同じ要素が含まれているか確認する。

順番は問わない

<pre><code>
val sut = arrayOf("red", "green", "blue")
assertThat(sut)
    .containsOnly("blue", "red", "green")
</code></pre>



### JUnitの.containsExactly("blue", "red", "green")

配列の要素が完全一致することを検証する。

順番まで一致しなければならない

<pre><code>
val sut = arrayOf("red", "green", "blue")
assertThat(sut)
    .containsExactly("red", "green", "blue")
</code></pre>


### JUnitの.doesNotContains

文字列が含まれるかどうかを確認する

<pre><code>
val sut = arrayOf("red", "green", "blue")
assertThat(sut)
    .doesNotContains("yellow")
</code></pre>








### 備考

title:JUnitの文字列のアサーション

description:実測値と期待値を比較検証するプロセスのこと。ユニットテスト、ひいてはソフトウェアテストにおいて最も重要な概念。UnitではAssertJのようなアサーションライブラリを用いることで、自然言語に近い直感的な記述が可能になる


img:https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmucaKbgWgJTHfHMMdUFAziBpyeB-GNVTnrQrRHJ46re_871oNfxeUkcxdp5RNQaalwc8&usqp=CAU

category_script:True





