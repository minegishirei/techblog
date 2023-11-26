




## 名前空間を整備する

まず、モノシリックアプリケーションの分解では、その足掛かりとして目指すべきアーキテクチャはサービスベースアーキテクチャである。
コンポーネントドメインを作成することは、サービスベースアーキテクチャへの移行を手助けする。

コンポーネントドメインとは、名前空間の名前のことで物理的に表示される。
そして、コンポーネントを表すドメインは次の4つから構成されるべきだ。

`アプリケーション.ドメイン.サブドメイン.コンポーネント.クラス`


### 名前空間のサンプル例

例えば、次の様な条件があるとする

- アプリケーション:ss

- ドメイン:customer

- サブドメイン:billing

- コンポーネント:payment

- クラス:MonthlyBilling

この場合の名前空間、及びクラスは次の様になる。

`ss.customer.billing.payment.MonthlyBilling`

**コンポーネントを表す名前空間は上の4つの階層からなるのが望ましい**が、古くからあるモノシリックアプリケーションの中にはドメイン駆動開発が普及する前に実装されたものも多く存在する。

例えば、次のような名前空間から構成されるアプリケーションはいくつかの問題を含んでいる。

| コンポーネント   | 名前空間            | 
| ---------------- | ------------------- | 
| 請求             | ss.billing.payment  | 
| 履歴             | ss.billing.history  | 
| 顧客プロフィール | ss.customer.profile | 
| 契約             | ss.supportcontract  | 

まず、各コンポーネントは顧客の機能に関連しているにもかかわらず、対応する名前空間にはその関連性が示されていない。
したがって、まずはいずれの名前空間にはサブドメインとしてcustomerドメインを追加する必要がある。

| コンポーネント   | 名前空間            | 
| ---------------- | ------------------- | 
| 請求             | ss.customer.billing.payment  | 
| 履歴             | ss.customer.billing.history  | 
| 顧客プロフィール | ss.customer.profile | 
| 契約             | ss.customer.supportcontract  | 

名前空間の先頭にcustomerを追加したことで、これら4つのコンポーネントの関連性が明らかになった。

### 名前空間を検知し続ける適応度関数

アプリケーション内部にチケット、顧客、管理者のドメインしか存在しないように監視するコードは次の通りである。

```java
public void restrict_domains() {
    classes()
    .should().resideInAPackage("..ss.ticket..")
    .orShould().resideInAPackage("..ss.customer..")
    .orShould().resideInAPackage("..ss.admin..")
    .check(myClasses);
}
```

この適応度関数は、開発チームが勝手に追加のドメインを作成してしまわないように監視し続けてくれる。
この関数もCI/CDパイプラインに追加しておくべきだ。

## 参考:Software Architecture Hard Parts

https://dl.ebooksworld.ir/books/Software.Architecture.The.Hard.Parts.Neal.Ford.OReilly.9781492086895.EBooksWorld.ir.pdf


## 備考

title:名前空間の設計方法【リファクタリング入門5】

description:名前空間の設計について解説。アプリケーションのコードの設計で最も大きな枠となるのが名前空間である。アプリケーションがきちんとした設計を保ち、保守可能な状態を維持できるかは名前空間のしっかりとした設計が第一となる。

img:https://github.com/kawadasatoshi/techblog/blob/main/0/inhouse_se/3063/breakdown.png?raw=true

category_script:page_name.startswith("3")



