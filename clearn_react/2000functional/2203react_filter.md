



## Array.filterは配列の条件に一致するものを選択する

一文字目が「W」で始まる関数を探したいとします。

このタスクでは **「配列の条件に一致する要素を抜き出す」** という点がタスクとなります。

```js
const schools = [
    "Yorktown",
    "Washington & Lee",
    "Wakefield"
]

const wSchools = schools.filter(school => school[0] === "W")
console.log( wSchools )
// ["Washington & Lee", "Wakefield"]
```


## filterメソッドで条件に一致しない物をはじく


```js
const schools = [
    "Yorktown",
    "Washington & Lee",
    "Wakefield"
]

const cutSchool = (cut, list) => list.filter(school => school !== cut)

console.log(cutSchool("Washington & Lee", schools).join(" * "))
// "Yorktown * Wakefield"

console.log(schools.join("\n"))
// Yorktown
// Washington & Lee
// Wakefield
```

この場合、cutSchool 関数を使用して、「ワシントンとリー」と一致するものを排除しています。

cutSchoolは純粋関数です。

1. 学校のリストと削除する学校の名前を引数として取り、

2. その特定の学校以外での新しい配列を返します




title:filterの使い方【関数型プログラミングReact】

category_script:page_name.startswith("2")