

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












