



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























