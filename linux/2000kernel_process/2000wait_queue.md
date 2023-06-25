

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
```



### `wait_queue_func_t func`メンバについて

`wait_queue_func_t` を追いかけていくと`try_to_wake_up`に辿り着く。
これは概念的には次のことを行いう概念です。
`(@state & @p->state) @p->state = TASK_RUNNING`

* タスクがキューに入れられなかった、または実行可能ではなかった場合も、実行キューに戻します。
* この関数は、タスクをデキューするSchedule()に対してアトミックです。
 * @p->state にアクセスする前に完全なメモリバリアを発行します。コメントを参照してください。
 * set_current_state() を使用します。
 * p->pi_lock を使用して、同時ウェイクアップに対してシリアル化します。
 * p->pi_lock の安定化に依存します。
 * - p->sched_class
 * - p->cpus_ptr
 * - p->sched_task_group
 * 移行を行うには、select_task_rq()/set_task_cpu() の使用方法を参照してください。
 * パフォーマンスを向上させるために、task_rq(p)->lock を 1 つだけ取得するよう非常に努力しています。
 * rq->ロックインを受け取ります:
 * - ttwu_runnable() -- 古い rq、避けられない、そこにあるコメントを参照してください。
 * - ttwu_queue() -- タスクのエンキュー用の新しい rq。
 * - psi_ttwu_dequeue() -- とても悲しいです :-( 会計は私たちを殺します。
 * 結果として、私たちはほぼすべてのことについて非常にひどい競争をしています。を参照してください。

```c
/**
 * try_to_wake_up - wake up a thread
 * @p: the thread to be awakened
 * @state: the mask of task states that can be woken
 * @wake_flags: wake modifier flags (WF_*)
 *
 * Conceptually does:
 *
 *   If (@state & @p->state) @p->state = TASK_RUNNING.
 *
 * If the task was not queued/runnable, also place it back on a runqueue.
 *
 * This function is atomic against schedule() which would dequeue the task.
 *
 * It issues a full memory barrier before accessing @p->state, see the comment
 * with set_current_state().
 *
 * Uses p->pi_lock to serialize against concurrent wake-ups.
 *
 * Relies on p->pi_lock stabilizing:
 *  - p->sched_class
 *  - p->cpus_ptr
 *  - p->sched_task_group
 * in order to do migration, see its use of select_task_rq()/set_task_cpu().
 *
 * Tries really hard to only take one task_rq(p)->lock for performance.
 * Takes rq->lock in:
 *  - ttwu_runnable()    -- old rq, unavoidable, see comment there;
 *  - ttwu_queue()       -- new rq, for enqueue of the task;
 *  - psi_ttwu_dequeue() -- much sadness :-( accounting will kill us.
 *
 * As a consequence we race really badly with just about everything. See the
 * many memory barriers and their comments for details.
 *
 * Return: %true if @p->state changes (an actual wakeup was done),
 *	   %false otherwise.
 */
