

### 概要

2000アクセス/dayを記録したwebアプリケーションを作成しました。
(参考url:http://fanstatic.short-tips.info/twitter_network/)
ローカルに開発環境を、AWS,EC2 ubuntu上に0から環境を構築し、上記二つを繋ぐためにGit,Githubを導入。
改修、拡張、本番環境と開発環境の移行のしやすさの観点からdocker-composeを導入し、
google analytics,google seach consoleを用いて数値分析,seo対策を行い、検索順位を60位から5位以内に改善しました。




個人開発
勤務期間：2019年4月～2021年11月

### 具体的な仕事内容

・サポートデスク
・障害分析

メンバー：1名

利用言語：Javascript,Python3,Nginx
ライブラリ：D3.js 
フレームワーク：Django
その他：Lets'Encrypt, Docker, Docker-compose, Git, Github, EC2


＜内容＞
・twitterの会話の履歴をもとに人脈相関図を作成するwebアプリケーション
・ローカルに開発環境を、AWS,EC2 ubuntu上に0から環境を構築
・上記二つを繋ぐためにGit,Githubを導入
・改修、拡張、本番環境と開発環境の移行のしやすさの観点からdocker-composeを選択
・Let's Encryptを用いたhttps対応
・twitterのデータはtwitter apiを利用して取得する
・データベースはgithub上で管理


### プロジェクトの流れ

1,AWS,EC2を購入
2,docker-composeを導入し、仮のwebアプリケーションで実装が可能か検証
3,ローカルでの開発環境にdocker-composeを使ったdjangoアプリケーションを作成
3,visual studioのremote機能を用いてEC2上でも動くかどうかを確認
4,ローカル開発環境とEC2開発環境を繋ぐGithub,Githubを導入
5,Route53を用いてドメイン取得

上記の手順で本格的な開発サイクルがスタート

  1,ローカルの開発環境で開発を行う
  2,gitを用いてadd commit pushを行う
  3,EC2からpullを行う
  4.本番環境の動作が問題ないかを確認

上記のサイクルを用いて、以下の4点を実装
・D3.jsを用いた人脈図の可視化
・Let's Encryptを用いたhttps対応
・github上へのデータ保存
・html css改良によるUIUXの改善
・レスポンシブ化






