



## youki とは何か

`youki`の由来は日本語の「容器」と「陽気な」です。

> youki is pronounced as /joʊki/ or yoh-key. youki is named after the Japanese word 'youki', which means 'a container'. In Japanese language, youki also means 'cheerful', 'merry', or 'hilarious'.

from https://github.com/containers/youki/blob/main/docs/src/youki.md


## youki はRustで書かれている。

ほとんどのコンテナランタイムは`Go`言語で書かれています。
例えば、dockerエンジンの本体であるMobyは2024年2月21日現在97%がGo言語で構成されています。(from https://github.com/moby/moby )
しかし、コンテナランタイムにはシステムコールが必要とされていますが、この処理をGo言語で書くと少し複雑になってしまいます。

このシステムコールは比較的シンプルにかけるため、youkiはRust言語を選択しました。
Rust言語はコンテナランタイム界隈ではまだまだこれからの言語ですが、コンテナランタイムを実装するうえで多くのメリットがあり、youkiはそれを証明しようとするプロジェクトです。



from https://event.ospn.jp/odc2021-online/session/405951

上記の記事にもある通り、コンテナランタイムがどのように動いているかを理解できるのも、このプロジェクトの魅力です。
（実際、私はコンテナランタイムやkernelとの関係に興味があり、youkiの学習を始めました）


## Rustのメモリ安全性

RustはC言語と比べれば比較的安全に扱うことができます。
OSやカーネルと直接通信が必要な時に必須となる作業です。

> もっと悪いことに、オペレーティングシステムと直接話したい時には、C 言語 という危険な言語で 会話を しなくてはなりません。C 言語はつねに存在し、逃れることはできないのです。 C 言語はプログラミングの世界での橋渡し言語だからです。 他の安全な言語も、たいてい C 言語のインターフェースを世界中に野放しでさらしています。 理由の如何にかかわらず、あなたのプログラムが C 言語と会話した瞬間に、安全ではなくなるのです。

> とはいえ、Rust は 完全に 安全なプログラミング言語です。

> ・・・いえ、Rust は安全なプログラミング言語をもっていると言えます。一歩下がって考えてみましょう。

from https://doc.rust-jp.rs/rust-nomicon-ja/meet-safe-and-unsafe.html


> 危険な Rust であなたができる事は、たったこれだけです。

- 生ポインタが指す値を得る
- unsafe な関数を呼ぶ（C 言語で書かれた関数や、intrinsic、生のアロケータなど）
- unsafe なトレイトを実装する
- 静的な構造体を変更する
























from https://minegishirei.hatenablog.com/entry/2024/02/22/085916