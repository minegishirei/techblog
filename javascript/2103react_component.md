

## 前置き

今回の記事は以下の内容を参考にしています。

<a href="./2101react_build.md">
Docker + Reactを10分で環境構築する
</a>

Reactプロジェクトの初期フォルダーをみながら学習することでより理解が深まります。


## やりたいこと

Reactのコンポーネントに触れてみてReactのコンポーネントを理解します。

そのために今回は 3ステップでプロジェクトに新規コンポーネントを追加します


## 変更箇所

今回の変更箇所はわずか3点です。

- Componentフォルダー一個作成
- H2Componentファイル作成
- App.jsファイル2行追記

この三点でコンポーネント概念と追加を理解してもらいます。


## No1.componentフォルダーを作る

componentフォルダーをsrcフォルダー配下に作成します。

(実際のところ場所はそこまで重要ではありません。)


## No2.H2component.jsxファイルを作る

H2component.jsxファイルを作り、以下の内容で記述します。

（注意！：このファイル名は小文字でも問題ないですが、functionとして定義するプログラム上のコンポーメント名は**大文字から始まらなければなりません**
)

関数名のH2componentは名前を自由に変えてもいいですが、小文字は避けてください。

``` { .html }
import React from 'react';

function H2component (props) {
    return <h2>this is test</h2>
}

export default H2component;
```

## No3. App.jsで2行追加する

以下のソースのように、src/App.jsへ二行追加します。

一行目はimport宣言句に

``` { .html }
import H2component from './components/H2component'; //--No1. 追加して欲しい箇所
```

もう一行は「Learn React」の後に

``` { .html }
<H2component /> //--No2. 追加して欲しい箇所
```

完成図は以下の通り。

``` { .html }
import logo from './logo.svg';
import './App.css';
import H2component from './components/H2component'; //--No1. 追加して欲しい箇所
import React from 'react';
function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
        <H2component /><H2component /><H2component /> //--No2. 追加して欲しい箇所
      </header>
    </div>
  );
}
export default App;
```


## No4. 完成

これまでの変更を行なった後に、再度ウェブブラウザからサイトにアクセスしてみましょう。

URL：http://localhost:3000/index.html

そうすると「this is test」と三つ連続で大文字で書かれたサイトになるはずです。

これまでの実験でreactのコンポーネントの概念を理解できたと思います。



## 次回

次回はコンポーネントの値を自由に書き換えるためのpropsについて説明します。

<a href="./2104react_prop.md">
propとコンポーネントについての説明
</a>



## 備考

title:Reactのコンポーネントを追加する【React学習サイト】

description:Reactのコンポーネントに触れてみてReactのコンポーネントを理解します。そのために今回は 3ステップでプロジェクトに新規コンポーネントを追加します

img:https://i.stack.imgur.com/PXvBv.png

category_script:page_name.startswith("21")


