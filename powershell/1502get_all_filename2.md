
参考:海外版のpowershell pdfファイル

URL：http://index-of.co.uk/Microsoft-Windows-Ebooks/OReilly.Windows.PowerShell.Cookbook.Oct.2007.pdf

#### 参考記事

この記事は以下の書籍を参考に執筆されました。
詳しい内容の確認はこちらからお願いいたします。

<iframe sandbox="allow-popups allow-scripts allow-modals allow-forms allow-same-origin" style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=oreilly10book-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=4873113822&linkId=3998987cf4c97963a20e5ceb58e41198"></iframe>





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


