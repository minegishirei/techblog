

## マルチカラムアトリビュート

複数列属性を持つようなアンチデザインパターンのこと。

SQLテーブルに対して列に対して年度や携帯電話番号など、これから増える可能性のあるものをカラムとして設定すると厄介な事象が発生します；


## 複数の値を持つ属性を格納する

例）

連絡先情報を格納するテーブルを作成するときに、電話番号は厄介なトラブルの元となる

なぜなら大抵の人は電話番号を一つではなく二つ以上持っているからだ。

場合によっては三つの電話番号を持っている人もいる

そんな時に次のようなテーブルを作成することも考えられるが、結論から言えばこれは悪手である。

```sql
CREATE TABLE ContactAdress (
    name        VARCHAR(50)
    house       VARCHAR(50),
    work        VARCHAR(50),
    phone1      VARCHAR(10),
    phone2      VARCHAR(10),
    phone3      VARCHAR(10)
)
```


# アンチパターン：複数の列を定義する

## 値を検索するときに次のようにORを繋げる必要が出てくる。


```sql
select
    *
from
    ContactAdress
where
    phone1 = "07014981234"
OR
    phone2 = "07014981234"
OR
    phone3 = "07014981234"
```

テーブルから特定の電話番号と一致するものを取り出すためだけのクエリに、これだけのORを使用する必要が出てきてしまう。

今回は参照だけだったが、deleteやupdateも含めた措置を行うとするとどれかに一致するという検索は心許ない。


## 一意性の保証を保てない

複数の列を用意して対応する方策には次のようなイレギュラーなインサートを防ぐ術はありません。

```sql
insert into
    ContactAdress
    Values(
        "tarou",
        "USA",
        "Google",
        "07014981234",
        "07014981234",
        "07014981234"
    )
```


## NULLで溢れる列

大抵の人は電話番号を2つ持ってはいますが、

3つの電話番号を持っている人は何人もいない。

よって、phone3の列はNULLだらけになってしまう。


## 増加する列の対応

何よりも大きいデメリットは、電話番号を3つ以上持っているユーザーへの対応。

イレギュラーなユーザーのために新しく電話番号を増やすことも得策とは言えない。


## 解決策：従属テーブルを作成する

今回の解決策を実施するためには、まずは無限に増殖しかねない列を消してしまうことです。

```sql
CREATE TABLE ContactAdress (
    name        VARCHAR(50)
    house       VARCHAR(50),
    work        VARCHAR(50)
    PRIMARY KEY (name)
)
```

電話番号をどのように管理するかというと、次のように管理します
```sql
CREATE TABLE PhoneAdress (
    name        VARCHAR(50),
    phone       UNSINED INT NOT NULL,
    PRIMARY KEY (name, phone),
    FOREIGN KEY(name) REFERENCES ContactAdress(name)
);
```

これにより、ContactAdress一行に対して、複数行（になる可能性がある）のPhoneAdressが定義されます。















title:マルチカラムアトリビュート【SQLアンチパターンまとめ】

description:SQLテーブルに対して列に対して年度や携帯電話番号など、これから増える可能性のあるものをカラムとして設定すると厄介な事象が発生します；

img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-589-4.jpeg


category_script:page_name.startswith("30")





