


## インデックスについて

インデックスとは、データの値と格納場所を結びつけるデータベースオブジェクト。

正しく使うとデータベースの検索の高速化が可能になる。

作成例

```sql
create table staff(
    id int , 
    name varchar(10), 
    description varchar(400),

    PRIMARY KEY(id),
    index (id),
    index (description)
);
```


しかしながら、インデックスを正しく理解/使用できている開発者は意外と少ないという。

また、インデックス機能について、いつ、どのタイミングで、どのカラムに対して適応するべきかを書いているマニュアルはもっと少ないという。


## インデックスのデメリット

インデックスにはメリットもあるが、デメリットもある。

例えば、insertを行うときには実行時間が長くなる点。

> インデックスを作成するということは「新しい行を追加するときに格納さきのオブジェクトが一つから二つになる」ので、
> 単純に考えれば時間は二倍になる。

しかし、それを差し置いてもインデックスを作成するのは **「select, update, delete」時にはデータを探すのに時間が減少する** というメリットがあるからである。

加えて、世の中のプログラムは圧倒的に**select文の方がinsert文よりも実行回数が多い** ことから、適切なインデックスは品質に貢献できると予測できる。









## ショットガン・インデックス

かといって無闇にインデックスを設定しても無意味orパフォーマンスの悪化につながる。

例えば、先程の作成例をみてみる

```sql
create table staff(
    id int , 
    name varchar(10), 
    description varchar(400),
    
    PRIMARY KEY(id),
    index (id),             - 1
    index (description)     - 2
);
```


- 1 idへのindex作成

idへのインデックス作成は一見すると効率的に見える

しかし、そのすぐ上の行を見るとidはPrimary Keyに設定されていることがわかる。

Oracleの資格保有者ならわかるが、primary keyには作成時にデフォルトでインデックスが作成される。

つまり**Primary Keyにインデックスを作成するのは無意味**。

どころか使用するデータベースによってはPrimary Keyのインデックスがふたつになるので、insert時のヘッダーが増えてしまう。


- 2 description

descriptionへインデックス作成もほとんど意味がない。

まずデータ構造に注目すると、descriptionの型はVarchar(400)であり、それに対してインデックスを作成することはサイズが大きくなってしまう。

次にこのカラムに対する意味と検索時の挙動を想像すると、=や>,<などの演算による比較はほとんど考えられない。

強いていうならばlikeによるワイルドカード検索を想像するかもしれないが、**likeの検索にインデックスは役に立たない**



## 対策

上記の二点

- likeの検索にインデックスは役に立たない

- Primary Keyにインデックスを作成するのは無意味

- 「select, update, delete」時にはデータを探すのに時間が減少する

- select文の方がinsert文よりも実行回数が多い













## 備考




title:インデックスの設定(ショットガン・インデックス)【SQLアンチパターン】

description:インデックスとは、データの値と格納場所を結びつけるデータベースオブジェクト。正しく使うとデータベースの検索の高速化が可能になる。しかしながら、インデックスを正しく理解/使用できている開発者は意外と少ない。




img:https://www.oreilly.co.jp/books/images/picture_large978-4-87311-589-4.jpeg


category_script:page_name.startswith("30")


