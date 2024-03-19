



# 事前準備

## 1. VagrantによるCentos7のインストール


```sh
vagrant init centos/7
```


```
PS C:\Users\kaoka\myworking\myworking\container_from_scratch> vagrant init centos/7
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.
```


```sh
vagrant up
```

```
PS C:\Users\kaoka\myworking\myworking\container_from_scratch> vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Checking if box 'centos/7' version '2004.01' is up to date...
==> default: Clearing any previously set forwarded ports...
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: Warning: Connection reset. Retrying...
    default:
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default:
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
    default: No guest additions were detected on the base box for this VM! Guest
    default: additions are required for forwarded ports, shared folders, host only
    default: networking, and more. If SSH fails on this machine, please install
    default: the guest additions and repackage the box to continue.
    default:
    default: This is not an error message; everything may continue to work properly,
    default: in which case you may ignore this message.
==> default: Rsyncing folder: /cygdrive/c/Users/kaoka/myworking/myworking/container_from_scratch/ => /vagrant
```


```sh
vagrant ssh
```



## 2. go言語のインストール

仮想環境内部に接続出来たら、まずはパッケージのアップデートを行いましょう。

```sh
sudo yum update -y
```

アップデートができたらGo言語のインストールを行います。

```sh
yum install epel-release
sudo yum install -y golang
```

Go言語が入ったことを確認。

```sh
[vagrant@localhost ~]$ go version
go version go1.20.10 linux/amd64
```



# コンテナを0から作る

## 1. `docker run`を作成する

まずはコンテナを実行するコマンド`docker run`コマンドを作成しましょう。

どんなエディターでもいいので、`container.go`を作成しましょう。
（自分はvimを使いました↓）

```sh
sudo yum install vim
vim container.go
```

中身は以下の通りです。

```go
package main
import (
  "fmt"
  "os"
  "os/exec"
)
// go run container.go run <cmd> <args>
// docker run <cmd> <args>
func main() {
  switch os.Args[1] {
    case "run":
      run()
    default:
      panic("invalid command!!")
  }
}
func run() {
  fmt.Printf("Running %v as PID %d \n", os.Args[2:], os.Getpid())
  cmd := exec.Command(os.Args[2], os.Args[3:]...)
  cmd.Stdin = os.Stdin
  cmd.Stdout = os.Stdout
  cmd.Stderr = os.Stderr
  cmd.Run()
}
```

上記のファイルを用いてビルドを行います。

```sh
go build container.go
```

ビルドが完了したら早速実行してみましょう。
新しく実行するコマンドは`echo "Hello World"`とします。


```sh
./container run echo "Hello World"
```

実行結果

```sh
[vagrant@localhost container_scratch]$ ./container run echo "Hello World"
Running [echo Hello World] as PID 13454
Hello World
```


### コード解説

上記のプログラムは、指定された引数をコマンドとして実行します。
コンテナとみなせる新しいプロセスを作成することでコマンドを実行します。

```go
func run() {
    // コマンドとその引数を出力します
    fmt.Printf("Running %v as PID %d \n", os.Args[2:], os.Getpid())

    // 新しいコマンドを作成します
    cmd := exec.Command(os.Args[2], os.Args[3:]...)

    // 新しいコマンドの標準入力を設定します
    cmd.Stdin = os.Stdin
    // 新しいコマンドの標準出力を設定します
    cmd.Stdout = os.Stdout
    // 新しいコマンドの標準エラー出力を設定します
    cmd.Stderr = os.Stderr

    // 新しいコマンドを実行します
    cmd.Run()
}
```

上記のコードだと、ホストOSとの分離が薄いのではと思いますが、ここにさらなる分離要素を加えていきます。


### 現時点ではホスト名の分離はできていない

`bin/bash`を使用して新しいプロセスを作成し、そのコンテナに専用のホスト名を割り当ててみましょう。
理想のコンテナは元のOSとは異なるホスト名を割り当てれるはずです。

