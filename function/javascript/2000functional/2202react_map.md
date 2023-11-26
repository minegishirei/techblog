








## javascriptのmapメソッド

今回はArray.mapです。
- **Array.map メソッドは関数を引数として取ります。**
- また、**配列内のすべての項目に対して 1 回呼び出され、それが返すものは何でも新しい配列に追加される** という特徴を持ちます。

### サンプルコード1: 全ての配列の文字を装飾

以下の場合、highSchoolsリストにある高校の名前は、`HighSchool`という文字列を末尾に付けるという動作をします。

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

### サンプルコード2: 配列から連想配列を生み出す

また、次の例では、「配列から連想配列を生み出す」というタスクをたった1行で完結させることができます。

```js
const schools = [
    "Yorktown",
    "Washington & Lee",
    "Wakefield"
]

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

const editName = (oldName, name, arr) => arr.map(item => (item.name === oldName) ?　({...item,name}) : item)

let updatedSchools = editName("Stratford", "HB Woodlawn", schools)
console.log( updatedSchools[1] ) 
// { name: "HB Woodlawn" }
console.log( schools[1] ) 
// { name: "Stratford" }
```

school 配列は、オブジェクトの配列です。 

updatedSchools変数はeditName関数を呼び出し結果を格納します。

関数の引数では、更新したい学校名、新しい学校名、最後に対象となる学校配列を取ります。



ちなみにこの関数は三項演算子を使うことでより短くなります。


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



## 実践例:Reactで配列からliタグ要素を作成する

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





title:mapの使い方【関数型プログラミングReact】

category_script:page_name.startswith("2")
