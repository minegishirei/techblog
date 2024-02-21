



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




























