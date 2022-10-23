



# 関数型の方が給料が高い?

私事ですがこのようなサイトを運営しています。

簡単にいうと、 **プログラミング言語を年収や求人数別で番付したものです。**

https://flamevalue.short-tips.info/

このサイトを運営してく中で気づいたことですが、全体的に関数型が書ける言語の方がオブジェクト指向型の言語よりも収入が高い気がしてます。（異論は認める）

そうでなくても、何かと話題になる関数型を知っておいて損はないと思うのです。

備忘録も兼ねて、関数型の議論が始まった時に会話に参加できるよう、概要だけでも記述しようかと思います。



# 関数型四天王とメリット

関数型というとlispの次のようなコードを思い出す人もいると思います。

```lisp
(if hoge (progn
          (setq hoge 1)
          (setq fuga 2))
         (progn
           (setq hoge 0)
           (setq fuga 1)))
```

...いや読めねぇよ！ってなるのがほとんどだと思いますが、これが関数型の全てだとは思っていないです。

むしろ関数型には次の４つの関数を抑えておけばなんとかなるとすら思ってます。

- join

- filter

- reduce

- map

これら4つの言語は簡単にいうと、配列に対する処理を全て関数で行い、**for文や変数をコードから抹殺するために存在する**と思ってます。

例えば、配列comment_listの全ての値を文字列にして「。」で繋げたいと思った時に、あなたならどうするでしょう?

```js
var comment_str = ""
for(var i in comment_list){
    comment_str += comment_list[i]
}
console.log(comment_str)
```

for文を使うと4行かかりましたね(console.logは除く)

こいつを関数型で再現するとどうなるでしょう？

```js
console.log( comment_list.join("。") )
```

**はい、一行で終わりました。**

これはかなり極端な例ではありますが、for文や変数を駆使してコードを書いていたときよりも、だいぶスッキリしますね。

これがコードの一部分だけなら効果は薄いと思いますが、関数型がソースコード全体に普及するとどうでしょう。
例えば、オブジェクト指向で書かれたソースコードが10ファイル分に及ぶソフトウェアがあり、あなたがそれを任されたとしましょう。
おそらく取り組むまでのハードルはかなり高いはずです。
それが3ファイルまで縮小するとどうでしょうか？
少なくとも読んでみようかなという気持ちが湧き上がってくるのではないでしょうか？

それでは実際にあなたのソースコードを凝縮してくれる奴らを紹介しましょう。


![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1678228/faedb5f7-221e-d51f-ccdc-4504d38c26b8.png)

※左からjoin,filter,reduce,map

https://www.nikkei.com/article/DGXMZO58584120Y0A420C2AA1P00/



## join：連結させたいならこいつ！

先ほども紹介した通りです。

配列から文字列を結合したいときに使用します。

### 具体例

こんな長かったコードが

```js
var comment_str = ""
for(var i in comment_list){
    comment_str += comment_list[i]
}
console.log(comment_str)
```

こんなになりました

```js
console.log( comment_list.join("。") )
```

### 使い方

```js
配列.join("ツナギ")
```

## filter:絞り込みたいならこいつ！

filterは**配列の要素を特定の条件を満たした要素に限定します。**

例えば、「comment_listの要素を星が5だけの配列に絞り込みたい」などです。

### 具体的

comment_listの仕様を、星とコメントがついた連想配列とします。

```js
comment_list - [
    {memo:"炭酸抜きコーラ. たいしたものですね！",star : 5},
    {memo:"強くなりたくば、喰らえ",star : 1},
    {memo:"わたしは一向にかまわんッッ！",star : 5}
]
```

comment_listの星が5のコメントだけの配列に直したいとします。

通常の手続き型言語であれば次のように書きますね。

```js
var new_comment_list = []
for(comment in comment_list){
    if(comment.star == 5 ){
        new_comment_list.push(comment)
    }
}
```
これを、filterを用いて書き直すとどうでしょうか？

```js
var new_comment_list = comment_list.filter(function(row){return row.star == 5})
```

**これもなんと一行に収まりました**

### 使い方

```js
配列.filter(function(row){return 条件式 })
```


## reduce:集約したいならこいつ!

reduceは、配列からある値を作り出すことを目的とします。

具体的には、平均値、合計値などなど...

### 具体例

例えばcomment_listからstarの合計を算出したいと考えたとします。

for文と変数を使うとこの通りですね。

```js
var sum = 0
for(row in comment_list){
    sum += 0   
}
```

**関数型を使えば、またしても一行に収まります。**

```js
const sum = comment_list.reduce(function(row, value){row.star + value},0)
```

## 使い方

reduceは他3つと比べると癖があります。

そのクセは

- 初期値を持つこと

- 保持する値があること

この二点です。

**特に、保持する値は関数の二番目に指定することを忘れないでください！**

```js
配列.reduce(function(要素, 保持している値){新しい値},初期値)
```


## map:刷新したいならこいつ!

mapは「新しい配列を生み出す」ことに優れています。

例えば、連想配列から特定の要素の配列を作りたい時など。



### 具体例

comment_listから、starだけの配列を作りたい場合。

```js
stars = []
for(comment in comment_list){
    stars.push(comment.star)
}
```

ここでも4行ほどかかってしまいますが関数型だと

```js
stars　= comment_list.map(function(row){return row.star})
```

一行に収まりましたね。

### 使用方法

```js
配列.map(function(要素){return 新しい要素})
```




# まとめ

関数型でメインとなる4つの関数を紹介しました。

これらをまとめて扱うことで、開発者の多様なニーズに応えることができます！


## 備考

title:関数型プログラミングを5分でマスターする

description:関数型には次の４つの関数を抑えておけばなんとかなるとすら思ってます。 join, filter, reduce, map

img:https://blogimg.goo.ne.jp/user_image/04/96/56d5d7527370ab694f6caa87144df21e.png

category_script:True

