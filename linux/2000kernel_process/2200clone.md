

例えば、ユーザーのコマンド入力のたびにシェルはシェルの複製を実行する新しいプロセスを生成します。

伝統的なUnixではすべてのプロセスが同じように扱われますが、これは効率が悪いです、。（親プロセスが所有する資源は複製され、子プロセスに渡される方法。多くの場合、すぐに`execve()`を発行して複製したアドレス空間を捨ててしまいます。

そこで、Linuxカーネルは次のように対応します。

1. コピー音ライト手法により、親プロセスおよび子プロセスの両方が同一の物理ページを読むことができます。（片方がその物理ページの変更を行おうとするときに複製する方法です）
2. 軽量プロセスにより親プロセスと子プロセスは、データ構造を共有しています。
3. `vfork()`システムコールは親プロセスとメモリ空間を共有するプロセスを生成します。子プロセスが実行を終了、もしくは新しいプログラムが実行を開始するまで、親プロセスの実行は止められます。


### clone()システムコール

from https://kazmax.zpp.jp/cmd/c/clone.2.html

**clone ()の主要な使用法はスレッド (threads) を実装することである**: 一つのプログラムの中の複数のスレッドは共有されたメモリ空間で 同時に実行される。
clone ()で子プロセスが作成された時に、作成された子プロセスは関数 fn ( arg )を実行する。

以下はcloneの引数一覧です

- `fn`生成するプロセスが実行する関数
- `arg`:fn()関数に渡す引数へのポインタ
- `flags`:グローバル定数と連携し、様々な情報を表す。

### flagsのオプション一覧

flagsはグローバル定数と連携し、様々な情報を表す。
以下がそのグローバル定数です。

- `CLONE_VM`:メモリディスクリプタおよび前頁テーブルを共有
- `CLONE_FS`:ルートディレクトリおよび作業ディレクトリのテーブルを共有
- `CLONE_FILES`:オープンされたファイルシステムの共有
- `CLONE_NEWNS`:cloneが独自の名前空間、つまり独自のマウントされたファイルシステムを必要とする場合に設定する。
- `CLONE_THREAD`:子プロセスの親として、呼び出しプロセスの親を設定する

```c
/*
 * cloning flags:
 */
#define CSIGNAL		0x000000ff	/* signal mask to be sent at exit */
#define CLONE_VM	0x00000100	/* set if VM shared between processes */
#define CLONE_FS	0x00000200	/* set if fs info shared between processes */
#define CLONE_FILES	0x00000400	/* set if open files shared between processes */
#define CLONE_SIGHAND	0x00000800	/* set if signal handlers and blocked signals shared */
#define CLONE_PIDFD	0x00001000	/* set if a pidfd should be placed in parent */
#define CLONE_PTRACE	0x00002000	/* set if we want to let tracing continue on the child too */
#define CLONE_VFORK	0x00004000	/* set if the parent wants the child to wake it up on mm_release */
#define CLONE_PARENT	0x00008000	/* set if we want to have the same parent as the cloner */
#define CLONE_THREAD	0x00010000	/* Same thread group? */
#define CLONE_NEWNS	0x00020000	/* New mount namespace group */
#define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
#define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
#define CLONE_PARENT_SETTID	0x00100000	/* set the TID in the parent */
#define CLONE_CHILD_CLEARTID	0x00200000	/* clear the TID in the child */
#define CLONE_DETACHED		0x00400000	/* Unused, ignored */
#define CLONE_UNTRACED		0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
#define CLONE_CHILD_SETTID	0x01000000	/* set the TID in the child */
#define CLONE_NEWCGROUP		0x02000000	/* New cgroup namespace */
#define CLONE_NEWUTS		0x04000000	/* New utsname namespace */
#define CLONE_NEWIPC		0x08000000	/* New ipc namespace */
#define CLONE_NEWUSER		0x10000000	/* New user namespace */
#define CLONE_NEWPID		0x20000000	/* New pid namespace */
#define CLONE_NEWNET		0x40000000	/* New network namespace */
#define CLONE_IO		0x80000000	/* Clone io context */
```

from https://github.com/torvalds/linux/blob/6995e2de6891c724bfeb2db33d7b87775f913ad1/include/uapi/linux/sched.h#L7C1-L34C52




## do_fork関数について

```c

/*
 *  Ok, this is the main fork-routine.
 *
 * It copies the process, and if successful kick-starts
 * it and waits for it to finish using the VM if required.
 */
long do_fork(unsigned long clone_flags,
              unsigned long stack_start,
              struct pt_regs *regs,
              unsigned long stack_size,
              int __user *parent_tidptr,
          int __user *child_tidptr)
{
    struct task_struct *p;
    int trace = 0;
    long nr;
    /*
     * Do some preliminary argument and permissions checking before we
     * actually start allocating stuff
     */
    if (clone_flags & CLONE_NEWUSER) {
            if (clone_flags & CLONE_THREAD)
                    return -EINVAL;
            /* hopefully this check will go away when userns support is
             * complete
             */
            if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SETUID) ||
                            !capable(CAP_SETGID))
                    return -EPERM;
    }
    /*
     * We hope to recycle these flags after 2.6.26
     */
    if (unlikely(clone_flags & CLONE_STOPPED)) {
            static int __read_mostly count = 100;
            if (count > 0 && printk_ratelimit()) {
                    char comm[TASK_COMM_LEN];
                    count--;
                    printk(KERN_INFO "fork(): process `%s' used deprecated "
                                        "clone flags 0x%lx\n",
                                get_task_comm(comm, current),
                                clone_flags & CLONE_STOPPED);
                }
    }
    /*
     * When called from kernel_thread, don't do user tracing stuff.
     */
    if (likely(user_mode(regs)))
            trace = tracehook_prepare_clone(clone_flags);
    p = copy_process(clone_flags, stack_start, regs, stack_size,
                     child_tidptr, NULL, trace);
    /*
     * Do this prior waking up the new thread - the thread pointer
     * might get invalid after that point, if the thread exits quickly.
     */
    if (!IS_ERR(p)) {
        struct completion vfork;
        trace_sched_process_fork(current, p);
        nr = task_pid_vnr(p);
        if (clone_flags & CLONE_PARENT_SETTID)
                put_user(nr, parent_tidptr);
        if (clone_flags & CLONE_VFORK) {
                p->vfork_done = &vfork;
                init_completion(&vfork);
        }
            audit_finish_fork(p);
            tracehook_report_clone(trace, regs, clone_flags, nr, p);
            /*
             * We set PF_STARTING at creation in case tracing wants to
             * use this to distinguish a fully live task from one that
             * hasn't gotten to tracehook_report_clone() yet.  Now we
             * clear it and set the child going.
             */
            p->flags &= ~PF_STARTING;
            if (unlikely(clone_flags & CLONE_STOPPED)) {
                    /*
                     * We'll start up with an immediate SIGSTOP.
                     */
                    sigaddset(&p->pending.signal, SIGSTOP);
                    set_tsk_thread_flag(p, TIF_SIGPENDING);
                    __set_task_state(p, TASK_STOPPED);
            } else {
                    wake_up_new_task(p, clone_flags);
            }

            tracehook_report_clone_complete(trace, regs,
                                            clone_flags, nr, p);

            if (clone_flags & CLONE_VFORK) {
                    freezer_do_not_count();
                    wait_for_completion(&vfork);
                    freezer_count()                        tracehook_report_vfork_done(p, nr);
                }
        } else {
                nr = PTR_ERR(p);
        }
        return nr;
}











