


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

```jsx
// 純粋コンポーネントちゃん
const MyButton = (props, { text }) => (
  <Button className="app-component" onClick={props.onClick}>
    {text}
  </Button>
);

// 純粋関数ちゃんたち
const addCount = state => { ...state, count : state.count+1 }
const subCount = state => { ...state, count : state.count-1 }

// 副作用マシマシコード
const App = () => {
    const [state, setState] = useState({count:0});
    const onClickCountUpButton =    () => {setState(addCount(state))}
    const onClickCountDownButton =  () => {setState(subCount(state))}
    return (<>
        <MyButton onClick={onClickCountUpButton}>   {count} +1 </MyButton>
        <MyButton onClick={onClickCountDownButton}> {count} -1 </MyButton>
    </>)
}
```

純粋でないと思うコンポーネントは以下の通り

`onClick`の中にある`setCount`はStateを変化させてしまっているため、副作用がある。
ここでの`state`は親要素のcountであり、グローバル変数を書き換えていると言っても過言ではない。

```jsx
const MyButton = (props, { text }) => (
  <Button className="app-component" onClick={props.setCount(props.count + 1)}>
    {text}
  </Button>
);
```

ちなみに、一つのコンポーネント内部で閉じた`state`であれば、純粋なコンポーネントとして考えて良い。









# 課題3 : 

stateを管理する純粋な関数は以下の通り


```jsx
const update(){

}
```














