


## SQLでパスワードを平文で格納してはいけない

データベース設計における重大なセキュリティリスクのうちの一つに、**SQLでパスワードを平文で格納する**というものがあります。

これは重大なセキュリティ欠陥であり、権限のない人に特権的なアクセスを与えるセキュリティリスクを生じさせます。


### パスワードを平文で格納したインシデント例

パスワードは、よく文字列型の列としてAcountsテーブルに格納されます。

```sql
CREATE TABLE Acounts (
    accountid       SERIAL          PRIMARY KEY,
    account_name    VARCHAR(20)     NOT NULL,
    email           VARCHAR(100)    NOT NULL,
    password        VARCHAR(30)     NOT NULL,
)
```

新規作成アカウントのために行を挿入する際にも、パスワードを文字列で記述します。

```sql

INSERT INTO 
    Acounts
VALUES
    (
        123, 
        'billkarwin', 
        'bill@example', 
        'xyzzy'
    )
```

パスワードを平文で格納するのは安全ではありませんし、ネットワーク上の平文パスワードをやりとりするのは尚更危険です。

INSERTの際のSQLを読み取られて仕舞えば、簡単にパスワードが判明してしまいます。

そのほかにも攻撃者から見ればいくらでもパスワードを盗むチャンスがあります。

- アプリケーション層からデータベースに送信されたSQLを傍受するのは簡単です。Wiresharkを起動しておけば簡単にみれます。

- SQLクエリのログを探す方法もあります。データベースが実行したSQL文の記録を含むログファイルにアクセスされる可能性です。

- バックアップファイルやバックアップメディアからもデータを読み取れます。



## 解決策：パスワードハッシュを格納する


今回は以下の順番で解決します。

- バックアップファイルやバックアップメディアからもデータを読み取れます。

- SQLクエリのログを探す方法もあります。データベースが実行したSQL文の記録を含むログファイルにアクセスされる可能性です。

- アプリケーション層からデータベースに送信されたSQLを傍受するのは簡単です。Wiresharkを起動しておけば簡単にみれます。


データベースの文字列が解読可能な状態ではなくとも、ユーザーの入力内容を使用したパスワード認証は可能です。

### ハッシュ関数を利用する

パスワードを、**一方向性の暗号化ハッシュ関数を用いて暗号化します**

このハッシュ関数は、入力文字列を、入力内容が識別不可能な八種と呼ばれる文字列に変換します。

```sql
SHA2('xyzzy', 256) = 'fjie8q@eu90gjq3r@84389q7tgjr8y34ut8-g@hrq8br'
```

左の文字列と数値と関数には意味がありますが、右側の、データベースに格納されている意味不明な文字列は元のパスワードから推測するのはおそらく不可能でしょう。
ハッシュアルゴリズムには入力情報を、「失う」ように設計されているため、ハッシュ側から入力情報文字列を復元することはできません。

### 1.SQLでのハッシュ関数の使用


以下に示す例は、Acountsテーブルを再定義したものです。SHA-256を用いてパスワードをハッシュ化すると、常に64文字になります。

このため、列を固定長のCHAR(64)列として定義するのをお勧めします。

```sql
CREATE TABLE Acounts (
    accountid       SERIAL          PRIMARY KEY,
    account_name    VARCHAR(20)     NOT NULL,
    email           VARCHAR(100)    NOT NULL,
    password_hash   CHAR(64)     NOT NULL,
)
```

このテーブルに対してユーザーデータをINSERTする場合、SQLのハッシュ関数を用いてINSERTします。

テーブルにINSERTされる際のパスワードの状態はSHA-356アルゴリズムによって読み取り不可です。

```sql

INSERT INTO 
    Acounts
VALUES
    (
        123, 
        'billkarwin', 
        'bill@example', 
        SHA2('xyzzy', 256)
    )
```

ログインイベントが発火した際には、**ユーザー入力に同じハッシュ関数を適用する**ことで、その結果をデータベースに格納されたハッシュ関数と比較することができます。


```sql
SELECT
    CASE 
    WHEN password_hask = SHA2('xyzzy', 256) THEN 1 
    ELSE 0
    END
FROM
    Acounts
WHERE
    account_id = 123;
```


これで、

- バックアップファイルやバックアップメディアからもデータを読み取れます。

という問題は解決しました。


### 2.ハッシュにソルトを加える

アカウントテーブルに入っている、ハッシュ化されたパスワードを読み取る方法ですが、
実は一つだけ攻撃方法が残っています。

1. よくあるパスワードとそのハッシュ値のリストを格納した自前のデータベースを準備する。

2. 何らかの方法でアカウントテーブルが攻撃者に見られたとする。

3. 1のハッシュ値のリストと、アカウントテーブルのパスワードを比較する辞書型攻撃を行う。

辞書に載っているようなありふれた言葉がパスワードに使われていれば、攻撃者のデータベースと同じハッシュが見つけられてしまうかもしれません。

この辞書型攻撃を防ぐ方法は、暗号化前のパスワードに「ソルト」と呼ばれる文字列を孵化することです。

```sql
SHA2('password', 256)
='fjpeq483qpu8ghj@8804u28gj82-548u2jg82-g8hj2-jhg82h2q8'
```

この状態だと、同じ256ハッシュでハッシュ化されたパスワードと一致してしまうかもしれませんが

