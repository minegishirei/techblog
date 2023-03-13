


- [cloud9,vscode比較まとめ](#cloud9vscode比較まとめ)
    - [cloud9](#cloud9)
    - [vscode](#vscode)
- [vscode onlineとは？](#vscode-onlineとは)
  - [インストールどころかアカウントもいらない](#インストールどころかアカウントもいらない)
  - [ただし、利用できない拡張機能もある](#ただし利用できない拡張機能もある)
  - [firefox未対応](#firefox未対応)
- [vscode onlineがcloud9に劣る点](#vscode-onlineがcloud9に劣る点)
  - [AWS Lambdaとの連携が難しい(ネイティブのvscodeからでないと連携ができない)](#aws-lambdaとの連携が難しいネイティブのvscodeからでないと連携ができない)
- [cloud9に勝る点](#cloud9に勝る点)
  - [「編集したい→エディタを開く」までが早い](#編集したいエディタを開くまでが早い)
  - [参考](#参考)



まずは簡単な比較から。

# cloud9,vscode比較まとめ

### cloud9

- AWS（Amazon Web Services）が提供するクラウドベースの統合開発環境（IDE）です。
- ブラウザ上で動作するため、PCやモバイル端末などどこからでもアクセスできます。
- 設定がシンプルで、AWSのインフラストラクチャーにより、サーバーの設定や環境構築などが簡単にできます。
- ターミナルウィンドウや、チャット機能など、共同開発に必要な機能も備えています。
  - 複数の開発者で一つの画面を開発する、**メタプログラミング**に最適です。
- 有料版もあり、AWSのサービスとの統合性が高いため、AWSを利用している場合には特に使いやすいです。
  - lambdaへの接続も可能です。

### vscode

- Microsoftが提供する、オープンソースのコードエディターです。
- インストールしてローカル環境で使用するため、ユーザーのパソコンにインストールする必要があります。
- 多機能で、豊富なプラグインや拡張機能が用意されています。
- カスタマイズ性が高く、ユーザーが好みに応じて機能を追加できます。
- 拡張機能を使用することで、Gitやデバッガー、言語サポートなども利用できます。

主な違いは以下の通りで、これらを総合的に判断してエディターを決めるとよいでしょう。

クラウドベースかローカルか、
AWSとの統合性、
拡張機能の種類やカスタマイズ性の高さ


ちなみに、vscodeがそのままオンラインに乗った、**vscode online**と呼ばれる製品が登場しております。


# vscode onlineとは？

名前の通り、vscodeがクラウド上に埋め込まれたもの。
クラウド上での保存の選択肢は

- Github
- Azure

の選択肢が存在する。



## インストールどころかアカウントもいらない

from https://forest.watch.impress.co.jp/docs/news/1360147.html

<img src="https://asset.watch.impress.co.jp/img/wf/docs/1360/147/image1_l.jpg">

「vscode.dev」へアクセスするだけで「Visual Studio Code」が完全に動作する。：インストールどころかアカウントもいらない

**とりあえず次のリンクをクリックして、アクセスすることをおすすめします**

https://vscode.dev/

自分の場合は、次のようなエディターが出現した。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/provider/vscode/vscode_online.png?raw=true">



## ただし、利用できない拡張機能もある

<img src="https://asset.watch.impress.co.jp/img/pcw/docs/1366/363/10_l.jpg">

```
既にMicrosoftは機能拡張の作者向けにWeb対応のガイドを提示しているが、一読する限りは一部の処理はNative(つまりVS Code向け)とWeb(つまりVS Code for Web)で処理を分ける必要がありそうだ。
```

拡張機能を書く時のコードは、ネイティブアプリとwebで異なる

from https://pc.watch.impress.co.jp/docs/topic/feature/1366363.html


## firefox未対応

vscode onlineはfirefoxについては未対応です。



# vscode onlineがcloud9に劣る点

## AWS Lambdaとの連携が難しい(ネイティブのvscodeからでないと連携ができない)

vscode で一応aws lambdaを編集することはできますが、cloud9ほどの手軽さはありません。

1. Visual Studio Code のインストール
2. Visual Studio Code のプロキシ設定
3. AWS ToolKit のインストール(Vscode onlineの拡張機能)
4. AWS CLI のインストール
5.  (4)でインストールしたAWS CLI のインストール確認 ＆ 設定
6.  Visual Studio Code からAWS への接続

from https://qiita.com/taku_ibu/items/7d5d75c0935a1796aa6c


# cloud9に勝る点

## 「編集したい→エディタを開く」までが早い

AWSのログインの認証は正直かなりめんどくさい。
いちいち「あなたはロボットですか？」に答えなければならない

vscode onlineは、ブラウザに「vscode.dev」を入力するだけで開ける。




## 参考

https://www.youtube.com/watch?v=d_JXIDvOctA


title:vscode onlineとは何か?









