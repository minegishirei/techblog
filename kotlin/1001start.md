
## とりあえず試したい方へ

とりあえずブラウザ上で試す: インストールしなくてもこちらからブラウザ上で実行可能

https://play.kotlinlang.org/

※Kotlinの公式のドメイン配下にあるサイトなので安全にお試しできます


## Kotlinを動かすための開発環境

Android Studioが必要。




## 言語のビジュアルが見たい方へ

外見はこんな感じ

<pre><code>
//this is comment
fun main() {
    var agreement : String = "Hello, world!!!"
    println(agreement)
}
</code></pre>

どちらかというとPythonやPerlに近い






## 参考サイト

以下のURLを参考にしました。

参考URL：https://qiita.com/koher/items/bcc58c01c6ff2ece658f




## Kotlinの人気急上昇について

以下の記事より、「Kotlin on Android」が正式に決まった

https://blog.jetbrains.com/ja/2017/05/18/767/


    Google I/OのキーノートにてAndroidチームはKotlinの公式サポートを発表いたしました。
    これはKotlinにとって大きな一歩であり、Androidデベロッパにとって、そしてJetBrainsツールファンに
    とって素晴らしいニュースです。

これはつまるところ**Kotlinのバックにgoogleがついた**とほぼ同義です。



## Kotlinの特徴


- Javaとの完全互換性

まずはこれ

    Kotlin は JetBrains 社が作っている JVM 上で動作する言語で、 "100% interoperable with Jav
    (Java と完全に相互運用可能 )" を謳っています。


- Javaよりすごい

Javaの互換性を保ちながらもJavaよりすごい

    Kotlin は Better Java としてかゆいところに手が届くように作られており、一方で Java プログラマが抵抗
    感なくすんなりと受け入れられるようにできています


以下のコードを見てわかる通り、面倒で無駄な宣言がなくなりスッキリしている

***before(Java)***

<pre><code>
class HelloWorld {
	public static void main(String[] args) {
		System.out.println("Hello, world.");
	}
}
</code></pre>

***after(Kotlin)***

<pre><code>
//this is comment
fun main() {
    println("Hello, world!!!")
}
</code></pre>

- 複数のOSに対応

SwiftはiOSの事実上の基準となっている言語だが、Androidには対応していない

しかしKotlinは複数のOSに対応可能。

iOSでもAndroidでも同様に動く。



## Javaの有償化について

JavaはOracle社が開発したプログラミング言語であるため、Kotlinもその影響を受けるのではないか？という懸念があったが

https://teratail.com/questions/135222

    Android端末では、アプリはARTと呼ばれるGoogle独自のJVM上で動作しており、そもそもOracleの影響を受けません。

ということで問題なしとのこと。

















title:Kotlin学習サイト【概要編】

description:JavaはOracle社が開発したプログラミング言語であるため、Kotlinもその影響を受けるのではないか？という懸念があったが問題なしとのこと。

category_script:True



