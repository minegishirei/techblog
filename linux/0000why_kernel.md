

参考:https://www.youtube.com/watch?v=8YGNg38-6jM

## カーネルが無いシステムとは

カーネルが無いシステムとは、次のようなシステムをイメージすると良い。

> ハードウェアの上に、直接アプリが一つあるとき。

アプリからハードウェアにアクセスする構造だが、以下の点で不便

- アプリがバグっていたらシステム終了
- 最悪デバイスが二度と動かなくなる
- アプリを作るたびに直接ハードウェアを操作するプログラムを書かなければならない。
- 複数アプリで一つのデバイスをコントロールできない。
    - （仮想記憶）:複数のアプリを動かすときに隣のアプリを覗ける


## なぜカーネルが必要なのか?

ハードウェアを操作する基本プログラムを作るため！

カーネルがあることでシステムを動かせる



## システムコールとは

アプリがカーネルの機能を呼び出すこと。

### 具体例

具定例）write()システムコール

このコードはデータを書き込む。`man 2 write`参照

かの有名な`echo`コマンドで使用される。

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

- カーネルモード:全命令を実行できる。カーネルの実行中はカーネルモードになる。
- ユーザーモード:一部命令が禁止される。アプリを実行するときにはユーザーモードになる。
    - ハードウェアアクセスを禁止
    - 禁止されたシステムコールをすると特定の処理が動く



















