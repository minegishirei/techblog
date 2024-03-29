﻿


https://www.youtube.com/watch?v=p4oHHzqjRMg




Reactのことを何にもわかんない人がReactの保守運用を頼まれたときに見るべきもの


## 全体図

<img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/2279509/7dabcb44-1e4d-c91d-b1c9-94065fe9926e.gif">


## Redux

アプリ内のデータをまとめて一元管理することができるライブラリ。
`slice`という言葉が出てきたらほぼ間違いなく使用している。

```js
import { createSlice } from "@reduxjs/toolkit"
```

以下の3つを作ることができるのが、Sliceの特徴
- State(データのこと)
- Reducer(データを操作する関数のこと)
- ActionCreator

これらのデータは、すべてstoreに保存されている。
その辺はreduxjsがいい感じにしてくれているのが特徴。

```js
export const postSlice = createSlice({
    name: "posts", // sliceの名前
    initialState: {value: PostsData}, // stateの初期状態
    reducers: {
        // reducersの初期状態
        // 記事を投稿するための裏側の仕組み
        addPost:(state, action) => {
            // valueは配列
            // payloadはデータと読み替えていい
            state.value.push(action.payload)
        }
    }
})
```


#### export部分

exportの際には

- 「actions」だけをexportする場合と、
- postSlice.reducer本体をexportする場合

の2パターン用意している。

- 前者はUI部分から呼ばれたりするが、
- 後者は後程storeにぶち込まれる


```js
// 投稿用のreducerを
export const { addPost } = postSlice.actions;
// postSliceのreducerが本体。
export default postSlice.reducer;
```


## アプリ本体

```js
// サードパーティー製ライブラリ
import './App.css';
import { useSelector } from "react-redux" // hooksのuseSelectorを使用して、データにアクセスするために使用
import { useDispatch } from "react-redux" // useDispatchを使用して、データの更新処理をstore(state)に送る

// ユーザー定義の関数
import { addPost } from './features/Posts'; // 掲示板投稿するための関数
import { useState } from 'react';


function app() {

  // //////// 入力取得 //////////
  // ユーザーが入力したデータを保持しておくための関数
  // reduxを使っているのにusestateを使用していたら、それはonclickと結びつけるためだけの一時変数位に思っておくのでちょうどいい。
  const [name, setname] = usestate();
  const [content, setcontent] = usestate();

  // //////// 投稿一覧 //////////
  // useselectorを使用することで、どんなデータにもアクセスすることができる
  const postlist = useselector((state) => state.posts.value); // createsliceの中のnameを参照している。なので今回は、state.postsを使用している。
  // console.log(postlist) // データがみえるかどうか確認。

  const dispatch = usedispatch();

  // 投稿ボタン
  const handleclick= () => {
    // addpostはsliceのreducer。 アクションを返すことができる。
    const addpostaction = addpost({
      id: postlist.length,
      name: name,
      content: content
    })
    // 帰ってきたアクションを、dispatchでstoreに送る。
    dispatch(addpostaction)
    setname("")
    setcontent("")
  }
  return (
    <div classname="app">
      <div>
        <h1>
          react redux 掲示板
        </h1>
      </div>
      <div classname='addpost'>
        <input type='text' placeholder='お名前' onchange={(e) => setname(e.target.value)}></input>
        <input type='text' placeholder='投稿内容' onchange={(e)=> setcontent(e.target.value)}></input>
        <button onclick={() => handleclick()}>投稿</button>
        <hr />
      </div>
      <div classname='displayposts'>
        {postlist.map((post)=>(
          <div key={post.id} classname='post'>
            <h1>
              {post.name}
            </h1>
            <h1 classname='postcontent'>
              {post.content}
            </h1>
            <button>削除</button>
          </div>
        ))}
      </div>
    </div>
  );
}

export default App;
```



