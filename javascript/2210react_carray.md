








- [高階関数のメリット](#高階関数のメリット)
- [高階関数とは](#高階関数とは)
- [カリー化](#カリー化)
- [カリー化の例2](#カリー化の例2)
- [まとめ](#まとめ)
- [備考](#備考)



## 高階関数のメリット

他の関数を返す高階関数は、複雑な問題を処理するのに役立ちます。

例えば、JavaScript の非同期性に関連する関係では、関数を作成するのに役立ちます。



## 高階関数とは

高階関数を使うのも関数型プログラミングの重要な側面です。

高階関数については以前述べましたが、この章ではさらに多用します。

**高階関数は他の関数を操作できる関数です。関数を引数として受け取るか、関数を返すか、またはその両方を行います。**

実は、

- Array.map

- Arrya.filter

- Array.reduce

は全て関数を引数に取るので、高階関数と言えます。

ですが、これらの関数以外の高階関数を使いたい場面もたまにあります。

では実際に、高階関数を実装する方法を見てみましょう。


```js
const invokeIf = (condition, fnTrue, fnFalse) =>
 (condition) ? fnTrue() : fnFalse()
const showWelcome = () =>
 console.log("Welcome!!!")
const showUnauthorized = () =>
 console.log("Unauthorized!!!")
invokeIf(true, showWelcome, showUnauthorized) // "Welcome"
invokeIf(false, showWelcome, showUnauthorized) // "Unauthorized"
```

invokeIf は 2 つの関数を想定しています。

- 1 つは true 用で、

- もう 1 つは false 用です。

showWelcome と showUnauthorized の両方を invokeIf に送信し、

- コンディションがションが true の場合、showWelcome が呼び出されます。 

- false の場合、showUnauthorized が呼び出されます。


## カリー化

**カレーじゃないっつってんだろ！！！**


カリー化は、高階関数の使用を伴う関数型手法で、簡単に言うと**関数を返す関数です**


ここでのカリーとは

> 2他動
> 〔馬を〕馬ぐしですく［手入れする］
> 〔なめし革を〕仕上げ加工する

この意味

**だからカレーじゃないっつってんだろ！！！**


参考：https://qiita.com/Yametaro/items/99cc1c8ebcfc703b1410

実際の使用例では、以下のようなイメージになります。

```js
function tashizann(hikisu1) {
    return function(hikisu2){
        return hikisu1 + hikisu2;
    }
}

const kekka = tashizann(3)(5);
alert(kekka);


// 部分適応
const tasu3 = tashizann(3);

// 部分適応された関数を見てみる
const kekka2 = tasu3(5);
alert(kekka2);
// 8

const kekka3 = tasu3(7)
alert(kekka3)
// 10
```

ここではtasu3という関数を作り、いくらでも3を足し放題になるわけです。

このように、カリー化された関数から具体的な3を足すという関数を一部分だけ使うことを
**部分適応**と言います。



## カリー化の例2

実践的にはこんな感じになります。

userLogsはユーザー名とメッセージを引数に取るような、カリー化された高階関数です。

ここではlogという関数を“grandpa23”というユーザー名で**部分適応**して使っています。

```js
const userLogs = userName => message =>　console.log(`${userName} -> ${message}`)

const log = userLogs("grandpa23")

log("attempted to load 20 fake members")
getFakeMembers(20).then(
    members => log(`successfully loaded ${members.length} members`),
    error   => log("encountered an error loading members")
)
// grandpa23 -> attempted to load 20 fake members
// grandpa23 -> successfully loaded 20 members

// grandpa23 -> attempted to load 20 fake members
// grandpa23 -> encountered an error loading members
```



## まとめ

高階関数を書いて後悔！なんちゃって




## 備考

title:カリー化と高階関数【関数型プログラミングReact】



category_script:page_name.startswith("2")