







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



category_script:page_name.startswith("2")