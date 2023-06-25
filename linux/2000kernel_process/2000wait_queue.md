

## 待ちキューの実装

プロセスは頻繁に待ち状態になります。

特に、割り込み処理、プロセスの動機、タイミングを取るときになどに待ちキューを使用します。
プロセスはディスク入出力の終了、システム資源の解放、一定時間の経過などを待つ必要があることをだけを覚えておいてください。

### 待ちキュー内の要素

待ちキュー内の要素は何かしらの事象を待っている状態です。

待ちキューは双方向リスト(`list_head`)によって実装されます。
待ちキューの要素は`wait_queue_t`型として定義されます。

```c
struct __wait_queue {
    unsigned int flags;
    struct task_struct * task;
    wait_queue_func_t func;
    struct list_head task_list;
}
```

- taskメンバはそのプロセスディスクリプタを指しています。
- task_listメンバは同じ事象の発生を待ち合わせているプロセスのリスト中の要素を指すポインタを格納します。


#### 待ちキューの頭

各待ちキューは双方向リストとして作られています。
そして、待ちキューの先頭は特別なデータが入ります。
それが、`wait_queue_head_t`です。

```c
struct __wait_queue_head {
    spinlock_t lock;
    struct list_head task_list;
}
```

同期は待ちキュー内のスピンロックによって行います。



##### spinlock_tについて

spinlockは例えば以下のようなコードで実装される。

> あるデータを取りに行こうとしたときに、とれるまで無限ループを繰り返すというもの。

```c
static inline void bit_spin_lock(int bitnum, unsigned long *addr)
{
	/*
	 * Assuming the lock is uncontended, this never enters
	 * the body of the outer loop. If it is contended, then
	 * within the inner loop a non-atomic test is used to
	 * busywait with less bus contention for a good time to
	 * attempt to acquire the lock bit.
	 */
	preempt_disable();
	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
		preempt_enable();
		do {
			cpu_relax();
		} while (test_bit(bitnum, addr));
		preempt_disable();
	}
	__acquire(bitlock);
}
```

from https://github.com/torvalds/linux/blob/8a28a0b6f1a1dcbf5a834600a9acfbe2ba51e5eb/include/linux/bit_spinlock.h#L16C1-L36C2


#### 待ちキューの初期化

待ちキューの頭の初期化はマクロで行います。
いかがそのコードです。

```c
#define __WAIT_QUEUE_HEAD_INITIALIZER(name) {					\
	.lock		= __SPIN_LOCK_UNLOCKED(name.lock),			\
	.head		= LIST_HEAD_INIT(name.head) }

#define DECLARE_WAIT_QUEUE_HEAD(name) \
	struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
```

from https://github.com/torvalds/linux/blob/8a28a0b6f1a1dcbf5a834600a9acfbe2ba51e5eb/include/linux/wait.h#L57C1-L62C67


### プロセスへの`sleep_on`関数

この関数は

- 条件を確認した結果、その結果が成立していないような場合に、*アトミックに*プロセスを待ち状態にするという関数です。
	- ここでの*アトミック*とは、極めて小さい期間という意味です。

from https://github.com/torvalds/linux/blob/8a28a0b6f1a1dcbf5a834600a9acfbe2ba51e5eb/net/sunrpc/sched.c#L447C1-L462C2



### 待ち状態への設定

`prepara_to_wait(&wq, &wait, task)`関数は

1. プロセスの状態を第三匹すうの値に設定します
2. 待ちキューの要素の排他フラグを0(排他的でない)にします
3. 待ちキューの頭がwqである待ちキューのリストに、待ちキュー要素(wait)を挿入します

このようにして、要素(`wait`)を待ち状態にするのです。
ちなみに、`prepare_to_wait_exclusive()`も存在しますが、これは2番の排他フラグを1(排他的)に設定します。


### 待ち状態からの回復

プロセスは起床すると、すぐに`finish_wait()`関数を呼び出します。
- `finish_wait()`関数はまず、プロセスの状態を再度`TASK_RUNNING`に設定します。
	これは、`Schedule()`関数を呼び出す前でも、プロセスが起床しているという条件が成立するようにするためです。
- 次に、待ちキューのリストから、待ちキュー要素を削除します。

### `wait_event`と`wait_event_interruptible`マクロ

- `wait_event`と`wait_event_interruptible`マクロは呼び出したプロセスを条件が成り立つまで待ちキューで待たせます。

例えば`wait_event(wq, condition)`マクロは次のようなコードです。

```c
DEFINE_WAIT(__wait);
for (;;){
	prepara_to_wait(&wq, &wait, TASK_UNINTERRUPTIBLE);
	if (condition)
}
finish_wait(&wq, &__wait);
```



### プロセスの起床

カーネルは次のマクロ(`wake_up`)によって待ちキュー上のプロセスを起こし、`TASK_RUNNING`状態にします。

```c
void wake_up(wait_queue_head_t, *q){
	struct list_head *tmp
	wait_queue_t *curr;
	list_for_each(tmp, &q->task_list){
		// wait_queue_tのアドレスの先頭を求める。
		curr = list_entry(tmp, wait_queue_t, task_list)
		// func:プロセスの起床関数のアドレス。実際に起床すれば1が帰る。
		if ( curr->func(curr, TASK_INTERRUPTIBLE|TASK_UNINTERUPTIBLE,0,NULL) && curr->flags)
			break;
	}
}






