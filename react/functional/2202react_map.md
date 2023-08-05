








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

category_script:page_name.startswith("2")
