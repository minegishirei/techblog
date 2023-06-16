

伝統的なデバイス名

ブロックデバイスの伝統的な名前

- HDD, SSD:`/dev/sda`, `/dev/sdb`, `/dev/sdc`...
- NVMe SSD: `dev/nvm0n1`, `dev/nvm0n2`
- VMの仮想デバイス：`dev/vda`, `dev/vdb`, `dev/vdc`...

注意点

## ブロックデバイスを一覧表示するコマンド

ブロックデバイスを一覧表示するコマンド:`lsblk` (ls blockの略)

実行例


## ブロックデバイスの情報を得る

- ブロックデバイスの情報を得る:`/sys/block/<名前>/`配下のファイルを参照

```
ll /sys/block/
```

ディレクトリ配下に大量のデバイスが見えるはず。これは各デバイスの情報を格納しているディレクトリである。


- デバイスのサイズを見る

```
cat /sys/block/<デバイス名>/size
```

- readonly

```sh
cat /sys/block/<デバイス名>/readonly
```

- removable

```sh
cat /sys/block/<デバイス名>/size
```

1か0で確認できる。


## デバイス名の付け方

カーネルは起動時に、デバイスの認識順に a,b,c...とつけていく。

この時、何らかの事情でデバイス認識順が変わると、デバイス名が変わる。
(デバイスの故障など)


## デバイス名を固定する

`Udev`のデバイス名固定機能、`persistent device name`を使用する。
Udevというサービスはデバイスを認識するごとに様々な別名を付けてくれる。


### まずはuuidを確認

デバイスのuuidを確認する。（世界で一意なid）

```sh
ls -l /dev/disk/by-uuid/
```








