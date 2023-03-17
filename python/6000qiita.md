

今回は、PythonのコードからQiita APIを経由して編集を行うソースを解説します。

内容は以下の通りです。

- [必要なライブラリ](#必要なライブラリ)
- [ベアラートークンを取得する](#ベアラートークンを取得する)
- [ソースコード](#ソースコード)
- [コード解説](#コード解説)




## 必要なライブラリ

必須となるライブラリはrequestsのみ。

つぎのコマンドでrequestsをインストールしましょう。

```sh
pip install requests
```

## ベアラートークンを取得する

Qiita APIを使用するためには、まずアクセストークンを取得する必要があります。以下は、Qiita APIのベアラートークンを取得する方法です。

- Qiitaにログインします。
- [設定] > [アプリケーション]を選択します。
- [新しいトークンを発行する]をクリックします。
- トークンに名前を付け、必要な権限を設定します。例えば、投稿の読み取りや書き込みのための権限を設定できます。
- [トークンを発行する]をクリックします。

トークンが生成されるので、そのトークンをコピーして安全な場所に保管します。
以上の手順で、Qiita APIのベアラートークンを取得することができます。取得したベアラートークンを使用して、Qiita APIを使用することができます。

ベアラートークンはだいたい次ぐらいの長さです。

> 5a92018081a8bb606ec0cb199da20543c432v343


## ソースコード

まずソースコードはこれ


```python

import requests
import json
import datetime
import pytz

BASE_URL = "https://qiita.com/api/v2/items"

def putQiitaArticle(title, markdown, path="article", id=""):
    token = "ベアラートークンを発行してください。"
    headers = {"Authorization": f"Bearer {token}"}
    item = {
        "title": title,
        "id": id,
        "tags": [
            {
            "name": "qiita"
            },
            {
            "name": "test"
            }
        ],
        "private": False,
        "coediting": False,
        "tweet": False,
        "body": markdown
    }
    # idがなければ、新規で記事を投稿
    if item["id"] == "":
        res = requests.post(BASE_URL, headers=headers, json=item)
        return res
    else:
        now = datetime.datetime.now(pytz.timezone('Asia/Tokyo'))
        item["title"] += now.strftime("【%Y/%m/%d %H時更新】")
        item_id = item["id"]
        res = requests.patch(BASE_URL + f"/{item_id}", headers=headers, json=item)
        return res
```


呼び出す部分のコードはこんな感じ

```python
if __name__ == "__main__":
    res = putQiitaArticle("この記事はQiitaから投稿しています", "#test " ,"article", "c2acb400a27ab78c22b6").json()
    print(res)
```


## コード解説

このコードは、Qiitaという技術系のブログサイトに記事を投稿または更新する関数putQiitaArticleを定義しています。

requests, json, datetime, pytzの4つのライブラリを使用しています。requestsライブラリは、HTTPリクエストを送信してレスポンスを受信するために使用されます。jsonライブラリは、JSON形式の文字列とPythonのオブジェクトとの相互変換を行うために使用されます。datetimeライブラリは、日時の操作を行うために使用されます。pytzライブラリは、タイムゾーンの操作を行うために使用されます。

この関数には、以下の引数があります。

- title: 記事のタイトル
- markdown: 記事の本文（Markdown形式）
- path: パス（デフォルト値は"article"）
- id: 記事のID（デフォルト値は""）

この関数では、記事のタイトル、本文、タグ、公開範囲、共同編集、ツイートの可否などの情報を辞書型で定義しています。この辞書型は、JSON形式に変換してQiitaのAPIに送信されます。また、ベアラートークンをヘッダーに含めて認証を行います。

idが空文字列である場合は、新しい記事を投稿し、それ以外の場合は記事を更新します。記事を更新する場合は、タイトルに更新日時を付与しています。タイムゾーンは日本時間に設定されています。

記事の投稿や更新に成功した場合は、レスポンスが返されます。





