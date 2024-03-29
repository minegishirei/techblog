



# お品書き


- [お品書き](#お品書き)
- [環境構築](#環境構築)
  - [インポートする必要のあるライブラリ](#インポートする必要のあるライブラリ)
- [GoKartのサンプルコード](#gokartのサンプルコード)
  - [GoKartの基本的なサンプルコード](#gokartの基本的なサンプルコード)
  - [GoKartの合流点があるサンプルコード](#gokartの合流点があるサンプルコード)
  - [GoKartのフロー調節をTaskInstanceParameterで行う](#gokartのフロー調節をtaskinstanceparameterで行う)
  - [備考](#備考)


# 環境構築

まず、次のコードでgokartがインストールされているかどうか確認してください。

`!pip list | grep gokart`

## インポートする必要のあるライブラリ

```py
import gokart
import luigi
```


# GoKartのサンプルコード


## GoKartの基本的なサンプルコード

次のコードは、ExampleTaskAの実行結果を標準出力するためだけの、非常に基本的な使用例です。

```py
import gokart
import luigi
class ExampleTaskA(gokart.TaskOnKart):
    param = luigi.Parameter()
    int_param = luigi.IntParameter(default=2)

    def run(self):
        self.dump(f'DONE {self.param}_{self.int_param}')

task_a = ExampleTaskA(param='example')
output = gokart.build(task=task_a)
print(output)
```


## GoKartの合流点があるサンプルコード

ExampleTaskBは、ExampleTaskCとExampleTaskDのタスクの終了を待機します。

この定義はExampleTaskB.requires()により定義されています。

```py
class ExampleTaskC(gokart.TaskOnKart):
    def run(self):
        self.dump('TASKC')
    
class ExampleTaskD(gokart.TaskOnKart):
    def run(self):
        self.dump('TASKD')

class ExampleTaskB(gokart.TaskOnKart):
    param = luigi.Parameter()

    def requires(self):
        return dict(task_c=ExampleTaskC(), task_d=ExampleTaskD())

    def run(self):
        task_c = self.load('task_c')
        task_d = self.load('task_d')
        self.dump(f'DONE {self.param}_{task_c}_{task_d}')
    
task_b = ExampleTaskB(param='example')
output = gokart.build(task=task_b)
print(output)
```

実行結果 : `DONE example_TASKC_TASKD`


## GoKartのフロー調節をTaskInstanceParameterで行う

`TaskInstaceParameter`を使うことで、合流点の結合を回避することができます。

依存関係は前の例と同じですが、`ExampleTaskB.requires()`で定義されるのではなく`タスクの外側で定義される`のが特徴です。

```py
class ExampleTaskC(gokart.TaskOnKart):
    def run(self):
        self.dump('TASKC')
    
class ExampleTaskD(gokart.TaskOnKart):
    def run(self):
        self.dump('TASKD')

class ExampleTaskB(gokart.TaskOnKart):
    param = luigi.Parameter()
    task_1 = gokart.TaskInstanceParameter()
    task_2 = gokart.TaskInstanceParameter()

    def requires(self):
        return dict(task_1=self.task_1, task_2=self.task_2)  # 必要なタスクはタスクパラメータ「task_1」と「task_2」から決定されます`

    def run(self):
        task_1 = self.load('task_1')
        task_2 = self.load('task_2')
        self.dump(f'DONE {self.param}_{task_1}_{task_2}')

# 依存関係はここで定義されます。（Task定義内部ではない）
task_b = ExampleTaskB(param='example', task_1=ExampleTaskC(), task_2=ExampleTaskD())
output = gokart.build(task=task_b)
print(output)
```

実行結果:`DONE example_TASKC_TASKD`




## 備考

title:GoKartのサンプルコード(Pythonのパイプラインパッケージ)

参考:https://github.com/m3dev/gokart/tree/master/docs


img:https://cdn-ak.f.st-hatena.com/images/fotolife/v/vaaaaaanquish/20210415/20210415015242.png

category_script:page_name.startswith("51")


