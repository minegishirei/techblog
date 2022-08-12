

## Reactとは？

React はそれはFacebookで構築されました、ユーザーインターフェイスの作成に使用される一般的なライブラリです。

大規模なデータ駆動型のWebサイトに関連するいくつかの課題に対処です。


## Reactプロジェクトの立ち上がり

Reactが 2013年にリリースされたとき、プロジェクトは当初、懐疑的な目で見られました。
React の慣例は非常にユニークであるためです。

新しいユーザーを怖がらせないように、コアのReactチームは次の記事を書きました。

> 「Why React? - なぜ  Reactなのか？」

この記事はあなたに「それをReact(反応)するために 5分間だけ考える」ことを勧めました。

彼らReact を使って作業することを奨励したかったのですが、Reactのアプローチがクレイジーすぎましたので手を付ける前に遠慮してしまったのです。


## Reactが奇妙に見える理由

- React は小さなライブラリであり、必要なものがすべて揃っているわけではありません

- React では、HTML のように見えるコードを JavaScript で直接記述します。(これをJSXと呼びます)

- これらのタグをブラウザーで実行するには、前処理が必要です。そして、おそらくそのための webpack のようなビルドツールが必要になります。 

私たちと同じように、その記事を読んだ方は、Reactをつぎの様に捉えるでしょう。

> 新しい JavaScript ライブラリ — DOM に関するすべての問題を解決するライブラリ。



## React はライブラリです。

従来の JavaScript フレームワークに期待されるすべてのツールが付属しています。

ですが**Reactライブラリは小さく、ジョブの一部にしか使用されません。**

Reactの中でも、常に新しいツールが登場し、古いツールは捨てられています。ですがJavascriptの非常に多くの異なるライブラリ名が継続的に議論に追加されているため、Javascritpそのものに追いつくのは不可能だと感じます。


## 新しい ECMAScript 構文

React は、JavaScript の歴史において、重要ではあるが混沌とした時期に成熟しました。

ECMA は、まれにしか仕様をリリースしていませんでした。場合によっては最大で仕様をリリースするのに10年かかり、これは、開発者が新しい文法を学ぶ必要がないことを意味します。


## 関数型 JavaScript の人気

関数型 JavaScript プログラミングについて。 

JavaScript は必ずしも関数型ではない言語ですが、関数型の手法は JavaScript コードで使用できます。 

Reactが強調するのはオブジェクト指向プログラミングよりも関数型プログラミングです。

この発想の転換はテスト容易性やパフォーマンスなどの分野でメリットをもたらす可能性があります。





## この記事の目標

この記事の目標は、物事を置くことによって学習プロセスの混乱を避けることです
順番に学習し、強力な学習基盤を構築します。

構文から始めてアップグレードして、最新の JavaScript 機能、特に JavaScript の機能に慣れてください。




## 備考

title:Reactの人気の理由とは？

description:Reactが強調するのはオブジェクト指向プログラミングよりも関数型プログラミングです。この発想の転換はテスト容易性やパフォーマンスなどの分野でメリットをもたらす可能性があります。






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