- 元のOSで`hostname`実行。元のOSのホスト名が`localhost.localdomain`であることがわかる。

```sh
[vagrant@localhost 0]$ hostname
localhost.localdomain
```

- `bin/bas`実行。新しいコンテナと新しいシェルが立ち上がる。

```sh
[vagrant@localhost 0]$ ./container run /bin/bash
Running [/bin/bash] as PID 2056
```

- `hostname`実行。ホスト名が元OS同様、`localhost.localdomain`であることがわかる。

```sh
[vagrant@localhost 0]$ hostname
localhost.localdomain
```

- `sudo hostname in-container`実行。ホスト名が変更された。

```sh
[vagrant@localhost 0]$ sudo hostname in-container
[vagrant@localhost 0]$ hostname
in-container
```

ここまでは想定通り、うごいている。
しかし問題はここから。

- `exit`実行。コンテナを終了し、元OSに出る。

```sh
[vagrant@localhost 0]$ exit
exit
```

- `hostname`実行。コンテナの内部の変更のはずが、コンテナ外へ波及してしまっていた。

```sh
[vagrant@localhost 0]$ hostname
in-container
```

これは、**このコンテナのホスト名が分離されていないために発生します。**


# コンテナの名前空間を独立させ、ホスト名の変更を波及させない。

先ほどは、コンテナのホスト名が分離されていないために、コンテナ内部の変更がコンテナ外へ影響を及ぼしてしまいました。
コンテナとコンテナ外は明確に隔離されていることが望ましいです。

**ホスト名の分離を作成するには、コンテナに新しい UTS 名前空間を割り当てることが得策です。**

> uts namespaceとは、
> ホスト名やNISドメイン名を分離する名前空間です。
>
> UTS は Unix Time-sharing System（UNIX で採用されていた、一台のコンピュータを複数のユーザで扱うための仕組み）の略ですが、今はその意味は失われているようです。時間も特に関係ありません。

from https://qiita.com/thirdpenguin/items/61f1291f6ee804531328

```go
package main
import (
  "fmt"
  "os"
  "os/exec"
  "syscall"
)
// go run container.go run <cmd> <args>
// docker run <cmd> <args>
func main() {
  switch os.Args[1] {
    case "run":
      run()
    default:
      panic("invalid command!!")
  }
}
func run() {
  fmt.Printf("Running %v as PID %d \n", os.Args[2:], os.Getpid())
  cmd := exec.Command(os.Args[2], os.Args[3:]...)
  cmd.Stdin = os.Stdin
  cmd.Stdout = os.Stdout
  cmd.Stderr = os.Stderr
  cmd.SysProcAttr = &syscall.SysProcAttr{
    Cloneflags: syscall.CLONE_NEWUTS
  }
  cmd.Run()
}
```

- Goファイルのビルドを行う。

```sh
go build container.go
```

## ホスト名の変更をしてみる

- ホスト名を変更

```sh
sudo hostname test
```

これで、コンテナ内部の変更がホストOSに及んでいないことがわかると思います。

```sh
[vagrant@localhost 0001split_process]$ sudo ./container run bash
Running [bash] as PID 3123
[root@localhost 0001split_process]# hostname test
[root@localhost 0001split_process]# hostname
test
[root@localhost 0001split_process]# exit
exit
[vagrant@localhost 0001split_process]$ hostname
localhost.localdomain
[vagrant@localhost 0001split_process]$
```

### ソース解説

変更があった部分を重点的にコメントを付け加えました。
最も重要な点は`cmd.SysProcAttr`の部分です。
新しいプロセスを作成する際のシステムプロセス属性を設定しておりますが、その属性に`CLONE_NEWNS`フラグを使用しています。

