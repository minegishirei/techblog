





# schedule関数の目的

schedule()がスケジューラーのメイン処理。schedule()はRunQueueから(動的)優先度の高いプロセスを選択して実行する。



```c
/*
 * __schedule() is the main scheduler function.
 *
 * The main means of driving the scheduler and thus entering this function are:
 *
 *   1. Explicit blocking: mutex, semaphore, waitqueue, etc.
 *
 *   2. TIF_NEED_RESCHED flag is checked on interrupt and userspace return
 *      paths. For example, see arch/x86/entry_64.S.
 *
 *      To drive preemption between tasks, the scheduler sets the flag in timer
 *      interrupt handler scheduler_tick().
 *
 *   3. Wakeups don't really cause entry into schedule(). They add a
 *      task to the run-queue and that's it.
 *
 *      Now, if the new task added to the run-queue preempts the current
 *      task, then the wakeup sets TIF_NEED_RESCHED and schedule() gets
 *      called on the nearest possible occasion:
 *
 *       - If the kernel is preemptible (CONFIG_PREEMPTION=y):
 *
 *         - in syscall or exception context, at the next outmost
 *           preempt_enable(). (this might be as soon as the wake_up()'s
 *           spin_unlock()!)
 *
 *         - in IRQ context, return from interrupt-handler to
 *           preemptible context
 *
 *       - If the kernel is not preemptible (CONFIG_PREEMPTION is not set)
 *         then at the next:
 *
 *          - cond_resched() call
 *          - explicit schedule() call
 *          - return from syscall or exception to user-space
 *          - return from interrupt-handler to user-space
 *
 * WARNING: must be called with preemption disabled!
 */
static void __sched notrace __schedule(unsigned int sched_mode)
{
        struct task_struct *prev, *next;
        unsigned long *switch_count;
        unsigned long prev_state;
        struct rq_flags rf;
        struct rq *rq;
        int cpu;


        cpu = smp_processor_id();
        rq = cpu_rq(cpu);
        prev = rq->curr;


        schedule_debug(prev, !!sched_mode);


        if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
                hrtick_clear(rq);


        local_irq_disable();
        rcu_note_context_switch(!!sched_mode);


        /*
         * Make sure that signal_pending_state()->signal_pending() below
         * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
         * done by the caller to avoid the race with signal_wake_up():
         *
         * __set_current_state(@state)          signal_wake_up()
         * schedule()                             set_tsk_thread_flag(p, TIF_SIGPENDING)
         *                                        wake_up_state(p, state)
         *   LOCK rq->lock                          LOCK p->pi_state
         *   smp_mb__after_spinlock()               smp_mb__after_spinlock()
         *     if (signal_pending_state())          if (p->state & @state)
         *
         * Also, the membarrier system call requires a full memory barrier
         * after coming from user-space, before storing to rq->curr.
         */
        rq_lock(rq, &rf);
        smp_mb__after_spinlock();


        /* Promote REQ to ACT */
        rq->clock_update_flags <<= 1;
        update_rq_clock(rq);


        switch_count = &prev->nivcsw;


        /*
         * We must load prev->state once (task_struct::state is volatile), such
         * that we form a control dependency vs deactivate_task() below.
         */
        prev_state = READ_ONCE(prev->__state);
        if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
                if (signal_pending_state(prev_state, prev)) {
                        WRITE_ONCE(prev->__state, TASK_RUNNING);
                } else {
                        prev->sched_contributes_to_load =
                                (prev_state & TASK_UNINTERRUPTIBLE) &&
                                !(prev_state & TASK_NOLOAD) &&
                                !(prev_state & TASK_FROZEN);


                        if (prev->sched_contributes_to_load)
                                rq->nr_uninterruptible++;


                        /*
                         * __schedule()                 ttwu()
                         *   prev_state = prev->state;    if (p->on_rq && ...)
                         *   if (prev_state)                goto out;
                         *     p->on_rq = 0;              smp_acquire__after_ctrl_dep();
                         *                                p->state = TASK_WAKING
                         *
                         * Where __schedule() and ttwu() have matching control dependencies.
                         *
                         * After this, schedule() must not care about p->state any more.
                         */
                        deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);


                        if (prev->in_iowait) {
                                atomic_inc(&rq->nr_iowait);
                                delayacct_blkio_start();
                        }
                }
                switch_count = &prev->nvcsw;
        }


        next = pick_next_task(rq, prev, &rf);
        clear_tsk_need_resched(prev);
        clear_preempt_need_resched();
#ifdef CONFIG_SCHED_DEBUG
        rq->last_seen_need_resched_ns = 0;
#endif


        if (likely(prev != next)) {
                rq->nr_switches++;
                /*
                 * RCU users of rcu_dereference(rq->curr) may not see
                 * changes to task_struct made by pick_next_task().
                 */
                RCU_INIT_POINTER(rq->curr, next);
                /*
                 * The membarrier system call requires each architecture
                 * to have a full memory barrier after updating
                 * rq->curr, before returning to user-space.
                 *
                 * Here are the schemes providing that barrier on the
                 * various architectures:
                 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC.
                 *   switch_mm() rely on membarrier_arch_switch_mm() on PowerPC.
                 * - finish_lock_switch() for weakly-ordered
                 *   architectures where spin_unlock is a full barrier,
                 * - switch_to() for arm64 (weakly-ordered, spin_unlock
                 *   is a RELEASE barrier),
                 */
                ++*switch_count;


                migrate_disable_switch(rq, prev);
                psi_sched_switch(prev, next, !task_on_rq_queued(prev));


                trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);


                /* Also unlocks the rq: */
                rq = context_switch(rq, prev, next, &rf);
        } else {
                rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);


                rq_unpin_lock(rq, &rf);
                __balance_callbacks(rq);
                raw_spin_rq_unlock_irq(rq);
        }
}
```



