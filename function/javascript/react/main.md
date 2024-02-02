


# 現時点でのReactの課題

- webサイトというドメイン領域上、副作用が多い
    - stateの参照、変更が多すぎる。管理ができない。

対策 : 純粋関数を増やす + stateを引数に入れる + 辞書をまとめて変更する

update関数 : state -> state




# 課題2 : コンポーネントを返す関数と、stateを管理する関数が同じ場所に書かれる


コンポーネントを構成する純粋な関数は、以下の通り

```jsx
const App = ({ text }) => (
  <div className="app-component">
    {text}
  </div>
);
```