```go
func run() {
    // プロセスの実行とPIDの表示
    fmt.Printf("Running %v as PID %d \n", os.Args[2:], os.Getpid())

    // 実行するコマンドを作成
    cmd := exec.Command(os.Args[2], os.Args[3:]...)

    // コマンドの標準入力、標準出力、標準エラー出力を設定
    cmd.Stdin = os.Stdin
    cmd.Stdout = os.Stdout
    cmd.Stderr = os.Stderr

    // コマンドの実行時のシステム属性を設定
    cmd.SysProcAttr = &syscall.SysProcAttr{
        // CLONE_NEWUTSフラグを設定して新しいUTS名前空間を作成
        Cloneflags: syscall.CLONE_NEWUTS,
    }

    // コマンドの実行
    cmd.Run()
}
```

`CLONE_NEWUTS` はホスト名と NIS ドメイン名を隔離させた新しいプロセスを作成するオプションです。
このオプションにより、新しいUTS名前空間を作成することが可能です。


# ホスト名を自動的に割り当てる

ここまでで、自作コンテナランタイムを行う過程で以下の分離を果たすことが出来ました。

- プロセスの分離
- ホスト名の分離

しかし、以下の要素の解決はまだできていません。

- ホスト名の自動生成
- ファイルシステムの分離

まずは、ホスト名の自動生成から行います。
ホスト名の自動生成はDockerを使用していれば誰しもほしいと感じるはずです。


```go
// main 関数はコマンドライン引数を解析し、適切な関数を実行します。
// run 関数は現在の実行可能ファイルを使用して特定の名前空間設定で子プロセスを作成します。
// child 関数はホスト名を設定し、指定されたコマンドを別のプロセスで実行します。
package main

import (
	"fmt"
	"os"
	"os/exec"
	"syscall"
)

// main 関数はコマンドライン引数を解析し、適切な関数を実行します。
func main() {
	switch os.Args[1] {
	case "run":
		run()
	case "child":
		child()
	default:
		panic("無効なコマンドです！！")
	}
}

// run 関数は現在の実行可能ファイルを使用して特定の名前空間設定で子プロセスを作成します。
func run() {
	fmt.Printf("PID %d として %v を実行中\n", os.Getpid(), os.Args[2:])

	// 子プロセス用の引数を準備します。
	args := append([]string{"child"}, os.Args[2:]...)
	cmd := exec.Command("/proc/self/exe", args...)

	// 子プロセスの標準入力、出力、エラーを設定します。
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	// 子プロセスが新しいUTS名前空間を使用するように設定します。
	cmd.SysProcAttr = &syscall.SysProcAttr{
		Cloneflags: syscall.CLONE_NEWUTS,
	}

	// 子プロセスを実行します。
	cmd.Run()
}

// child 関数はホスト名を設定し、指定されたコマンドを別のプロセスで実行します。
func child() {
	fmt.Printf("PID %d として %v を実行中\n", os.Getpid(), os.Args[2:])

	// コンテナのホスト名を設定します。
	syscall.Sethostname([]byte("container-demo"))

	// 別のプロセスで指定されたコマンドを実行します。
	cmd := exec.Command(os.Args[2], os.Args[3:]...)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Run()
}
```

今回はシステムコール`sethostname`を用いて コンテナのホスト名を設定しています。



```sh
[vagrant@localhost 0030hostname_assign]$ sudo ./container run bash
PID 3348 として [bash] を実行中
PID 3351 として [bash] を実行中
[root@container-demo 0030hostname_assign]# hostname
container-demo
[root@container-demo 0030hostname_assign]# exit
exit
[vagrant@localhost 0030hostname_assign]$ hostname
localhost.localdomain
[vagrant@localhost 0030hostname_assign]$
```

無事に、ホスト名が自動で割り当てられていることが確認できました。

しかしそれでも、コンテナはホストマシンのプロセスを認識できます。

