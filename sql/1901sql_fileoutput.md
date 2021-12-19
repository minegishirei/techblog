



## 概要：SQLの実行結果をファイル出力する

SQLを実行している時、まれにファイルに出力したくなる時があります。
例えばデータの状態を監視し、レポートを作成したい時など。

それを最も簡単にこなすのが「SPOOL」コマンドです

## 「SQL ファイル出力」で検索したあなたへ(SQL Plus)

SQL Plusでは 「SPOOL (ファイル名)」と記述することで指定したファイルに実行結果を全て吐き出すことができます。

<code><pre>
> SPOOL report
> @run_report_output.pkg
> SPOOL OFF
</pre></code>

SQL Plusのデフォルトの拡張子は.lstで上記のコマンドではrepot.lstが作成され、そのファイル内に「@run_report_output.pkg」の実行結果が出力されます。

しかし、この拡張子はユーザー自身で塗り替えることが可能です。

例えば、report.textに出力したい時は

<code><pre>
> SPOOL report.text
> @run_report_output.pkg
> SPOOL OFF
</pre></code>







title:ファイル出力について【SQL基礎入門】

description:SQL Plusでは 「SPOOL (ファイル名)」と記述することで指定したファイルに実行結果を全て吐き出すことができます。


img:https://images.squarespace-cdn.com/content/v1/5c3cf2ac5417fc3efa512c5a/1547588142968-VWQR0WMNFIX7GW18937A/lrg.jpg




category_script:page_name.startswith("25")

