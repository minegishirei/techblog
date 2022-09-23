
## ファイルが置かれたら起動するスクリプト【powershell学習サイト】

power automateなどはファイルがおかれた瞬間/メール配信された瞬間に起動する仕組みがあります。

同様のことをpowershellで実現するにはどうすればよいのでしょうか。




## ファイルが置かれたら起動するスクリプト

```ps1
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "C:\temp"
$watcher.Filter = "*.xml"
Register-ObjectEvent -InputObject $watcher -SourceIdentifier mywatch -EventName Created -Action {
    Write-Output "error" | Out-File -FilePath "C:\temp\error.log" -Encoding Default -append
}
```

上記のpowershellスクリプトを「grep_rectangle_v2.ps1」と保存して実行してみましょう。

次のように出力されれば成功です。

```ps1

Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
1      mywatch                         NotStarted    False                                ...

```

これで**上記のコマンドを実行したpowershellコンソール画面が存在し続ける限りはチェックし続ける仕組みが完成しました**

また、監視対象のフォルダーは**共有ディレクトリ**でも動くので、サーバーから出力されたファイルの監視も可能になります。


## 動作確認

C:\temp（ｃドライブ配下のtempフォルダー）にxmlファイルを配置してみましょう。

同じ"C:\temp配下にerror.logが出力されるはずです。


## 登録されているか確認

登録されているか確認するには以下のコマンドを打ちます。

```ps1
Get-EventSubscriber
```


## 登録解除時間軸：2022/09/19 ~ NOW


時間軸：2022/09/19 ~ NOW



登録を解除するには以下のコマンドを打ちましょう。

```ps1
Unregister-Event -SourceIdentifier mywatch
```



## 備考

title:ファイルが置かれたら起動するスクリプト【powershell学習サイト】

description:powerautomateなどはファイルがおかれた瞬間/メール配信された瞬間に起動する仕組みがあります。同様のことをpowershellで実現するにはどうすればよいのでしょうか
