


### sqlの「like」とは何か

sqlのlikeはパターン検索を可能にするキーワードです。

具体的には次のような場合に使います。

- ある文字を含むものを条件に入れたい。

- ある文字から始まるものだけを抽出したい。
  
基本的にはこの二つの用途しか使いません。

### 「sql ワイルドカード」で検索したあなたへ

SQLのワイルドカードでは次の二つの文字が使える

- 「%(パーセント)」     任意の長さ（ゼロを含む）の文字列
- 「_(アンダーバー)」   任意の１文字

しかし基本的には<strong>%(パーセント)しか使わない。</strong>



### 「sql 特定の文字を含む」で検索した方へ

SQLのlikeで「特定の文字列を含む」場合を検索したい場合、次のように%で挟むことで記述できます。

```sql
select
    *
from
    (テーブル名)
where
    (カラム名) like '%検索したい文字列%'
```

例えば次のような「従業員テーブル」があったとします。

あなたは従業員の中でも「鈴木」から始まる従業員の人を探しています。


<table>
    <thead>
        <tr>
            <th>id</th>
            <th>name</th>
            <th>salary</th>
            <th>dept_id</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1234</td>
            <td>鈴木 貴教</td>
            <td>10,00
            </td>
            <td>20
            </td>
        </tr>
        <tr>
            <td>
            1235
            </td>
            <td>
            鈴木 悟
            </td>
            <td>
            20.000
            </td>
            <td>
            20
            </td>
        </tr>
        <tr>
            <td>
            1236
            </td>
            <td>
            nanashi
            </td>
            <td>
            30,00
            </td>
            <td>
            10000
            </td>
        </tr>
    </tbody>
</table>


その時には次のようにlikeを使うことで「鈴木」を名前に含んでいる人を抽出することができます。

#### ポイントは「検索したい文字列を%で挟むこと」です。

```sql
select
    *
from
    employees e
where
    e.name like '%鈴木%'
```




- 実行結果

<table>
    <thead>
        <tr>
            <th>id</th>
            <th>name</th>
            <th>salary</th>
            <th>dept_id</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1234</td>
            <td>鈴木 貴教</td>
            <td>10,00
            </td>
            <td>20
            </td>
        </tr>
        <tr>
            <td>
            1235
            </td>
            <td>
            鈴木 悟
            </td>
            <td>
            20.000
            </td>
            <td>
            20
            </td>
        </tr>
    </tbody>
</table>

従業員テーブルには「nanashi」さんもいますが今回は意図した通り「鈴木さん」だけが抽出されています。




### 「SQL 特定の文字列で終わる」で検索したあなたへ

特定の文字列で終わるクエリを書きたい場合は,特定の文字列の先頭に%をつけることで実現させることができます。

```sql
select
    *
from
    テーブル名
where
    カラム名 like '%検索文字列'

```

例えば次の従業員テーブルで、名前が「悟」の人を検索したいと考えたとします。


- employeesテーブル
  
<table>
    <thead>
        <tr>
            <th>id</th>
            <th>name</th>
            <th>salary</th>
            <th>dept_id</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1234</td>
            <td>鈴木 貴教</td>
            <td>10,00
            </td>
            <td>20
            </td>
        </tr>
        <tr>
            <td>
            1235
            </td>
            <td>
            鈴木 悟
            </td>
            <td>
            20.000
            </td>
            <td>
            20
            </td>
        </tr>
        <tr>
            <td>
            1236
            </td>
            <td>
            nanashi
            </td>
            <td>
            30,00
            </td>
            <td>
            10000
            </td>
        </tr>
    </tbody>
</table>

それもsqlのlikeを使えば簡単に実現できます。

#### ポイントは「検索したい文字列の先頭に%をつけること」です。

```sql
select
    *
from
    employees
where
    name like '%悟'

```


- 実行結果
  
<table>
    <thead>
        <tr>
            <th>id</th>
            <th>name</th>
            <th>salary</th>
            <th>dept_id</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
            1235
            </td>
            <td>
            鈴木 悟
            </td>
            <td>
            20.000
            </td>
            <td>
            20
            </td>
        </tr>
    </tbody>
</table>










### サンプルテーブル


<table>
    <thead>
        <tr>
            <th>id</th>
            <th>name</th>
            <th>salary</th>
            <th>dept_id</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1234</td>
            <td>鈴木 貴教</td>
            <td>10,00
            </td>
            <td>20
            </td>
        </tr>
        <tr>
            <td>
            1235
            </td>
            <td>
            鈴木 悟
            </td>
            <td>
            20.000
            </td>
            <td>
            20
            </td>
        </tr>
        <tr>
            <td>
            1236
            </td>
            <td>
            nanashi
            </td>
            <td>
            30,00
            </td>
            <td>
            10000
            </td>
        </tr>
    </tbody>
</table>



### その他の例(FRAQTAからの割り算の割り出し)


VB6,VBAのコードの中から「 / 」が含むSQLを全て割り出す必要が出てきた。

つまり割り算を炙り出さなければならないが、これがまた難しい。

しかしこの無理難題にもlikeを用いることで適切に対応することができた。

幸いにもFRAQTAには全てのソースコードが入っている。


```sql
select
    *
from
    FRAQTA a
where
    a.line like '%"%/%"%'
and
    a.svn_repository_path IN (
        "",
        "",
        ...
        ""
    )
```








title:「sql like」で検索したあなたへ【SQL基礎】




img:https://www.oreilly.co.jp/books/images/picture_large4-87311-281-8.jpeg


description:sqlのlikeはパターン検索を可能にするキーワードです。具体的には次のような場合に使います。ある文字を含むものを条件に入れたい。ある文字から始まるものだけを抽出したい。基本的にはこの二つの用途しか使いません。


category_script:page_name.startswith("11")

