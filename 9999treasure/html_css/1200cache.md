



## Real World HTTP

参考

<img src="https://dragon-taro.com/wp-content/uploads/2018/11/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88-2018-11-12-21.18.00.png">


## HTTP/1.0のキャッシュの仕組み：日時更新によるキャッシュ(古い)

HTTP/1.0のキャッシュの仕組みです。

1. 多くのWebサーバーには次のようなヘッダーをレスポンスに含めます。

<code><pre>
Last-Modified: Wed. 08 Jun 2016 15:23:45 GMT
</code></pre>

2. ウェブブラウザがキャッシュ済みのURLを再度読み込むときは、サーバーから返された日時をそのまま**If-Modified-Since** ヘッダーに入れてリクエストします。

<code><pre>
If-Modified-Since: Wed. 08 Jun 2016 15:23:45 GMT
</code></pre>

3. ウェブサーバーはリクエストに付与された日時とサーバー上のコンテンツの日時を比較し、変更があれば通常通りステータス200を返し、コンテンツをレスポンスボディに含めて送信します。


4. もし変更がなければ **ステータス304 Not Modified**を返し、ボディはレスポインスに含まれなくなります。

このキャッシュの仕組みの弱点は「更新日時を確かめる方法が存在することで通信が余計に増える」という点です


## Expiresヘッダー

上記の弱点をExpiresヘッダーはキャッシュの有効性を確認する通信自体を廃止することで達成しました。


<img src="https://junzou-marketing.com/wp/wp-content/uploads/2018/09/browser-cache-works.png">

Expiresヘッダーには日時が格納されます。

<pre><code>
Expires: Fri 05 Aug 2016 00:52:00 GMT
</code></pre>

クライアントはこの期間内であればキャッシュが「新鮮」ということで強制的にキャッシュを利用します。

ちなみに「3病後にコンテンツが古くなる」という状態であったとしても3秒後に勝手にリロードすることはありません。

ちなみに「戻る」ボタンなどのヒストリー捜査の場合は有効期限が切れたページをそのまま使うことがあります。

## Expiresヘッダーの誤った使い方

サーバーに変更点があったかどうかの問い合わせ自体がなくなるため、SNSのトップページで使うのは間違いである。

使い道はCSSなどの滅多に更新が行われないStaticコンテンツで使用するのが望ましい。

場合によってはWebAPIでのExpiresヘッダーの利用もリクエストの回数を減らしサーバーへの負荷を減らす選択肢になります。

ちなみにHTTP/1.1ではExpiresヘッダーの寿命は最大で1ねんいしましょうというガイドラインが追加されている。

## Pragma: no-cache キャッtしゅの強制的解除(古い)

no-cacheはプロキシサーバーに対して、「リクエストしたコンテンツがキャッシュされていたとしても、本来のサーバー（オリジンサーバー）までリクエストを届けて欲しい」という指示になります。


このno-cacheはHTTP1.1ではCache-Controlにマージされています。



## キャッシュを使ってしまう条件

- GETとHEAD以外のメソッド

- Cache-Controlヘッダーにprivateが設定されている

- Cache-Controlヘッダーにno-storeが設定されている

- Authorizationヘッダーがあるが、Cache-Controlヘッダーにpublicがない


## Cache-Control(Expiresよりも強い)

HTTP/1.1で追加されたのがCache-Controlヘッダーです。

こちらはより柔軟なキャッシュ制御を**サーバー側から**支持できます。

このヘッダーは**Expires**よりも優先されます。

- public

同一のコンピューターを使う複数のユーザーの間でキャッシュを再利用する。(ユーザーAとユーザーBは同じキャッシュを利用する)

- private

同じURLからユーザーごとに異なるコンテンツが返される場合に使用する。
同一のコンピューターを使う別のユーザー間でキャッシュを再利用しない。

- max-age-n

nには数字が入る。86400を指定すると、一日間はキャッシュが有効で、サーバーに問い合わせることなくキャッシュを利用する。それ以降はサーバーに問い合わせを行い、304 Not Modifiedが帰ってきた時のみキャッシュを利用する

<img src="https://web-dev.imgix.net/image/tcFciHGuF3MxnTr1y5ue01OGLBn2/e2bN6glWoVbWIcwUF1uh.png?auto=format">

- no-cache

キャッシュが有効かどうか毎回サーバーに問い合わせを行う。
max-age-0とほぼ同じ。

- no-store

キャッシュをつかわない。

- immutable

コンテンツが決して変化しないことを伝える。
しかしChromeは対応しない。

## Cache-Controlの使い方

カンマ区切りで複数指定が可能だが、内容的には次の組み合わせになる。

- private、publicのどちらか：キャッシュの共有範囲の決定

- max-age, no-chache、no-storeのどれか：キャッシュの期間の決定











## 備考

title:RealWorldHTTP備忘録 Cache-Control,Pragma,Expires

description:Expiresはサーバーに変更点があったかどうかの問い合わせ自体がなくなるため、SNSのトップページで使うのは間違いである。使い道はCSSなどの滅多に更新が行われないStaticコンテンツで使用するのが望ましい。

img:https://dragon-taro.com/wp-content/uploads/2018/11/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88-2018-11-12-21.18.00.png

category_script:True