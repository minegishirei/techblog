
<h1>
    powershell学習サイト
</h1>


## while文

基本的なwhile文は以下の通り

```ps1
$i=1
while ($i -le 5) {
    Write-Output "$i";
    $i++;
}
```

- `$i++`は「iの数字を一つ増やす」という意味

- `while ($i -le 5) {`は括弧`()`内の条件を満たす間、何度も`{}`中括弧を実行する


この実行結果

```ps1
1
2
3
4
5
```


## whileを使った無限ループ


whileでは`()`内部の条件を満たしている限り、`{}`内部の処理を実行し続ける。
この性質を利用して、無限ループを作ることができる。

```ps1
while($true){
    echo "無限ループ中"
}
```

もしこのプログラムを実行して無限ループが発生してしまった場合は、**`Ctrl+Z`でプログラムを強制的に終了させましょう。**

当然ずっと無限ループさせるわけにはいかないので、どこかで`break`を用いてループから脱出する必要はある。

```ps1
$count = 0
while($true){
    $count += 1
    echo "無限ループ中"
    if($count -eq 10){
        break
    }
}
```

この場合、`無限ループ中`というワードが10行出力されたあとプログラムは終了する


#### 参考記事

この記事は以下の書籍を参考に執筆されました。
詳しい内容の確認はこちらからお願いいたします。

<iframe sandbox="allow-popups allow-scripts allow-modals allow-forms allow-same-origin" style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=oreilly10book-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=4873113822&linkId=3998987cf4c97963a20e5ceb58e41198"></iframe>








title:Powershell while文の書き方
