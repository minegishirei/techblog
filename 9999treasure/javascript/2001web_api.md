


## web apiとは何か？

「HTTPプロトコルを利用してネットワーク越しに提供するAPI」のこと

APIとは「Application Programming Interface」の略語でプログラミングで操作しやすいように構築されているサービスのこと

詰まるところ、**「中身をよく知らなくても、HTTPプロトコルを使用してネットワークを超えてプログラミングで操作しやすいように提供されている機能」**のこと

機能の提供を受ける側は開発者を想定しており、そのエンドポイント(=ユーザーから見える末端)はURLで指定されている。

そして注目するべきことは、そのリクエストのレスポンスはJSON形式であるということ。

通常レスポンスされるHTML,CSS,Javascriptは最終的には人間が読むためのもの。

対してWeb APIからレスポンスされるデータは**プログラミングのために二次利用される事を想定した**データである


## web apiのリクエストの具体例

例えば、pythonからtwitter

以下のようなコードがあったとする。

この場合はユーザーから見えるエンドポイントは

> https://api.twitter.com/2/lists/{}

というURLである


<pre><code>
import requests
import os
import json

# To set your enviornment variables in your terminal run the following line:
# export 'BEARER_TOKEN'='<your_bearer_token>'
bearer_token = os.environ.get("BEARER_TOKEN")


def create_url():
    # List fields are adjustable, options include:
    # created_at, description, owner_id,
    # private, follower_count, member_count,
    list_fields = "list.fields=created_at,follower_count"
    # You can replace the ID given with the List ID you wish to lookup.
    id = "list-id"
    url = "https://api.twitter.com/2/lists/{}".format(id)  ## エンドポイント
    return url, list_fields


def bearer_oauth(r):
    """
    Method required by bearer token authentication.
    """

    r.headers["Authorization"] = f"Bearer {bearer_token}"
    r.headers["User-Agent"] = "v2ListLookupPython"
    return r


def connect_to_endpoint(url, list_fields):
    response = requests.request("GET", url, auth=bearer_oauth, params=list_fields)
    print(response.status_code)
    if response.status_code != 200:
        raise Exception(
            "Request returned an error: {} {}".format(
                response.status_code, response.text
            )
        )
    return response.json()


def main():
    url, list_fields = create_url()
    json_response = connect_to_endpoint(url, list_fields)
    print(json.dumps(json_response, indent=4, sort_keys=True))


if __name__ == "__main__":
    main()
</code></pre>


## レスポンスの具体例

上記のコードを実行した後、通常はJSON形式でレスポンスが帰ってくる。

JSON形式は次のように入れ子担ったデータ構造である。

<pre><code>
  {
  "created_at": "Tue Feb 27 21:11:40 +0000 2018",
  "id": 968594506663669800,
  "id_str": "968594506663669760",
  "text": "RT @honeydrop_506: 180222 ICN #백현 #BAEKHYUNnn나의 겨울과 너nn#iHeartAwards #BestFanArmy #EXOL @weareoneEXO https://t.co/hg7I3xAlBg",
  "source": "<a href='"http://twitter.com"' rel='"nofollow"'>Twitter Web Client</a>",
  "truncated": false,
  "in_reply_to_status_id": null,
  "in_reply_to_status_id_str": null,
  "in_reply_to_user_id": null,
  "in_reply_to_user_id_str": null,
  "in_reply_to_screen_name": null,
  "user": {
    "id": 4448809940,
    "id_str": "4448809940",
    "name": "ayah",
    "screen_name": "lovbyun",
    "location": "bbh iu jjh pcy kjd dks",
    "url": "https://curiouscat.me/baekhyun-l",
    "description": "hi hello I love exo",
    "translator_type": "none",
    "protected": false,
    "verified": false,
</code></pre>


## なぜWeb APIを公開するのか

1. 広告の役割

簡単にいうと

**API利用者がAPIの公開元のサービスに対して、付加価値を提供してくれるから**

もっとざっくりというと

広告の役割を果たしている。


2. コスト削減

例えば、サービスに対して副次的な機能をあなたが作りたいと思ったとする。

仕組み自体は簡単だが費用と時間がかかってしまう。

そんな時にAPIを公開して置くことで、

開発者はAPIを勝手に利用して

勝手にあなたが作る必要があったサービスを公開して

自動的にあなたのサービスが有名になる。



## Web APIを公開して成功した例

1. Amazon

Amazonは商品についてのデータを公開するAPIを提供していた。(昔はこのAPIそのものがAWSであった(今はクラウドとしての側面が強いが) )

そしてAmazonは商品のデータと購入ページまでのリンクを提供しており、そのリンクから購入した場合は収益の一部をリンクを貼った人が得られる仕組みである。

これによりAmazonは自社の製品のリンクを多数のサイトに置くことに成功しており、現在の成功に繋がっている。


2. Twitter

Twitterアプリはさまざまな場面で見られるようになったが、その機能の大元のデータはTwitterAPIとして提供されている

さらにbotやデータ分析などの活用が広がり情報が集まる場所になっている。

結果一つの大きなエコシステムが誕生している。




## Web APIを作る意味(非公開の場合)

モダンなウェブアプリケーションやモバイルアプリケーションでは、新しい情報を移すためにいちいち画面遷移したりまっさらな状態からデータを読み込んだりしない。

今手元にないデータをAPIを通して手に入れるだけでページの更新が可能になる。

これはWeb APIを作らなければ手に入れられない機能である。












https://qiita.com/T_zou/items/534d177cd045bb54f880



