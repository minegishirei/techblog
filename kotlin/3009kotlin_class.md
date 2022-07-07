




## クラスの基本 

Kotlinでクラスを定義するには以下のように書く

<pre><code> 
class Human {
    private var name = "名無し” 
    var age = 20
    fun intro() {
        println("私の名前h$ {name} です。${age} 歳です。")
    }
}
</code></pre>

アクセス修飾子を利用することもできる。 

アクセス修飾子とは、変数やメソッドのスコープを定義する機能 例) 

<pre><code> 

class Human {
    private var name = "名無し” 
    var age = 20
    protected fun intro() {
        println("私の名前h$ {name}です。${age}歳です。")
    }
}
</code></pre>



## 基本的なアクセス修飾子 

- public:全てのクラスからアクセス可能 

- protected:定義されたクラスとそのサブクラスからのみアクセス可能 

- internal:同じpモジュール内のクラスからのみアクセス可能

モジュールとは



Kotlinのファイルが一体としてコンパイルされるまとまりのこと 

Eclipseやandroid studioなどでのプロジェクト単位のまとまりのこと


## Javaコードが実行されるまでの流れ 

1. 複数のJavaファイルがまとめてコンパイルされて、クラスファイルになる 

2. Java virtual Machine(JVM) がクラスファイルに記載されたコードを解釈・実行 

3. ここで、クラスファイルはソースコードを実行する過程で生成される中間コードであり、OSに依存しない。

クラスファイルはJVMに読み込まれるので、OSごとの依存が存在しない。また、JVMで動くコードはJava以外にもあり、KotlinもJVMのひとつ。

## プロパティ (フィールド) 

Kotlinではフィールドではなく、プロパティという機能が存在する。(正直どっちも同）

フィールドとは異なり、プロパティはただ単にクラスが持つ変数ではなく、それ自体がアクセサーを持つ。

getter, setterの関数でプロパティを設定する。

<pre><code> 
var プロパティ名:データ型 - 初期値
getter関数
setter関数 
</code></pre>


## Kotlinのプロパティのサンプルコード(定義部分) 

fieldはset内の特別な変数名で値の代入を受けたときに実行される。

<pre><code> 
class Human {
    var name = "名無し” 
    var age = 20 
        set (value) { 
            if(value < 0)) {
                println("年齢が不正です。") 
            }else{
                filed = value
            }
        }
    protected fun intro() {
        println("私の名前h${name}です。${age} 歳です。")
    }
}
</code></pre> 

以下使用部分。 

setメソッドは代入時に自動的に呼び出される。 

<pre><code> 
val human = Human () 
human.intro() 
//私の名前は名無しです。20際です。 
//以下setメソッド起動時の処理 
human.age = -1 
///年齢が不正です。
printIn(human.name) 
//結果:名無し 
</code></pre>


## 注意点

- アクセサーの引数は慣習的にはvalueを用いる。

- filedはバッキングフィールドと呼ばれる。プロパティの値を格納するために裏側で自動生成されるフィールド
 
- valを使ってプロパティを宣言すると、**読み取り専用のプロパティになる 

- setterを使用することはできず、getterは可能


title:Kotlinのクラスの書き方【Kotlin学習サイト】


description:public:全てのクラスからアクセス可能 - protected:定義されたクラスとそのサブクラスからのみアクセス可能 - internal:同じpモジュール内のクラスからのみアクセス可能

category_script:True


