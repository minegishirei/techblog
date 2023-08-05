

変数は少ない方が読み手の負荷にかからないし、何よりコードは書かない方が良いです。

例えばpropsの変数valueが`undefined`のときは`不明`と表示させたいとき。
if文を使えば以下のように容易に処理ができます。

```js
const label = (props) => {
    let value = props.value;
    if (value === undefined) {
        value = "不明"
    }
    
    return (<>
        <p>{value}</p>
    </>)
}
```

機能としてはこれでも十分かもしれませんが、以下の点が改善できそうです。

- `let`で宣言した変数`value`が冗長に見える
- やりたい処理の割には長いように感じる

**三項演算子を使えば変数も手続き処理も不要になります。**

```js
const label = (props) => {
    return (<>
        <p>{(props.value !== undefined) ? props.value : "不明"}</p>
    </>)
}
```
`{}`で囲ったvalueを表示させる処理は以下のようになります。

- props.valueが`undefined`出なければ想定通りprops.valueを表示
- それ以外は"不明"と表示

三項演算子は**デフォルトの処理だと一つ目の値が適応される**と直感的にわかる点も良いですね。













