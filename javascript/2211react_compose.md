










- [コンポジション](#コンポジション)
- [連鎖その1：replaceメソッド](#連鎖その1replaceメソッド)
- [連鎖その2：composeメソッド](#連鎖その2composeメソッド)
- [composeメソッドの実装方法](#composeメソッドの実装方法)
- [備考](#備考)


## コンポジション

関数型プログラムは、ロジックを焦点を特定のタスクについて絞った小さな純粋な関数に分割し、最終的にはこれらの小さな関数をまとめる必要があります。

具体的には、それらを組み合わせたり、直列または並列で呼び出したり、最終的にアプリケーションが完成するまで、それらをより大きな関数にポーズします。

コンポジションに関しては、さまざまな実装テクニックがあります。

よく知られていることの 1 つは**連鎖**です。

**JavaScript では、ドット表記を使用して関数を連鎖させて、関数の戻り値に作用させることができます。**


## 連鎖その1：replaceメソッド

文字列には置換するメソッドがあります。 

文字列.replaceメソッドはテンプレート文字列を返します

ですので、replace メソッドを連鎖させるような使い方も可能です。

```js
const template = "hh:mm:ss tt"
const clockTime = template.replace("hh", "03")
    .replace("mm", "33")
    .replace("ss", "33")
    .replace("tt", "PM")
console.log(clockTime)
// "03:33:33 PM"
```

この例で変数templateは文字列です

replace メソッドを最後までチェーンすることにより、時間、分、秒、および時刻を置き換えることができます

このように、連鎖は合成テクニックの 1 つですが、他にもあります。


## 連鎖その2：composeメソッド

composeメソッドの目的は「より単純な関数を組み合わせて、より高次の関数を生成する」ことです。

まずcomposeメソッドを使わない例ですが、

```js
const both = date => appendAMPM(civilianHours(date))
```

このように、関数を入れ子にして実行してます。

ところが、これらの関数は日本語で言えば入れ子というより**連鎖**に近いです。

**そしてその「連鎖」をより直感的に表す記法があります。comopseメソッドです。**

```js
const both = compose(
 civilianHours,
 appendAMPM
)
both(new Date())
```

このアプローチははるかに優れています。

特に、**機能を任意の時点で追加できるのでスケールしやすいという点が最高です。**

このアプローチにより、composeの引数の順序を簡単に変更できます。


## composeメソッドの実装方法

ちなみにcomposeメソッドは次のようにして実装できる、後悔関数です。

```js
const compose = (...fns) => (arg) => fns.reduce((composed, f) => f(composed), arg) 
```

これは、コンポジションを説明するために設計されたcompose関数の簡単な例です。

copmpose関数は、より多くの処理を行うときになるとより複雑になります。

例えば、1つ以上の引数を指定したり、関数ではない引数を処理したりなどです。



## 備考

title:javascriptのcomposeメソッドの作り方

description:ちなみにcomposeメソッドは次のようにして実装できる、後悔関数です。const compose = (...fns) => (arg) => fns.reduce((composed, f) => f(composed), arg) 



category_script:page_name.startswith("2")