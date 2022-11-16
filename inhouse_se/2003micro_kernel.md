


## 概要

マイクロカーネルアーキテクチャは別名、プラグインアーキテクチャと呼ばれている。

コアシステムとプラグインの二つのコンポーネントで構成される比較的シンプルなアーキテクチャであり、**アプリケーションのカスタムロジックの結合と分離を実現している。**

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2003micro_kernel/micro_kernel.png?raw=true">

プラグインアーキテクチャの用途は大きく分けて2種類あり、

- パッケージ化され、単一のモノシリックなアプリとしてダウンロードされてインストールできるようなアプリケーション

- カスタムビジネス(国ごとのローカライズが発生するなど)アプリケーション

このいずれかで使用される。

今回は前者の意味合いで(ダウンロードして使用するタイプのアプリケーションで)解説する。


## プラグインアーキテクチャの構成

システムは「コアシステム」「プラグインコンポーネント」の二種類から成り立ち、
中央集約型の「コアシステム」に対して「プラグインコンポーネント」を取り付ける形で構成される。


コアシステム本体は場合によっては[レイヤードアーキテクチャ](./2001layerd_arch.md)にもなる。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2003micro_kernel/layerd.png?raw=true">

あるいは、[レイヤードアーキテクチャ](./2001layerd_arch.md)のような技術的な分割ではなく[ドメインごとに分けられたアーキテクチャ](./2008microservice_arch.md)も選択肢に入るだろう。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2003micro_kernel/micro_kernel.png?raw=true">

いずれにせよ、「コアシステム」「プラグインコンポーネント」で分けられ、「コアシステム」本体には制約はない。


## プラグインアーキテクチャの使用例

- EclipseやAndroid Studioなどの統合開発環境はプラグインアーキテクチャを使用している

- 支払い方法の選択(クレジットカード,PayPaI、ストアクレジット、ギフトカード)が発生する場合も候補になる

- ローカライゼーション（言語選択や地域選択など）


### Eclipseはプラグインアーキテクチャである。

EclipseはJavaの開発環境である。

*Java開発に必要な機能の多くが同梱されており、独自のJavaコンパイラ（ECJ：Eclipse Compiler for Java）も添付されているほか、単体テストツールJUnitやビルドツールAntなどJava開発で標準的に用いられる外部ツールと連携することができる。*

https://e-words.jp/w/Eclipse.html

Eclipseのメインとなるシステムでは、**ファイルを開き、テキストを編集して、閉じる**だけのメモ帳と大差ないロジックしかない。
そこに、プラグインを適切に扱うロジックを入れて、外部のプラグインを迎え入れているのだ。

プラグインを追加して初めてEclipseはEclipseになるのだ。

<img src="https://genpaku.org/other/eclipse/plugin_architecturej/plugin_architecture.files/eclipse_extensions.jpg">

https://genpaku.org/other/eclipse/plugin_architecturej/plugin_architecture.html

プラグイン拡張に関与するオブジェクト。workbench UIプラグインは、独自のヘルプ関連メニュー項目を定義しているactionSets拡張機能を通して、workbenchヘルプ・プラグインによって拡張される。


## コアシステム

コアシステムはシステムの実行に必要な最小限の機能で構成される。

それ以外の余分な機能をその他のコンポーネントに任せることで、
コアシステム本体拡張性と保守性が向上し、テスト性が向上する。

### サンプルコード

例えば、デバイスと連携する必要のあるソフトウェアを組むことになったとする。
どのように連携するかはデバイスごとに異なる場合、これはプラグインアーキテクチャを採用する候補になり得る。

どのようなコードを組むかの議論になった時に、次のようにif分岐で対応するのは一つの案ではある。
（これでも十分プラグインアーキテクチャだ）

```java
public void assessDevice(String deviceID) { 
    if (deviceID.equals("iPhone6s")) {
        assessiPhone6s();
    } else if (deviceID.equals("iPad1"))
        assessiPad1();
    } else if (deviceID.equals("Galaxy5"))
        assessGalaxy5(); 
    } else {

    }
}
```

しかし、これでは新しいデバイスを追加するたびにif分岐を追加しなくてはならない。
**プラグインアーキテクチャのメリットは、本体のコードをいじらずに外部のコンポーネントで対応できる点だが、これでは本体に影響が出てしまう**

