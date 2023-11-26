








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


category_script:page_name.startswith("2")
