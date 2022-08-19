
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













title:すぐにわかる！クラスの使い方【powershell】


