

参考:https://www.youtube.com/watch?v=8YGNg38-6jM

# カーネルが無いシステムとは

カーネルが無いシステムとは、次のようなシステムをイメージすると良い。

> ハードウェアの上に、直接アプリが一つあるとき。

アプリからハードウェアにアクセスする構造だが、以下の点で不便

- アプリがバグっていたらシステム終了
- 最悪デバイスが二度と動かなくなる
- アプリを作るたびに直接ハードウェアを操作するプログラムを書かなければならない。
- 複数アプリで一つのデバイスをコントロールできない。
    - （仮想記憶）:複数のアプリを動かすときに隣のアプリを覗ける


つまり

**もしOSが存在せず、ハードウエア上にシステムを構築しなければならない場合、
メモリ管理、割り込み処理、I/O デバイスとの通信、ファイル管理、
ネットワークスタックの構成と管理など、やらなければならないことが大量に出てきてしまうのです。**


## なぜカーネルが必要なのか?

ハードウェアを操作する基本プログラムを作るため！
カーネルがあることでシステムを動かせる


# linuxのアーキテクチャの全体像

<img src="./img/linuxkernel_overview.png">

linuxkernelは次の三構造になっている。

- ハードウェア
    - CPU、メインメモリからディスクドライブ、ネットワークインターフェース、周辺機器まで
キーボードやモニターなどのデバイスを管理する。それぞれのハードウェアに対してインターフェースが用意されている。ハードウェアのインターフェースはさらに以下のように分類される。
1. CPU インターフェイス
2. メイン メモリとのインターフェイス
3. ネットワーク インターフェイスとドライバー (有線および無線。)
4. ファイルシステムおよびブロックデバイスドライバーインターフェイス
5. キャラクタデバイス、ハードウェア割り込み、およびデバイスドライバ（キーボード、端末など）

- カーネル
    - 多数のコンポーネントがあることに注意してください。init システムやメモリ管理、ネットワーキングにファイルシステムなどカーネルとユーザー ランドの間にあるもの。
    ユーザーランドからは**システムコール**経由で呼び出される。
    - ex
        - `write`システムコール
        - `getuid`システムコール

- ユーザーランド
    - オペレーティング システム コンポーネントを含む、大部分のアプリが実行されている場所。シェル (第 3 章で説明)、ps や ssh などのユーティリティ、グラフィカル ユーザーなど、ユーザーから目に見える場所は**ユーザーランド**に属します。
    - ex
        - `ps`コマンド
        - `ssh`コマンド
        - `grep`コマンド

ここまででわかる通り、私たちが通常 Linux の動作の一部と考えているシェルや`grep`、`find`、`ping`などのユーティリティなどのシステムは厳密に言えればカーネルの機能の一部ですが、ダウンロードするアプリと非常によく似ており、linuxの中でもユーザーランドの一部です。

そのほかのユーザーランドとカーネルのトピックでは、`ユーザーモード`と`カーネルモード`という言葉がよくつかわれます。
これはLinuxのハードウェアに対する特権のことであり、平たく言うと**カーネルモードでシステムが動いている場合にはハードウェアの利用が可能である**ということになります。




# システムコールとは

アプリがカーネルの機能を呼び出すこと。
linuxkernelにはAPIが存在しており、このAPIを利用することでシステムコールが可能です。
Go、Rust、Python、Java などの言語は、これらの syscall 上に構築される可能性があります。


### 具体例1:writeシステムコール

> 具定例）write()システムコール

このコードはデータを書き込む。`man 2 write`参照

かの有名な`echo`コマンドで使用される。

#### 具体例2:getuidシステムコール

getuidは現在ログインしているユーザーの一意のIDを手にれることができる。
linuxのmanページから`getuid`を確認することでオフィシャルな説明が確認可能だ。

> getuid() returns the real user ID of the calling process.

ちなみに似たコマンドで`fgeteuid`が存在する。

> getuid () は呼び出しプロセスの実際のユーザー ID を返します。
> 
> geteuid () は、呼び出しプロセスの実効ユーザー ID を返します

from https://www.man7.org/linux/man-pages/man2/getuid.2.html

**そして、この`getuid`はシステムコールとしてlinuxkernelのapiとして実装されている。**

この`getuid`をlinuxコマンドラインから呼び出すには次のように`id`コマンドを使用する。

```sh
id --user
```


### システムコールを目視する

`strace`コマンドを使用。このコマンドはプロセスのシステムコールの履歴を見ることができる。
プログラミングの`hello world`を見てみよう。

#### C言語

- C言語で書かれたコードをコンパイルした`hello_c`を実行する際

