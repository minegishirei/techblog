


## Get-Helpコマンドが解決する課題

特定のコマンドがどのように機能し、どのように使用するかについて学びたいと思います。

コマンドに関するヘルプと使用法の情報を提供するコマンドは、Get-Helpと呼ばれます。
ニーズに応じて、ヘルプ情報のいくつかの参照をサポートします。

これはLinuxコマンドでいうところの「man」コマンドに当たります

## Get-Helpコマンドの使い方

特定のコマンドのヘルプ情報の概要を取得するには、Get-Helpコマンドレットの引数としてコマンドの名前を指定します。

これには主に、その概要、構文、および詳細な説明が含まれます。

<pre><code>
Get-Help CommandName
</code></pre>

または

<pre><code>
CommandName -?
</code></pre>

## Get-Helpコマンドで詳細を確認する

特定のコマンドの詳細なヘルプ情報を取得するには、Get-Helpコマンドレットに–Detailedフラグを指定します。
要約ビューに加えて、これにはパラメーターの説明と例も含まれます。

<pre><code>
Get-Help CommandName -Detailed
</code></pre>

## Get-Helpコマンドで全ての情報を確認する

特定のコマンドの完全なヘルプ情報を取得するには、Get-Helpコマンドレットに–Fullフラグを指定します。
詳細ビューに加えて、これには完全なパラメーターの説明と追加の注記も含まれます。

<pre><code>
Get-Help CommandName -Full
</code></pre>


## powershellでコマンドの使用例を確認する方法

特定のコマンドの例のみを取得するには、–Examplesフラグを指定します。

<pre><code>
Get-Help CommandName -Examples
</code></pre>


## powershellにてコマンドを検索する方法


Get-Commandコマンドレットと同様に、Get-Helpコマンドレットはワイルドカードをサポートします。

特定のパターン（process,file など）に一致するすべてのコマンドを一覧表示する場合は、Get-Help * process *と入力するだけです。

プロセスについて調べたければ

<pre><code>
Get-Help *process*.
</code></pre>

ファイルについて知りたければ

<pre><code>
Get-Help *File*.
</code></pre>


## まとめ

Get-Helpコマンドレットは、WindowsPowerShellを探索するときに最も一般的に使用する3つのコマンドの1つです。他の2つのコマンドは、Get-CommandとGet-Memberです。



## 備考

Get-Helpコマンドレットは、PowerShellのヘルプシステムと対話するための主要な方法です。





## 備考

title:Get-Helpコマンドの使い方【powershell学習サイト】

description:特定のコマンドがどのように機能し、どのように使用するかについて学びたいと思います。コマンドに関するヘルプと使用法の情報を提供するコマンドは、Get-Helpと呼ばれます。

category_script:True

img:https://question.short-tips.info/api/ogp/?text=Get-Helpコマンドの使い方【powershell学習サイト】
