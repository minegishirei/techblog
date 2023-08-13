



vim体操


## まずは上下の運動から〜

```sh
jjkkjjkk
```

## 次に左右の運動〜

```sh
hhhhlllllhhhhhllll
```

## 行間の移動

`S`コマンドで行レベルの置換（外部のファイルの読み込み、コピペ実施


## 行の移動

- `0`で先頭に移動。
- `$`で先頭に移動。

`0$0$0$0$0$0$0$0$0$0$0$0$`


## 移動履歴を辿る移動

- `Ctrl+o`
- `Ctrl+i`

これらのコマンドはファイルを跨いだ移動履歴の追跡にも使える。


## バッファ

- `"1p`:一個前のバッファをペーストする。
- `"2p`:2個まえのバッファをペーストする。

## 名前つきバッファ

`y`,`d`,などのバッファへ格納する際には、名前をつけることができる。

例えば、"o"という名前をつけたい場合は

- `"odd`:と入力することで`"op`,で再度呼び出し可能。

以下のようにして記憶する。

- 「この行はどこかで再利用するな〜」と思ったら`"ddd`とした後、復活させる時に,`"dp`で呼び起こす。


## `mx`:マークを付ける

- `mx`:でマークを付けることができる
- 対象に戻るためには`xを入力することで移動することができる


## インデント整理:`gg=G`

vscodeなどインデント整理をデフォルトでサポートしているエディターでは`gg=G`を打つことで
インデントの整形が可能である。



## 他のファイルを開く

- `Ctrl+P`コマンドパレットを開く。


## Exploreへ移動

- `Shift+Ctrl+E`でエクスプローラーへ移動

## git push

- `Ctrl+Shift+P`
- `push`


## 垂直複数選択

- `Ctrl+V`



