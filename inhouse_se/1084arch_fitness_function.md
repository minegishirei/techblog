



アーキテクトがアーキテクチャ特性を明らかにして改善するべき優先順位をつけた後、
開発者にその優先順位を守ってもらうためにはどうすれば良いか。

特に、「アーキテクチャのモジュール性」は緊急ではないが重要であると誰もがわかっているはずだ。
しかし、その重要項目の改善業務に開発者を充てる方法はどのような数値を指し示せば良いだろうか。


## 適応度関数

機械学習の元となる有名な問題に、循環セールスマン問題と言うものがある

```txt
循環セールスマン問題とは...

全ての都市をちょうど一度ずつ巡り出発地に戻る巡回路のうちで
総移動コストが最小のものを求める組合せ最適化問題である。
```

https://ja.wikipedia.org/wiki/循環セールスマン問題


この「コスト」を測る関数にはいくつか候補が存在する。

1. ルートの長さを評価する関数

2. コストを最小限に抑えることを目的とした、ルートに関連する全体的なコストを評価する関数

3. 総移動時間の短縮に最適化することを目的とした、セールスマン問題の巡回時間を評価する関数

これらの「コストを図る関数」を**適応度関数**と呼ぶ。


## アーキテクチャ適応度関数

進化的アーキテクチャでは、この概念を借用してアーキテクチャ適応度関数と言うものを定義した。

**あるアーキテクチャ特性、非要件定義について、客観的な整合性評価を行うための何らかの仕組み。**


検証するアーキテクチャにおいて、適応度関数はさまざまなツールを用いて実装される。

- JDependent:Javaの循環依存を検知するためのプラグイン

https://github.com/clarkware/jdepend

- NetArchTest:.NETでのアーキテクチャの確認ツール

https://github.com/BenMorris/NetArchTest


## 循環依存問題

モジュール性は、ほとんどのアーキテクチャが気にしている暗黙のアーキテクチャ特性だ。
と言うのも、モジュール性がうまく維持されないと、コードベースの構造が損なわれる可能性があり、最終的に保守不可能な状態に陥ってしまうからだ。

次の図では、各コンポーネントが相互に参照してしまった結果、巨大な一つの泥団子のようになってしまっている。

<img src="https://resources.jetbrains.com/help/img/idea/2022.2/cycle-dependencies-scheme.png">

この場合、あるコンポーネントを使用するために他のコンポーネントを持ってこようとすると、最終的に全てのコンポーネントをインポートする必要がある。

このような各コンポーネントが違いに参照してしまう状態を、**循環依存問題**と言う。

ではどのようにしたらこの循環依存問題を未然に防げるのだろうか。

**答えは簡単で、このような循環をチェックする適応度関数を書くことで解決する。**

```java
public class CycleTest {
    private JDepend jdepend;

    @BeforeEach
    void init() {
        jdepend = new JDepend();
        jdepend.addDirectory("/path/to/project/persistence/classes");
        jdepend.addDirectory("/path/to/project/web/classes");
        jdepend.addDirectory("/path/to/project/thirdpartyjars");
    }

    @Test
    void testAllPackages() {
        Collection packages = jdepend.analyze();
        // ここに注目！
        // jdepend.containsCycles()を呼び出して循環依存を確認しちえる
        assertEquals("Cycles exist", false, jdepend.containsCycles());
    }
}
```

このコードでは、メトリクスツールのJDependを使ってパッケージ間の構造に循環依存があるかどうかをチェックし、
循環依存がある場合にテストを失敗させるようになっている。

**このテストをプロジェクトの継続的ビルドに組み込むことで、アーキテクトは循環関係の偶発的な導入を心配する必要がなくなる。**


## 朱系列からの距離を図る適応度関数

主系列からの距離と言う指標を用いた適応度関数も存在する。

```java
@Test
    void AllPackages() {
    double ideal = 0.0;
    // project-dependent Collection packages = jdepend.analyze(); Iterator iter = packages.iterator();
    double tolerance = 0.5; 
    while (iter.hasNext()) {
        JavaPackage p = (JavaPackage)iter.next(); 
        assertEquals("Distance exceeded: " + p.getName(), ideal, p.distance(), tolerance);
    } 
}
```

このコードでは、JDependを用いて主系列からの距離のしきい値を設定し、クラスが範囲外になるとテストが失敗するようにしている。


## レイヤードアーキテクチャの適応度関数

特定のアーキテクチャに対してのみ有効的に発揮される関数もいくつか作成された。

そのうちの一つには、**ArchUnitと呼ばれる、定番のアーキテクチャがルール通りに開発されているかどうかをチェックできるものもある**

ArchUnitはJava用のテストフレームワークで、ユニットテストとしてコード貸された、さまざまな定義済みの統制ルールを提供する。
ArchUnitを使って、「レイヤードアーキテクチャ」をチェックしようとすると次のようになる。

```java
layeredArchitecture()
    .layer("Controller").definedBy("..controller..")
    .layer("Service").definedBy("..service..")
    .layer("Persistence").definedBy("..persistence..")
    .whereLayer("Controller").mayNotBeAccessedByAnyLayer()
    .whereLayer("Service").mayOnlyBeAccessedByLayers("Controller")
    .whereLayer("Persistence").mayOnlyBeAccessedByLayers("Service")
```

この場合、

- Controllerレイヤーがcontrollerクラスで定義されているか

- Serviceレイヤーがserviceクラスで定義されているか

- どのControllerレイヤーも、どこからアクセスされることなく

- ServiceレイヤーがControllerレイヤーからアクセスされる可能性があり

- PersistenceレイヤーがServiceレイヤーからアクセスされる可能性がある

このことをテストできる

また、このようなテストフレームワークは一種類だけでなく、.NETフレームワークでも同様のツールが存在する。
(NetArchTest)

サンプルコードは以下の通り

```c#
var result = Types.InCurrentDomain()
    .That()
    .ResideInNamespace("NetArchTest.SampleLibrary.Presentation")
    .ShouldNot().HaveDependencyOn("NetArchTest.SampleLibrary.Data") 
    .GetResult()
    .IsSuccessful;
```

この場合、**「Presentationクラス」は「Data」クラスに依存するべきではない**と言う内容をテストしている。









## アーキテクチャの成功度合い

title:【アーキテクチャ設計基礎】適応度関数とは何か?

description:アーキテクトがアーキテクチャ特性を明らかにして改善するべき優先順位をつけた後、開発者にその優先順位を守ってもらうためにはどうすれば良いか。特に、「アーキテクチャのモジュール性」は緊急ではないが重要であると誰もがわかっているはずだ。しかし、その重要項目の改善業務に開発者を充てる方法はどのような数値を指し示せば良いだろうか。

category_script:( page_name.startswith("1") or page_name.startswith("2") )

img:https://1048636645-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-MAffO8xa1ZWmgZvfeK2%2F-MK-lT4QGYHB8LD42a_r%2F-MK-lmcxbtabXwjYp6S5%2Fimage.png?alt=media&token=a57491a8-3216-4297-bc52-4e5dd295bc4b


