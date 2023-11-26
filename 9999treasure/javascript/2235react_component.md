






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

category_script:page_name.startswith("2")



