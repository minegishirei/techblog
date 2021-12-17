

## マークダウンでテーブルを書く方法

マークダウンの記法を用いることでhtmlのような複雑な手法を用いずとも直感的なテーブルを作成することが可能になります。


## サンプルテーブル

- employees



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
            <td>tarou</td>
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
            kaiou
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




## 実際の書き方


<pre><code>

## サンプルテーブル

- employees

|  id    |  name   |  salary | dept_id |
| -----  |  ----   |  ----   | ----    |
|  1234  |  tarou  |  10,000 | 10      |
|  1235  |  kaiou  |  20,000 | 20      |


<pre><code>




## 備考

title:markdownでtableを書く方法(すぐわかるmarkdown)

description:マークダウンの記法を用いることでhtmlのような複雑な手法を用いずとも直感的なテーブルを作成することが可能になります。


