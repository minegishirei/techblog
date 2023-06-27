

## do_fork関数について

clone,fork,forkvの基盤となるのがこの`do_fork`関数です。
プロセスをコピーし、切り離しスタートします。

行っていることは以下の通り

1. 事前に予備的な引数の確認を行う
```c
    /*
     * Do some preliminary argument and permissions checking before we
     * actually start allocating stuff
     * 事前にいくつかの予備的な引数と権限のチェックを行ってください。
     */
    if (clone_flags & CLONE_NEWUSER) {
        if (clone_flags & CLONE_THREAD)
           return -EINVAL;
            /* hopefully this check will go away when userns support is
             * complete
             */
        if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SETUID) || !capable(CAP_SETGID))
            return -EPERM;
    }
```
2. プロセスが監視されているかどうか確認し、監視されていれば`CLONE_PTRACE`フラグを立てる
3. `copy_process()`を呼び出す
```c
    /*
     * When called from kernel_thread, don't do user tracing stuff.
     */
    if (likely(user_mode(regs)))
        trace = tracehook_prepare_clone(clone_flags);
    p = copy_process(clone_flags, stack_start, regs, stack_size,
         child_tidptr, NULL, trace);
```

4. プロセスにエラーがないことを確認出来たら`wake_up_new_task()`を呼び出しプロセスを走らせる
```c
    /*
     * When called from kernel_thread, don't do user tracing stuff.
     */
    if (likely(user_mode(regs)))
        trace = tracehook_prepare_clone(clone_flags);
    p = copy_process(clone_flags, stack_start, regs, stack_size,
         child_tidptr, NULL, trace);
```