```sh
[vagrant@localhost 0030hostname_assign]$ sudo sleep 100 &
[1] 3544
[vagrant@localhost 0030hostname_assign]$ sudo ./container run bash
PID 3549 として [bash] を実行中
PID 3552 として [bash] を実行中
[root@container-demo 0030hostname_assign]# ps
  PID TTY          TIME CMD
 3544 pts/1    00:00:00 sudo
 3546 pts/1    00:00:00 sleep
 3547 pts/1    00:00:00 sudo
 3549 pts/1    00:00:00 container
 3552 pts/1    00:00:00 exe
 3555 pts/1    00:00:00 bash
 3570 pts/1    00:00:00 ps
```

次回はこの問題を解決していきたいと思います。



# ファイルシステムの分離

コンテナはホストマシンのプロセスを認識できる理由は「/proc」フォルダーです。

コンテナはホスト マシンと同じルート ファイル システムを使用しています。したがって、コンテナには別のルート ファイル システムが使用され、そこに `/proc` がマウントされます。


```go
package main
import (
  "fmt"
  "os"
  "os/exec"
  "syscall"
)

// コマンドのオプションによって実行内容を変更。
func main(){
  switch os.Args[1] {
    case "run":
      run()
    case "child":
      child()
    default:
      panic("invalid command")
  }
}

func run(){
  // os.GetPIDはプロセスIDを取得（現在のプロセスIDと同じ）
  fmt.Printf("Runnning %v as PID %d \n", os.Args[2:], os.Getpid())
  args := append([]string{"child"}, os.Args[2:]...)
  cmd := exec.Command("/proc/self/exe", args...)
  cmd.Stdin = os.Stdin
  cmd.Stdout = os.Stdout
  cmd.Stderr = os.Stderr
  cmd.SysProcAttr = &syscall.SysProcAttr{
    Cloneflags : syscall.CLONE_NEWUTS | syscall.CLONE_NEWPID,
  }
  cmd.Run()
}
func child(){
  fmt.Printf("Running %v as PID %d \n", os.Args[2:], os.Getpid())
  syscall.Sethostname([]byte("container-demo"))
  cmd := exec.Command(os.Args[2], os.Args[3:]...)
  cmd.Stdin = os.Stdin
  cmd.Stdout = os.Stdout
  cmd.Stderr = os.Stderr
  cmd.Run()
}
```


まず、コンテナはそのコンテナの中身のプロセスのみ視認できる必要があります。
これは、PID名前空間を使用することで区別できます。

```go
  cmd.SysProcAttr = &syscall.SysProcAttr{
    Cloneflags : syscall.CLONE_NEWUTS | syscall.CLONE_NEWPID,
  }
```

この状態でビルド&実行&プロセス確認をしてみましょう。

```sh
[vagrant@localhost 0040hostname]$ sudo sleep 100 &
[1] 7382
[vagrant@localhost 0040hostname]$ ps
  PID TTY          TIME CMD
 7354 pts/0    00:00:00 bash
 7385 pts/0    00:00:00 ps
[vagrant@localhost 0040hostname]$ sudo ps
  PID TTY          TIME CMD
 7382 pts/0    00:00:00 sudo
 7384 pts/0    00:00:00 sleep
 7386 pts/0    00:00:00 sudo
 7388 pts/0    00:00:00 ps
[vagrant@localhost 0040hostname]$ go build container.go
[vagrant@localhost 0040hostname]$ sudo ./container run bash
Runnning [bash] as PID 7404
Running [bash] as PID 1
[root@container-demo 0040hostname]# ps
  PID TTY          TIME CMD
 7382 pts/0    00:00:00 sudo
 7384 pts/0    00:00:00 sleep
 7402 pts/0    00:00:00 sudo
 7404 pts/0    00:00:00 container
 7407 pts/0    00:00:00 exe
 7410 pts/0    00:00:00 bash
 7425 pts/0    00:00:00 ps
```

`syscall.CLONE_NEWPID`のオプションを付け加えても、ホストマシンのプロセスを認識してしまいました。

