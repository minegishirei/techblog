



## `task_struct`について

プロセスに関する情報は`task_struct`構造体に格納される。
**プロセスディスクリプタ**とも呼ばれる。

プロセスの情報は具体的には以下のようなものがあげられる。

- プロセスの属性
- CPU上で実行されているか
- あるいは何かしらの事象を待って止められているか
- どのファイルへのアクセス権が許可されているか

などなどプロセス状態を格納するメンバがそろっている。
それだけでなく、情報が格納されているほかの構造体へのポインタが入っているメンバもあります。

- `thread_info` :プロセスに対応する低水準（低レイヤー）な情報
- `mm_struct`   :メモリリージョンディスクリプタへのポインタ
- `tty_struct`  :プロセスに対応するtty（制御端末）
- `fs_struct`   :カレントディレクトリ
- `files_struct`:ファイルディスクリプタへのポインタ
- `signal_struct`:受信シグナル


linuxkernelでは以下のファイルに存在する。

`linux-3.12.6/include/linux/sched.h`

```c
struct task_struct {
    volatile long state;    /* -1 unrunnable, 0 runnable, >0 stopped */
    ...
    int exit_state;
    int exit_code, exit_signal;
    ...
    struct task_struct __rcu *real_parent; /* real parent process */
    struct task_struct __rcu *parent; /* recipient of SIGCHLD, wait4() reports */
    ...
    struct list_head children;      /* list of my children */
    struct list_head sibling;       /* linkage in my parent's children list */
    struct task_struct *group_leader;       /* threadgroup leader */
	struct mm_struct		*mm;
	struct mm_struct		*active_mm;
    ...
    struct pid_link pids[PIDTYPE_MAX];
    ...
    const struct cred __rcu *cred;  /* effective (overridable) subjective task*/
    ...
    char comm[TASK_COMM_LEN]; /* executable name excluding path
    - access with [gs]et_task_comm (which lock
    it with task_lock())
    - initialized normally by setup_new_exec */
};
```

from https://www.coins.tsukuba.ac.jp/~yas/coins/os2-2013/2013-12-26/

参照:https://github.com/torvalds/linux/blob/692b7dc87ca6d55ab254f8259e6f970171dc9d01/include/linux/sched.h#L739




## `state`メンバについて

`task_struct`構造体のstateはその名が示す通り、プロセスの現在の状態を表します。

格納される値は以下の通りです。（多少編集有）

```c
/* Used in tsk->state: */
#define TASK_RUNNING			0x00000000
#define TASK_INTERRUPTIBLE		0x00000001
#define TASK_UNINTERRUPTIBLE	0x00000002
#define TASK_STOPPED			0x00000004
#define TASK_TRACED 			0x00000008
/* Used in tsk->exit_state: */
#define EXIT_DEAD			0x00000010
#define EXIT_ZOMBIE			0x00000020
#define EXIT_TRACE			(EXIT_ZOMBIE | EXIT_DEAD)
/* Used in tsk->state again: */
#define TASK_PARKED			0x00000040
#define TASK_DEAD			0x00000080
#define TASK_WAKEKILL		0x00000100
#define TASK_WAKING			0x00000200
#define TASK_NOLOAD			0x00000400
#define TASK_NEW			0x00000800
#define TASK_RTLOCK_WAIT	0x00001000
#define TASK_FREEZABLE		0x00002000
#define __TASK_FREEZABLE_UNSAFE	       (0x00004000 * IS_ENABLED(CONFIG_LOCKDEP))
#define TASK_FROZEN			0x00008000
#define TASK_STATE_MAX			0x00010000
```

from https://github.com/torvalds/linux/blob/692b7dc87ca6d55ab254f8259e6f970171dc9d01/include/linux/sched.h#L86


- `TASK_STOPPPED`:プロセスは停止中。`SIGSTOP` `SIGTSTP` `SIGTTIN` `SIGTTOU`を受け取るとこの状態になる。

