


- [cloud9に劣る点](#cloud9に劣る点)
  - [AWS Lambdaとの連携が難しい(ネイティブのvscodeからでないと連携ができない)](#aws-lambdaとの連携が難しいネイティブのvscodeからでないと連携ができない)
- [cloud9に勝る点](#cloud9に勝る点)
  - [「編集したい→エディタを開く」までが早い](#編集したいエディタを開くまでが早い)
  - [参考](#参考)


## Vscode onlineとは？

名前の通り、vscodeがクラウド上に埋め込まれたもの。

クラウド上での保存の選択肢は

- Github

- Azure

の選択肢が存在する。



## インストールどころかアカウントもいらない:

from https://forest.watch.impress.co.jp/docs/news/1360147.html

<img src="https://asset.watch.impress.co.jp/img/wf/docs/1360/147/image1_l.jpg">

「vscode.dev」へアクセスするだけで「Visual Studio Code」が完全に動作する。：インストールどころかアカウントもいらない

**とりあえず次のリンクをクリックして、アクセスすることをおすすめします**

https://vscode.dev/

自分の場合は、次のようなエディターが出現した。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/provider/vscode/vscode_online.png?raw=true">



## 利用できない拡張機能もある

<img src="https://asset.watch.impress.co.jp/img/pcw/docs/1366/363/10_l.jpg">

```
既にMicrosoftは機能拡張の作者向けにWeb対応のガイドを提示しているが、一読する限りは一部の処理はNative(つまりVS Code向け)とWeb(つまりVS Code for Web)で処理を分ける必要がありそうだ。
```

拡張機能を書く時のコードは、ネイティブアプリとwebで異なる

from https://pc.watch.impress.co.jp/docs/topic/feature/1366363.html


## firefox未対応






# cloud9に劣る点

## AWS Lambdaとの連携が難しい(ネイティブのvscodeからでないと連携ができない)

1. Visual Studio Code のインストール
2. Visual Studio Code のプロキシ設定
3. AWS ToolKit のインストール(Vscode onlineの拡張機能)
4. AWS CLI のインストール
5.  (4)でインストールしたAWS CLI のインストール確認 ＆ 設定
6.  Visual Studio Code からAWS への接続

from https://qiita.com/taku_ibu/items/7d5d75c0935a1796aa6c


# cloud9に勝る点

## 「編集したい→エディタを開く」までが早い

AWSのログインの認証は面倒くさい。
いちいち「あなたはロボットですか？」に答えなければならない

vscode onlineは、ブラウザに「vscode.dev」を入力するだけで開ける。




## 参考

https://www.youtube.com/watch?v=d_JXIDvOctA


title:vscode onlineとは何か?









