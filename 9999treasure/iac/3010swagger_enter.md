

- [swaggerの文法](#swaggerの文法)
- [info:サービスの概要を説明する箇所](#infoサービスの概要を説明する箇所)
- [servers:APIのurl情報を記載する](#serversapiのurl情報を記載する)
- [paths:urlを記述する部分](#pathsurlを記述する部分)
  - [{}でパラメーターを受け取る](#でパラメーターを受け取る)
  - [responsesでステータスコードを設定する。](#responsesでステータスコードを設定する)
  - [componets:部品化](#componets部品化)



## Swaggerのサンプルコード

swaggerはyml形式で記述します。
以下は公式ドキュメントに記述されたswaggerファイルです。

まずは以下の点を押さえておきましょう
- すべてのキーワードは小文字で書かれる
- バージョンは2系と3系で大きく異なる。AWSではまだ古い2系を使用しているので注意しよう。

```yml
openapi: 3.0.0
info:
  title: Sample API
  description: Optional multiline or single-line description in [CommonMark](http://commonmark.org/help/) or HTML.
  version: 0.1.9
servers:
  - url: http://api.example.com/v1
    description: Optional server description, e.g. Main (production) server
  - url: http://staging-api.example.com
    description: Optional server description, e.g. Internal staging server for testing
paths:
  /users:
    get:
      summary: Returns a list of users.
      description: Optional extended description in CommonMark or HTML.
      responses:
        '200':    # status code
          description: A JSON array of user names
          content:
            application/json:
              schema: 
                type: array
                items: 
                  type: string
```


# swaggerの文法

swaggerには**大きく分けて二つのパートに分かれます。**

- paths:urlを記述する箇所
- info:APIサービス全体の概要を記述する箇所
- servers:APIで使用するサーバーの情報を記述する箇所


# info:サービスの概要を説明する箇所

swaggerのinfoセクションではそのサービスの概要を記述することができます。

```yml
info:
  title: Sample API
  description: Optional multiline or single-line description in [CommonMark](http://commonmark.org/help/) or HTML.
  version: 0.1.9
```

- title:APIの名前です。
- descriptiohn:APIについての拡張情報です。

これらのタグはswaggerドキュメントと化したとき、htmlのtitleとdescriptionに該当します。
descriptionは以下のように記述することで、複数行にわたって記述できます。
また、マークダウンの仕様も可能です。

```yml
  description: |-
    This is a sample Pet Store Server based on the OpenAPI 3.0 specification.  You can find out more about
    Swagger at [https://swagger.io](https://swagger.io). In the third iteration of the pet store, we've switched to the design first approach!
    You can now help us improve the API whether it's by making changes to the definition itself or to the code.
    That way, with time, we can improve the API in general, and expose some of the new features in OAS3.

    _If you're looking for the Swagger 2.0/OAS 2.0 version of Petstore, then click [here](https://editor.swagger.io/?url=https://petstore.swagger.io/v2/swagger.yaml). Alternatively, you can load via the `Edit > Load Petstore OAS 2.0` menu option!_
    
    Some useful links:
    - [The Pet Store repository](https://github.com/swagger-api/swagger-petstore)
    - [The source API definition for the Pet Store](https://github.com/swagger-api/swagger-petstore/blob/master/src/main/resources/openapi.yaml)

```


# servers:APIのurl情報を記載する

serversセクションではAPIのurlの情報などを記述します。
本番のurlやサンドボックス、モックAPIなど複数のurlを指定することができます。
**すべてのAPIパスは、サーバーURLに対して相対的であることに注意してください**

```yml
servers:
  - url: http://api.example.com/v1
    description: Optional server description, e.g. Main (production) server
  - url: http://staging-api.example.com
    description: Optional server description, e.g. Internal staging server for testing
```



# paths:urlを記述する部分

パスの部分ではurlの内部のディレクトリ構造を表現することができます。
たとえば、次の例では`user`ディレクトリの詳細を表現しています。

```yml
paths:
  /users: ## /users というurlにアクセスしたときの実装
    get: ## GETメソッドにてアクセス。
      summary: Returns a list of users. ##エンドポイントのタイトル名
      description: Optional extended description in CommonMark or HTML
      responses:
        '200': ## ステータスコードのこと。今回は200番を返したいときのケース
          description: A JSON array of user names
          content:
            application/json: ## レスポンスの形式（今回はJsonだが、xmlのパターンもある）
              schema: 
                type: array
                items: 
                  type: string
```

- `/users` : 
- summary: エンドポイントのタイトル名
- description: 概要
- responses: ステータスコードのこと。今回は200番を返したいときのケース
- 



## {}でパラメーターを受け取る

urlのエンドポイント名に、`{パラメーター}`のように記載することで、パラメーターを使用することができます。
パラメーターは複数記述することができ、それぞれ細かい記述が可能です。

```yml
paths:
  /users/{userId}:
    get:
      summary: Returns a user by ID.
      parameters:
        - name: userId # パラメーターの名前
          in: path
          required: true # 必須なパラメーター
          description: Parameter description in CommonMark or HTML. # パラメーターについての説明
          schema: # 型などの記述情報のこと。
            type : integer
            format: int64
            minimum: 1 #1文字以上必須。
      responses: 
        '200':
          description: OK
```



## responsesでステータスコードを設定する。

操作ごとに200 OK や 404 Not Foundなどのステータスコードを設定することが可能です。

```yml
paths:
  /users/{userId}:
    get:
      summary: Returns a user by ID.
      parameters:
        - name: userId
          in: path
          required: true
          description: The ID of the user to return.
          schema:
            type: integer
            format: int64
            minimum: 1
      responses:
        '200': ## 200番のステータスコード(問題ない状態)
          description: A user object.
          content:
            application/json:
              schema:
                type: object
                properties:
                  id:
                    type: integer
                    format: int64
                    example: 4
                  name:
                    type: string
                    example: Jessica Smith
        '400': ## 入力ミスによる認証エラー
          description: The specified user ID is invalid (not a number).
        '404': ## 番号が合わないことによる認証エラー
          description: A user with the specified ID was not found.
        default:
          description: Unexpected error
```



## componets:部品化

**componets**内部ではpaths間で共通となる部品を作り出すことができます。
今回の例ではユーザーデータを受け付けるschemasを共通化しています。

```yml
paths:
  /users/{userId}:
    get:
      summary: Returns a user by ID.
      parameters:
        - in: path
          name: userId
          required: true
          schema:
            type: integer
            format: int64
            minimum: 1
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'    # <-------呼び出し部分1
  /users:
    post:
      summary: Creates a new user.
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/User'      # <-------呼び出し部分2
      responses:
        '201':
          description: Created

components: ## ここから共通部品を定義する
  schemas: ## schemas
    User:
      type: object
      properties:
        id:
          type: integer
          example: 4
        name:
          type: string
          example: Arthur Dent
      # Both properties are required
      required:  
        - id
        - name
```























