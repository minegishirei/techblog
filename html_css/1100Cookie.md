

## Cookieとは

**ブラウザ側にデータを保存する仕組み**のことをCoocieと言う


HTTPのリクエストヘッダーの中に、Cookie, Set-Cookieによる状態管理メカニズムを組み込むことができる

<img src="https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F87538%2F072895af-86cb-7f4c-3b27-5a5d2c5abb24.png?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&w=1400&fit=max&s=2e3aeffb917e234251c32895dafa5d01">


## cookieはどんな時に使われるのか

Cookieの使用用途にはいくつか分類があります。

まずは、発行元がユーザーが訪れたサイトか、それ以外のサイトかです。

また、使用期間にはブラウザを閉じたら消えてしまう**セッションクッキー**と、期間が設定されているブラウザを閉じても残る**永続クッキー**のに種類があります。

これを元に次の4つの目的が考えられます。

1. 厳密に必要なクッキー。ECサイトで買い物をするときに、ショッピングカート機能を実現するためにクッキーを使用するとしたら、それは機能要件を満たすために絶対に必要なものです。

2. 環境設定クッキー。過去に選択したユーザーの好みの言語、ユーザー名とパスワードなどです。

3. 統計クッキー。アクセスしたページやクリックしたリンクなど、分析情報を記録するためのクッキーです。

4. マーケティングクッキー。ユーザーの行動をトラッキングして、広告の精度をあげる。


## Cookieのメカニズム
<img src="https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F87538%2F915bf33b-81ec-5f69-5f09-88d1988ad207.png?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&w=1400&fit=max&s=2710160050793eda2a39eed67285d82c">

1. サーバからSet-Cookie: key=value; option群を返します。

2. ブラウザはSet-Cookieを受け取り、受信時にブラウザにwww.example.orgのCookieとして、保存します。

次回以降のwww.example.orgへのリクエスト時に、CookieをHTTP Headerに乗せて送信します。



## Cookieの間違った使い方

クッキーは便利な機能があるが、適切ではない使い方がある。

1. 永続性の問題。

ブラウザのセキュリティ設定によって、あるいはシークレットモードのブラウザは、サーバーからの保存の指示を無視することもある。

無くなっても問題のない情報や、サーバーからの情報で復元できるデータ以外を格納する用途には向かない。

2. データサイズの問題

クッキーはリクエスト時にはヘッダーとして通信に常にふよされるため、通信量が増えてしまう。

リクエスト、レスポンスの両方に通信量が影響を与える。

3. セキュリティの問題

HTTP下でのクッキーは平文でやりとりされる。

SECUREを付与すれば、HTTPSで暗号化された時にしか送受信されませんが、HTTPの場合クッキーは平文で送受信されてしまいます。






## 参考ページ

https://qiita.com/OmeletteCurry19/items/f24ee02a942d8f6931a5


## 備考

title:Cookieの間違った使用用途と仕組みについて解説

description:HTTPのリクエストヘッダーの中に、Cookie, Set-Cookieによる状態管理メカニズムを組み込むことができる。


img:https://dragon-taro.com/wp-content/uploads/2018/11/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88-2018-11-12-21.18.00.png

category_script:True