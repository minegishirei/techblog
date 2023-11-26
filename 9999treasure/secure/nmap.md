
- [nmapしてもいいサイト](#nmapしてもいいサイト)
- [ためしにnmapしてみよう](#ためしにnmapしてみよう)





## nmapしてもいいサイト


Nmapは、ポートスキャンやサービス探索など、さまざまなネットワーク探索タスクに使用されるツールです。ただし、Nmapを使用して他人のネットワークをスキャンすることは、法的に問題がある場合がありますので、十分に注意してください。

**以下のサイトは「2023年04月03日」時点ではnmapをオッケーしているサイトです。**
ただし、負荷の強いコマンドは禁止しているようですので、注意してお使いください。

http://scanme.nmap.org/


> こんにちは。Nmap Security Scanner Projectが提供するサービス、Scanme.Nmap.Org へようこそ。

> このマシンは、人々が Nmap について学習するのを支援し、Nmap のインストール (またはインターネット接続) が適切に機能していることをテストして確認するためにセットアップしました。このマシンを Nmap またはその他のポート スキャナーでスキャンする権限があります。サーバーを強く叩きすぎないようにしてください。1 日に数回のスキャンは問題ありませんが、1 日に 100 回スキャンしたり、このサイトを使用して ssh ブルート フォース パスワード クラッキング ツールをテストしたりしないでください。

> ありがとう
> -フョードル


## ためしにnmapしてみよう

それでは試しにnmapをしてみましょう。
msfconsoleを使用している人はそちらでもかまいませんし、独自にnmapコマンドをインストールするでもいいでしょう。

```sh
nmap http://scanme.nmap.org/
```

実行結果：IPアドレスが存在しません。

```
Starting Nmap 7.92 ( https://nmap.org ) at 2023-04-03 02:00 UTC
Unable to split netmask from target expression: "http://scanme.nmap.org/"
WARNING: No targets were specified, so 0 hosts scanned.
Nmap done: 0 IP addresses (0 hosts up) scanned in 0.05 seconds
```

エラーを見ると、ドメインが存在していないと言われてしまった。
httpsを外してもう一度行う。

```sh
nmap scanme.nmap.org
```

実行中は以下のようなログが出力されます。

```
[*] exec: nmap scanme.nmap.org

Starting Nmap 7.92 ( https://nmap.org ) at 2023-04-03 02:00 UTC
Stats: 0:01:19 elapsed; 0 hosts completed (1 up), 1 undergoing SYN Stealth Scan
SYN Stealth Scan Timing: About 58.19% done; ETC: 02:03 (0:00:57 remaining)
```

エンターを押すことで、更新された情報を見ることができます。
実際エンターを押すとログが増えているのがわかります。

```
[*] exec: nmap scanme.nmap.org

Starting Nmap 7.92 ( https://nmap.org ) at 2023-04-03 02:00 UTC
Stats: 0:01:19 elapsed; 0 hosts completed (1 up), 1 undergoing SYN Stealth Scan
SYN Stealth Scan Timing: About 58.19% done; ETC: 02:03 (0:00:57 remaining)
Warning: 45.33.32.156 giving up on port because retransmission cap hit (10).
Stats: 0:02:54 elapsed; 0 hosts completed (1 up), 1 undergoing SYN Stealth Scan
SYN Stealth Scan Timing: About 59.62% done; ETC: 02:05 (0:01:58 remaining)
```