コンテナはホストマシンのプロセスを認識できる理由は「/proc」です。
コンテナはホストマシンと同じルートファイルシステムを使用しています。
したがって、コンテナには別のルートファイル システムが用意され、そこに `/proc` がマウントされるべきです。

/procディレクトリは、普通のファイルシステムと違い、ハードディスクやSSDなどのストレージ上ではなく、メモリの中に作られるファイルシステムです。
linuxのプロセスはこの`/proc`配下にファイルorフォルダーとして格納され、管理されます。
また、/procにあるファイルを編集すれば、システムをコントロールすることもできます。


```go
package main
import (
  "fmt"
  "os"
  "os/exec"
  "syscall"
)

// コマンドのオプションによって実行内容を変更。
func main(){
  switch os.Args[1] {
    case "run":
      run()
    case "child":
      child()
    default:
      panic("invalid command")
  }
}

func run(){
  // os.GetPIDはプロセスIDを取得（現在のプロセスIDと同じ）
  fmt.Printf("Runnning %v as PID %d \n", os.Args[2:], os.Getpid())
  args := append([]string{"child"}, os.Args[2:]...)
  cmd := exec.Command("/proc/self/exe", args...)
  cmd.Stdin = os.Stdin
  cmd.Stdout = os.Stdout
  cmd.Stderr = os.Stderr
  cmd.SysProcAttr = &syscall.SysProcAttr{
    Cloneflags : syscall.CLONE_NEWUTS | syscall.CLONE_NEWPID,
  }
  cmd.Run()
}
func child() {
  // コマンドライン引数の表示とプロセスIDの取得
  fmt.Printf("Running %v as PID %d \n", os.Args[2:], os.Getpid())

  // ホスト名を設定
  syscall.Sethostname([]byte("container-demo"))

  // 新しいプロセスの生成
  cmd := exec.Command(os.Args[2], os.Args[3:]...)
  cmd.Stdin = os.Stdin
  cmd.Stdout = os.Stdout
  cmd.Stderr = os.Stderr

  // ルートファイルシステムの変更
  syscall.Chroot("/containerfs")
  os.Chdir("/")

  // proc ファイルシステムのマウント
  syscall.Mount("proc", "proc", "proc", 0, "")

  // コマンドの実行
  cmd.Run()

}

```

大幅に変更された`child()`関数を確認してみましょう。

- まず、`chroot`コマンドでルートファイルシステムを変更していることが確認できます。
    - chrootとは、「CHange ROOT」のことで、ルートディレクトリを変更する技術です。ここでのROOTとは特権ユーザではなく、ファイルシステムのルートディレクトリのことを指します。UNIX系のファイルシステムは、「/」すなわちルートディレクトリを頂上としたツリー構造をとっています。このルートディレクトリを、たとえばですが「/var/chroot/」ディレクトリに変更する技術が「chroot」です。
    from https://linuc.org/study/knowledge/420/
    - この技術によって、元の`/proc`フォルダーが見えなくなり、プロセスの隔離ができました。
- 次に、`cd`コマンドでディレクトリの移動をしてます。
    - 移動先は`/`ディレクトリで、コンテナの外側から見たときには`/containerfs`ディレクトリとなります。



これで、PID 名前空間を使用してプロセス ID の分離が実現しました。同様に、ネットワークとユーザーの名前空間を使用して、ネットワークとユーザーを分離できます。

ここまで分離出来た結果を確認してみましょう。

- UTS(Unix Time Sharing)名前空間: ホスト名とドメイン名
- PID 名前空間: プロセス番号
- マウント名前空間: マウント ポイント
- IPC 名前空間: プロセス間通信リソース
- ネットワーク名前空間: ネットワークリソース
- ユーザー名前空間: ユーザーおよびグループの ID 番号











page:https://minegishirei.hatenablog.com/entry/2024/03/20/082948