


## コンポーネントの継承のデメリット

例えば、次の二つの名前空間があるとする

- survey（クラス含む：アンケートの通知やアンケートの作成を行う）

- survey.templates（クラス含む：アンケートのテンプレートを含む）

この二つは、明らかに親子関係が存在する。
また、開発者の立場からすれば、これらの親子関係は理にかなっている様に見える。


しかし、**このようなコンポーネントの親子関係はいくつか問題を生む。**

- これらのコンポーネントは厳密に言えば独立しておらず、これらのコンポーネントから一つのサービスを作ろうとしても、templatesはsurveyサービスに入れるか、別のサービスとして独立させるかが曖昧になる。

- コンポーネントを継承のような関係で利用すると濃い結合が発生する。例えば、survey内にあるクラスの変更は、templatesの変更を余儀なくさせる可能性が高い。

この様に、**名前空間の末端以外にクラスがあることは一般的には回避するべきである**
この、名前空間の末端以外に存在するクラスを、**孤立クラス**と呼ぶ


## 参考:Software Architecture: The Hard Parts

https://dl.ebooksworld.ir/books/Software.Architecture.The.Hard.Parts.Neal.Ford.OReilly.9781492086895.EBooksWorld.ir.pdf


## コンポーネントのフラット化とは

このようなコンポーネントの親子関係を回避し、**コンポーネントをフラット化する**とは次の様な関係である。

- survey（クラスを含まない）

- survey.create（クラスを含む：アンケートの作成）

- survey.send（クラスを含む：アンケートの送信）

- survey.template（クラスを含む：アンケートのテンプレート）

- survey.shared（クラスを含む；アンケートのテンプレートを含む）

この様にすることで、createの変更はsendに影響を及ぼすことはなく、安全にアンケートの作成に取り組むことができる。
(また、これらのコンポーネントの使用の際には、**集約**を意識して使用することをお勧めする。)

また、surveyコンポーネントにはクラスを含まないため、survey内部のクラスが他のコンポーネントへ影響を与えることはない。


## コンポーネントのフラット化：具体例

例えば、ss名前空間の中にserveyという名前空間が入子構造として存在していたとする。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/3100_component_flat/flat1.png?raw=true">

このときservey名前空間にクラスが存在している場合、このクラスは**孤立クラス**として扱われ、望まれない状態である。
（このクラスをサービス化する際に、どの様なサービスにすればいいかで問題が発生する。）

survey全体をフラット化するためには次の2通りの選択肢がある。

### 孤立クラスが存在する名前空間に、ノードリーフ名前空間を移動する

孤立クラスと同じ階層にノードリーフ名前空間を移動するのが方法1である。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/3100_component_flat/flat_a.png?raw=true">

この場合、templates名前空間を.surveyの段階に落としている。
テンプレートコードを.surveyまで移動させることで、surveyのさらにその先の名前空間がなくなり、surveyはコンポーネントとしてフラットになった。


### 孤立クラスを分解し、新たなノードリーフ空間を作成する

孤立クラスのところに移動させるのではなく、孤立クラスをノードリーフ名前空間へ移動させるのが方法2である。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/3100_component_flat/flat_b.png?raw=true">

この場合、.survey名前空間に新しく3つの名前空間が作成されている。

- .createと.processは元々.surveyにあった孤立クラスを分解した物である。

- sharedはsurvey内部で使用する共通のコンポーネントである。

- templateは移動していない。他のクラスが移動してきている。

この様にすることで、.surveyはコンポーネントとしてフラットになった。




















## 備考

title:コンポーネントのフラット化とは何か？【リファクタリング入門3】

description:名前空間の末端以外にクラスがあることは一般的には回避するべきである。この、名前空間の末端以外に存在するクラスを、**孤立クラス**と呼び、この孤立クラスをなくすことをフラット化と呼ぶ。

img:https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/3063/breakdown.png?raw=true

category_script:page_name.startswith("3")