次のコードでは、deviceIDごとに新しいクラスを宣言している

```java
public void assessDevice(String deviceID) {
    String plugin = pluginRegistry.get(deviceID);
    Class<?> theClass = Class.forName(plugin); 
    Constructor<?> constructor = theClass.getConstructor(); 
    DevicePlugin devicePlugin = (DevicePlugin)constructor.newInstance(); 
    DevicePlugin.assess();
}
```

`Class.forName(plugin)`で新しいdeviceIDが宣言されるたびに、新しいクラスを生み出してassessメソッドを実行していることに成功している。



## プラグインコンポーネント

プラグインコンポーネントはスタンドアローンで、独立しているシステムである。
コアシステムを拡張または拡張することを目的とした、特殊な処理、追加機能、およびカスタムコードを含むコンポーネントです。
さらに、これらを使用して**揮発性の高いコードを分離し**、**アプリケーション内の保守性とテスト性を向上させることができます。**

理想的には、**プラグインコンポーネントは互いに独立しており、それらの間に依存関係がない必要があります。**

プラグインコンポーネントは

- 共有ライブラリ(JAR、DLL、Gemなど)

- Javaのパッケージ名、
 
- C＃の名前空間

として実装できます。

<img>

### プラグインコンポーネントはAPIとして実装可能

プラグインコンポーネントは、**必ずしもコアシステムとのポイントツーポイント通信である必要はありません。**

プラグイン機能を呼び出す手段として**RestFULL-APIまたはメッセージングを使用するなど、他の選択肢もあります。**
この場合、各プラグインはスタンドアロンサービス（またはコンテナを使用して実装されたマイクロサービス）です。

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2003micro_kernel/restfull_micro_kernel.png?raw=true">

この場合、コードレベルではなく**システムやコンテナレベルで結合が可能になったため、疎結合による再利用やテスト容易性が高まるのがメリットだ。**

しかし、モノシリックなアーキテクチャではなく分散アーキテクチャになり、全体のシステムも複雑になってしまうのがデメリットだ。


## プラグインコンポーネントがデータベースを持つこともあり得る

プラグインコンポーネントがデータベースにアクセスすることは一般的にはありえない。
理由はプラグインコンポーネントが与える変更はコアシステムにのみ影響されるべきであり、コアシステムのデータベースに影響を与えるべきではないからだ。

ただし、**それぞれのプラグインコンポーネントがデータベースを持つことはあり得る。**

<img src="https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2003micro_kernel/micro_kernel_database.png?raw=true">





## プラグインコンポーネントの存在認知

ユーザーやカスタマーサービス担当者がプラグインを利用するためには、まずそのプラグインが存在していることを把握しなければなりません。

そのためには次の方法が考えられれます。

- レジストリへの登録

- サードパーティ性のライブラリとしての運用

### レジストリを登録する

例えば、税務調査でリスクの高い項目にフラグを立てる税務ソフトのプラグインの場合、レジストリには次の情報が登録される

- サービス名

- データコントラクト（入力データと出力データ）

- コントラクト形式(XML形式やCSVなど)

などの情報が登録される。



## メリット

プラグインアーキテクチャは、Visual Studio CodeやEclipseなど、開発者向けのツールでよく使用される。

ソフトのサイズを抑え、余分な機能を削ぎ落とすことに特化している機能でもある。

他の具体例では、**請求書作成アプリケーション**などが当たる。

米国の請求書の税率は州ごとに異なり、またその週の中でも細かくルールを定められていることがある。
このような場合にif文を使った条件分岐を行うことは、ソースの泥団子化を引き起こし、意図しない変更を招きかねない。

そのような場合に**各州の情報を定めたクラスを作成し、外部のプラグインコンポーネントとして扱うことで、コアシステムの健全性を保つことができる**





## 備考

title:プラグインを使用するシステムの実装方法

description:マイクロカーネルアーキテクチャは別名、プラグインアーキテクチャと呼ばれている。システムは「コアシステム」「プラグインコンポーネント」の二種類から成り立ち、中央集約型の「コアシステム」に対して「プラグインコンポーネント」を取り付ける形で構成される。


category_script:(page_name.startswith("2") or page_name.startswith("1"))

img:https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/2003micro_kernel/micro_kernel.png?raw=true



