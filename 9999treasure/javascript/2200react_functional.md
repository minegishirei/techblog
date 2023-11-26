




## 参考文献

https://media.graphassets.com/IUzPTEZhTNeVopsd6Xo1?dl=true?dl=true

<img src="https://images-na.ssl-images-amazon.com/images/I/7169mYAhsmL.jpg">





## JavaScript による関数型プログラミング

 **React プログラミングの世界を探索し始めると、関数型プログラミングの話題がよく出てきます。**

関数型プログラミングはJavaScript プロジェクトでますます使用されます。

何も考えずに、すでに機能する JavaScript コードを書けるかもしれませんが、もし関数型プログラミングが分からない方は次の事を考えてみてください

> もしも配列をマッピングまたは配列そのものを削除した場合は、すでに関数型プログラマーになりつつあるのです。 

React、Flux、および Redux はすべて関数型 JavaScript 内に収まりまりますので、関数型プログラミングの基本概念を理解することでReactアプリケーションの構築レベルが上がります。


## 関数型プログラミングとは何か？


JavaScriptは民主主義的なプログラミングであるため、JavaScript は関数型プログラミングをサポートします。

関数型プログラミングをサポートするとは、平たくいうと次のことと同義です。

> 関数が変数と同じことを実行できることを意味します。


## 関数を変数に入れる

```js
var log = function(message) {
 console.log(message)
};
log("In JavaScript functions are variables")

```

ES6verJavascriptでは、関数型プログラミングを強化できる言語の改善を追加しました。

アロー関数、promise、スプレッド演算子などのテクニックなどがこれに当たります。

JavaScript では、関数はアプリケーション内のデータを表すことができます。

ちなみに、宣言と同じ方法で var キーワードを使用して関数を宣言できること

```js
const log = message => console.log(message)
```

これらのステートメントはどちらも同じことを行います。

つまり、**関数を変数に格納します。**


## 関数を配列に入れる

JavaScript で配列に関数を追加することもできます。

```js
const messages = [
    "They can be inserted into arrays",
    message => console.log(message),
    "like variables",
    message => console.log(message)
]
messages[1](messages[0]) // They can be inserte
```

同じメッセージ内部の関数を、メッセージ内部の変数を引数にとって関数を実行することができました。





## 高階関数

javascriptでは変数と同様に、他の関数を返すこともできます。

次の関数では、insideFnの関数の引数に、関数を取っています。

```js
const insideFn = logger => logger("They can be sent to other functions as arguments");
insideFn(message => console.log(message)) 

```


高階関数を実装で使う場合、2度に分けて実装するイメージになります

```js
// 1回目
var createScream = function(logger) {
    return function(message) {
        logger(message.toUpperCase() + "!!!")
    }
}
// 2回目
const scream = createScream(message => console.log(message))
scream('functions can be returned from other functions')
// FUNCTIONS CAN BE RETURNED FROM OTHER FUNCTIONS!!!
scream('createScream returns a function')
// CREATESCREAM RETURNS A FUNCTION!!!
scream('scream invokes that returned function')
// SCREAM INVOKES THAT RETURNED FUNCTION!!!

```

最後の 2 つの例は高階関数、つまり、他の関数を返えす関数でした。


ちなみに

ES6 構文を使用すると、一行でcreateScream を記述できます。


ここから先は矢の本数に注意が必要です。複数の矢印は、高階関数があることを意味します。

```js
const createScream = logger => message => logger(message.toUpperCase() + "!!!")

```

関数がファーストクラスであるため、JavaScript は関数型言語であると言えます。

つまり、関数はデータです。

それらは、保存、取得、またはフローすることができます。

変数のようにアプリケーションを介して。






## 命令型と宣言型

関数型プログラミングは、より大きなプログラミングパラダイムの一部です。

宣言型プログラミングは、アプリケーションが何が起こるかを定義することよりも**記述することを優先する方法で構造化されているプログラミング**と言えます。

宣言型プログラミングを理解するために、命令型プログラミングと対比しましょう。

プログラミング、または達成方法のみに関係するプログラミングのスタイルをコードで見てみましょう。