```sql
SHA2('password' || 'G0y6cfj3iqw84j3q8gp', 256)
='fj9q3fjq348-fu8q438q3@jg4q358u8-w3gjq83g5qw8-j5858304'
```

ソルトを付け加えることで、ハッシュ化されたパスワードが完全に別の値になっています。

リスト型攻撃の際に用いる辞書に、ソルトと呼ばれる文字列は含まれるはずがないので、攻撃者は一致するハッシュを推測することができなくなるのです。


### 3.SQLからパスワードを隠す

ここまでの方法で、

- データベースのハッシュパスワードを、攻撃者の持つよく使われるパスワードをハッシュ化したものを参照する攻撃

を防ぐことができました。

ですが、まだ

- SQLクエリのログを探す方法もあります。データベースが実行したSQL文の記録を含むログファイルにアクセスされる可能性

を対策できていません。**依然としてSQLのクエリの中でパスワードが平文として使用されているためです。**

これを防ぐための方法は、SQLクエリ内部で生のパスワードを使用しないことです。
言い換えれば、**アプリケーション内(PHPやDjango等)でハッシュパスワードを計算し、SQLクエリではハッシュのみを用いるようにすることです。**

```php
$password = 'xyzzy';
$stmt = $pdo->query(
    "SELECT salt
    FROM Accounts
    WHERE account_name = 'bill'");
$row = $stmt->fetch();
$salt = $row[0];
$hash = hash('sha256', $password . $salt); //!!!ここでhash化を行っている!!!
$stmt = $pdo->query("
    SELECT (password_hash = '$hash') AS password_matches;
    FROM Accounts AS a
    WHERE a.acct_name = 'bill'");
$row = $stmt->fetch();
```

- サンプルコードのhash関数は、16進数のみを返すことが保証されています。
    このため、SQLインジェクションの心配はありません。

- また、$hashにはハッシュ化されたパスワードが格納されており、直後に実行されるクエリでは暗号化されたハッシュパスワードが使われてます。
    この状態であれば、SQLの実行ログからパスワードを探ることもできません。


## ハッシュ化されたパスワードをリカバリする方法

パスワードを忘れたユーザーを助ける方法について愛説します。
しかし、もうパスワードはリカバリーできません。データベースにはパスワードではなくハッシュ化されたパスワードが格納されてあるからです。

これに対する対抗策は二つあります。

### 1.アプリケーションが生成した一時パスワードをメールで送る

ユーザーが助けを求めてきた時、パスワードを電子メールで送るのではなく、アプリケーションが生成した一時パスワードをメールで送る方法があります。

もちろん、ユーザーの初回ログイン後にパスワードの変更を強制するようにアプリケーションを管理するべきですが。

```txt
差出人：deamon
宛先: bill@example.com
件名：パスワードリセット

アカウントのパスワードのリセットをリクエストしました。
仮パスワードは「p0trz3b1e」です。
このパスワードは、1 時間後にアクセス無効になります。

下のリンクをクリックしてアカウントにログインし、
新しいパスワードを設定してください。
http://www.example.com/login
```

### 2.アクセストークンを発行する方法

二番目の方法は電子メールに新しいパスワードを記載する代わりに、アクセストークンを発行してそれを使用して認証する方法です。

まず前提として、パスワードのリセットを受け付けるテーブルを作成しておきます。

```sql
CREATE TABLE PasswordResetRequest (
    token CHAR(32) PRIMARY KEY,
    account_id BIGINT UNSIGNED NOT NULL,
    expiration TIMESTAMP NOT NULL,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);
```

ユーザーからパスワードリセットの要求が出た場合、一意の(重複が発生しない)トークンを発行します。

```sql
-- トークン発行
SET @token = MD5('billkarwin' || CURRENT_TIMESTAMP);
```

その後、発行したトークンをPasswordResetRequestへ格納するとともに、メールでトークンを渡します。

```sql
INSERT INTO 
    PasswordResetRequest
VALUES 
    (@token, 123, CURRENT_TIMESTAMP + INTERVAL 1 HOUR);
-- INTERVAL 1 HOURで一時間追加しているのは、認証時に時刻が一時間経過していないかどうかを確認するため。
```

メールで渡すトークンには、getリクエストを用いたrset_passwordページへ遷移するのが望ましいですね。

```txt
差出人：deamon
宛先: bill@example.com
件名：パスワードリセット
アカウントのパスワードのリセットをリクエストしました。
1時間以内に下のリンクをクリックして、パスワードを変更してください。
1時間後、以下のリンクは機能しなくなります。

http://www.example.com/reset_password?token=f5cabff22532bd0025118905bdea50da
```

reset_passwordのページでの認証要件は以下の通りになります。

- tokenパラメーターの値はPasswordResetRequestテーブルの行と一致していなければならない

- このトークン執行期限は過去ではなく未来時刻でなくてはなりません。









## SQLでパスワードを管理する方法

title:SQLでパスワードを管理する方法

description:データベース設計における重大なセキュリティリスクのうちの一つに、「SQLでパスワードを平文で格納する」というものがあります。これは重大なセキュリティ欠陥であり、権限のない人に特権的なアクセスを与えるセキュリティリスクを生じさせます。

category_script:page_name.startswith("30")
