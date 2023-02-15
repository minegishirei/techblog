

## 複数行の文字列を変数に代入する

「@"」で囲むことで文字列を複数行にかける。

```ps1
$myString = @"
This is the first line
of a very long string. A "here string"
lets you to create blocks of text
that span several lines.
"@
```

この手法はただの文字列にだけでなく、コードのコメントアウトにも使える。

例えば、`MyTest`関数をコメントアウトしたい場合。`$null`という変数を作成して`@"文字列"`で関数を丸ごと囲むことで、疑似的なコメントアウトとして利用が可能です。

```ps1
# This is a regular comment
$null = @"
function MyTest
{
    "This should not be considered a function"
}
$myVariable = 10;
"@
# これ以降のコードは通常のコードです。
...
```




redirect:https://minegishirei.hatenablog.com/entry/2023/02/15/111500

