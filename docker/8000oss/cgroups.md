









## cgroups概要

cgroupはリソースごとにコントローラーが存在し、コントローラーはcgroupfsという特別なファイルシステムを介して使います。
このファイルシステムは、ストレージデバイス上に存在するわけではなく、メモリ上にだけ存在します。

Ubuntu20.04では /sys/fs/cgroup ディレクトリ以下に、各コントローラーに対応するcgroupファイルシステムがマウントされています。

cgroupsは、Linuxカーネルの一部として提供されており、コマンドラインツール（通常は「cgroup-tools」パッケージに含まれています）やAPIを介して操作することができます。



## cgroupsはファイルとして扱う


cgroupfsという名前の仮想ファイルシステムにディレクトリーを作成することにより、システム上の cgroup 階層を管理できます。

デフォルトのパスは`/sys/fs/cgroup/`です。


from https://access.redhat.com/documentation/ja-jp/red_hat_enterprise_linux/9/html/managing_monitoring_and_updating_the_kernel/assembly_using-cgroupfs-to-manually-manage-cgroups_managing-monitoring-and-updating-the-kernel


### 新規プロセスを作ってみる

次のように、cgroup配下にフォルダーを作成することで新規プロセスを作成することができます。

`mkdir /sys/fs/cgroup/Example/`

/sys/fs/cgroup/Example/ ディレクトリーには、**memory および pids コントローラー用のコントローラー固有のファイルも含まれます。**

これらのファイルは、linux kernelに含まれる、**cgroups**によって自動的に作成されたものです。



```sh
cat /sys/fs/cgroup/cgroup.controllers
```

実際にlinux環境下で上記のコマンドを打つとプロセスが見えると思います。




<figure class="figure-image figure-image-fotolife" title="cgroup">[f:id:minegishirei:20230613180117p:plain:alt=cgroup]<figcaption>cgroup</figcaption></figure>





### ブラウザを開いてcgroupsを見てみる。


1.まずはブラウザを開き、ターミナルで`top`コマンドを入力します。

```sh
top
```

<figure class="figure-image figure-image-fotolife" title="cgroup process確認">[f:id:minegishirei:20230613180842p:plain:alt=cgroup process確認]<figcaption>cgroup process確認</figcaption></figure>


この時に開いたブラウザのPIDを`top`で確認しましょう。
今回だと、PID:2331ですね。

2.PIDをメモしたら`q`を押して`top`コマンドを終了します。

3.`/proc`配下にあるプロセスを確認しょう。

```sh
cat /proc/2331/cgroup
```

[f:id:minegishirei:20230613181545p:plain:alt=]

**プロセスが属する cgroup を表示するには、`cat proc/<PID>/cgroup` コマンドを実行します。**


4.`/sys/fs/cgroup`配下を調べる

先ほど調べた結果を、`/sys/fs/cgroup`配下で調べましょう。

[f:id:minegishirei:20230613182101p:plain:alt=]


プロセスに関する情報が記述されてますね！