static int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
{
	unsigned long flags;
	int cpu, success = 0;

	preempt_disable(); //プリエンプションを停止する
	if (p == current) {
		/*
		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
		 * == smp_processor_id()'. Together this means we can special
		 * case the whole 'p->on_rq && ttwu_runnable()' case below
		 * without taking any locks.
		 *
		 * In particular:
		 *  - we rely on Program-Order guarantees for all the ordering,
		 *  - we're serialized against set_special_state() by virtue of
		 *    it disabling IRQs (this allows not taking ->pi_lock).
		 */
		if (!ttwu_state_match(p, state, &success))
			goto out;

		trace_sched_waking(p);
		ttwu_do_wakeup(p);
		goto out;
	}

	/*
	 * If we are going to wake up a thread waiting for CONDITION we
	 * need to ensure that CONDITION=1 done by the caller can not be
	 * reordered with p->state check below. This pairs with smp_store_mb()
	 * in set_current_state() that the waiting thread does.
	 */
	raw_spin_lock_irqsave(&p->pi_lock, flags);
	smp_mb__after_spinlock();
	if (!ttwu_state_match(p, state, &success))
		goto unlock;

	trace_sched_waking(p);

	/*
	 * Ensure we load p->on_rq _after_ p->state, otherwise it would
	 * be possible to, falsely, observe p->on_rq == 0 and get stuck
	 * in smp_cond_load_acquire() below.
	 *
	 * sched_ttwu_pending()			try_to_wake_up()
	 *   STORE p->on_rq = 1			  LOAD p->state
	 *   UNLOCK rq->lock
	 *
	 * __schedule() (switch to task 'p')
	 *   LOCK rq->lock			  smp_rmb();
	 *   smp_mb__after_spinlock();
	 *   UNLOCK rq->lock
	 *
	 * [task p]
	 *   STORE p->state = UNINTERRUPTIBLE	  LOAD p->on_rq
	 *
	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
	 * __schedule().  See the comment for smp_mb__after_spinlock().
	 *
	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
	 */
	smp_rmb();
	if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
		goto unlock;

//#ifdef CONFIG_SMP
	/*
	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
	 * possible to, falsely, observe p->on_cpu == 0.
	 *
	 * One must be running (->on_cpu == 1) in order to remove oneself
	 * from the runqueue.
	 *
	 * __schedule() (switch to task 'p')	try_to_wake_up()
	 *   STORE p->on_cpu = 1		  LOAD p->on_rq
	 *   UNLOCK rq->lock
	 *
	 * __schedule() (put 'p' to sleep)
	 *   LOCK rq->lock			  smp_rmb();
	 *   smp_mb__after_spinlock();
	 *   STORE p->on_rq = 0			  LOAD p->on_cpu
	 *
	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
	 * __schedule().  See the comment for smp_mb__after_spinlock().
	 *
	 * Form a control-dep-acquire with p->on_rq == 0 above, to ensure
	 * schedule()'s deactivate_task() has 'happened' and p will no longer
	 * care about it's own p->state. See the comment in __schedule().
	 */
	smp_acquire__after_ctrl_dep();

	/*
	 * We're doing the wakeup (@success == 1), they did a dequeue (p->on_rq
	 * == 0), which means we need to do an enqueue, change p->state to
	 * TASK_WAKING such that we can unlock p->pi_lock before doing the
	 * enqueue, such as ttwu_queue_wakelist().
	 */
	WRITE_ONCE(p->__state, TASK_WAKING);

	/*
	 * If the owning (remote) CPU is still in the middle of schedule() with
	 * this task as prev, considering queueing p on the remote CPUs wake_list
	 * which potentially sends an IPI instead of spinning on p->on_cpu to
	 * let the waker make forward progress. This is safe because IRQs are
	 * disabled and the IPI will deliver after on_cpu is cleared.
	 *
	 * Ensure we load task_cpu(p) after p->on_cpu:
	 *
	 * set_task_cpu(p, cpu);
	 *   STORE p->cpu = @cpu
	 * __schedule() (switch to task 'p')
	 *   LOCK rq->lock
	 *   smp_mb__after_spin_lock()		smp_cond_load_acquire(&p->on_cpu)
	 *   STORE p->on_cpu = 1		LOAD p->cpu
	 *
	 * to ensure we observe the correct CPU on which the task is currently
	 * scheduling.
	 */
	if (smp_load_acquire(&p->on_cpu) &&
	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags))
		goto unlock;

	/*
	 * If the owning (remote) CPU is still in the middle of schedule() with
	 * this task as prev, wait until it's done referencing the task.
	 *
	 * Pairs with the smp_store_release() in finish_task().
	 *
	 * This ensures that tasks getting woken will be fully ordered against
	 * their previous state and preserve Program Order.
	 */
	smp_cond_load_acquire(&p->on_cpu, !VAL);

	cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
	if (task_cpu(p) != cpu) {
		if (p->in_iowait) {
			delayacct_blkio_end(p);
			atomic_dec(&task_rq(p)->nr_iowait);
		}

		wake_flags |= WF_MIGRATED;
		psi_ttwu_dequeue(p);
		set_task_cpu(p, cpu);
	}
//#else
	cpu = task_cpu(p);
//#endif /* CONFIG_SMP */

	ttwu_queue(p, cpu, wake_flags);
unlock:
	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
out:
	if (success)
		ttwu_stat(p, task_cpu(p), wake_flags);
	preempt_enable();

	return success;
}
```

from https://github.com/torvalds/linux/blob/a92b7d26c743b9dc06d520f863d624e94978a1d9/kernel/sched/core.c#L4120C1-L4317C1


