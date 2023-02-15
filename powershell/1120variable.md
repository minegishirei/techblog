# powershell学習サイト


- [powershell学習サイト](#powershell学習サイト)
  - [参考記事](#参考記事)
  - [変数について](#変数について)
  - [数値の代入](#数値の代入)
  - [変数確認(変数表示)](#変数確認変数表示)
  - [変数一覧の表示](#変数一覧の表示)
  - [変数の種類](#変数の種類)
  - [変数の型指定](#変数の型指定)
    - [Powershellの変数型一覧](#powershellの変数型一覧)





## 参考記事

この記事は以下の書籍を参考に執筆されました。
詳しい内容の確認はこちらからお願いいたします。

<iframe sandbox="allow-popups allow-scripts allow-modals allow-forms allow-same-origin" style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=oreilly10book-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=4873113822&linkId=3998987cf4c97963a20e5ceb58e41198"></iframe>




powershell入門

## 変数について 

変数の書き方は以下の通り

```ps1 
$FilePath = "C:\Windows\System32"
```
<p>
変数名に厳しいルールはないが、 基本的には大文字スタートで大文字区切りがよしとされる。
</p>

```ps1 
NG1 : $filePath
NG2 : $file_path 

GOOD! : $FilePath
```


## 数値の代入


```ps1 
$num1 = 1
```


## 変数確認(変数表示)

echo コマンドを使う。 

あるいは代入せずに`$num1`をべた書きするだけでも確認は可能 

```ps1 
#方法1
$num1 = 1 
echo "num1 varius is $num1"
$num1 = 2 
echo "num1 varius is $num1"

#方法2 
$num1
```

*ちなみに#で始まる行はコメント行と呼ばれ、プログラムの動作に一切影響を及ぼさない。 コード内に書けるメモだと思っていい。*


## 変数一覧の表示

Get-Variableで可能

```ps1
$num1 = 1 
echo "numl varius is "$numl 
$num2 = 2
echo "num2 varius is"$num2

Get-Variable 
```

## 変数の種類

Powershellで使用できる変数の型は以下の通り。

```ps1 
$a = 12                         # System. Int32 
$a = "Word"                     # System. String
$a = 3 ,12, "Word"              # array of System.
$a = Get-ChildItem C:\Windows   # FileInfo and DirectoryInfo types
```
**数字、文字列、配列だけでなく、コマンドの実行結果まで格納できる。(後々に紹介するが、コマンドの実行結果は再利用が可能)**

以下microsoftのドキュメントから

> 整数、文字列、配列、ハッシュ テーブルなど、任意の種類のオブジェクトを変数に格納 できます。 
> また、プロセス、サービス、イベント ログ、およびコンピューターを表す オブジェクト。
> PowerShell 変数は緩やかに型指定されます。 つまり、特定の種類のオブジェクトに限定されません。 
> 1つの変数に、異なる種類のオブジェクトのコレクションまたは配列を同時に含めするこ ともできます。
> 変数のデータ型は、変数の値の.NET 型によって決まります。 変数のオブジェクト型を表示するには、Get-Member を使用します。 


## 変数の型指定 

Powershellでは以下のように大括弧を使用することで型の指定が可能。

```ps1 
[int] $number = 8 
$number = "12345" 
$number = "Hello"  #The string is converted to an integer.
```

上記のコマンドはエラーが起きる！(想定通りのエラー)

```ps1 
Cannot convert value "Hello" to type "System. Int32". Error: "Input string was
not in a correct format. At line:1 char:1 + $number = "Hello"
+
+ CategoryInfo_e: : MetadataError: (:) [],
ArgumentTransformationMetadataException + FullyQualifiedError Id : RuntimeException 
```

*ここの例ではintという数値を入れる変数に対してstringを代入していることでエラーが発生させることができる。*

このように、`[] $変数名`で型を指定することで、**意図していない変数が代入される事態を防ぐことが可能だ**


### Powershellの変数型一覧

どのような型があるのかは以下のコマンドを打つことで把握できる

```ps1
Get-Service | Get-Member
```

代表的なものは以下の通り

```ps1 
int 
string
datetime 
array 
```





title:誰でもわかる！powershell入門学習サイト〜変数編〜

description:プログラミング言語powershellの入門サイトです。今回は第一弾、変数編

img:https://blog.hubfly.com/wp-content/uploads/2018/12/powershell.png

category_script:page_name.startswith("1")

redirect:https://minegishirei.hatenablog.com/entry/2023/02/15/100414