以下全文

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
     * 事前にいくつかの予備的な引数と権限のチェックを行ってください。
     */
    if (clone_flags & CLONE_NEWUSER) {
        if (clone_flags & CLONE_THREAD)
           return -EINVAL;
            /* hopefully this check will go away when userns support is
             * complete
             */
        if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SETUID) || !capable(CAP_SETGID))
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
```



### copy_processについて

この関数は`task_struct`を返却する関数です。


1. clone_flags引数で渡されたフラグが矛盾していないか確認する。
    1. `CLONE_NEWNS`フラグと`CLONE_FS`フラグが同時に設定されている場合は`error in value`を返す
    2. `CLONE_THREAD`が設定されているが、`CLONE_SIGHAND`が設定されていないとき
        `((clone_flags & CLONE_THREAD) && !(clone_flags & CLONE_SIGHAND)`
        同じスレッドグループの軽量プロセスは、シグナルを共有する必要がある。
```c
        /*
         * Don't allow sharing the root directory with processes in a different
         * namespace
         * 1. `CLONE_NEWNS`フラグと`CLONE_FS`フラグが同時に設定されている場合は`error in value`を返す
         */
        if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
                return ERR_PTR(-EINVAL);


        if ((clone_flags & (CLONE_NEWUSER|CLONE_FS)) == (CLONE_NEWUSER|CLONE_FS))
                return ERR_PTR(-EINVAL);
```

2. `dup_task_struct`を実施し、子プロセスのディスクリプタを取得します。
```c
p = dup_task_struct(current, node);
```

```c
/*
 * This creates a new process as a copy of the old one,
 * but does not actually start it yet.
 *
 * It copies the registers, and all the appropriate
 * parts of the process environment (as per the clone
 * flags). The actual kick-off is left to the caller.
 */
__latent_entropy struct task_struct *copy_process(
                                        struct pid *pid,
                                        int trace,
                                        int node,
                                        struct kernel_clone_args *args)
{
        int pidfd = -1, retval;
        struct task_struct *p;
        struct multiprocess_signals delayed;
        struct file *pidfile = NULL;
        const u64 clone_flags = args->flags;
        struct nsproxy *nsp = current->nsproxy;


        /*
         * Don't allow sharing the root directory with processes in a different
         * namespace
         * 1. `CLONE_NEWNS`フラグと`CLONE_FS`フラグが同時に設定されている場合は`error in value`を返す
         */
        if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
                return ERR_PTR(-EINVAL);


        if ((clone_flags & (CLONE_NEWUSER|CLONE_FS)) == (CLONE_NEWUSER|CLONE_FS))
                return ERR_PTR(-EINVAL);


        /*
         * Thread groups must share signals as well, and detached threads
         * can only be started up within the thread group.
         */
        if ((clone_flags & CLONE_THREAD) && !(clone_flags & CLONE_SIGHAND))
                return ERR_PTR(-EINVAL);


        /*
         * Shared signal handlers imply shared VM. By way of the above,
         * thread groups also imply shared VM. Blocking this case allows
         * for various simplifications in other code.
         */
        if ((clone_flags & CLONE_SIGHAND) && !(clone_flags & CLONE_VM))
                return ERR_PTR(-EINVAL);


        /*
         * Siblings of global init remain as zombies on exit since they are
         * not reaped by their parent (swapper). To solve this and to avoid
         * multi-rooted process trees, prevent global and container-inits
         * from creating siblings.
         */
        if ((clone_flags & CLONE_PARENT) &&
                                current->signal->flags & SIGNAL_UNKILLABLE)
                return ERR_PTR(-EINVAL);


        /*
         * If the new process will be in a different pid or user namespace
         * do not allow it to share a thread group with the forking task.
         */
        if (clone_flags & CLONE_THREAD) {
                if ((clone_flags & (CLONE_NEWUSER | CLONE_NEWPID)) ||
                    (task_active_pid_ns(current) != nsp->pid_ns_for_children))
                        return ERR_PTR(-EINVAL);
        }


        if (clone_flags & CLONE_PIDFD) {
                /*
                 * - CLONE_DETACHED is blocked so that we can potentially
                 *   reuse it later for CLONE_PIDFD.
                 * - CLONE_THREAD is blocked until someone really needs it.
                 */
                if (clone_flags & (CLONE_DETACHED | CLONE_THREAD))
                        return ERR_PTR(-EINVAL);
        }


        /*
         * Force any signals received before this point to be delivered
         * before the fork happens.  Collect up signals sent to multiple
         * processes that happen during the fork and delay them so that
         * they appear to happen after the fork.
         */
        sigemptyset(&delayed.signal);
        INIT_HLIST_NODE(&delayed.node);


        spin_lock_irq(&current->sighand->siglock);
        if (!(clone_flags & CLONE_THREAD))
                hlist_add_head(&delayed.node, &current->signal->multiprocess);
        recalc_sigpending();
        spin_unlock_irq(&current->sighand->siglock);
        retval = -ERESTARTNOINTR;
        if (task_sigpending(current))
                goto fork_out;


        retval = -ENOMEM;
        p = dup_task_struct(current, node);
        if (!p)
                goto fork_out;
        p->flags &= ~PF_KTHREAD;
        if (args->kthread)
                p->flags |= PF_KTHREAD;
        if (args->user_worker) {
                /*
                 * Mark us a user worker, and block any signal that isn't
                 * fatal or STOP
                 */
                p->flags |= PF_USER_WORKER;
                siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
        }
        if (args->io_thread)
                p->flags |= PF_IO_WORKER;


        if (args->name)
                strscpy_pad(p->comm, args->name, sizeof(p->comm));


        p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? args->child_tid : NULL;
        /*
         * Clear TID on mm_release()?
         */
        p->clear_child_tid = (clone_flags & CLONE_CHILD_CLEARTID) ? args->child_tid : NULL;


        ftrace_graph_init_task(p);


        rt_mutex_init_task(p);


        lockdep_assert_irqs_enabled();
#ifdef CONFIG_PROVE_LOCKING
        DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
#endif
        retval = copy_creds(p, clone_flags);
        if (retval < 0)
                goto bad_fork_free;


        retval = -EAGAIN;
        if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
                if (p->real_cred->user != INIT_USER &&
                    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
                        goto bad_fork_cleanup_count;
        }
        current->flags &= ~PF_NPROC_EXCEEDED;


        /*
         * If multiple threads are within copy_process(), then this check
         * triggers too late. This doesn't hurt, the check is only there
         * to stop root fork bombs.
         */
        retval = -EAGAIN;
        if (data_race(nr_threads >= max_threads))
                goto bad_fork_cleanup_count;


        delayacct_tsk_init(p);  /* Must remain after dup_task_struct() */
        p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE | PF_NO_SETAFFINITY);
        p->flags |= PF_FORKNOEXEC;
        INIT_LIST_HEAD(&p->children);
        INIT_LIST_HEAD(&p->sibling);
        rcu_copy_process(p);
        p->vfork_done = NULL;
        spin_lock_init(&p->alloc_lock);


        init_sigpending(&p->pending);


        p->utime = p->stime = p->gtime = 0;
#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
        p->utimescaled = p->stimescaled = 0;
#endif
        prev_cputime_init(&p->prev_cputime);


#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
        seqcount_init(&p->vtime.seqcount);
        p->vtime.starttime = 0;
        p->vtime.state = VTIME_INACTIVE;
#endif


#ifdef CONFIG_IO_URING
        p->io_uring = NULL;
#endif


#if defined(SPLIT_RSS_COUNTING)
        memset(&p->rss_stat, 0, sizeof(p->rss_stat));
#endif


        p->default_timer_slack_ns = current->timer_slack_ns;


#ifdef CONFIG_PSI
        p->psi_flags = 0;
#endif


        task_io_accounting_init(&p->ioac);
        acct_clear_integrals(p);


        posix_cputimers_init(&p->posix_cputimers);


        p->io_context = NULL;
        audit_set_context(p, NULL);
        cgroup_fork(p);
        if (args->kthread) {
                if (!set_kthread_struct(p))
                        goto bad_fork_cleanup_delayacct;
        }
#ifdef CONFIG_NUMA
        p->mempolicy = mpol_dup(p->mempolicy);
        if (IS_ERR(p->mempolicy)) {
                retval = PTR_ERR(p->mempolicy);
                p->mempolicy = NULL;
                goto bad_fork_cleanup_delayacct;
        }
#endif
#ifdef CONFIG_CPUSETS
        p->cpuset_mem_spread_rotor = NUMA_NO_NODE;
        p->cpuset_slab_spread_rotor = NUMA_NO_NODE;
        seqcount_spinlock_init(&p->mems_allowed_seq, &p->alloc_lock);
#endif
#ifdef CONFIG_TRACE_IRQFLAGS
        memset(&p->irqtrace, 0, sizeof(p->irqtrace));
        p->irqtrace.hardirq_disable_ip  = _THIS_IP_;
        p->irqtrace.softirq_enable_ip   = _THIS_IP_;
        p->softirqs_enabled             = 1;
        p->softirq_context              = 0;
#endif


        p->pagefault_disabled = 0;


#ifdef CONFIG_LOCKDEP
        lockdep_init_task(p);
#endif
```