```sh
strace -o c.log ./hello_c
```

#### Python

- pytonで書かれたコードを実行する際

具体例

```python
#!/usr/bin/python3
print("hello python")
```

このコードのシステムコールを見てみる。

```sh
strace -o c.log  ./hello.py
```


実行結果...

```
read(3, "#!/usr/bin/python3", 18)       = 18
read(3, "\nprint(\"hello world\")\n", 4096) = 22
close(3)                                = 0
stat("./hello.py", {st_mode=S_IFREG|0755, st_size=40, ...}) = 0
readlink("./hello.py", 0x7ffe79b13de0, 4096) = -1 EINVAL (Invalid argument)
getcwd("/home/minegishiminami/myworking/0000dev", 4096) = 40
lstat("/home/minegishiminami/myworking/0000dev/hello.py", {st_mode=S_IFREG|0755, st_size=40, ...}) = 0
openat(AT_FDCWD, "./hello.py", O_RDONLY) = 3
fcntl(3, F_GETFD)                       = 0
fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
fstat(3, {st_mode=S_IFREG|0755, st_size=40, ...}) = 0
ioctl(3, TCGETS, 0x7ffe79b24d60)        = -1 ENOTTY (Inappropriate ioctl for device)
lseek(3, 0, SEEK_CUR)                   = 0
fstat(3, {st_mode=S_IFREG|0755, st_size=40, ...}) = 0
read(3, "#!/usr/bin/python3\nprint(\"hello "..., 4096) = 40
lseek(3, 0, SEEK_SET)                   = 0
read(3, "#!/usr/bin/python3\nprint(\"hello "..., 4096) = 40
read(3, "", 4096)                       = 0
close(3)                                = 0
write(1, "hello world\n", 12)           = 12
rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7f5d96112f10}, {sa_handler=0x630520, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7f5d96112f10}, 8) = 0
brk(0xe94000)                           = 0xe94000
sigaltstack(NULL, {ss_sp=0xdd8870, ss_flags=0, ss_size=8192}) = 0
sigaltstack({ss_sp=NULL, ss_flags=SS_DISABLE, ss_size=0}, NULL) = 0
exit_group(0)                           = ?
```

まず注目するべきは一行目。

> read(3, "#!/usr/bin/python3", 18)       = 18
> read(3, "\nprint(\"hello world\")\n", 4096) = 22

pythonはインタプリタ言語であるため、まず最初に読み込みを行っている。

次に`write`が書かれているコード。

> write(1, "hello world\n", 12)           = 12

この部分ではデータを書き込む`write`システムコールが行われている。






### 結論

どんなプログラミング言語であれ、`hello world`を出力するときは

**`write`システムコールを行っている**

ことがわかると思います。




## CPUモード

カーネルのCPUを動かすときのモード。大きく二種類ある。
(x86_64のring protection)
ご覧のとおり、私たちが通常 Linux の動作の一部と考えているものの多くは、
シェルや grep、find、ping などのユーティリティなどのシステムは、実際には
カーネルですが、ダウンロードするアプリと非常によく似ており、ユーザーランドの一部です
- カーネルモード:全命令を実行できる。カーネルの実行中はカーネルモードになる。
- ユーザーモード:一部命令が禁止される。アプリを実行するときにはユーザーモードになる。
    - ハードウェアアクセスを禁止
    - 禁止されたシステムコールをすると特定の処理が動く




# CPU

Linuxは複数のコンピューターアーキテクチャ上で動作します。
（ここでのコンピューターアーキテクチャはCPUファミリアと同じ意味です。）
現在使用しているLinuxがどのCPUアーキテクチャであるかを把握するには`dmidecode`コマンドを使用します。
もし出力結果が得られない場合には、`lscpu`コマンドを使用するのがよいでしょう。

