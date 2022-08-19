
参考:海外版のpowershell pdfファイル

URL：http://index-of.co.uk/Microsoft-Windows-Ebooks/OReilly.Windows.PowerShell.Cookbook.Oct.2007.pdf



##  ファイルの名前の一覧を取得するコード

<pre><code>
$rootpathItem = Get-ChildItem -Recurse
foreach($item in $rootpathItem){
    if($item.PSIsContainer){
        #folder
    }else{
        $item.Name
    }
}
</code></pre>


##  拡張子を指定してファイルの一覧を取得するコード

以下は.pngで終わるファイル名を全て取得するコード

<pre><code>
$rootpathItem = Get-ChildItem -Recurse
foreach($item in $rootpathItem){
    if($item.PSIsContainer){
        #folder
    }else{
        if($item.Name.EndsWith(".png")){
            $item.Name
        }
    }
}
</code></pre>


##  拡張子を指定してファイルの一覧を取得するコード(複数指定)

以下は.vbp .exeで終わるファイルを全て取り出すコード

<pre><code>
$rootpathItem = Get-ChildItem -Recurse
foreach($item in $rootpathItem){
    if($item.PSIsContainer){
        #folder
    }else{
        if($item.Name.EndsWith(".exe")){
            $item.Name
        }
        if($item.Name.EndsWith(".vbp")){
            $item.Name
        }
    }
}
</code></pre>

if文を追加していけばさらに多くの拡張子を指定できる。






title:【powershell】ファイルの名前のみの一覧を取得するコード

description:powersehllではファイルの名前のみの一覧を取得するコードも容易に書くことができます。

category_script:page_name.startswith("1")