一般的なタスクを考えてみましょう: 

    文字列を URL フレンドリーにすることです。
    これは、文字列内のすべてのスペースをハイフンに置き換えるという意味です。
    （スペースは URL フレンドリーではないためです。）

## 命令型アプローチ


まず、これに対する命令型アプローチを調べてみましょう


```js
var string = "This is the midday show with Cheryl Waters";
var urlFriendly = "";
for (var i=0; i＜string.length; i++) {
    if (string[i] === " ") {
        urlFriendly += "-";
    } else {
        urlFriendly += string[i];
    }
}
console.log(urlFriendly);

```



この例では、文字列内のすべての文字をループし、スペースを置き換えます。

for ループと if ステートメントを使用し、等値で値を設定します。

**命令型プログラムでは何が起こっているのかを理解するには、多くのコメントが必要です。**


## 宣言型アプローチ

次に、同じ問題に対する宣言型アプローチを見てみましょう。

```js
const string = "This is the mid day show with Cheryl Waters"
const urlFriendly = string.replace(/ /g, "-")
console.log(urlFriendly)
```

ここでは、正規表現とともに string.replace を使用して、すべてを置き換えています。

ここで注目するべきポイントは、**処理されるスペースは、replace 関数内で抽象化されます。**

宣言型でのプログラム構文自体は、何が起こるべきか、そして物事がどのように行われるかの詳細を記述します。

ですが、実際に起こることは抽象化されているのです。


## 宣言型アプローチ2

宣言型プログラムは、コード自体が何を記述しているかを説明するため、何が起こっているか簡単に推論できます。

たとえば、次のサンプルの構文を読んでください。

    このコードではメンバーが API からロードされた後に発生する一連の処理をcomposeしています。

```js
const loadAndMapMembers = compose(
    combineWith(sessionStorage, "members"),
    save(sessionStorage, "members"),
    scopeMembers(window),
    logMemberInfoToConsole,
    logFieldsToConsole("name.first"),
    countMembersBy("location.state"),
    prepStatesForMapping,
    save(sessionStorage, "map"),
    renderUSMap
);
getFakeMembers(100).then(loadAndMapMembers);
```

**宣言型のアプローチはより読みやすいため、推論が容易になります。そして、これらの各機能の実装方法の詳細は抽象化されています。**

関数は適切に命名され、メンバーデータがどのように記述されるかを説明する方法で結合されます。

読み込まれてから保存され、マップに印刷されます。

このアプローチには多くのコメントは必要ありません。

基本的に、宣言型プログラミングはアプリケーションを生成するまでの仮定を記述しているのです。

**アプリケーションについて推論しやすい場合、およびアプリケーションについて推論しやすい場合、そのアプリケーションは拡張が容易です.**









## 命令型アプローチでDOMを書いた場合

ここで、ドキュメント/オブジェクト/モデル (DOM) を構築するタスクについて考えてみましょう。(つまりhtmlを動的に構築する方法)

命令型アプローチは、DOM の構築方法に直接的に関係します。

```javascript
var target = document.getElementById('target');
var wrapper = document.createElement('div');
var headline = document.createElement('h1');
wrapper.id = "welcome";
headline.innerText = "Hello World";
wrapper.appendChild(headline);
target.appendChild(wrapper);
```

このコードは、要素の作成、要素の設定、および要素への追加を記述しています。

DOM が命令的に構築されるコード行において、
ドキュメントに対して変更を加えたり、機能を追加したり、スケーリングしたりするのは非常に困難です。


## サンプルコード

それでは、React を使用して宣言的に DOM を構築する方法を見てみましょう。



```JSX
const { render } = ReactDOM

const Welcome = () => (
    <div id="welcome">
        <h1>Hello World</h1>
    </div>
)

render(
    <Welcome />,
    document.getElementById('target')
)
```

**React は宣言型です。**

ここで、Welcomeコンポーネントは、あるべき DOM を記述します。

render 関数は、コンポーネントで宣言された命令を使用して、DOMを構築し、レンダリングします。

私達はWelcome コンポーネントをtarget要素にレンダリングしたいことがはっきりとわかります。






