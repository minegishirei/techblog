
- [イベントログの収集](#イベントログの収集)
- [イベントログの履歴を手に入れる](#イベントログの履歴を手に入れる)
- [イベントログから検索をかける](#イベントログから検索をかける)
- [頻度の高いイベントログを取得する方法](#頻度の高いイベントログを取得する方法)
- [まとめ](#まとめ)


## イベントログの収集

パソコンでエラーが発生した場合、通常は一時的なエラーやユーザーの操作ミスが原因です。しかし、時には致命的なエラーが発生し、長期的な対処が必要になることもあります。このような場合に、以下のコマンドを実行してイベントログを取得することができます。


```sql
Get-EventLog -List
```

このコマンドを実行すると、登録されたイベントログのリストが表示されます。これらのログは、完全な.NETオブジェクトとして扱えるため、様々な操作が可能です。

```scss
Max(K) Retain OverflowAction        Entries Name
------ ------ --------------        ------- ----
   512      0 OverwriteAsNeeded       2,157 ADAM (Test)
   512      7 OverwriteOlder          2,090 Application
   512      7 OverwriteOlder          0 Internet Explorer
 8,192     45 OverwriteOlder          0 Media Center   
   512      7 OverwriteOlder          0 ScriptEvents
   512      7 OverwriteOlder          2,368 System
15,360      0 OverwriteAsNeeded       0 Windows PowerShell
```

## イベントログの履歴を手に入れる

最新のイベントログを取得するには、以下のようにコマンドを実行します。

```sql
Get-EventLog System -Newest 10 | Format-Table Index,Source,Message -A
```

このコマンドを実行すると、最新の10件のイベントログが表示されます。これらのログから、DHCPサービスがPCにアドレスを割り当てたことや、システムの稼働時間が42秒であることなどが分かります。これらのログには、プロセスのレベルではなく、スレッドレベルにまで及ぶ詳細な記述が含まれています。

## イベントログから検索をかける
イベントログからフィルタリングするには、以下のようにコマンドを実行します。


```sql
Get-EventLog System | Where-Object { $_.Message -match "disk" }
```

このコマンドを実行すると、メッセージログに"disk"が含まれるすべてのイベントログが表示されます。このように、フィルタリングには"Where-Object"を使用します。






## 頻度の高いイベントログを取得する方法

PCの構成に不審な点がある場合、トラブルシューティングの第一歩は、頻繁に発生するエラーを特定することです。以下のコードで、頻度の高いエラーを調べることができます。

```sql
Get-EventLog System | Group-Object Message
```

上記コードを実行すると、以下のような結果が得られます。

```scss
Copy code
Count Name                      Group
----- ----                      -----
23 The Background Intelli... {LEE-DESK, LEE-DESK, LEE-DESK, LEE-DESK...
23 The Background Intelli... {LEE-DESK, LEE-DESK, LEE-DESK, LEE-DESK...
3 The Logical Disk Manag... {LEE-DESK, LEE-DESK, LEE-DESK}
3 The Logical Disk Manag... {LEE-DESK, LEE-DESK, LEE-DESK}
3 The Logical Disk Manag... {LEE-DESK, LEE-DESK, LEE-DESK}
161 Driver Microsoft XPS D... {LEE-DESK, LEE-DESK, LEE-DESK, LEE-DESK...
(...)
```

イベントログを保存し、出力する方法
以下のコードを使用して、イベントログを保存し、出力することができます。

```bash
# イベントログの保存
Get-EventLog System | Export-CliXml c:\temp\SystemLogBackup.clixml

# イベントログの出力
$archivedLogs = Import-CliXml c:\temp\SystemLogBackup.clixml
$archivedLogs | Group Source
```

上記のコードを実行すると、以下のような結果が得られます。

```scss
Copy code
Count Name                      Group
----- ----                      -----
23 The Background Intelli... {LEE-DESK, LEE-DESK, LEE-DESK, LEE-DESK...
23 The Background Intelli... {LEE-DESK, LEE-DESK, LEE-DESK, LEE-DESK...
3 The Logical Disk Manag... {LEE-DESK, LEE-DESK, LEE-DESK}
3 The Logical Disk Manag... {LEE-DESK, LEE-DESK, LEE-DESK}
3 The Logical Disk Manag... {LEE-DESK, LEE-DESK, LEE-DESK}
161 Driver Microsoft XPS D... {LEE-DESK, LEE-DESK, LEE-DESK, LEE-DESK...
(...)
```




## まとめ

次のコマンドを実行してイベントログを取得することができます。
また、取得したイベントログは必要に応じて


```sql
Get-EventLog -List
```




