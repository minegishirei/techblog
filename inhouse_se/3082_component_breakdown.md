



## このサイトの目的:ソースコードのサイズと管理方法

モノシリックなアプリケーションを移行する際には、コンポーネントを特定し、サイズを図ることが最初の手順となる

コンポーネントのサイズとは、コンポーネントが保有する機能の数のことである。
例えば、チケットの販売システムで購入ボタンに紐ずくイベントハンドラがSQLの発行を行うのは明らかにコンポーネントが担う役割の上を行っている。
その場合はイベントハンドラとDAOを別のコンポーネントとして分離しウェイトを減らさなければならない。

ここでのコンポーネントとは、Pythonであればディレクトリ構成による名前空間、C#でのnamespace呼び出しによる名前空間のことである。

**アプリケーション内のコードのサイズが一定の水準であることは重要であり、一般的にコンポーネントの平均値から偏差値1~2以内に収まっているべきである。**


## コンポーネントのサイズを図る方法

コンポーネントのサイズを図る指標はいくつかある。

- ステートメント数:(ほぼ)ソースコードの行数のことである。完全な指標ではないのは確かだが、どれだけの役割を背負っているかの指標にはなる。

- ファイル数:この指標はコンポーネントのサイズとあまり関係ないが、コンポーネントへの付加情報を提供する。例えば、2個しかないファイルに10000行のコードが書かれていたら、とりあえず目を通した方がいいだろう。

- パーセンテージ:ステートメント数であれ、ファイル数であれ、パーセンテージでコンポーネントを図るのは良い指標である。一つの名前空間で22%を占めるコンポーネントは、複数のドメインに分割するのが良い。


## コンポーネントのサイズを管理し続ける方法

コンポーネントを一定のサイズに分割し終えた後は、サイズが適度な状態で維持されるのが理想だ。
そのためには、**CI/CDパイプラインの一部としてオープンソースやCOTSツールを使用して実装する方法が良い**

そして、ソースコードが適切なサイズや健全な依存関係を持っているか確認する関数を**適応度関数**と呼ぶ。


### 適応度関数例:ファイルサイズ

一般的にコンポーネントの平均値から偏差値1-2以内に収まっているべきである。
例えば、ファイルサイズであれば、10,10,15などの外れ値があることは認めるべきではない。
ちなみに、標準偏差とは、次の様な式である。この値から1-2以内に収まっているのが適切な状態である。

<img src="https://data-viz-lab.com/wp-content/uploads/2021/05/8bc62af8e5a38dea020696820b40417f-1.png">

from https://data-viz-lab.com/standarddeviation


そして、ファイルサイズの適応度関数は次の様になる。

```py
# Walk the directory structure, creating namespaces for each complete path
LIST component_list = identify_components(root_directory)
# Walk through all of the source code to accumulate total statements and number
# of statements per component
SET total_statements TO 0
MAP component_size_map
FOREACH component IN component_list {
    num_statements = accumulate_statements(component)
    ADD num_statements TO total_statements
    ADD component,num_statements TO component_size_map
}
# Calculate the standard deviation
SET square_diff_sum TO 0
num_components = get_num_entries(component_list)
mean = total_statements / num_components
FOREACH component,size IN component_size_map {
    diff = size - mean
    ADD square(diff) TO square_diff_sum
}
std_dev = square_root(square_diff_sum / (num_components - 1))
# For each component calculate the number of standard deviations from the
# mean. Send an alert if greater than 3
FOREACH component,size IN component_size_map {
    diff_from_mean = absolute_value(size - mean);
    num_std_devs = diff_from_mean / std_dev
    IF num_std_devs > 3 {
        send_alert(component, num_std_devs)
    }
}
```

from https://dl.ebooksworld.ir/books/Software.Architecture.The.Hard.Parts.Neal.Ford.OReilly.9781492086895.EBooksWorld.ir.pdf

software arcitecture hardpartsより引用

このような関数を実装し、CI/CDパイプラインに組み込むことで、アーキテクチャは健全な状態を維持できる。




## 参考:ソフトウェアアーキテクチャハードパーツ

https://dl.ebooksworld.ir/books/Software.Architecture.The.Hard.Parts.Neal.Ford.OReilly.9781492086895.EBooksWorld.ir.pdf











## 備考


title:ソースコードの行数はどのぐらいが適切か?【リファクタリング入門1】

category_script:page_name.startswith("3")

description:アプリケーション内のコードのサイズが一定の水準であることは重要であり、一般的にコンポーネントの平均値から偏差値1~2以内に収まっているべきである

img:https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/3063/breakdown.png?raw=true