- `TASK_TRACED`:デバッガにより停止中。`ptrace()`システムコールなどによりほかのプログラムから監視されている場合は、どのシグナルを受信しても、この状態になります。
- `TASK_UNINTERRUPTIBLE`:ある条件が成り立つのを一時停止して待ち合わせしている状態。次の条件で`TASK_RUNNGIN`になる
    - ハードウェアの割り込み
    - プロセスが待っているシステム資源の解放
    - シグナルの受信


stateメンバの値は、以下のようにして単純に代入します。

```sh
p->state = TASK_RUNNNING
```

あるいは、`set_task_state`マクロや、`set_current_state`(現在実行中のプロセスの状態を設定する)マクロを利用することもあります。
→（以前は`set_task_state`は次の階層の中に定義されていたようですが、今はないようです）

```c
include/linux/sched.h
```

```c
#define set_current_state(state_value)				\
	do {							\
		current->task_state_change = _THIS_IP_;		\
		smp_store_mb(current->state, (state_value));		\
	} while (0)
#endif

#define set_current_state(state_value)			\
	smp_store_mb(current->state, (state_value))
#endif
```


## プロセスのしきべつ

### プロセスディスクリプタポインタ

プロセスとプロセスディスクリプタは必ず一対一対応しており、カーネルは`task_struct`構造体の32ビットのアドレスを使用してプロセスを識別します。このアドレスを、**プロセスディスクリプタポインタ**と呼びます。これにより、独立にスケジューリング可能な各実行コンテキストにはそれぞれディスクリプタが割り当てられております。

### PID

PIDはプロセスディスクリプタの`pid`メンバに格納されています。新しく生成されるPIDはその直前に生成されたプロセスのPIDに1を足した値になります。

```c
struct task_struct{
    ...
	/* PID/PID hash table linkage. */
	struct pid			*thread_pid;
    ...
}
```

from https://github.com/torvalds/linux/blob/692b7dc87ca6d55ab254f8259e6f970171dc9d01/include/linux/sched.h#LL998C1-L999C27

#### PIDのMAX

ちなみにPIDにもMAXの値は存在し、デフォルトでは`PID_MAX_DEFAULT-1`です
カーネルはＰＩＤがこの上限に達したときに、使われていないPIDの再利用を行う必要があります。

```c
/*
 * This controls the default maximum pid allocated to a process
 */
#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
```

from https://github.com/torvalds/linux/blob/e660abd551f1172e428b4e4003de887176a8a1fd/include/linux/threads.h#L28

さらに、システム管理者は`/proc/sys/kernel/pid_max`ファイルにより小さな値を書き込むことにより、PIDの最大値を下げることができます。



#### PIDの再利用

PIDを再利用するときは、`pidmap_array`ビットマップを使う必要があります。`pidmap_array`ビットマップは、使用中のPIDと未使用のPIDを表しています。

```c
static pidmap_t pidmap_array[PIDMAP_ENTRIES] =
	 { [ 0 ... PIDMAP_ENTRIES-1 ] = { ATOMIC_INIT(BITS_PER_PAGE), NULL } };
```


### TGIDによるグループ化

これまで、PIDは一意の値であることを期待されていると説明してきました。

しかし、UNIXプログラマは同じグループのスレッドが同じPIDを持っていることを期待しまsう。

> 例えば、あるPIDにシグナルを送ると、そのグループ内のすべてのスレッドに効果を及ぼすなど。

**この仕組みを体現するため、Linuxはスレッドグループを使用しています。**スレッド間で共有する識別子として、グループの最初の軽量プロセスであるスレッドグループリーダのPIDを使用するのでう。
この識別子は各プロセスディスクリプタの`tgid`メンバに格納されています。
そして、`getpid`システムコールは、カレントプロセスの`pid`ではなく、`tgid`の値を返すのです。

```c
static pid_t getpid(void)
{
	return bpf_get_current_pid_tgid();
}
```

参照 https://github.com/torvalds/linux/blob/e660abd551f1172e428b4e4003de887176a8a1fd/tools/perf/examples/bpf/augmented_raw_syscalls.c#LL351C1-L354C2

この仕組みのおかげで、すべてのマルチスレッドアプリケーションは同じ識別子を共有できるのです。








