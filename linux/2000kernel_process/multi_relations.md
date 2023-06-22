






まずは双方向リストについて解説する。
Linuxkernel内部では`list_head`というデータ構造が用意されており、これが様々な場面で使用される。
このデータ構造は`next`と`prev`の二つのメンバを持ち、データ構造に前後の概念を導入したいときに使用される。

<figure class="figure-image figure-image-fotolife" title="双方向リスト">[f:id:minegishirei:20230622105506p:plain:alt=双方向リスト]<figcaption>双方向リスト</figcaption></figure>


## list_headの定義

list_headは以下のように定義されている。

```c
struct list_head {
	struct list_head *next, *prev;
};
```


### list_headの作成

list_headの作成には`LIST_HEAD`マクロを使用する。

```c
#define LIST_HEAD_INIT(name) { &(name), &(name) }

#define LIST_HEAD(name) \
	struct list_head name = LIST_HEAD_INIT(name)
```

from https://github.com/torvalds/linux/blob/dad9774deaf1cf8e8f7483310dfb2690310193d2/scripts/kconfig/list.h#LL29C1-L32C46


このマクロを使用する際には`LIST_HEAD(list_name)`と宣言することで新しいlist_headを作成することができる


### list_headの操作

list_headを操作するためにいくつかの関数が用意されている。

- `list_add(n, p)`:　pが指す要素の直後に、nが指す要素を挿入する
- `list_add_tail(n, p)`: pが指す要素の直前に、nが指す要素を挿入する
- `list_del(p)`: pが指す要素を削除する
- `list_for_each(p)`: リストの先頭(h)で指定したリストの各要素を操作する。


## プロセスリスト

存在するすべてのプロセスディスクリプタをリンクするためにも、`list_head`は使われています。


```c
struct task_struct {
    ...
	struct list_head		tasks;
    ...
}
```

from https://github.com/torvalds/linux/blob/dad9774deaf1cf8e8f7483310dfb2690310193d2/include/linux/sched.h#LL864C1-L866C26


それぞれの`task_struct`構造体は上記の通り、`list_head`がたの`tasks`メンバを持ち、この`tasks`メンバの`prev`メンバがひとつ前の`task_struct`要素を指し、`next`メンバがひとつ後の`task_struct`要素を指しています。

プロセスリストの先頭には常に`task_struct`がたの`init_task`が格納されており、`init_task`はいわゆるプロセス0、つまりswapperのプロセスディスクリプタとなります。



## プロセスの親子関係

- プログラムから生成されたプロセスには親子関係があります。
- プロセスが複数のプロセスを生成するとき、プロセス間には兄弟関係が構築されます。

こうした兄弟/親子関係を表すメンバが、プロセスディスクリプタには存在します。

### プロセスを生成したプロセスディスクリプタ

プロセスPを生成したプロセスディスクリプタは`real_parent`メンバに格納されます。
（本物の）と名前が付く通り、このプロセスは削除される可能性もあります。
その場合はプロセス1を示すようになります。

```c
struct task_struct {
    ...
	/* Real parent process: */
	struct task_struct __rcu	*real_parent;
    ...
}
```


### プロセスの現在の親

プロセスPの"現在の"親プロセスを示します。この値は通常は`real_pparent`と同じですが、ほかのプロセスが`ptrace()`システムコールを使用してプロセスを監視するときなど、異なる番号を示すケースもあります。

```c
struct task_struct {
    ...
 	/* Recipient of SIGCHLD, wait4() reports: */
	struct task_struct __rcu	*parent;
    ...
}
```


### プロセスのすべての子/親戚

プロセスの現在の子供、親戚のデータは`children`,`sibling`にそれぞれ格納されます。

```c
struct task_struct {
    ...
 	/*
	 * Children/sibling form the list of natural children:
	 */
	struct list_head		children;
	struct list_head		sibling;
    ...
}
```






from https://www.youtube.com/watch?v=bLw4HocrZiA











