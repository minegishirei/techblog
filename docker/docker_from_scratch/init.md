




# VagrantによるCentos7のインストール


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



## go言語のインストール

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

## `docker run`を作成する

まずはコンテナを実行するコマンド`docker run`コマンドを作成しましょう。


どんなエディターでもいいので、`container.go`を作成しましょう。

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
  cmd := exec.Command(os.Args[2], os.Args[3:]...)\
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


