## 関数型言語の特徴

ここまで、関数型プログラミングとその意味を紹介しました。

「機能的」または「宣言的」であるため、コアコンセプトの導入に強みを持っています。

関数型プログラミングのキーワードでは、 不変性、純度、データ変換、高次関数、および再帰がポイントとなります。


## 不変性(immutable)

ミュータントとは突然変異のことです。

それにim(否定)を付け加えると、不変であるという意味になります。

次の例では、lawnカラー辞書を変更する処理を行っていますが、
元の辞書に影響が出てしまっています。

```js
let color_lawn = {
    title: "lawn",
    color: "#00FF00",
    rating: 0
}

function rateColor(color, rating) {
    color.rating = rating
    return color
}
console.log(rateColor(color_lawn, 5).rating) // 5
console.log(color_lawn.rating) // 5
```

JavaScript では、関数の引数は実際のデータへの参照です。

色の設定このような実装は、元の色オブジェクトを変更または突然変異させるため、想定外の動作を引き起こしてしまう可能性があります。


```js
var rateColor = function(color, rating) {
    return Object.assign({}, color, {rating:rating})
}
console.log(rateColor(color_lawn, 5).rating) // 5
console.log(color_lawn.rating) // 4
```

ここでは、Object.assign を使用して色の評価を変更しました。 Object.assign はコピーを表します。

これで、オリジナルを変更することなくrateColorを実行することができました。

ちなみにアロー関数ではさらに短く書くことができます。

```js
const rateColor = (color, rating) =>
    ({
        ...color,
        rating
    })
```

色を不変オブジェクトとして扱い、より少ない構文で処理します。

返されたオブジェクトを括弧で囲んでいることに注意してください。



## 不変性その2(immutableその2)


次のコードのaddColorはタイトルと色の配列をinputして、配列に値を追加したものを返します。

```js
let list = [
    { title: "Rad Red"},
    { title: "Lawn"},
    { title: "Party Pink"}
]

var addColor = function(title, colors) {
    colors.push({ title: title })
    return colors;
}
console.log(addColor("Glam Green", list).length) // 4
console.log(list.length) // 4
```

気を付けなければ奈良に野は、Array.pushは不変の関数ではありません。

この addColor 関数は元の配列に別のフィールドを追加するしようなので、元の配列は変更されます
。

**元のlistを維持するために代わりに Array.concat を使用する必要があります。**


```js
const addColor = (title, array) => array.concat({title})
console.log(addColor("Glam Green", list).length) // 4
console.log(list.length) // 3 
```

Array.concatは配列を連結します。

**この場合、新しいオブジェクトを新しい色で取得します。**


## ES6では

ES6 スプレッド演算子を使用して、配列を連結するのと同じ方法で連結することもできます。

```js
const addColor = (title, list) => [...list, {title}]
```

この関数は元のリストを新しい配列にコピーし、新しいオブジェクトのコピーに色のタイトルを付けます。

**元の配列は不変です。**



## JSXとは？

JavaScript XMLの略で、Reactのコンポーネント内でマークアップ言語を記述するためのXML風の構文です。



## JavascriptでのDOM操作

それでは、DOM を変更する不純な関数を調べてみましょう。

従来のDOM

```js
function Header(text) {
    let h1 = document.createElement('h1');
    h1.innerText = text;
    document.body.appendChild(h1);
}
Header("Header() caused side effects");
```


Header関数は、見出し (特定のテキストを含む 1 つの要素) を作成し、そのDOMを作成します。

この関数は不純です。関数や値は返されませんが、引数に現れないDOM の変更という副作用を引き起こします。

## ReactでのDOM操作

React では、UI は純粋な関数で表現されます。

次のサンプルでは、​​Header は見出しを作成するために使用できる純粋な関数—前の例と同じように 1 つの要素例です。

**ただし、この関数自体は副作用を引き起こしません。つまりDOM を変更しません。**

関数は要素を返すだけの文字列として、予測可能な関数となるのです。

```js
const Header = (props) => <h1>{props.title}</h1>
```


## 備考

title:【React関数型プログラミング】


category_script:page_name.startswith("2")