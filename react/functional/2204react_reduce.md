




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





category_script:page_name.startswith("2")