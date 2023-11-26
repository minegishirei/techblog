







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


category_script:page_name.startswith("2")





