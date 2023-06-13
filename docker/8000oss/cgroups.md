




## cgroups概要

cgroupはリソースごとにコントローラーが存在し、コントローラーはcgroupfsという特別なファイルシステムを介して使います。
このファイルシステムは、ストレージデバイス上に存在するわけではなく、メモリ上にだけ存在します。

Ubuntu20.04では /sys/fs/cgroup ディレクトリ以下に、各コントローラーに対応するcgroupファイルシステムがマウントされています。

cgroupsは、Linuxカーネルの一部として提供されており、コマンドラインツール（通常は「cgroup-tools」パッケージに含まれています）やAPIを介して操作することができます。



## cgroupsはファイルとして扱う


cgroupfsという名前の仮想ファイルシステムにディレクトリーを作成することにより、システム上の cgroup 階層を管理できます。

デフォルトのパスは`/sys/fs/cgroup/`です。



### 新規プロセスを作ってみる

次のように、cgroup配下にフォルダーを作成することで新規プロセスを作成することができます。

`mkdir /sys/fs/cgroup/Example/`

/sys/fs/cgroup/Example/ ディレクトリーには、**memory および pids コントローラー用のコントローラー固有のファイルも含まれます。**

これらのファイルは、linux kernelに含まれる、**cgroups**によって自動的に作成されたものです。



```sh
cat /sys/fs/cgroup/cgroup.controllers
```


from https://access.redhat.com/documentation/ja-jp/red_hat_enterprise_linux/9/html/managing_monitoring_and_updating_the_kernel/assembly_using-cgroupfs-to-manually-manage-cgroups_managing-monitoring-and-updating-the-kernel




