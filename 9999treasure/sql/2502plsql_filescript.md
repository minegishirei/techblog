


## SQLのスクリプトファイルの実行

ほとんどの文法についてはSQL*Plusと同様にファイルに貯蓄することができます。

最も簡単なスクリプトファイルの実行は「＠」を先頭につけて実行します。


例えば、abc.pkgファイルを実行したい場合は

<pre><code>
> @abc.pkg

</code></pre>

と書きます。

もう少し明示的にファイルを実行したい場合は

<pre><code>
> START abc.pkg

</code></pre>

と書きます。

さらにファイルのパスまで明示的にファイルを実行したい時は

<pre><code>
> @/files/src/release/1.0/abc.pkg

</code></pre>






<pre>
Almost any statement that works interactively in SQL*Plus can be stored in a file for
repeated execution. The easiest way to run such a script is to use the SQL*Plus @ com‐
mand.4
 For example, this runs all the commands in the file abc.pkg:
SQL> @abc.pkg
The file must live in my current directory (or on SQLPATH somewhere).
If you prefer words to at signs, you can use the equivalent START command:
SQL> START abc.pkg
and you will get identical results. Either way, this command causes SQL*Plus to do the
</pre>




title:SQL   のスクリプトファイル実行【PL/SQL基礎入門】

description:ほとんどの文法についてはSQL*Plusと同様にファイルに貯蓄することができます。最も簡単なスクリプトファイルの実行は「＠」を先頭につけて実行します。


img:https://images.squarespace-cdn.com/content/v1/5c3cf2ac5417fc3efa512c5a/1547588142968-VWQR0WMNFIX7GW18937A/lrg.jpg




category_script:page_name.startswith("25")




