


##  環境変数を変更することについて

バッチファイルが環境変数を変更すると、cmd.exeはスクリプトが終了した後もこの変更を保持します。
ですが、あるバッチファイルが**別のバッチファイルの環境を偶然に汚染する可能性**があるため、これはしばしば問題を引き起こします。
とはいえ、バッチファイルの作成者は、特定のタスクに合わせて環境のパスやその他の側面をカスタマイズするために、意図的にグローバル環境を変更することがあります。



##  課題：powershellでの環境変数を変更した値を保持したい。

ただしpowershellにおいて、グローバルでない環境変数はプロセスのプライベートな詳細であり、そのプロセスが終了すると消えます。
これにより、上記の環境カスタマイズスクリプトは、PowerShellから実行すると機能しなくなります。


##  解決策：環境変数をテキストファイルに保持する

これは原始的な解決策ではありますが、環境変数をテキストファイルに保持するのが合理的です。

次のスクリプトを使用すると、環境を変更し、cmd.exeが終了した後も変更を保持するバッチファイルを実行できます。これは、バッチファイルが完了したら環境変数をテキストファイルに保存し、PowerShellセッションでそれらすべての環境変数を再度設定することで実現されます。

Invoke-CmdScript と名付けます。

<pre><code>
$tempFile = [IO.Path]::GetTempFileName()

## cmd.exeの出力を保存します。また、cmd.exeに出力を依頼します
## バッチファイルが完了した後の環境テーブル
cmd /c " `"$script`" $parameters && set > `"$tempFile`" "

## 一時ファイルの環境変数を調べます。
## それぞれについて、ローカル環境で変数を設定します。
Get-Content $tempFile | Foreach-Object {
    if($_ -match "^(.*?)=(.*)$")
    {
        Set-Content "env:\$($matches[1])" $matches[2]
    }
}
Remove-Item $tempFile
</code></pre>


##  スクリプトの使用方法

 Invoke-CmdScript.ps1

Invoke the specified batch file (and parameters), but also propagate any
environment variable changes back to the PowerShell environment that
called it.

i.e., 既に存在するファイル:'foo-that-sets-the-FOO-env-variable.cmd':

<pre><code>
PS > type foo-that-sets-the-FOO-env-variable.cmd
@set FOO=%*
echo FOO set to %FOO%.

PS > $env:FOO
PS > Invoke-CmdScript "foo-that-sets-the-FOO-env-variable.cmd" Test
C:\Temp>echo FOO set to Test.
FOO set to Test.
PS > $env:FOO
Test
</code></pre>


title:環境変数の変更方法【powerhsell学習サイト】




