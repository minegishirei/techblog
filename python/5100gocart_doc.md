


# お品書き

- [お品書き](#お品書き)
- [GoKartチュートリアル](#gokartチュートリアル)
  - [GoKartのインストール](#gokartのインストール)
  - [GoKartのサンプルコード](#gokartのサンプルコード)
- [GoKartの実行方法](#gokartの実行方法)
  - [GoKartのrunの使い方](#gokartのrunの使い方)
  - [GoKartのbuildの使い方](#gokartのbuildの使い方)
- [GoKartのログファイルのパス](#gokartのログファイルのパス)
- [GoKartのメリット・デメリット](#gokartのメリットデメリット)
  - [GoKartメリット](#gokartメリット)
  - [GoKartデメリット](#gokartデメリット)
  - [参考](#参考)


# GoKartチュートリアル

## GoKartのインストール

アクティブ化されたPython環境内で、次のコマンドを使用してgokartをインストールします。



## GoKartのサンプルコード

次のコードは、goKartを利用した最も小さいコードです。

```py
import gokart

class Example(gokart.TaskOnKart):
    def run(self):
        self.dump('Hello, world!')

task = Example()
output = gokart.build(task)
print(output)
```

実行結果:`Hello, world!`


# GoKartの実行方法

Gokartには`run`、`build`の2通りのタスク実行方法が存在します。
それぞれの使用用途は以下の通り。

- `gokart.run`: シェルで引数を使用します。
- `gokart.build`: jupyterノートブック、IPython などで使用します。

gokart.runとgokart.buildを同じコードで併用することは推奨されていません。

## GoKartのrunの使い方

`run`を選択した場合、pythonのコマンドラインの実行時にパラメーターを指定することができます。

```py
import gokart
import luigi

class SampleTask(gokart.TaskOnKart):
    param = luigi.Parameter()

    def run(self):
        self.dump(self.param)

gokart.run()
```

この場合、パラメーターとして`param`変数に値を代入する必要があります。
その場合のコマンドラインは次のようなコマンドになります。

`python sample.py SampleTask --local-scheduler --param=hello`

また、コマンドラインでの引数ではなくpython内部でのパラメーターを指定する場合は次のようなコードになります。

```py
gokart.run(['SampleTask', '--local-scheduler', '--param=hello'])
```

## GoKartのbuildの使い方

`build`を選択肢場合、pythonのコード内部にパラメーターを指定することができます。

次のコードは、`build`を用いたパラメーターを指定するコードです。

```py
import gokart
import luigi

class SampleTask(gokart.TaskOnKart):
    param = luigi.Parameter()

    def run(self):
        self.dump(self.param)

gokart.build(SampleTask(param='hello'), return_value=False)
```

ログのレベルを変更するには、lob_levelパラメーターを変更することで対応します。

```py
gokart.build(SampleTask(param='hello'), return_value=False, log_level=logginge.DEBUG)
```




# GoKartのログファイルのパス

gokart は、機械学習に必要なすべての情報を記録します。デフォルトではリソースはスクリプトと同じディレクトリに生成されます。
タスクの実行結果はデフォルトでは`__name__`ディレクトリに保存されます。


```ps1
$ tree resources/
resources/
├── __main__
│   └── Example_8441c59b5ce0113396d53509f19371fb.pkl
└── log
    ├── module_versions
    │   └── Example_8441c59b5ce0113396d53509f19371fb.txt
    ├── processing_time
    │   └── Example_8441c59b5ce0113396d53509f19371fb.pkl
    ├── random_seed
    │   └── Example_8441c59b5ce0113396d53509f19371fb.pkl
    ├── task_log
    │   └── Example_8441c59b5ce0113396d53509f19371fb.pkl
    └── task_params
        └── Example_8441c59b5ce0113396d53509f19371fb.pkl
```

ログ出力する際にはパラメーターの値に応じたハッシュ値でファイル名が保存されます。
つまり、**パラペーターの値を変更することで自動的に上書き保存を回避して新規保存することが可能です。**
これはパラメーターの変更を実験的に行い調節するのにとても便利です。



次のコードのように、実行結果の保存パスをコントロールすることも可能です。


```py
import pickle

with open('resources/__main__/Example_8441c59b5ce0113396d53509f19371fb.pkl', 'rb') as f:
    print(pickle.load(f))  # Hello, world!
```

パラメーターファイルに加えて、次のファイルも同様に保存されます。


- module_versions: スクリプトの実行時にインポートされたすべてのモジュールのバージョンです。再現性の確保のために使用できます。

- processing_time: タスクの実行時間。

- random_seed: これは pythonとnumpyのランダムシードです。機械学習の再現性に使用できます。
  
- task_log: これはタスクログの出力先です。

- task_params: タスクのパラメータです。







# GoKartのメリット・デメリット

## GoKartメリット

Luigiの良い点に追加として：
- TaskInstanceParameterを使用することにより、Pipeline定義とタスク処理を分離し、将来のプロジェクトで簡単に再利用できるようにすることができます。
- pickle, npz, gz, txt, csv, tsv, json, xml 形式のファイルアクセス（読み書き）ラッパーがFileProcessorクラスとして提供されます。
- 各実験パラメータを保存する仕組みが備わっています。thunderboltというビューワーが提供されます。
- 中間ファイル名に含まれた、パラメータセットに固有のハッシュ文字列を参照して、パラメータが変更された際にはタスクを再実行します。
様々なパラメータセットで実験するのに有用です。
- クラスデコレータを使用してLuigiの requires クラスメソッドを簡潔に書くためのシンタクティックシュガーが提供されます。
- Slackに通知できます。


## GoKartデメリット

サポートされているデータファイル形式が限られています。 サポートされていない形式を使用するためには、ファイルやデータベースアクセス（読み書き）するためのコードを書く必要があります。


## 参考

https://github.com/m3dev/gokart/blob/master/docs/tutorial.rst

https://qiita.com/Minyus86/items/70622a1502b92ac6b29c



title:GoKartとは何か?

img:https://cdn-ak.f.st-hatena.com/images/fotolife/v/vaaaaaanquish/20210415/20210415015242.png

category_script:page_name.startswith("51")