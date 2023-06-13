





## cgroupの読み込み

既に存在するcgroupのコントローラーを取得したい。

```go
control, err = cgroup1.Load(cgroup1.Default, cgroups.StaticPath("/test"))
```


## cgroupへのプロセス追加

次のコードは`Pid:1234`を追加するコードです。

```go
control, err = cgroup1.Load(cgroup1.Default, cgroups.StaticPath("/test"))
if err := control.Add(cgroup1.Process{Pid:1234}); err != nil {
}
```