```sh
[root@ac93e82b6845 myworking]# lscpu
Architecture:            x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Address sizes:         46 bits physical, 48 bits virtual
  Byte Order:            Little Endian
CPU(s):                  20
  On-line CPU(s) list:   0-19
Vendor ID:               GenuineIntel
  Model name:            12th Gen Intel(R) Core(TM) i7-12700
    CPU family:          6
    Model:               151
    Thread(s) per core:  2
    Core(s) per socket:  10
    Socket(s):           1
    Stepping:            2
    BogoMIPS:            4224.00
    Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse ss
                         e2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology tsc_reliable nonstop
                         _tsc cpuid pni pclmulqdq vmx ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline
                         _timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single ssbd ibrs
                         ibpb stibp ibrs_enhanced tpr_shadow vnmi ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi
                         2 erms invpcid rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves avx_vnni u
                         mip waitpkg gfni vaes vpclmulqdq rdpid movdiri movdir64b fsrm serialize flush_l1d arch_capabili
                         ties
Virtualization features:
  Virtualization:        VT-x
  Hypervisor vendor:     Microsoft
  Virtualization type:   full
Caches (sum of all):
  L1d:                   480 KiB (10 instances)
  L1i:                   320 KiB (10 instances)
  L2:                    12.5 MiB (10 instances)
  L3:                    25 MiB (1 instance)
Vulnerabilities:
  Itlb multihit:         Not affected
  L1tf:                  Not affected
  Mds:                   Not affected
  Meltdown:              Not affected
  Mmio stale data:       Not affected
  Retbleed:              Mitigation; Enhanced IBRS
  Spec store bypass:     Mitigation; Speculative Store Bypass disabled via prctl and seccomp
  Spectre v1:            Mitigation; usercopy/swapgs barriers and __user pointer sanitization
  Spectre v2:            Mitigation; Enhanced IBRS, IBPB conditional, RSB filling, PBRSB-eIBRS SW sequence
  Srbds:                 Not affected
  Tsx async abort:       Not affected
```

lscpuコマンドの実行結果、

- cpuファミリアは`x86_64`
- CPU数は`20`
- CPUのモデルは`Intel 12世代`

さらにコンパクトな情報は`uanme -a`で確認できます。

```sh
[root@ac93e82b6845 myworking]# uname -a
Linux ac93e82b6845 5.15.90.1-microsoft-standard-WSL2 #1 SMP Fri Jan 27 02:56:13 UTC 2023 x86_64 GNU/Linux
```

## CPUファミリア一覧


### x86 CPUファミリア

x86アーキテクチャはIntelが開発した命令セットファミリでのちにAMDに提供されます。

- `Intel 64bit cpu`はカーネル内部では`x64`または`x86_64`と表記されています。
- `Intel-32bit`はカーネル内部では`x86`と表記されます。
- `AMD84`はカーネル内部では`amd64`と表記されます。

アウトオブオーダー実行への依存とエネルギー効率の悪さがデメリットとしてあげられますが、
`x86`はいま最も使用されているCPUファミリアです。

> アウト・オブ・オーダー実行（アウト・オブ・オーダーじっこう、英: out-of-order execution）とは、高性能プロセッサにおいてクロックあたりの命令実行数（IPC値）を増やし性能を上げるための手法の1つで、機械語プログラム中の命令の並び順に依らず、データなどの依存関係から見て処理可能な命令について逐次開始・実行・完了させるものである。頭文字で'OoO'あるいは'O-o-O'とも書かれる。「順序を守らない実行」の意である。

from https://ja.wikipedia.org/wiki/%E3%82%A2%E3%82%A6%E3%83%88%E3%83%BB%E3%82%AA%E3%83%96%E3%83%BB%E3%82%AA%E3%83%BC%E3%83%80%E3%83%BC%E5%AE%9F%E8%A1%8C

x86 CPUファミリアに対する命令は`x86アセンブラ`として定義されており、
x86アーキテクチャは8個の汎用レジスタ (GPR) と6個のセグメントレジスタ、1個のフラグレジスタ、1個の命令ポインタを持っている。

- RAX/EAX/AX/AL/AH : 「アキュムレータレジスタ」と呼ばれる。算術演算操作の結果が格納される。
- RCX/ECX/CX/CL/CH : 「カウンタレジスタ」と呼ばれる。シフトローテート命令とループ命令に使用される。
- RDX/EDX/DX/DL/DH : 「データレジスタ」と呼ばれる。算術演算操作とI/O操作に使用される。
- RBX/EBX/BX/BL/BH : 「ベースレジスタ」と呼ばれる。セグメントモードでのDS（後述）に格納されたデータを指し示すために使用される。
- RSP/ESP/SP : 「スタックポインターレジスタ」と呼ばれる。スタックのトップを指し示すポインタ。
- RBP/EBP/BP : 「スタックベースポインタレジスタ」と呼ばれる。スタックのベースを指し示すのに使用される。
- RSI/ESI/SI : 「ソースレジスタ」と呼ばれる。ストリーム操作コマンド（たとえば MOV命令）でのソース（入力元）へのポインタとして使用される。
- RDI/EDI/DI : 「デスティネーションレジスタ」と呼ばれる。ストリーム操作コマンドでの転送先（←英語でデスティネーションという. 出力先のようなもの）へのポインタとして使用される。



### ARM CPUファミリア













