

## 前置き

今回の記事は以下の内容を参考にしています。

<a href="./2101react_build.md">
Docker + Reactを10分で環境構築する
</a>

Reactプロジェクトの初期フォルダーをみながら学習することでより理解が深まります。


## やりたいこと

今回の記事ではApp.jsについて触れていきます。

App.jsで行なっている処理は具体的には何を行なっているのか。

通常のJavascriptとの相違点とJSXと違う内容について



## Reactのトップレベル

Reactをいじるときのトップレベルのソースは

**「./src/App.js」です**

ソースファイルを見てみると、通常のJavascriptとは異なる点が何点か存在します。

<pre><code>
src/App.js)

import logo from './logo.svg'; # --- 気になる点No.1
import './App.css';

function App() {
  return (
    ```<div className="App"> # -- 気になる点No.2
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
          Hello world and this is start your React Life. its my life
        </a>
      </header>
    </div>
    ```
  );
}

export default App;  # -- 気になる点No.3
</code></pre>

それぞれ順に見ていきます。


## Reactのimport構文

気になる点No.1は「Reactのimport構文」です。

Node.jsにはimport構文は存在してましたが、あくまで他のJavascriptファイルのことでした。

今回読み込むファイルは同じフォルダー配下に存在する「logo.svg」です

<pre><code>
import logo from './logo.svg';
</code></pre>

.svgは描画用のファイル拡張子でJavascriptファイルではないです。

ここで行っているのは **「./logo.svg」という文字列を「logo」という変数に当てはめている** という作業を行なっています。

このlogo変数はのちのコードで次のように使われています。

<pre><code>
<img src={logo} className="App-logo" alt="logo" />
</code></pre>

{}で括ることで変数として扱うことができます。

ここの部分は生のJavaScriptとは違う点です。


## javascriptにhtmlが書き込まれている

気になる点二つ目はJavascriptファイル内にHtmlそのものが生で書き込まれていることです。

この書き方はJSXと呼ばれる書き方でJavaScript XMLを略してJSXと呼ばれています。

HTMLよく似た構文であるXMLをJavascriptにそのまま書き込めることでhtmlのjavascriptによる操作をより直感的に行えているわけです。

<pre><code>
function App() {
  return (
    <div className="App"> # -- 気になる点No.2
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
          Hello world and this is start your React Life. its my life
        </a>
      </header>
    </div>
  );
}
</code></pre>


## ファイルを書き換えてみる

せっかくなのでApp.jsを書き換えて見ます。

「--追加部分!!!」に対して好きな文字列を付け加えてみましょう。

ページ中央にあるリンク文字列が更新されるはずです。

`
import logo from './logo.svg';
import './App.css';

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
          Learn React.   --追加部分!!!。 this is change area
        </a>
      </header>
    </div>
  );
}

export default App;
`



## 「export default」とは何か

最後にファイル配下のコード「export default App」について解説します。

このコードではファイル内で定義した変数やクラスを外部でも使えるようにしています。

実際に「index.js」をみてみますと、上から4行目にはAppファイルをimportしているのが見えます。

<pre><code>
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';  ## -- 読み込み部分
import reportWebVitals from './reportWebVitals';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
</code></pre>

App.jsで定義したAppクラスをexport文で外部利用可能にし、

index.jsがimport文によってそのクラスを利用しています。



## 次回

Reactのコンポーネントに触れてみてReactのコンポーネントを理解します。

そのために今回は 3ステップでプロジェクトに新規コンポーネントを追加します

<a href="./2103react_component.md">
コンポーネントについての説明
</a>





title:React App.jsについて【React入門】

description:今回の記事ではApp.jsについて触れていきます。App.jsで行なっている処理は具体的には何を行なっているのか。通常のJavascriptとの相違点とJSXと違う内容について実際のファイルシステムをみながらの解説です。

img:https://i.stack.imgur.com/PXvBv.png

category_script:page_name.startswith("21")


