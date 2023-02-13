
##  クラスの使い方(サンプル１)

まずは宣言のやり方

<pre><code>
class Car{
    # プロパティ
    [string] $people;
    [int] $location;

    Car([string] $poeple, [int] $location) {
        $this.people = $people
        $this.location = $location
    }

    # メソッド
    [void]rideoff(){
        $this.people = ""
    }

    [void]move(){
        $location = += 1
    }

    [string]whereami(){
        return $this.location;
    }
}
</code></pre>

基本的な使い方は上記の通り

classの後にクラス名を宣言して自作クラスの完成

あとは内部に変数名と関数を宣言して実態を作っていく。


##  自作クラスの使い方

<pre><code>
$car = Car("tanaka tarou", 10)
$car.move()
$car.move()
$car.move()
$car.rideoff()
$car.whereami()
</code></pre>

$を使って変数宣言

その後に通常の関数と同様にしてコンストラクタを呼び出し、インスタンスを作成する。


#### 参考記事

この記事は以下の書籍を参考に執筆されました。
詳しい内容の確認はこちらからお願いいたします。

<iframe sandbox="allow-popups allow-scripts allow-modals allow-forms allow-same-origin" style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=oreilly10book-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=4873113822&linkId=3998987cf4c97963a20e5ceb58e41198"></iframe>














title:すぐにわかる！クラスの使い方【powershell】


