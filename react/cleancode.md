


## 辞書は頻繁に使うべし

```jsx
// NG
switch (user.type) {
  case user:
    return <User />;
  case admin:
    return <AdminUser />;
  case host:
    return <HostUser />;
}

// Good🥴
const userView = {
  user: <User />,
  admin: <AdminUser />,
  host: <HostUser />,
};

return userView[user.type];
```

from https://qiita.com/JNJDUNK/items/e040925e546a45a1d913#7-%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E3%81%AF%E4%BD%BF%E3%81%84%E3%81%93%E3%81%AA%E3%81%9B%E3%81%A6%E3%81%84%E3%82%8B%E3%81%8B

<iframe width="560" height="315" src="https://www.youtube.com/embed/Un0aoW0kNeE?start=374" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>



## カリー化はマスターすべし

例えばAPIを呼び出す関数を書くとき。
以下のように感じに書くこともできます。

```js
const base_url = "https://example.com"
const async callAPI = (endpoint="normal",count=10, q="Excel") => {
  const url = `${base_url}/${endpoint}?q=${q}&count=${count}`
  const response = await fetch(url)
  return response.json()
}
```

ですが、urlを切り替えたいときに`base_url`を変更するのはなんだか癪ですよね。
そこで別の選択肢として**カリー化**を使ってみましょう。


```js
// カリー化
const async curreyCallAPI = (base_url = "https://example.com") => {
  return (endpoint="normal",count=10, q="Excel") => {
    const url = `${base_url}/${endpoint}?q=${q}&count=${count}`
    const response = await fetch(url)
    return response.json()
  }
}

// 適応
if is_dev === true:
    const callAPIDokomo  = curreyCallAPI("https://dokomo.com")
else:
    const callAPI        = curreyCallAPI()

```

このようにカリー化を使用することで以下の二つのメリットがあります。

- **中身の処理が似ているが微妙に内容が異なる処理の重複を防ぐ**
- **関数の中身の決定を遅らせる**





## ディレクトリ構成について

Reactには様々なディレクトリ構成のパターンがある。
以前流行したのは**Atomic Design**というやつだ。
これは画面の構成要素である「ボタン」や「フォーム」などを**分割不可能な構成要素**としたうえでこれらの組み合わせで画面を作るという物だ。

しかし以下の記事のように、「Atomic Designをやめた」という話もあるので完全に定着したという物でもない。
デファクトスタンダードは存在しなさそうだ。



### ページごとに完全に区切りケース

次のgithubリポジトリはページごとにディレクトリを区切っている。

from https://github.com/soumyajit4419/Portfolio/tree/master/src/components

今回の例だと以下の通り。

```sh
C:.components
│  Footer.js
│  Navbar.js
│  Particle.js
│  Pre.js
│  ScrollToTop.js
│
├─About
│      About.js
│      AboutCard.js
│      Github.js
│      Techstack.js
│      Toolstack.js
│
├─Home
│      Home.js
│      Home2.js
│      Type.js
│
├─Projects
│      ProjectCards.js
│      Projects.js
│
└─Resume
        ResumeNew.js
```

以下のような規則でコンポーネントを構成する。

- 第一階層
  - ページの名前
  - すべてのページで使用する共通コンポーネント
- 第二階層（ページの中身）
  - 本体（ページ.js）
  - ページを構成するコンポーネント

そのほかだと次のリポジトリがある。

from https://github.com/heysafronov/square-react-dashboard/tree/master/src

#### ページによるディレクトリ構成のメリットとデメリット

- デメリット
  - 再利用性が低いこと。（ページで重複するコードが出現する）
  - ディレクトリを開いたときに本体ではなく共通部分が見えてしまうこと。
  - データの受け渡し方法は不明
- メリット
  - 多様性が完全にサポートできること。（個々の部分は再利用性とトレードオフ）




## bulletproof-react（銀の弾丸）

reactにおける「ディレクトリ構成はこうあるべきだ」という構成論を持つディレクトリ。

from https://github.com/alan2207/bulletproof-react/tree/master/src

```sh
src
|
+-- assets            # assets folder can contain all the static files such as images, fonts, etc.
|
+-- components        # shared components used across the entire application
|
+-- config            # all the global configuration, env variables etc. get exported from here and used in the app
|
+-- features          # feature based modules
|
+-- hooks             # shared hooks used across the entire application
|
+-- lib               # re-exporting different libraries preconfigured for the application
|
+-- providers         # all of the application providers
|
+-- routes            # routes configuration
|
+-- stores            # global state stores
|
+-- test              # test utilities and mock server
|
+-- types             # base types used across the application
|
+-- utils             # shared utility functions
```

簡単なアプリケーションだと冗長すぎるが名前の付け方などが参考になった。



## Atomic Design

次のディレクトリはアトミックデザインである。

from https://github.com/creativetimofficial/notus-nextjs/tree/main/components

コンポーネントの配下には画面を構成する様々な要素が用意されており、
分割可能かどうかの調整が見える。

```sh
C:.components
├─Cards
│      CardBarChart.js
│      CardLineChart.js
│      CardPageVisits.js
│      CardProfile.js
│      CardSettings.js
│      CardSocialTraffic.js
│      CardStats.js
│      CardTable.js
│
├─Dropdowns
│      IndexDropdown.js
│      NotificationDropdown.js
│      PagesDropdown.js
│      TableDropdown.js
│      UserDropdown.js
│
├─Footers
│      Footer.js
│      FooterAdmin.js
│      FooterSmall.js
│
├─Headers
│      HeaderStats.js
│
├─Maps
│      MapExample.js
│
├─Navbars
│      AdminNavbar.js
│      AuthNavbar.js
│      IndexNavbar.js
│
├─PageChange
│      PageChange.js
│
└─Sidebar
        Sidebar.js
```













