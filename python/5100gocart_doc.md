


# お品書き

- [お品書き](#お品書き)
- [GoKartチュートリアル](#gokartチュートリアル)
  - [GoKartのインストール](#gokartのインストール)
  - [GoKartのサンプルコード](#gokartのサンプルコード)
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

次のコードのように、
実行結果の保存パスをコントロールすることも可能です。


```py
import pickle

with open('resources/__main__/Example_8441c59b5ce0113396d53509f19371fb.pkl', 'rb') as f:
    print(pickle.load(f))  # Hello, world!
```







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


