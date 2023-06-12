



## dockerの仕組み:cgroupsとnamespacesを使っている。

以下のような記事を見つけた。

> コンテナの仕組み
> 
> そもそもですが, コンテナは Linux kernel の namespaces, cgroups などの機能によって実現されています4。
> 
> 
> - namespaces: プロセス, ネットワーク, ユーザーなどのグローバルなリソースを独立させる5
> - cgroups: CPU, メモリなどのリソース割り当てをプロセスごとに制限する
> このため, 前提として, 通常は Linux kernel 上でないと Docker をはじめとするコンテナは作れません。

この場合、どこでcgroupsを読んでいるのか、どこでnamespacesを読んでいるのかを探さなければならない。


## cgroupsとは?

cgroup（Control Group）は、Linuxカーネルの機能の1つで、**システムリソース（CPU、メモリ、ディスクIO、ネットワークなど）を使用するプロセスをグループ化**し、**それぞれのグループに対してリソース使用量を制限**することができるものです。

from https://qiita.com/ymktmk/items/d8f3d000325608e714c2#cgroup%E3%81%A8%E3%81%AF



### cgroupsの場所


clientのパッケージの中のほとんどのソースには以下のような記述がある。

(https://github.com/minegishirei/explainable_moby)このあたりのソースコードで「cgroups」と検索すると見れる）

```go
package client

import (
	"bytes"
	"context"
	"fmt"
	"io"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"sync"
	"syscall"
	"testing"
	"time"

	"github.com/containerd/cgroups/v3"
	"github.com/containerd/cgroups/v3/cgroup1"
	cgroupsv2 "github.com/containerd/cgroups/v3/cgroup2"
	. "github.com/containerd/containerd"
	"github.com/containerd/containerd/cio"
	"github.com/containerd/containerd/containers"
	"github.com/containerd/containerd/errdefs"
	"github.com/containerd/containerd/oci"
	"github.com/containerd/containerd/plugin"
	"github.com/containerd/containerd/runtime/v2/runc/options"
	"github.com/containerd/containerd/sys"
	"github.com/opencontainers/runtime-spec/specs-go"
	exec "golang.org/x/sys/execabs"
	"golang.org/x/sys/unix"
)
```

これはつまり、**githubのcontainerdの中に別リポジトリとしてcgroups**というソースがあるはずということだ。

(Go言語をよく知らないが、github.comにあるリポジトリも含めてビルドすることができるらしい。)

見つけた：https://github.com/containerd/cgroups

見たところバージョンが二つある。


## containerdのcgroupsについて

cgourpsリポジトリの存在意義は次の通りだ。

> Go package for creating, managing, inspecting, and destroying cgroups. The resources format for settings on the cgroup uses the OCI runtime-spec found here.

**cgroup を作成、管理、検査、および破棄するための Go パッケージ。**

### containerd cgroupsサンプルコード1

現在のシステムが cgroups v2 を実行しているかどうかの確認

```go
var cgroupV2 bool
if cgroups.Mode() == cgroups.Unified {
	cgroupV2 = true
}
```

from https://github.com/containerd/cgroups#check-that-the-current-system-is-running-cgroups-v2


### containerd cgroupsサンプルコード1: 新しいcgroupsを作成するには


```go
import (
    "github.com/containerd/cgroups/v3/cgroup2"
    specs "github.com/opencontainers/runtime-spec/specs-go"
)

res := cgroup2.Resources{}
// dummy PID of -1 is used for creating a "general slice" to be used as a parent cgroup.
// see https://github.com/containerd/cgroups/blob/1df78138f1e1e6ee593db155c6b369466f577651/v2/manager.go#L732-L735
m, err := cgroup2.NewSystemd("/", "my-cgroup-abc.slice", -1, &res)
if err != nil {
	return err
}
```








