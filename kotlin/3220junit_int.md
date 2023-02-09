


## 数値のアサーション

文字列とほとんど同様に、分かりやすいメソッドが用意されている


<pre><code>
assertThat(3.1415)
    .isNotZero()
    .isNotNegative()
    .isLessThan(4)
    .isGreaterThanorEqualto(3)
    .isbetween(3.0, 3.2)
</code></pre>

### JUnitの.isNotZero()

0ではない事を検証する

<pre><code>
assertThat(3.1415)
    .isNotZero()
</code></pre>




### JUnitの.isNotNegative()

マイナスの値ではないことを証明する


<pre><code>
assertThat(3.1415)
    .isNotZero()
</code></pre>



### JUnitの.isLessThan()

ある特定の値より小さいことを証明する

<pre><code>
assertThat(3.1415)
    .isLessThan(5)
</code></pre>



### JUnitの.isGreaterThanorEqualto()

ある値より大きいか等しいかを検証する

<pre><code>
assertThat(3.1415)
    .isGreaterThanorEqualto(2)
</code></pre>



### 備考

title:JUnitの文字列のアサーション

description:実測値と期待値を比較検証するプロセスのこと。ユニットテスト、ひいてはソフトウェアテストにおいて最も重要な概念。UnitではAssertJのようなアサーションライブラリを用いることで、自然言語に近い直感的な記述が可能になる


img:https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmucaKbgWgJTHfHMMdUFAziBpyeB-GNVTnrQrRHJ46re_871oNfxeUkcxdp5RNQaalwc8&usqp=CAU

category_script:True





