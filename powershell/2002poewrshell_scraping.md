

- [Powershellでスクレイピングを行う方法](#powershellでスクレイピングを行う方法)
  - [PowershellでHTMLを取得する](#powershellでhtmlを取得する)
    - [注意:robots.txtを確認すること](#注意robotstxtを確認すること)
  - [HTML agility Packをインストールする](#html-agility-packをインストールする)
  - [スクレイピング結果を保存する](#スクレイピング結果を保存する)
  - [結果を保存する](#結果を保存する)
  - [まとめ](#まとめ)


# Powershellでスクレイピングを行う方法

今回はPowershellでスクレイピングを行う方法を解説します。

---


- 
  - 今日はPowershellでスクレイピングを行うよ
- 
  - スクレイピングって何？
- 
  - スクレイピングはWebサイトを含むインターネット上から情報収集を行うプログラムのことだよ。
  - サイトによっては著作権に反する行為になりかねないけど膨大な情報を自動的に扱うことができるよ。
- 
  - インターネットの情報を全部拾ってこれるの？
- 
  - 例えば「明日の東京の天気」をスクレイピングによって情報を集めてプログラミングで扱うことができるよ
- 
  - スクレイピング...諸刃の剣ね...


---


## PowershellでHTMLを取得する

---


- 
  - まずはネットからhtmlを拾ってくるところから始めるよ
- 
  - 了解！

---

PowerShellの`Invoke-WebRequest`コマンドレットを使用して、WebページのHTMLを取得することができます。

```ps1
$url = "https://example.com"
$response = Invoke-WebRequest -Uri $url
$html = $response.Content
```

今回はexampleですが、例えばyahooの天気予報を取得したい場合にはurlを次のように変更しましょう。

```ps1
$url = "https://weather.yahoo.co.jp/weather/"
$response = Invoke-WebRequest -Uri $url
$html = $response.Content
echo $html
```

サンプル実行例

```html
<!DOCTYPE html>
<html lang="ja">

<head>
  <link rel="stylesheet" href="https://s.yimg.jp/images/weather/pc/v2/css/map-1.1.0.css">
  <title>Yahoo!天気・災害 - 天気予報 / 防災情報</title>
  <link rel="canonical" href="https://weather.yahoo.co.jp/weather/">
</head>

<body class="yj950-2">
  (中略...)
        
  <script src="https://s.yimg.jp/images/weather/pc/v2/js/yjw_cre_sub-1.1.js" type="text/javascript" charset="UTF-8"></script>
</body>
</html>
```

### 注意:robots.txtを確認すること

---

- 
  - 今回の例では"https://example.com"から拾ってきているしこのサイトはほぼ自由に扱って問題ないけど
  - 情報を拾いたいサイトを入力するときにはそのサイトがスクレイピングを許容しているかどうか確認する必要があるよ
- 
  - 気をつけないと警察に捕まっちゃうのね
  - どう確認すればいいの？
- 
  - 大抵のwebサイトでは"/robots.txt"を設定しているよ
  - 例えばtwitterのrobots.txtは"https://twitter.com/robots.txt"に設定してある
- 
  - ここの設定を見ればスクレイピングを許可しているかどうかわかるのね
- 
  - その通り、特に`robots.txt`の中でも`User-agent: *`の下にある項目を確認すれば、許可されているページとそうでないページがわかるよ
---

## HTML agility Packをインストールする

---

- 
  - それじゃあ手に入れたhtmlコードを解析していこうか
- 
  - さっき見た生のhtmlはクソまずいわね
  - どうしたら綺麗に見えるかしら...
- 
  - PowerShellの`HTML Agility Pack`と呼ばれる外部ライブラリを使用することができるよ
  - 以下のコマンドを使用して、`NuGetパッケージマネージャー`を使用して`HTML Agility Pack`をインストールしようか。
  - `Install-Package HtmlAgilityPack`
- 
  - なんかよくわかんないけどエンター押したら行けたっぽい！
- 
---


HTMLを解析するために、PowerShellの`HTML Agility Pack`と呼ばれる外部ライブラリを使用することができます。

まずは`HTML Agility Pack`をインストールする必要があります。
次のコマンドを使用してNuGetパッケージマネージャーから`HTML Agility Pack`をインストールします。

```ps1
Install-Package HtmlAgilityPack
```


## スクレイピング結果を保存する

HTMLを解析して、必要な要素を抽出することができます。**たとえば、すべてのリンクを取得するには、次のようにします。**

```ps1
$url = "https://example.com"
$response = Invoke-WebRequest -Uri $url
$html = $response.Content

Add-Type -Path ".\packages\HtmlAgilityPack.1.11.28\lib\net45\HtmlAgilityPack.dll"

$doc = New-Object HtmlAgilityPack.HtmlDocument
$doc.LoadHtml($html)

$links = $doc.DocumentNode.SelectNodes("//a")
foreach ($link in $links) {
    Write-Output $link.InnerHtml
}
```


## 結果を保存する


---

- 
  - 必要に応じて、スクレイピングされたデータをファイルに保存することができるよ。
  - `out-File`コマンドを使うことで先ほど取得した結果をすべてファイルに出力してみよか。
- 
  - なんかよくわかんないけどエンター押したら行けたっぽい！
- 

---


```ps1
Out-File -FilePath "output.txt" -InputObject $links
```


## まとめ

---

- 
  - 以上の手順に従うことで、PowerShellを使用してWebスクレイピングを行うことができたね。
- 
  - ただ... WebスクレイピングはWebサイトの利用規約に反する場合があるのね...
- 
  - そうだね。よく言う、大いなる力には大いなる責任が伴うってやつだね。
- 

---










title:Powershellでスクレイピングする





