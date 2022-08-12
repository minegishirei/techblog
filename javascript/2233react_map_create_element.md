









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


category_script:page_name.startswith("2")
