







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




