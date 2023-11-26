


## 最近の(個人で考えている)jsのデザインパターン

## 注意

この記事は「Javascriptのフロント側のデザインパターン」をいくら調べても出てこなかったので、
これまでの開発経験に基づいた偏見から構成されています。

完全オリジナル故、誤りがあることをお許しください。


## やるべきこと

1. データをAPIリクエストで取得する：API層

2. データを適切な形に変形する：Data層

3. データを「4.」に渡す：Control層

4. htmlにデータを当てはめる：DOM層

(5. テスト層)


## 構造


### DOM層(View層)

htmlに対してデータを当てはめる層

function or classに対して値を入れることでそれがhtmlに反映される

DOM操作を担当する。

注意点は、ここで特定のデータならでわの操作（json形式のネストを指定するような行為のこと）を行ってはいけない。

表示の枠だけを掌り、データの種類に縛られてはいけない。

「4. htmlにデータを当てはめる」を担当する

リファクタリングの際は、ここから進めると良い

- 「ViewFactory」：データ形式を指定して生産する工場。「View」という雛形を出してくれる。

- 「View」：データのテンプレートのこと。「View」に対して値をセットしてbuildすることで表示が切り替わる。

この「View」自体は抽象クラスであり、それぞれのhtmlパーツが必要なデータに応じてViewへ与える引数も異なる。

<pre><code>

class ViewFactory{
    constructor(){
        this.ViewList = {
            "imageview" : ImageView,
            "imageListView" : ImageListView
        }
    }

    getView(id){
        
    }
}

class View {

}

class ImageListView extends View{

}

</code></pre>



### Control層

1. Data層からデータを取得。

2. テンプレート工場（ViewFactory)から雛形（Viewとその継承クラス）を取得し、

3. 雛形に当てはめる作業を行う。

<pre><code>
class Control {
    next(var: control){
        this.next = contorl
        return control
    }
}

basicControl = new BasicControl()
basicControl.next(new MlaskControl)
class BasicControl extends Control{
    start() {
        this.callAPI()                  //call api
    }
    
    //API用にカスタマイズされたリクエスト。
    callAPI {
        startMainAPI(this, url)
    }

    recieveAPI(json) {
        mlaskControl = MlaskControl()   //mlaskprocess
        mlaskControl.start(json.review_data.rows)
        //mainnext
        //mlaskContorlが実行している間でも、すでにデータの加工を始める

        viewFactory = new ViewFactory()

        var dataSingleValue = new DataSingleValue(json)
        var view = viewFactory.getView("singleNumber")
        view.attach(dataSingleView)
        view.display()
        
        var dataGraph       = new DataGraphValue(json)
        var view = new viewFactory.getView("table")
        view.attach(dataGraph)
        view.display()
    }
}


class MlaskControl extends Control {
    start(rows) {
        this.callAPI()
    }

    //API用にカスタマイズされたリクエスト。
    callAPI {
        startMainAPI(this, url)
    }
    recieveAPI {
        // データを貯めて貯めて
        // 最終的にData層に渡す
    }
}
</code></pre>



### Data層

データの変形を担当する。

与えられるデータによって動きを変えても良いが、

最終的に出力するデータは「View層にとって都合の良い形」に変形しなければならない。

- getAverage関数

- getKeyArray関数

- getValue関数

<pre><code>

</code></pre>



### API層

API層ではデータをフェッチし、与えられたJsonファイルを
Control層に返すことで結果を呼び出す。

APIを重複で呼び出す場合は、Controlの数自体が増える。

<pre><code>


function startMainAPI(クラス名){
    fetch(url)
        .then(クラス名.recieveAPI)
}


</code></pre>


title:最近のフロントエンド側のJavascriptデザインパターン

description:この記事は「Javascriptのフロント側のデザインパターン」をいくら調べても出てこなかったので、これまでの開発経験に基づいた偏見から構成されています。

category_script:True