- [純粋関数の鉄則](#純粋関数の鉄則)
- [javascriptの関数型プログラミングの胆：join, map, filter, reduce](#javascriptの関数型プログラミングの胆join-map-filter-reduce)
- [Array.joinは配列をつなげる](#arrayjoinは配列をつなげる)
- [関数型プログラミングまとめ](#関数型プログラミングまとめ)
- [備考](#備考)


## 純粋関数の鉄則

純粋関数は、関数型プログラミングのもう1つの中心的な概念です。

アプリケーションの状態に影響を与えないため、作業が大幅に楽になります。

関数を使用する場合は、次の 3 つのルールに従うようにしてください。

1. 関数は少なくとも一つの引数を取るべき

2. 関数は少なくとも一つ以上の引数を返すべき

3. 関数は引数の値を変更してはならない





## javascriptの関数型プログラミングの胆：join, map, filter, reduce

データが不変の場合、アプリケーションはなにか意味をなすのでしょうか？

**機能的なプログラミングとは、アプリケーションとは、データをある形式から別の形式に変換することです。**

私たちは関数を使用して変換されたコピーを生成します。

これらの関数はコードの不完全性を軽減し、複雑さが軽減されます。

1 つのデータセットを生成する方法を理解するために、特別なフレームワークは必要ありません。

ただし、**データ変換のプロになるために習得しなければならない 2 つのコア機能があります。**

- cient: Array.map 

- および Array.reduce。**

このセクションでは、これらおよびその他のコア機能がどのように伝達されるかを見ていきます。

たとえば、学校名が並んだ配列の操作を考えてみましょう。

```js
const schools = [
 "Yorktown",
 "Washington & Lee",
 "Wakefield"
]
```

## Array.joinは配列をつなげる

学校のリストを「, 」区切りで結合したいときは、joinを使うといいでしょう。

```js
const schools = [
    "Yorktown",
    "Washington & Lee",
    "Wakefield"
]

console.log( schools.join(", ") ) 
```

join は組み込みの JavaScript 配列メソッドで、区切り文字列を抽出するために使用できます

元の配列はそのままです。 




## 関数型プログラミングまとめ


熟練した JavaScript エンジニアになりたい場合は、これらの機能をマスターする必要があります。

あるデータセットから別のデータセットを作成する機能は必須で、あらゆるタイプのプログラミング パラダイムに役立ちます。





## 備考


title:関数型プログラミング概要とjoinの使い方【関数型プログラミングReact】

description:












## javascriptのmapメソッドで

関数型プログラミングに不可欠なもう 1 つの配列関数は、Array.map です。

述語の代わりに、**Array.map メソッドは関数を引数として取ります。**

この関数は **配列内のすべての項目に対して 1 回呼び出され、それが返すものは何でも新しい配列に追加される** という特徴を持ちます。


```js
const schools = [
    "Yorktown",
    "Washington & Lee",
    "Wakefield"
]

const highSchools = schools.map(school => `${school} High School`)

console.log(highSchools.join("\n"))
// Yorktown High School
// Washington & Lee High School
// Wakefield High School

console.log(schools.join("\n"))
// Yorktown
// Washington & Lee
```

この場合、highSchoolsリストは`HighSchool`という文字列を末尾に付けるという動作をします。

また、次の例では配列から、連想配列を生み出すタスクをたった1行で行ってます。

```js
const highSchools = schools.map(school => ({ name: school }))
console.log( highSchools )
// [
//  { name: "Yorktown" },
//  { name: "Washington & Lee" },
//  { name: "Wakefield" }
// ]
```


## javascriptで配列の中身を展開する

```js
let schools = [
 { name: "Yorktown"},
 { name: "Stratford" },
 { name: "Washington & Lee"},
 { name: "Wakefield"}
]

const editName = (oldName, name, arr) =>
    arr.map(item => {
    if (item.name === oldName) {
        return {
            ...item,
            name
        }
    } else {
        return item
    }
})

let updatedSchools = editName("Stratford", "HB Woodlawn", schools)
console.log( updatedSchools[1] ) 
// { name: "HB Woodlawn" }
console.log( schools[1] ) 
// { name: "Stratford" }
```

school 配列は、オブジェクトの配列です。 

updatedSchools変数はeditName関数を呼び出し結果を格納します。

関数の引数では、更新したい学校名、新しい学校名、最後に対象となる学校配列を取ります。


**これにより、新しい配列が変更されますが、元の配列は編集されません。**

ちなみにこの関数はif/elseではなく、三項演算子を使うことでより短くなります。

```js
const editName = (oldName, name, arr) => arr.map(item => (item.name === oldName) ?　({...item,name}) : item)
```

## mapを使って連想配列にキーを追加する(Object.keys)

配列をオブジェクトに変換する必要がある場合は、Array.mapとObject.keys を組み合わせて対応できます。 

**Object.keys は、辞書からキーの一覧を返すために使用できるメソッドです。**

学校オブジェクトを学校の配列に変換する必要があるとしましょう:

```js
const schools = {
    "Yorktown": 10,
    "Washington & Lee": 2,
    "Wakefield": 5
}

const schoolArray = Object.keys(schools).map(key =>
    ({
        name: key,
        wins: schools[key]
    })
)

console.log(schoolArray)
// [
//  {
//    name: "Yorktown",
//    wins: 10
//  },
//  {
//    name: "Washington & Lee",
//    wins: 2
//  },
//  {
//    name: "Wakefield",
//    wins: 5
//   }
//  ]
```

この例では、Object.keys は学校名の配列を返し、その配列でmap を使用し同じ長さの新しい配列を生成します。


ここまでで、**Array.map と Array.filter を使用して配列を変換できることを学びました。**

また、**Object.keys を組み合わせることで配列をオブジェクトに変更できることも学びました。**




title:mapの使い方【関数型プログラミングReact】





## Array.filterは配列の条件に一致するものを選択する

一文字目が「W」で始まる関数を探したいとします。

このタスクでは **「配列の条件に一致する要素を抜き出す」** という点がタスクとなります。

```js
const schools = [
    "Yorktown",
    "Washington & Lee",
    "Wakefield"
]

const wSchools = schools.filter(school => school[0] === "W")
console.log( wSchools )
// ["Washington & Lee", "Wakefield"]
```


## filterメソッドで条件に一致しない物をはじく


```js
const schools = [
    "Yorktown",
    "Washington & Lee",
    "Wakefield"
]

const cutSchool = (cut, list) => list.filter(school => school !== cut)

console.log(cutSchool("Washington & Lee", schools).join(" * "))
// "Yorktown * Wakefield"

console.log(schools.join("\n"))
// Yorktown
// Washington & Lee
// Wakefield
```

この場合、cutSchool 関数を使用して、「ワシントンとリー」と一致するものを排除しています。

cutSchoolは純粋関数です。

1. 学校のリストと削除する学校の名前を引数として取り、

2. その特定の学校以外での新しい配列を返します




title:filterの使い方【関数型プログラミングReact】




- [reduceを使って値の集約を行う](#reduceを使って値の集約を行う)
- [reduceを連想配列で使う](#reduceを連想配列で使う)
- [reduceを使用して重複をなくす](#reduceを使用して重複をなくす)
- [備考](#備考)

## reduceを使って値の集約を行う

機能的な武器庫に必要な最後のツールは、reduceです。

reduce および reduceRight関数を使用して、配列を任意の値に変換できます。

```js
const 新しい値 = 配列.reduce(関数, 初期値)
```

**覚えておいてほしいポイントは三つあります。**

1. 一つ目の引数が常に変わる。

2. 二つ目の引数は配列から順に取り出される

3. returnされた値は一つ目の引数に格納される


例えば、ages配列から最大の年を取得したいとします。

```js
const ages = [21,18,42,40,64,63,34];
const maxAge = ages.reduce((max, age) => {
    console.log(`${age} > ${max} = ${age > max}`);
    if (age > max) {
        return age
    } else {
        return max
    }
}, 0)
console.log('maxAge', maxAge);
// 21 > 0 = true
// 18 > 21 = false
// 42 > 21 = true
// 40 > 42 = false
// 64 > 42 = true
// 63 > 64 = false
// 34 > 64 = false
// maxAge 64
```

age 配列は、最大年齢の64という1つの値に縮小(reduce)されました。

reduceの内部の関数は二つの値を取ります。

最初のageの値は21で、maxの値は0です。(maxの初期値はmaxAgeの定義の末尾に書いてあります。)

このコールバックが初めて呼び出されたとき、age は 21 に等しく、配列の最初の値であり、max は 0 (初期値) です。

その後、どちらが大きいかの判定をif/elseで行ってます。

それぞれの分岐のreturnで返される結果がmaxに格納されるのです。

**覚えておいてほしいポイントは三つあります。**

1. 一つ目の引数が常に変わる。

2. 二つ目の引数は配列から順に取り出される

3. returnされた値は一つ目の引数に格納される

つまり**なにが反復ごとに変わるのか？**に着目するのが最も重要と考えられます。

ちなみに参考演算子を使うとほぼ1ライナーで書けます。

```js
const max = ages.reduce(
    (max, value) => (value > max) ? value : max,
    0
)
```


## reduceを連想配列で使う

連想配列を使えばよりreduceの挙動が分かりやすくなるかもしれません。

```js
const colors = [
    {
        id: '-xekare',
        title: "rad red",
        rating: 3
    },
    {
        id: '-jbwsof',
        title: "big blue",
        rating: 2
    },
    {
        id: '-prigbj',
        title: "grizzly grey",
        rating: 5
    },
    {
        id: '-ryhbhsl',
        title: "banana",
        rating: 1
    }
]

const hashColors = colors.reduce(
    (hash, {id, title, rating}) => {
        hash[id] = {title, rating}
        return hash
    },
    {}
)

console.log(hashColors);
// {
//      "-xekare": {
//          title:"rad red",
//          rating:3
//      },
//      "-jbwsof": {
//          title:"big blue",
//          rating:2
//      },
//      "-prigbj": {
//          title:"grizzly grey",
//          rating:5
//      },
//      "-ryhbhsl": {
//          title:"banana",
//          rating:1
//      }
// }
```

この例では、reduce 関数に送信される 2 番目の引数は空の辞書オブジェクトで、これがhashの初期値です。

```js
hash[id] = {title, rating}
```

この行でhashに値が追加されるので、各反復中に、hashColorsは増加します。

returnされたhashは、次の反復の引数hashに代入されるので、hash配列は増加するのです。



## reduceを使用して重複をなくす

reduceをつかって重複をなくすこともできます。

```js
const colors = ["red", "red", "green", "blue", "green"];
const distinctColors = colors.reduce(
    (distinct, color) =>
        (distinct.indexOf(color) !== -1) ? distinct : [...distinct, color]
    ,[]
)
console.log(distinctColors)
// ["red", "green", "blue"]
```

reduceによる反復では何が変わるのでしょうか？

この場合、distinctがが変化していきます。

参考演算子によってreturnされるdistinctは、次の様に動きます。

1. 最初は[]から始まるただの配列です

2. indexOf関数によってdistinctに要素がないと判断した時、distinctを展開,colorを末尾に追加し、再び[]で閉じます。

このように、reduceのコードを読むためには **「度の値が変化するのか？」** に着目するのが大事です。


## 備考

title:reduceの使い方【関数型プログラミングReact】














- [高階関数のメリット](#高階関数のメリット)
- [高階関数とは](#高階関数とは)
- [カリー化](#カリー化)
- [カリー化の例2](#カリー化の例2)
- [まとめ](#まとめ)
- [備考](#備考)



## 高階関数のメリット

他の関数を返す高階関数は、複雑な問題を処理するのに役立ちます。

例えば、JavaScript の非同期性に関連する関係では、関数を作成するのに役立ちます。



## 高階関数とは

高階関数を使うのも関数型プログラミングの重要な側面です。

高階関数については以前述べましたが、この章ではさらに多用します。

**高階関数は他の関数を操作できる関数です。関数を引数として受け取るか、関数を返すか、またはその両方を行います。**

実は、

- Array.map

- Arrya.filter

- Array.reduce

は全て関数を引数に取るので、高階関数と言えます。

ですが、これらの関数以外の高階関数を使いたい場面もたまにあります。

では実際に、高階関数を実装する方法を見てみましょう。


```js
const invokeIf = (condition, fnTrue, fnFalse) =>
 (condition) ? fnTrue() : fnFalse()
const showWelcome = () =>
 console.log("Welcome!!!")
const showUnauthorized = () =>
 console.log("Unauthorized!!!")
invokeIf(true, showWelcome, showUnauthorized) // "Welcome"
invokeIf(false, showWelcome, showUnauthorized) // "Unauthorized"
```

invokeIf は 2 つの関数を想定しています。

- 1 つは true 用で、

- もう 1 つは false 用です。

showWelcome と showUnauthorized の両方を invokeIf に送信し、

- コンディションがションが true の場合、showWelcome が呼び出されます。 

- false の場合、showUnauthorized が呼び出されます。


## カリー化

**カレーじゃないっつってんだろ！！！**


カリー化は、高階関数の使用を伴う関数型手法で、簡単に言うと**関数を返す関数です**


ここでのカリーとは

> 2他動
> 〔馬を〕馬ぐしですく［手入れする］
> 〔なめし革を〕仕上げ加工する

この意味

**だからカレーじゃないっつってんだろ！！！**


参考：https://qiita.com/Yametaro/items/99cc1c8ebcfc703b1410

実際の使用例では、以下のようなイメージになります。

```js
function tashizann(hikisu1) {
    return function(hikisu2){
        return hikisu1 + hikisu2;
    }
}

const kekka = tashizann(3)(5);
alert(kekka);


// 部分適応
const tasu3 = tashizann(3);

// 部分適応された関数を見てみる
const kekka2 = tasu3(5);
alert(kekka2);
// 8

const kekka3 = tasu3(7)
alert(kekka3)
// 10
```

ここではtasu3という関数を作り、いくらでも3を足し放題になるわけです。

このように、カリー化された関数から具体的な3を足すという関数を一部分だけ使うことを
**部分適応**と言います。



## カリー化の例2

実践的にはこんな感じになります。

userLogsはユーザー名とメッセージを引数に取るような、カリー化された高階関数です。

ここではlogという関数を“grandpa23”というユーザー名で**部分適応**して使っています。

```js
const userLogs = userName => message =>　console.log(`${userName} -> ${message}`)

const log = userLogs("grandpa23")

log("attempted to load 20 fake members")
getFakeMembers(20).then(
    members => log(`successfully loaded ${members.length} members`),
    error   => log("encountered an error loading members")
)
// grandpa23 -> attempted to load 20 fake members
// grandpa23 -> successfully loaded 20 members

// grandpa23 -> attempted to load 20 fake members
// grandpa23 -> encountered an error loading members
```



## まとめ

高階関数を書いて後悔！なんちゃって




## 備考

title:カリー化と高階関数【関数型プログラミングReact】














- [コンポジション](#コンポジション)
- [連鎖その1：replaceメソッド](#連鎖その1replaceメソッド)
- [連鎖その2：composeメソッド](#連鎖その2composeメソッド)
- [composeメソッドの実装方法](#composeメソッドの実装方法)
- [備考](#備考)


## コンポジション

関数型プログラムは、ロジックを焦点を特定のタスクについて絞った小さな純粋な関数に分割し、最終的にはこれらの小さな関数をまとめる必要があります。

具体的には、それらを組み合わせたり、直列または並列で呼び出したり、最終的にアプリケーションが完成するまで、それらをより大きな関数にポーズします。

コンポジションに関しては、さまざまな実装テクニックがあります。

よく知られていることの 1 つは**連鎖**です。

**JavaScript では、ドット表記を使用して関数を連鎖させて、関数の戻り値に作用させることができます。**


## 連鎖その1：replaceメソッド

文字列には置換するメソッドがあります。 

文字列.replaceメソッドはテンプレート文字列を返します

ですので、replace メソッドを連鎖させるような使い方も可能です。

```js
const template = "hh:mm:ss tt"
const clockTime = template.replace("hh", "03")
    .replace("mm", "33")
    .replace("ss", "33")
    .replace("tt", "PM")
console.log(clockTime)
// "03:33:33 PM"
```

この例で変数templateは文字列です

replace メソッドを最後までチェーンすることにより、時間、分、秒、および時刻を置き換えることができます

このように、連鎖は合成テクニックの 1 つですが、他にもあります。


## 連鎖その2：composeメソッド

composeメソッドの目的は「より単純な関数を組み合わせて、より高次の関数を生成する」ことです。

まずcomposeメソッドを使わない例ですが、

```js
const both = date => appendAMPM(civilianHours(date))
```

このように、関数を入れ子にして実行してます。

ところが、これらの関数は日本語で言えば入れ子というより**連鎖**に近いです。

**そしてその「連鎖」をより直感的に表す記法があります。comopseメソッドです。**

```js
const both = compose(
 civilianHours,
 appendAMPM
)
both(new Date())
```

このアプローチははるかに優れています。

特に、**機能を任意の時点で追加できるのでスケールしやすいという点が最高です。**

このアプローチにより、composeの引数の順序を簡単に変更できます。


## composeメソッドの実装方法

ちなみにcomposeメソッドは次のようにして実装できる、後悔関数です。

```js
const compose = (...fns) => (arg) => fns.reduce((composed, f) => f(composed), arg) 
```

これは、コンポジションを説明するために設計されたcompose関数の簡単な例です。

copmpose関数は、より多くの処理を行うときになるとより複雑になります。

例えば、1つ以上の引数を指定したり、関数ではない引数を処理したりなどです。



## 備考

title:javascriptのcomposeメソッドの作り方

description:ちなみにcomposeメソッドは次のようにして実装できる、後悔関数です。const compose = (...fns) => (arg) => fns.reduce((composed, f) => f(composed), arg) 











## 関数型プログラミングハンズオン

関数型プログラミングの中心的な概念を紹介してきました。

次はこれらの概念を活用して、小さな JavaScript アプリケーションを構築してください。

JavaScript を使用すると、機能的パラダイムから抜け出すことができますが、ルールに従わなければならないので、集中し続ける必要があります。

この3つの簡単なルールにことに従うことは、目標を達成するための近道です。

1. データを不変に保ちます。

2. 関数を純粋に保つ — 少なくとも 1 つの引数を受け入れ、データまたは別の関数を返す
ション。

3. ループよりも再帰を使用します (可能な限り)。



## 課題


私たちの挑戦は時を刻む時計を作ることです。

- 時計は時間、分、秒と時刻から成り立ちます。

- 各フィールドは常に 2 桁でなければなりません。つまり、1 や 2 などの 1 桁の値には先行ゼロを適用する必要があります。

- また、表示を毎秒tickして変更する必要があります。


## 愚かな解決方法

通常のプログラミングでは以下のようなソースになるはずです。

```js
// Log Clock Time every Second
setInterval(logClockTime, 1000);
function logClockTime() {
    // Get Time string as civilian time
    var time = getClockTime();
    // Clear the Console and log the time
    console.clear();
    console.log(time);
}
function getClockTime() {
    // Get the Current Time
    var date = new Date();
    var time = "";

    // Serialize clock time
    var time = {
        hours: date.getHours(),
        minutes: date.getMinutes(),
        seconds: date.getSeconds(),
        ampm: "AM"
    }
    if (time.hours == 12) {
        time.ampm = "PM";
    } else if (time.hours > 12) {
        time.ampm = "PM";
        time.hours -= 12;
    }
    // Prepend a 0 on the hours to make double digits
    if (time.hours < 10) {
        time.hours = "0" + time.hours;
    }
    // prepend a 0 on the minutes to make double digits
    if (time.minutes < 10) {
        time.minutes = "0" + time.minutes;
    }
    // prepend a 0 on the seconds to make double digits
    if (time.seconds < 10) {
        time.seconds = "0" + time.seconds;
    }
    // Format the clock time as a string "hh:mm:ss tt"
    return time.hours + ":"
    + time.minutes + ":"
    + time.seconds + " "
    + time.ampm;
}
```

この解決策は非常に簡単です。

しかし、これらの機能は大規模で複雑です。

各関数は多くのことを行い、それらは理解するのが難しく、コメントが必要であり、保守するのは大変でしょう。



## 関数型を取り入れた解決方法


機能的アプローチがよりスケーラを生み出す方法を見てみましょう。

私たちの目標は、アプリケーション ロジックを小さな部分、つまり関数に分割することです。

各関数は単一のタスクに焦点を当て、それらをより大きな関数に構成します。

1. まず、値を与えてコンソールを管理するいくつかの関数を作成しましょう。

2. 1秒を返す関数、現在の時刻を返す関数が必要です。

3. コンソールにメッセージを記録し、コンソールをクリアするいくつかの関数。

関数型プログラムでは、可能な限り値よりも関数を使用する必要があります。

```js
const oneSecond = () => 1000
const getCurrentTime = () => new Date()
const clear = () => console.clear()
const log = message => console.log(message)
```


次に、データを変換するための関数が必要になります。

この 3 つの関数は、Date オブジェクトを時計に使用できるオブジェクトに変更するために使用されます。

- serializeClockTime

日付オブジェクトを受け取り、時間を含む時間のオブジェクトを返します

```js
const serializeClockTime = date =>
    ({
        hours: date.getHours(),
        minutes: date.getMinutes(),
        seconds: date.getSeconds()
    })
```

- civilianHours

時計の時刻オブジェクトを受け取り、時間を人間が読めるオブジェクトに変換します。

```js
const civilianHours = clockTime =>
    ({
        ...clockTime,
        hours: (clockTime.hours > 12) ?　clockTime.hours - 12 :clockTime.hours
    })
```

> 例: 1300 は 1 時になります

- appendAMPM

時刻オブジェクトを取得し、そのオブジェクトに AM または PM の時刻を追加します。

```js
const appendAMPM = clockTime =>
    ({
        ...clockTime,
        ampm: (clockTime.hours >= 12) ? "PM" : "AM"
    })
```


これら 3 つの関数は、元のデータを変更せずにデータを変換するために使用されます。



次に、いくつかの高階関数が必要になります:


- display

ターゲット関数を受け取り、ターゲットに時間を送信する関数を返します。
この例では、ターゲットは console.log になります。

```js
const display = target => time => target(time)
```

- formatClock

テンプレート文字列を受け取り、あるルールに基づいてフォーマットされた時刻を返します。

この例では、テンプレート文字列は「hh:mm:ss tt」です。

そこから、formatClock は、プレースホルダーを時、分、秒、および時刻に変更します。

```js
const formatClock = format =>
    time =>
    format.replace("hh", time.hours)
        .replace("mm", time.minutes)
        .replace("ss", time.seconds)
        .replace("tt", time.ampm)
```

- prependZero

オブジェクトのキーを引数として取り、格納された値の先頭にゼロを追加します。

```js
const prependZero = key => clockTime => ({
    ...clockTime,
    [key]: (clockTime[key] < 10) ?
    "0" + clockTime[key] :
    clockTime[key]
})
```

時を刻む時計を構築するために必要な関数がすべて揃ったので、次のものが必要です。


- convertToCivilianTime
クロック時間を引数として取り、それを次のように変換する単一の関数

```js
const convertToCivilianTime = clockTime =>
    compose(
        appendAMPM,
        civilianHours
    )(clockTime)
```

- doubleDigits

時間と分と秒は、必要に応じて先頭にゼロを追加して 2 桁で表示します。

```js
const doubleDigits = civilianTime =>
    compose(
        prependZero("hours"),
        prependZero("minutes"),
        prependZero("seconds")
    )(civilianTime)
```

- startTicking

毎秒コールバックを呼び出す間隔を設定してクロックを開始します。

コールバックは、次のすべての処理を行います。

コンソールは毎秒クリア、currentTime の取得、変換、自然言語化、フォーマット、および表示。

```js
const startTicking = () =>
    setInterval(
        compose(
            clear,
            getCurrentTime,
            serializeClockTime,
            convertToCivilianTime,
            doubleDigits,
            formatClock("hh:mm:ss tt"),
            display(log)
        ),
        oneSecond()
    )
startTicking()
```

このクロックの関数型バージョンは、命令バージョンと同じ結果を達成します。

ただし、このアプローチにはかなりの利点があります。

- まず、これらすべての機能は **簡単にテストして再利用できます。** それらは、将来の時計やその他のデジタル障害で使用できます。

- また、**このプログラムは簡単に拡張できます。** 副作用はありません。

この章では、関数型プログラミングの原則を紹介しました。


次の章では、原則の理解を深めて、公式に React に飛び込みます。










## 備考


title:Javascriptで関数型プログラミングハンズオン！

description:関数型プログラミングにはかなりの利点があります。まず、これらすべての機能は 簡単にテストして再利用できます。それらは、将来の時計やその他のデジタル障害で使用できます。また、このプログラムは簡単に拡張できます。そこに副作用はありません。







## React環境構築

reactで最も単純な環境構築は、**スクリプトタグを読み込むことです**

次のコードでは最もシンプルなReactの環境を構築します。

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Pure React Samples</title>
    </head>
    <body>

        <!-- Target container -->
        <div class="react-container"></div>

        <!-- React library & ReactDOM-->
        <script src="https://unpkg.com/react@15.4.2/dist/react.js"></script>
        <script src="https://unpkg.com/react-dom@15.4.2/dist/react-dom.js"></script>
        <script>
        // Pure React and JavaScript code
        </script>
    </body>
</html>
```

これらは、ブラウザーで React を操作するための最小要件です。

JavaScriptソースは別のファイルに配置することができますが、ページのどこかにロードする必要があります。



## 備考

title:Reactのスクリプトタグで環境構築を行う

description:reactで最も単純な環境構築は、スクリプトタグを読み込むことです。次のコードでは最もシンプルなReactの環境を構築します。









- [The Virtual DOM](#the-virtual-dom)
- [React Element](#react-element)
- [ReactDOM](#reactdom)
- [備考](#備考)

この章では、React がブラウザーでどのように動作するかを理解するために、純粋なReactを学びます。



## The Virtual DOM

HTML は、単純に、ブラウザーがウェブサイトを構築するときに従う一連の指示です。

Javascriptでは、ドキュメントオブジェクトモデル、または DOMと呼ばれます。

DOM API は、JavaScript がDOMオブジェクトと対話するために使用できるライブラリです。

DOMAPIでは次のいずれかのメソッドを用いて、ブラウザーで DOM を変更します。 

- document.createElement 

- document.appendChild


JavaScript で DOM 要素をレンダリングするのは比較的簡単ですが、デメリットもあります。新しい要素の挿入は非常に遅い場合があり、これはWeb開発者が細心の注意を払っているかどうかでパフォーマンスが変わります。


**React は、ブラウザーDOMを更新するように設計されたライブラリーです。私たちはもはやパフォーマンスの高い SPA の構築に伴う複雑さを考慮する必要はありません。なぜなら、React がそれをやってくれるからです。**

React では、直接DOM APIとやり取りしません。代わりに、仮想DOMと対話します
仮想 DOM は React 要素で構成されており、概念的にはHTML 要素ですが、実際には JavaScript オブジェクトです。

JavaScriptオブジェクト、仮想DOM、およびReactは、DOM API を可能な限り効率的に使用します。



## React Element


ブラウザDOMはDOM要素で構成されています。

同様に、ReactDOMは、ReactDOM要素によって作成されます。

DOM 要素と React 要素は同じように見えるかもしれませんが、それらは実際にはかなり異なります。 


まずは、React.createElementを使用して、h1を表す ReactElementを作成してみます。

```js
React.createElement("h1", null, "Baked Salmon")
```

- 最初の引数は、作成したい要素のタイプを定義します。この場合、私たちは＜h1＞要素を作成します。 

- 3番目の引数は要素の子である開始タグと終了タグの間に挿入されるすべてのノードを表します。
- 2番目の要素はプロパティを表しますが、今回は省略します。

レンダリングの結果は、次の要素が作成されます。

```html
<h1>Baked Salmon</h1>
```


プロパティを持つ場合はもう少しだけ複雑になります。

```js
React.createElement("h1",{id: "recipe-0", 'data-type': "title"},"Baked Salmon")
```

この場面でのReactDOMの生成結果は、次の要素になります。

```html
<h1 data-reactroot id="recipe-0" data-type="title">Baked Salmon</h1>
```

ここまで写経した人は気付いたと思いますが、ReactのcreateElemetはhtmlの要素の順番とほぼ同じです。


したがって、ReactDOM要素は、React にどのように構成するかを伝える JavaScriptリテラルにすぎません。

次のjavascript要素は、実際にcreateElementにより作成された要素を示しています。

```js
{
    $$typeof: Symbol(React.element),
    "type": "h1",
    "key": null,
    "ref": null,
    "props": {"children": "Baked Salmon"},
    "_owner": null,
    "_store": {}
}
```

これこそがReact要素なのである。




## ReactDOM

ReactDOM には、ブラウザーで React 要素をレンダリングするために必要なツールが含まれています。



## 備考


title:createElementを使い要素を作成する【React入門】











## ReactDOMを使って子要素をレンダリングする

次のようなulタグとliタグには親子関係が存在します。

この場合、urlを**親要素** liを**子要素**と呼びます。

liはたくさんあるので、childではなく、childrenと呼ばれます。

```html
<ul>
 <li>1 lb Salmon</li>
 <li>1 cup Pine Nuts</li>
 <li>2 cups Butter Lettuce</li>
 <li>1 Yellow Squash</li>
 <li>1/2 cup Olive Oil</li>
 <li>3 cloves of Garlic</li>
</ul>
```


この例では、6つの子要素が存在します。

これらの親子関係をReactでは次のように表現します。


```js
React.createElement(
    "ul",
    null,
    React.createElement("li", null, "1 lb Salmon"),
    React.createElement("li", null, "1 cup Pine Nuts"),
    React.createElement("li", null, "2 cups Butter Lettuce"),
    React.createElement("li", null, "1 Yellow Squash"),
    React.createElement("li", null, "1/2 cup Olive Oil"),
    React.createElement("li", null, "3 cloves of Garlic")
)
```

全体を眺めるだけで、htmlで記述したのと対して変わらないのが分かるでしょう。

createElement 関数に送信されるすべての追加引数は、別の子要素です。

React はこれらの子要素の配列を作成し、値を設定します。

React Elementを確認してみると次のようにpropsプロパティの中にchildrenが設定されているのが分かるでしょう。

```js
{
    "type": "ul",
    "props": {
        "children": [
            { "type": "li", "props": { "children": "1 lb Salmon" } … },
            { "type": "li", "props": { "children": "1 cup Pine Nuts"} … },
            { "type": "li", "props": { "children": "2 cups Butter Lettuce" } … },
            { "type": "li", "props": { "children": "1 Yellow Squash"} … },
            { "type": "li", "props": { "children": "1/2 cup Olive Oil"} … },
            { "type": "li", "props": { "children": "3 cloves of Garlic"} … }
        ]
        ...
    }
}
```

## Sectionの子要素をReactで表す。

次のようなsectionで複雑に入れ子関係が実装されたコードも

```html
<section id="baked-salmon">
 <h1>Baked Salmon</h1>
 <ul class="ingredients">
 <li>1 lb Salmon</li>
 <li>1 cup Pine Nuts</li>
<li>2 cups Butter Lettuce</li>
 <li>1 Yellow Squash</li>
 <li>1/2 cup Olive Oil</li>
 <li>3 cloves of Garlic</li>
 </ul>
 <section class="instructions">
 <h2>Cooking Instructions</h2>
 <p>Preheat the oven to 350 degrees.</p>
 <p>Spread the olive oil around a glass baking dish.</p>
 <p>Add the salmon, garlic, and pine nuts to the dish.</p>
 <p>Bake for 15 minutes.</p>
 <p>Add the yellow squash and put back in the oven for 30 mins.</p>
 <p>Remove from oven and let cool for 15 minutes.
 Add the lettuce and serve.</p>
 </section>
</section>
```

ReactのSectionの要素を表すと次のようになります。


```js
React.createElement("section", {id: "baked-salmon"},
    React.createElement("h1", null, "Baked Salmon"),
    React.createElement("ul", {"className": "ingredients"},
        React.createElement("li", null, "1 lb Salmon"),
        React.createElement("li", null, "1 cup Pine Nuts"),
        React.createElement("li", null, "2 cups Butter Lettuce"),
        React.createElement("li", null, "1 Yellow Squash"),
        React.createElement("li", null, "1/2 cup Olive Oil"),
        React.createElement("li", null, "3 cloves of Garlic")
    ),
    React.createElement("section", {"className": "instructions"},
        React.createElement("h2", null, "Cooking Instructions"),
        React.createElement("p", null, "Preheat the oven to 350 degrees."),
        React.createElement("p", null,
        "Spread the olive oil around a glass baking dish."),
        React.createElement("p", null, "Add the salmon, garlic, and pine..."),
        React.createElement("p", null, "Bake for 15 minutes."),
        React.createElement("p", null, "Add the yellow squash and put..."),
        React.createElement("p", null, "Remove from oven and let cool for 15 ....")
    )
)
```

ほとんどhtmlと同じであることが分かると思います。




title:React.createElementによる子要素の作成【React入門】












## Reactで配列からliタグ要素を作成する

React を使用する主な利点は、データを UI 要素から分離できることです。

React は単なる JavaScript であるため、JavaScript ロジックを追加して、データからReactDOMそしてHTMLを構築するのに役立てることができます。


例えば次のようなhtmlも

```html
<ul>
    <li>1 lb Salmon</li>
    <li>1 cup Pine Nuts</li>
    <li>2 cups Butter Lettuce</li>
    <li>1 Yellow Squash</li>
    <li>1/2 cup Olive Oil</li>
    <li>3 cloves of Garlic</li>
</ul>
```

配列を使って次の様に配列データとjavascriptのロジックに分離することができます。


```js
var items = [
    "1 lb Salmon",
    "1 cup Pine Nuts",
    "2 cups Butter Lettuce",
    "1 Yellow Squash",
    "1/2 cup Olive Oil",
    "3 cloves of Garlic"
]

React.createElement(
    "ul",
    { className: "ingredients" },
    items.map(ingredient => React.createElement("li", null, ingredient)
)
```

この構文は、配列内の各成分に対して React 要素を作成します。

map関数は配列からさらに新しい配列を作り出せることがポイントです。

Reactは関数型プログラミングですので、mapを使いこなせればReact使いとしてレベルは高くなります。



title:ReactでのmapとcreateElementの使い方【React入門】








## Reactコンポーネントとは？

度のユーザーインターフェースでも、ある部品の集合で出来ています。


<img src="https://ja.reactjs.org/static/9381f09e609723a8bb6e4ba1a7713b46/90cbd/thinking-in-react-components.png">

例えば、こんな具合に

https://ja.reactjs.org/docs/thinking-in-react.html



React では、これらの各パーツをコンポーネントとして記述します。

これらのコンポーネントにより、異なるデータセットに同じDOM構造を再利用できます。


React で構築したいユーザー インターフェイスを検討するときは、再利用可能な機会を探してください。

例えば、4番と5番は再利用可能なコンポーネントとして捉えられます。




## createClassは将来廃止される可能性がある

React が 2013 年に初めて導入されたとき、コンポを作成する方法は 1 つしかありませんでした。

それはつまり、createClass 関数を使うことです。

その後、コンポーネントを作成する新しい方法が登場しましたが、createClass は引き続き使用されます。

現在createClassはReact プロジェクトで広く使用されています。

ただし、React プロジェクトは createClass を将来廃止される可能性があります。



例えば次のようなhtmlの構造があり、これらを一つの部品（コンポーネント）として扱いたいとします。

```html
<IngredientsList>
 <ul className="ingredients">
 <li>1 lb Salmon</li>
 <li>1 cup Pine Nuts</li>
 <li>2 cups Butter Lettuce</li>
 <li>1 Yellow Squash</li>
 <li>1/2 cup Olive Oil</li>
 <li>3 cloves of Garlic</li>
 </ul>
</IngredientsList>
```

これまでのcreateElementを使った対応だと次のようになります。

```js
const IngredientsList = React.createClass({
    displayName: "IngredientsList",
    render() {
        return React.createElement("ul", {"className": "ingredients"},
            React.createElement("li", null, "1 lb Salmon"),
            React.createElement("li", null, "1 cup Pine Nuts"),
            React.createElement("li", null, "2 cups Butter Lettuce"),
            React.createElement("li", null, "1 Yellow Squash"),
            React.createElement("li", null, "1/2 cup Olive Oil"),
            React.createElement("li", null, "3 cloves of Garlic")
        )
    }})
const list = React.createElement(IngredientsList, null, null)
ReactDOM.render(
    list,
    document.getElementById('react-container')
)
```

ですが、これではデータとロジックが癒着してしまっているため、再利用はむずかしいと言えます。


## createClassによるコンポーネント作成

コンポーネントを使用すると、**データを使用して再利用可能な UI を構築できます。**

```js
const IngredientsList = React.createClass({
    displayName: "IngredientsList",
    render() {
        return React.createElement("ul", {className: "ingredients"},
            this.props.items.map((ingredient, i) =>
            React.createElement("li", { key: i }, ingredient)))
        }
    })
```

ここではthisキーワードを用いてitemsの中の配列からliタグを作成しています。


```js

const items = [
    "1 lb Salmon",
    "1 cup Pine Nuts",
    "2 cups Butter Lettuce",
    "1 Yellow Squash",
    "1/2 cup Olive Oil",
    "3 cloves of Garlic"
]
ReactDOM.render(
    React.createElement(IngredientsList, {items}, null),
    document.getElementById('react-container')
)
```

コンポーネントはオブジェクトであるため、クラスのカプセル化のように使用することができます。


```js
const IngredientsList = React.createClass({
    displayName: "IngredientsList",
    renderListItem(ingredient, i) {
        return React.createElement("li", { key: i }, ingredient)
    },
    render() {
        return React.createElement("ul", {className: "ingredients"},
            this.props.items.map(this.renderListItem)
        )
    }
})
const items = [
    "1 lb Salmon",
    "1 cup Pine Nuts",
    "2 cups Butter Lettuce",
    "1 Yellow Squash",
    "1/2 cup Olive Oil",
    "3 cloves of Garlic"
]
ReactDOM.render(
    React.createElement(IngredientsList, {items}, null),
    document.getElementById('react-container')
)
```


これは、MVC 言語のビューの考え方でもあります。

IngredientsListに関連付けられているすべてのUIは1つのコンポーネントにカプセル化されています。

これで、私たちはReactコンポーネントを使用してReact 要素を作成することができました。

```html
<ul data-react-root class="ingredients">
    <li>1 lb Salmon</li>
    <li>1 cup Pine Nuts</li>
    <li>2 cups Butter Lettuce</li>
    <li>1 Yellow Squash</li>
    <li>1/2 cup Olive Oil</li>
    <li>3 cloves of Garlic</li>
</ul>
```



title:createClassによるコンポーネント作成【React入門】









## React.Component


React.Component は、新しく出た、React コンポーネントを構築するために使用できる抽象クラスです。

このクラスを次のように拡張することで、**継承によってカスタムコンポーネントを作成できます。**

同じ構文を使用して IngredientsList を作成してみます。


以前の構文では以下のように記述してました。

```js
// before

const IngredientsList = React.createClass({
    displayName: "IngredientsList",
    renderListItem(ingredient, i) {
        return React.createElement("li", { key: i }, ingredient)
    },
    render() {
        return React.createElement("ul", {className: "ingredients"},
            this.props.items.map(this.renderListItem)
        )
    }
})
const items = [
    "1 lb Salmon",
    "1 cup Pine Nuts",
    "2 cups Butter Lettuce",
    "1 Yellow Squash",
    "1/2 cup Olive Oil",
    "3 cloves of Garlic"
]
ReactDOM.render(
    React.createElement(IngredientsList, {items}, null),
    document.getElementById('react-container')
)
```

React.Componentクラスを継承する使い方だと次のようによりオブジェクト指向に忠実なコンポーネントになります。

```js
class IngredientsList extends React.Component {
    renderListItem(ingredient, i) {
        return React.createElement("li", { key: i }, ingredient)
    }
    render() {
        return React.createElement("ul", {className: "ingredients"},
        this.props.items.map(this.renderListItem)
        )
    }
}
const items = [
    "1 lb Salmon",
    "1 cup Pine Nuts",
    "2 cups Butter Lettuce",
    "1 Yellow Squash",
    "1/2 cup Olive Oil",
    "3 cloves of Garlic"
]
ReactDOM.render(
    React.createElement(IngredientsList, {items}, null),
    document.getElementById('react-container')
)
```


ですがクラスを使ったReactのコーディングは近年排除される傾向があるため、次の章で紹介する関数型プログラミングの手法がより堅実でしょう。



## 備考



title:React.Componentの使い方とコンポーネント【React入門】

filename:1301react_component.md











## 関数型コンポーネント


ステートレスな関数型コンポーネントは関数であり、オブジェクトではありません。
したがって、thisを持ちません。

一般的に、ステートレス関数が十分に堅牢であり何よりシンプルであるため、クラスの使用をなるべく避けて可能な限り関数型コンポーネントを使用してます。

関数型コンポーネントでは、**propsを受取った後、最終的にはDOM要素を返す**必要があります。このように、**関数型プログラミングを使用することは、副作用をひきおこす事なく、シンプルさが促進され、コードベースのテストが非常に容易になるのです。**


以下は関数型コンポーネントのサンプルです。

```js
const IngredientsList = props =>
    React.createElement("ul", {className: "ingredients"},
        props.items.map((ingredient, i) =>
            React.createElement("li", { key: i }, ingredient)
            )
        )
```

このコンポーネントを ReactDOM.render でレンダリングします。

createClass または ES6 クラス構文で作成されたコンポーネントのレンダリングとまったく同じ方法です。

この関数は props 引数を介してデータを受取り、最終的にはcreateElementの実行結果を返却します。

このステートレスな機能コンポーネントを改善する方法の 1 つは、properties引数の中にwデストラクタを使用することです。

```js
const IngredientsList = ({items}) =>
    React.createElement("ul", {className: "ingredients"},
        items.map((ingredient, i) =>
        React.createElement("li", { key: i }, ingredient)
        ))
 ```







## 関数型プログラミングでMVCを可能にする

Reactでは関数型プログラミングを実施することによって、データを props としてコンポーネントに渡すことができるため、データをアプリケーションのロジックから分離できます。

これは我々に次のようなプログラミング手法を提供することができます。

すなわち、データを変更することで自動的に関数が働き、ビューが変更されるようなプログラミングです。

これは厳密なMVCモデルに基づいたプログラミングであり、アプリケーションの影響範囲が予想しやすくなります。


## MVCモデルに基づいた具体例

5 人のチームメンバーの気分を表示するアプリがあったとします。
にこやかな顔かしかめ面のどちらか。五人それぞれのムードを表現する元のデータは、
ある配列であるとします。

```js
["smile", "smile", "frown", "smile", "frown"];
```

このデータは次の様に表現されます。

```html
(>_<) (≧▽≦) (>_<) (≧▽≦) (>_<)
```

もし彼ら5人が管理するシステムで何かが壊れて、チームが週末中ずっと働かなければならない場合、チームの対応を反映できます。

```js
["frown", "frown", "frown", "frown", "frown"];
```

この配列のデータを変更するだけで新しい気分になり、次の結果が得られます。

```html
(>_<) (>_<) (>_<) (>_<) (>_<)
```

この場合、1 番目、2 番目、4 番目の値を笑顔からしかめっ面に変更する必要があります。
したがって、最初の配列を変更するには、3 つの変更が必要であると言えます。

これらの変更を反映するために DOM を更新する方法を考えてみましょう。

- 1 つの非効率的なこれらの変更は、DOM 全体を消去して再構築することです。

我々がもし、このUIを一度全て消して、内部のDOMを再構築する場合、5つのDOMを作成して新しく追加する必要があります。

これはとても遅いです。

- 代わりに、**もし既にあるDOMの中野文字列を置き換えるだけでしたら**

この場合は目標とするUIにもう少し早く近づきますね。

このような変更をReactDOMは可能にします。

新しい DOM 要素を挿入する必要がある場合、ReactDOM はそれらを挿入しますが、
DOM 挿入 (最もコストのかかる操作) を最小限に抑えるようにreactは調整します。

このスマートな DOM レンダリングは、React が妥当な量で動作するために必要です。
アプリケーションの状態が大きく変化するため、その状態を変えるたびに、UIを効率的に再レン​​ダリングするために ReactDOM.render に依存するのが賢い選択なのです。



## React.DOMの使い方

これまでのところ、要素を作成する唯一の方法は、React.createElement を使用することでした。

React 要素を作成する別の方法は、Factoryを使用することです。

- ReactのFactoryには、一般的にサポートされているすべてのHTMLおよびSVGDOM要素を構築する手法が用意されています。

- それだけでなく、React.createFactory 関数を使用して独自のファクトリを構築できます。

Factoryを使って、ulとliによるリストを作る例を見てみましょう。

```js
React.DOM.ul({"className": "ingredients"},
    React.DOM.li(null, "1 lb Salmon"),
    React.DOM.li(null, "1 cup Pine Nuts"),
    React.DOM.li(null, "2 cups Butter Lettuce"),
    React.DOM.li(null, "1 Yellow Squash"),
    React.DOM.li(null, "1/2 cup Olive Oil"),
    React.DOM.li(null, "3 cloves of Garlic")
)
```

この場合、最初の引数は属性用であり、一つ目はclassName属性を定義します。

追加の引数は、子の配列に追加される要素です。

このコードをデータとビューでさらに分離させると、次の様になります。

```js
var items = [
 "1 lb Salmon",
 "1 cup Pine Nuts",
 "2 cups Butter Lettuce",
 "1 Yellow Squash",
 "1/2 cup Olive Oil",
 "3 cloves of Garlic"
]

var list = React.DOM.ul({className: "ingredients" },
        items.map((ingredient, key) =>
            React.DOM.li({key}, ingredient))
)
ReactDOM.render(
    list,
    document.getElementById('react-container')
)
```


## ReactのFactoryの使い方

先ほどまでの例でデータのとロジックの分離まではできましたが、ロジックの再利用が出来ていません。

この「ロジックの再利用」の為には、関数化する必要があります。

React.createFactoryはそれを可能にします。

```js
const { render } = ReactDOM;
const IngredientsList = ({ list }) =>
    React.createElement('ul', null,
    list.map((ingredient, i) => 
        React.createElement('li', {key: i}, ingredient))
 )
const Ingredients = React.createFactory(IngredientsList)
const list = [
    "1 lb Salmon",
    "1 cup Pine Nuts",
    "2 cups Butter Lettuce",
    "1 Yellow Squash",
    "1/2 cup Olive Oil",
    "3 cloves of Garlic"
]
render(
    Ingredients({list}),
    document.getElementById('react-container')
)
```









## 備考

title:React最強のハンズオン

description:最強のエンジニアになるためのReact入門

filename:1500react_dom.md




