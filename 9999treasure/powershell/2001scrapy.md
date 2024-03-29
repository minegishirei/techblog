




## powershellでhtmlテキストを手に入れる

```ps1
$source = "http://blogs.msdn.com/powershell/rss.xml"     
$wc = New-Object System.Net.WebClient
$content = $wc.DownloadString($source)
```

WebClientのDownloadStringを使えばhtmlのソースを手に入れることができる。

しかし、このままではタグがついたままなので綺麗なテキストに直さなければならない。


## powershellからのスクレイピングコード(サンプル)

以下のコードはmicrosoft beingで検索するコード（現在はhtmlの形式が変わったため、更なる工夫が必要）

```ps1
[string] $question = "何かの文字列"
$encoded = [System.Web.HttpUtility]::UrlEncode($question)
$url = "http://search.live.com/results.aspx?q=$encoded"
$text = (new-object System.Net.WebClient).DownloadString($url)


$startIndex = $text.IndexOf(＜span class="answer_header">')
$endIndex = $text.IndexOf('function YNC')

if(($startIndex -ge 0) -and ($endIndex -ge 0))
{
    $partialText = $text.Substring($startIndex, $endIndex - $startIndex)

    #以下のコードが動かない原因
    $pattern = '＜script.+?＜div (id="results"|class="answer_fact_body")>'
    $partialText = $partialText -replace $pattern,"`n"
    $partialText = $partialText -replace '＜span class="attr.?.?.?">',"`n"
    $partialText = $partialText -replace '＜BR ?/>',"`n"
    $partialText = clean-html $partialText
    $partialText = $partialText -replace "`n`n", "`n"
    "`n" + $partialText.Trim()
}
else {
    "`nNo answer found."
}

##  Clean HTML from a text chunk
function clean-html ($htmlInput)
{
    $tempString = [Regex]::Replace($htmlInput, "<[^>]*>", "")
    $tempString.Replace("&nbsp&nbsp", "")
}
```

#### 解説

powershellでのスクレイピングは正直なところ賢い選択とは思えない

やるならpythonが妥当である。

なぜならpowershellではwebページにアクセスすることはできても、htmlを解析するためのライブラリが豊富ではないからである。

その点pythonであればbeautifulsoupという強力なライブラリが存在する。

もし言語の選択肢が残っているのであればpythonをおす。


redirect:https://minegishirei.hatenablog.com/entry/2023/02/21/211722


title:powershellでスクレイピングする

description:WebClientのDownloadStringを使えばhtmlのソースを手に入れることができる。

category_script:page_name.startswith("2")

img:https://johobase.com/jb/wp-content/uploads/2021/03/taskbar-powershell-icon-contextmenu.png

参考:海外版のpowershell pdfファイル

URL：http://index-of.co.uk/Microsoft-Windows-Ebooks/OReilly.Windows.PowerShell.Cookbook.Oct.2007.pdf










