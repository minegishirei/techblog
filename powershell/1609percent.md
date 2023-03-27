
PowerShellにおける `%` は、いくつかの異なる意味を持つことがあります。以下にいくつかの例を挙げます。

- [1.モジュロ演算子](#1モジュロ演算子)
- [2.  ForEach-Objectエイリアス](#2--foreach-objectエイリアス)


## 1.モジュロ演算子

`%` は、2つの数値を除算し、余りを返すモジュロ演算子として使用できます。たとえば、次のコードは、10を3で割ったときの余りを返します。

```ps
C:\> 10 % 3
```

サンプル実行結果

```
1
```



## 2.  ForEach-Objectエイリアス

`%` は、**ForEach-Objectコマンドレットのエイリアス**としても使用できます。これは、配列やコレクションの各要素に対して処理を実行するために使用されます。たとえば、次のコードは、現在のディレクトリに含まれるファイルのリストを出力します。

```ps
PS C:\> Get-ChildItem | % { $_.Name }
```

サンプル実行結果

```
0
aws
blog
communication
docker
html_css
iac
inhouse_se
javascript
kotlin
powershell
provider
python
ranking
sql
vb6
vim
.gitignore
README.md
```


以上は、PowerShellで使用される `%` 演算子のいくつかの例です。


