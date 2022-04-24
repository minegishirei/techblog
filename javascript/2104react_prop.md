


## 前置き

今回の記事は以下の内容を参考にしています。

<a href="./2101react_build.md">
Docker + Reactを10分で環境構築する
</a>

Reactプロジェクトの初期フォルダーをみながら学習することでより理解が深まります。


## やりたいこと/目的

Reactのコンポーネント+Propについての理解を深めます。

そのために今回は 3ステップでプロジェクトに新規コンポーネントを追加した上で、propを追記していきます。


## 変更箇所

今回の変更箇所はわずか3点です。

- Componentフォルダー一個作成
- H2Componentファイル作成
- App.jsファイル2行追記

この三点でコンポーネント概念についての理解の充実とpropの有益性を理解してもらいます。


## No1.componentフォルダーを作る

componentフォルダーをsrcフォルダー配下に作成します。

(実際のところ場所はそこまで重要ではありません。)


## No2. H2component.jsxファイルを作る

componentフォルダー配下にH2component.jsxファイルを作り、以下の内容で記述します。

<pre><code>
import React from 'react';

function H2component (props) {
    return (<div><h2>{props.title}</h2><p>{props.description}</p></div>)
}

export default H2component;
</code></pre>



## No3. App.jsファイルを編集する

App.jsファイルを次のように編集してください。

<pre><code>
import logo from './logo.svg';
import './App.css';
import H2component from './components/H2component';
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
        <H2component 
        title={'Reactハンズオンラーニング 第2版 ―Webアプリケーション開発のベストプラクティス'} 
        description={'本書では実際に動くコンポーネントを作りながら、最新のReactの記法について解説しつつ、最新のツールやライブラリも紹介します。'}/>
        <H2component 
        title={'ハンズオンNode.j'} 
        description={'対象読者は、フロントエンド開発の知識はあってもサーバサイド開発は知らないエンジニアや、他言語の経験はあってもNode.jsは触ったことがないプログラマー。'}/>
        <H2component 
        title={'プログラミングTypeScript ―スケールするJavaScriptアプリケーション開発'} 
        description={'TypeScriptの型に関する基礎的な内容からその応用、エラー処理の手法、非同期プログラミング、各種フレームワークの利用法、既存のJavaScriptプロジェクトのTypeScript移行の方法まで、言語全般を総合的に解説します。'}/>
      </header>
    </div>
  );
}

export default App;
</code></pre>


## 実行

変更した後はサーバーに再度接続します。

次のように出れば編集成功です。

<pre><code>
 Reactハンズオンラーニング 第2版 ―Webアプリケーション開発のベストプラクティス
本書では実際に動くコンポーネントを作りながら、最新のReactの記法について解説しつつ、最新のツールやライブラリも紹介します。

 ハンズオンNode.j
対象読者は、フロントエンド開発の知識はあってもサーバサイド開発は知らないエンジニアや、他言語の経験はあってもNode.jsは触ったことがないプログラマー。

 プログラミングTypeScript ―スケールするJavaScriptアプリケーション開発
TypeScriptの型に関する基礎的な内容からその応用、エラー処理の手法、非同期プログラミング、各種フレームワークの利用法、既存のJavaScriptプロジェクトのTypeScript移行の方法まで、言語全般を総合的に解説します。
</code></pre>



## 備考

title:Reactのpropを理解するハンズオン【React学習サイト】

description:Reactのコンポーネント+Propについての理解を深めます。そのために今回は 3ステップでプロジェクトに新規コンポーネントを追加した上で、propを追記していきます。

img:https://i.stack.imgur.com/PXvBv.png

category_script:page_name.startswith("21")
