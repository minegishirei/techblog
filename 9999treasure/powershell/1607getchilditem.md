
- [get-childitemとは](#get-childitemとは)
  - [get-childitemの使い方](#get-childitemの使い方)
  - [get-childitemで再帰的にフォルダーを探索する。](#get-childitemで再帰的にフォルダーを探索する)
    - [getchilditemで階層を指定して再起的に調査する](#getchilditemで階層を指定して再起的に調査する)
  - [get-childitemのコマンドのオプション](#get-childitemのコマンドのオプション)
  - [さらに詳しいGet-Childitemのヘルプ](#さらに詳しいget-childitemのヘルプ)
  - [ディレクトリが空の時どのような挙動をするか](#ディレクトリが空の時どのような挙動をするか)
  - [パスを指定してファイルフォルダーを取得する](#パスを指定してファイルフォルダーを取得する)
  - [get-childitemのmode（ファイルの属性）について](#get-childitemのmodeファイルの属性について)
  - [getchilditemで名前のみ取得したい](#getchilditemで名前のみ取得したい)
  - [Get-Childitemで知れる全てのこと](#get-childitemで知れる全てのこと)
  - [ファイル一覧を絶対パス(フルパス)で手に入れる](#ファイル一覧を絶対パスフルパスで手に入れる)
  - [getchilditemでワイルドカードを使いたい](#getchilditemでワイルドカードを使いたい)
  - [get-childitemに「-(ハイフン)」が入っている理由](#get-childitemに-ハイフンが入っている理由)
  - [get-childitemの大文字小文字が覚えれない](#get-childitemの大文字小文字が覚えれない)
  - [「get-childitem」の使い方](#get-childitemの使い方-1)




# get-childitemとは

## get-childitemの使い方

powershellのコマンドの一種。

**入力することでカレントディレクトリ配下のファイル、ディレクトリー覧を取得できる。**

実行例

```ps1
Get-ChildItem
```

実行結果

```
ディレクトリ: 

Mode    LastWriteTime Length    Name
d-----  2021/08/28    3178      ModAuto 
-a----  2021/08/27    423       Start-Desktop.psm1
-a----  2021/08/27    425       Stop-AllProcess.psm1
```




## get-childitemで再帰的にフォルダーを探索する。

`-Recurse`を付けると再帰的にフォルダーを探索し、一覧表示することができる。

```ps1
Get-ChildItem -Recurse
```

実行結果

```
TIL
EU:C:Users\REI¥ffmyworking\MyPowerShell
Mode
LastWriteTime
Length Name
-- -- - ---- - ----
2021/08/28 2021/08/27 2021/08/27
15:05 14:26 14:03
ModAuto 3178 Start-Desktop. psm1 425 Stop-ATI Process. psm1
T
E : C:\Users
Length Name
Mode
LastWriteTime 
---- ----- 2021/08/28 15:05 - --
2021/08/28 15:04 
```


### getchilditemで階層を指定して再起的に調査する

-Depthを付けた後に深さを指定するとカレントディレクトリから指定した数までフォルダーに入り込んで探索する

例えば、3階層分だけ調査したい時は次にように`-Depth 3`を指定する

```ps1
Get-ChildItem -Depth 3
```

実行結果

```
実行結果
以下膨大な量のフォルダー情報が出力される
```



## get-childitemのコマンドのオプション

サンプルコード

```ps1
Get-Help Get-ChildItem 
```

Get-Helpを使うと、次のように構文が出現する

```ps1 
Get-ChildItem [[-Path] ＜string[] >] [[-Filter] ＜string>] [＜CommonParameters>] 
Get-Child Item [[-Filter] ＜tring>] [<CommonParameters>] 
```

エイリアス

```
gci
Is
dir
```






## さらに詳しいGet-Childitemのヘルプ

コマンドは以下のコマンドを入力

```ps1 
Get-Help Get-ChildItem -Online 
```

## ディレクトリが空の時どのような挙動をするか

空の時は何も表示しない

これは再帰的な表示でも同じ

```
Get-ChildItem空のディレクトリは表示されません。 
ときにGet-ChildItemコマンドが含まれても
深さや再帰のパラメータを、空のディレクトリは出力に含まれません。 
```

引用: マイクロソフト公式ドキュメント



## パスを指定してファイルフォルダーを取得する

パスを指定するには-Pathオプションを使う

サンプルコード

`Get-ChildItem -Path C:\Test`




## get-childitemのmode（ファイルの属性）について

ディレクトリー覧を取得した時にアルファベットでフラグがついていることがあるがそれは以下のような意味を表す

- l (リンク) 

- d (ディレクトリ) 

- a (記録) 

- r(読み取り専用) 

- h(隠れた) 

- s (システム)

例

```ps1
ディレクトリ: C:\Users

Mode    LastWriteTime Length    Name
d-----  2021/08/28    3178      ModAuto 
-a----  2021/08/27    423       Start-Desktop.psm1
-a----  2021/08/27    425       Stop-AllProcess.psm1
```

上記位のMode部分。



## getchilditemで名前のみ取得したい

-Name で名前のみの取得が可能

`Get-ChildItem -Path C:\Test -Name `



## Get-Childitemで知れる全てのこと

Get-Childitemによって得られるデータには以下の情報が含まれる

フォルダーの場合

- 名前：Name : ModAuto

- フォルダー名：CreationTime : 2021/08/28 10:22:03 

- 作成時期：LastWriteTime : 2021/08/28 15:05:34

- 最終更新日：LastAccessTime : 2021/08/28 15:05:34 

- モード(アクセス権限など)：Mode : d-----

- リンクがあるかどうか： Link Type


ファイルの場合、フォルダーの情報に加えてバージョンの情報も含まれる 


- Name: Start-Desktop.psm1 (ファイル名) 

- Length 3274 (ファイルサイズ) 

- CreationTime : 2021/08/26 8:11:05 (作成時期) 

- LastWriteTime : 2021/09/01 16:55:25(最終更新日) 

- LastAccessTime : 2021/09/01 16:55:25(最終アクセス) 

- Mode : -a----(モード) 

- Link Type Target Version Info : File: C:\UMyPowerShell\Start-Desktop.psm1

- InternalName: OriginalFilename: 

- FileVersion: FileDescription: Product: ProductVersion: Debug:

- False Patched:False

- PreRelease: Private Build: 

-Special Build:False False False


## ファイル一覧を絶対パス(フルパス)で手に入れる


```ps1
Get-ChildItem | Foreach-Object { echo $_.VersionInfo } | Select-Object Filename 
```


```ps1
FileName
C:\Users\Start-Desktop.psm1 
C:\Users\Stop-AllProcess.psm1 
```



## getchilditemでワイルドカードを使いたい

Where-Objectを使おう

以下のコードは. psm1で終わるコード 

```ps1
Get-ChildItem  | Where-Object { $_.Name - like "*.psm1" } 
```



## get-childitemに「-(ハイフン)」が入っている理由

そもそもpowershellの全てのコマンドには規則性がある

それは、`動詞-名詞`という構成で全てのコマンドが成り立っているという規則だ。

get-childitemも例外ではなく

- 「何かを手に入れる」という意味のgetと

- 「子要素（この場合は特定のディレクトリは以下にあるファイル）」という意味のchilditem

の二つから構成されている。


## get-childitemの大文字小文字が覚えれない

get-childitemは全てが小文字ではなく、`Get-ChildItem`というように大文字が含まれている。

これは**キャメルケース**と呼ばれる類の命名方法で、**意味のある単語の先頭を大文字にすることでコマンドの文字列を解読しやすくする**という働きがある

この場合だと 

```ps1
Get(手に入れる)-Child(子供)Item(要素)
```

という意味がある。



## 「get-childitem」の使い方



title:「get-childitem」の使い方を解説する【初心者向け】

description:「get-childitem」の使い方。get-childitemはpowershellのコマンドの一種で、入力することでカレントディレクトリ配下のファイルやディレクトリのー覧を取得することができる。 

img:https://boeprox.files.wordpress.com/2016/01/image2.png

category_script:page_name.startswith("16")

date:2022-10-29

この記事の各種数値は以下の通り

- 合計クリック数:228

- 合計表示回数:5715

- CTR:4%

- 平均検索順位:13

```
getchilditem	18	308	5.8%	4.2
get-childitem -include	18	54	33.3%	2.5
get-childitem -directory	18	51	35.3%	1.7
get-childitem オプション	13	725	1.8%	9.9
get-childitem	11	926	1.2%	11.2
powershell get-childitem -include	8	11	72.7%	9
powershell get-childitem オプション	4	244	1.6%	9.9
```

before_title_:getchilditemを誰よりも分かりやすく解説する【powershell】




