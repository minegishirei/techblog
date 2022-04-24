


## 概要

マイクロカーネルアーキテクチャは別名、プラグインアーキテクチャと呼ばれている。

システムは「コアシステム」「プラグインコンポーネント」の二種類から成り立ち、

中央集約型の「コアシステム」に対して「プラグインコンポーネント」を取り付ける形で構成される。


<img src="https://camo.githubusercontent.com/a867bf149f55ee6f496db5243b2b7b6dba7211264ed2d3199ded869ed609dfbe/68747470733a2f2f6c6561726e696e672e6f7265696c6c792e636f6d2f6c6962726172792f766965772f66756e64616d656e74616c732d6f662d736f6674776172652f393738313439323034333434372f6173736574732f666f73615f313230312e706e67">

コアシステム本体は場合によってはレイヤードアーキテクチャにもなる

コアシステムのアーキテクチャ例１

<img src="https://camo.githubusercontent.com/a15ea6ecef1695b3ee03f8c35c42242776ea4388cf335d945b5a20f2094b5636/68747470733a2f2f6c6561726e696e672e6f7265696c6c792e636f6d2f6c6962726172792f766965772f66756e64616d656e74616c732d6f662d736f6674776172652f393738313439323034333434372f6173736574732f666f73615f313230322e706e67">

例2

<img src="https://camo.githubusercontent.com/e420e50c2846ba2f2dfd0dfcff03b6365ee37449917a28ad7b96e0b5737d9023/68747470733a2f2f6c6561726e696e672e6f7265696c6c792e636f6d2f6c6962726172792f766965772f66756e64616d656e74616c732d6f662d736f6674776172652f393738313439323034333434372f6173736574732f666f73615f313230332e706e67">


## コアシステム

コアシステムはシステムの実行に必要な最小限の機能

コアシステムはシンプルな構成にし、それ以外の余分な機能をその他のコンポーネントに任せることで、
拡張性と保守性が向上し、テスト性が向上します

以下の例ではデバイスごとに設定されたメソッドgetConstructorを
DevicePluginを用いて本体であるマイクロカーネルからの呼び出しを可能にしている

<pre><code>
public void assessDevice(String deviceID) {	
    String plugin = pluginRegistry.get(deviceID);	
    Class<?> theClass = Class.forName(plugin);	
    Constructor<?> constructor = theClass.getConstructor();
    DevicePlugin devicePlugin = (DevicePlugin)constructor.newInstance();
    DevicePlugin.assess();
}
</code></pre>

## プラグインコンポーネント

プラグインコンポーネントはスタンドアローンで、独立している。

コアシステムを拡張または拡張することを目的とした、特殊な処理、追加機能、およびカスタムコードを含むコンポーネントです

さらに、これらを使用して揮発性の高いコードを分離し、アプリケーション内の保守性とテスト性を向上させることができます。

理想的には、**プラグインコンポーネントは互いに独立しており、それらの間に依存関係がない必要があります。**

ポイントツーポイントプラグインコンポーネントは、共有ライブラリ（JAR、DLL、Gemなど）、Javaのパッケージ名、またはC＃の名前空間として実装できます。

<img src="https://camo.githubusercontent.com/33d4ad40701793c236ebc7c735fe6da6df3c49f67b9414b2d7197281efc115c6/68747470733a2f2f6c6561726e696e672e6f7265696c6c792e636f6d2f6c6962726172792f766965772f66756e64616d656e74616c732d6f662d736f6674776172652f393738313439323034333434372f6173736574732f666f73615f313230342e706e67">


プラグインコンポーネントは、必ずしもコアシステムとのポイントツーポイント通信である必要はありません。

プラグイン機能を呼び出す手段としてRESTまたはメッセージングを使用するなど、他の選択肢もあります。

各プラグインはスタンドアロンサービス（またはコンテナを使用して実装されたマイクロサービス）です。

<img src="https://camo.githubusercontent.com/36b97e74ca6eccac45bef98a9952c5729ba2a3827f07a2f969228b9fa36c6072/68747470733a2f2f6c6561726e696e672e6f7265696c6c792e636f6d2f6c6962726172792f766965772f66756e64616d656e74616c732d6f662d736f6674776172652f393738313439323034333434372f6173736574732f666f73615f313230362e706e67">

プラグインコンポーネントがデータベースにアクセスすることは一般的にはありえない。

ただし、それぞれのプラグインコンポーネントがデータベースを持つことはあり得る。

<img src="https://camo.githubusercontent.com/932cc3e7d08f2ec11cd18fc6b10cf9e60ac9cc1202e09ae491d623e0800e28e2/68747470733a2f2f6c6561726e696e672e6f7265696c6c792e636f6d2f6c6962726172792f766965772f66756e64616d656e74616c732d6f662d736f6674776172652f393738313439323034333434372f6173736574732f666f73615f313230372e706e67">


## プラグインコンポーネントの存在認知

プラグインを利用するためには、まずそのプラグインが存在していることを把握しなければなりません。

そのためには次の方法が考えられれます。

・レジストリへの登録

・サードパーティ性のライブラリとしての運用



## メリット

プラグインアーキテクチャは、Visual Studio CodeやEclipseなど、開発者向けのツールでよく使用される。

ソフトのサイズを抑え、余分な機能を削ぎ落とすことに特化している機能でもある。

具体例では、**請求書作成アプリケーション**などが当たる。

米国の請求書の税率は週ごとに異なり、またその週の中でも細かくルールを定められていることがある。

このような場合にif文を使った条件分岐を行うことは、ソースの泥団子化を引き起こしかねない。

そのような場合に「各州の情報を定めたクラスを作成し、外部のプラグインコンポーネントとして扱うことで、システムの健全性を保つことができる」


## まとめ

総評は以下の通り

<img src="https://camo.githubusercontent.com/36cefa78150c21b321909d0beeaa6b8aa18d746235c8390688e4fab57de93146/68747470733a2f2f6c6561726e696e672e6f7265696c6c792e636f6d2f6c6962726172792f766965772f66756e64616d656e74616c732d6f662d736f6674776172652f393738313439323034333434372f6173736574732f666f73615f313230382e706e67">



## 備考

title:プラグインアーキテクチャのメリットとデメリット【アーキテクチャ詳細】

description:マイクロカーネルアーキテクチャは別名、プラグインアーキテクチャと呼ばれている。システムは「コアシステム」「プラグインコンポーネント」の二種類から成り立ち、中央集約型の「コアシステム」に対して「プラグインコンポーネント」を取り付ける形で構成される。


category_script:page_name.startswith("2")

img:https://camo.githubusercontent.com/a867bf149f55ee6f496db5243b2b7b6dba7211264ed2d3199ded869ed609dfbe/68747470733a2f2f6c6561726e696e672e6f7265696c6c792e636f6d2f6c6962726172792f766965772f66756e64616d656e74616c732d6f662d736f6674776172652f393738313439323034333434372f6173736574732f666f73615f313230312e706e67