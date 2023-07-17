

## linux上のターミナルで使えるショートカット一覧

### 有名どころ

- `Ctrl + A` : 先頭への移動
- `Ctrl + E` : 末尾への移動
- `Ctrl + R` : 過去のコマンド入力の履歴を遡る

https://qiita.com/DogK0625/items/16535e6732ec3ba238c2


### 次に使うもの

- `Ctrl + K` : カーソルから右の文字を全て消す。
    - 使い所 : `Ctrl + R`で過去のコマンドを遡った後、オプションを変更するときに特定の位置から末尾までの削除する
- `Ctrl + B` : 左にカーソルを移動させる
    - 使い所 : `Ctrl + K`でオプションを変更するためにカーソルを移動させるなど。



## コマンドラインの実行結果をコピーする:`pbcopy`

パイプラインを使用して`pbcopy`に渡すことでコピーする。

```sh
cat hoge.txt | pbcopy
```

from https://qiita.com/Kzno/items/6f2fa98256bdffb0fd43

























