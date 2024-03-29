


# Vimの魅力とそのランキング

Vimの魅力はなんといっても**シンプルなコマンドによる高速で複雑で自動的な編集**です。

Vimでは少量のコマンドを変幻自在に組み合わせることで、あたかも魔法を扱う様に編集ができます。(個人の考えでは**Vimマスターのコツは格ゲーと同じ**だと思っているぐらいです。)※

そんなコマンドたちですが、どれ一つとして同じものがない以上、当然使われる頻度が異なります。

本記事の目的はそんな優秀なコマンドたちを格付けして、優先して学習するべきコマンドの知名度を上げ、Vimmerの人口を少しでも増やす試みです。

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1678228/8a5be5a6-0e95-91ca-c606-b240b7284aac.png)



※以下参照

https://qiita.com/kawadasatoshi/items/507a10a3f6a9e83b5576


# 格付けランキングに対する注釈

- 統計データなんてものはありません。

- 全部独断と偏見です。

- 多少炎上するリスクはあると思いますが、優先順位を付けることはエンジニアリングを学習する際の価値に繋がると思います。

- 筆者はVimを始めたばかりで達者なVimmerの皆さんから見ればまだまだひよっこです。

- ですので「こんなコマンドの方が便利だよ！」というのがあれば是非教えていただければ幸いです。


# 前提条件

- CtrlとShiftは小指で操作する。

- jjとｊｊはEscにバインドしておく。


以下Vscodeのsetting.json
例えば、uは

```json
{
    "sshfs.configs": [
        {
            "name": "instock",
            "privateKeyPath": "C:\\Users\\MINEGISHIREI\\my-keypair.pem",
            "username": "ec2-user",
            "host": "35.73.151.54"
        }
    ],
    "files.encoding": "utf8bom",
    "editor.unicodeHighlight.nonBasicASCII": false,
    "editor.unicodeHighlight.invisibleCharacters": false,
    "workbench.editorAssociations": {
        "*.zip": "default"
    },
    "workbench.colorTheme": "Default Dark+",
    "security.workspace.trust.untrustedFiles": "open",
    "vim.useSystemClipboard": true,
    "vim.insertModeKeyBindings": [
        {
            "before": ["j", "j"],
            "after": ["<Esc>"]
        }, 
        {
            "before": ["ｊ", "ｊ"],
            "after": ["<Esc>"]
        }
    ],
    "vim.hlsearch": true
}
```


# 全Vimコマンド入場

## (★★★★★)Sランクコマンド（常に使う）

- Undo : `u`

編集でひとつ前の状態に戻すことができます。

初心者でもプロでも、キーの押し間違いで編集してしまうことが発生します。
その失敗をなかったときにできるこのコマンドは非常に優秀です。

- 編集モードからデフォルトモードに切り替え保存する : `jj:w`

編集が終わった時の（エンター & Ctrl+S）並みには使います。
編集中の内容はサーバーがこけたときに消えてしまうことがあるのでこまめに保存しましょう。

余談ですがEscキーはとても遠いので`jj`にバインディングすることをお勧めします。

> ???「どこへ行っていたンだッ エスケープッッ 俺達は君を待っていたッッッ 」

- 上下左右移動 : `hjkl`

息をする様に移動できればマスターした証。移動は格ゲーの基本。

- 末尾に追記:`A`

自分の場合は末尾への移動でも使っています。
(`Ajj`でデフォルトモードのまま末尾に移動することができる)


## (★★★★☆)Aランクコマンド（編集の時に使う）

- ファイルの末尾と先頭に移動する : `gg`と`G`

- 文字列検索: `/[searchword][Enter]`からの`n`

- 現在のカーソルを画面中心に移動する : `zz`

-

- ファイルを一行カットする：`dd`

- ファイルを一行コピーする：`yy`

- ペーストする：`p`

-

- 一文字の末尾に追記：`a`

- 現在のカーソルの前に追記:`0i`

- 先頭に文字列挿入:`I`


## (★★★☆☆)Bランクコマンド（以外と使いどころが限られる）

- 前方向：`Ctrl+f`

- 後方向：`Ctrl+b`

- 画面の上中下に移動：`HML`

この3つはよくセットで使います。（ソースコードを眺めるように読む時など）

- 段落ごとの移動を行う : `{`

- 段落ごとの移動を行う : `}`

- 一単語文だけ移動する : `b`と`w`

この三つはトリッキーな移動です。日本語の文章の編集でもまれに登場します。

- 行数指定して移動：`:[行数]`

かなり使えそうなコマンドだが、`zz`でカーソルが画面の中心に移動することを考えると
以外と使いどころが限られる。

- 一文字の置換 : `r[一単語]`

- 空行を挿入する：`ojj`


## (★★☆☆☆)Cランクコマンド

今のところはまだない。

## (★☆☆☆☆)Dランクコマンド


- $　：末尾まで移動する。

たかが末尾まで移動するのに、Shiftと4同時押しはしんどい。
Aで十分(左手の小指と薬指だけで完結するので、を動かす必要がない)

- マーキング : `m[a-z]`

- マーキング先に移動 : `[a-z]`

この二つは一見便利に見えるが、実践ではあまり使わない。
問題点は**マーキングする手間が面倒**なのと、**マーキングした場所とアルファベットをいちいち覚えなければならないコスト**が発生すること。

それをやるぐらいなら行数を覚えておいて`:[行数]`で移動した方が早い。

- 行内部ジャンプ:`f(アルファベット一文字)`

私が日本人じゃなかったらトップオブトップでした。
日本語とこのコマンドの相性ははっきり言って最悪です。

英語を母国語とする地域であればfの後にローマ字を入れるだけでジャンプできるのですが、
**日本語が主体となる我が国日本ではfを押した後に半角全角を押さなければなりません！**

逆に、ソースコードを編集する際では最強のコマンドかもしれません。


# その他

## 空いているキーコマンド

どんなプログラミング言語でも、同じ単語を二連続で挿入する場面はあまりない。

`jj`コマンドに対してEscキーをバインディングしてモードの切り替えを素早くしたように、空いているキーバインドを有効活用して編集を効率化する可能背はある。

- Insertモードの「hh」「kk」「ll」(jjは既に埋められている）


# Vimコマンド練習メニュー

- A, jj, 0を繰り返す。

- hh jj kk llを繰り返す。

- Ctrl+f, Ctrl+b, Ctrl+u, Ctrl+dを繰り返す。

- /[searchword]を打つ。

- Aを打つ


# 備考

title:よく使うVimのコマンドランキング

description:Vimでは少量のコマンドを変幻自在に組み合わせることで、あたかも魔法を扱う様に編集ができます。例えば、Undo : uは編集でひとつ前の状態に戻すことができます。

img:https://m.media-amazon.com/images/I/419SM7TDHZL.jpg

category_script:True



