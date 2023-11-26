

## とりあえず試したい方へ

とりあえずブラウザ上で試す: インストールしなくてもこちらからブラウザ上で実行可能

https://play.kotlinlang.org/

※Kotlinの公式のドメイン配下にあるサイトなので安全にお試しできます



## インストール方法:しっかりとインストールしたい人向け


### しっかり構築したい方へ

Android Studioのインストールが必要。

合計で20~30分程でできる。




### まずはAndroid Studioのインストールの仕方

以下のサイトにアクセスした後

https://developer.android.com/studio

「Download」を押す

規約が出てくるが特に読まなくてもいい奴なので適当にチェックボックス押してダウンロード

ダウンロードには5分程かかった。


### Mac, Windowsなどの指定がある方

ダウンロードボタンを押すのではなく「Download options」を押すこと

（万が一通常のDownloadを押してもOSに合わせたandroid studioが入ると思うが...)

その後Mac,Window,Lixux,ChromeOSなどのOSごとの対応が出てくる。


### Android Studio.exeを起動

ダウンロードフォルダー配下に移動した（C:\Users\(ユーザ名)\Downloads）
android-studio-ide-xxx-xxxxxxx-windows.exeを起動する

C:\Users\～～\Downloads\android-studio-2021.1.1.22-windows.exe


### Welcome To Android Studio Setup

:NEXT>を押す

### Chose Components

Android Virtual Deviceを押したまま

:NEXT>

### Install Loaction

「C:\Program Files\Android\Android Studio」を選択したまま

:NEXT>

### Chose Start Menu Folder

「Android Studio\Android Studio」を選択

:NEXT>

### インストールが開始される

トータルで5分

最初の1分は全く進まないが、2分ぐらいからいきなり進む。

インストールが完了後は

:NEXT>


### Completeing Android Studio Setup

チェックボックスに「start android studio」をいれて「Finish」




## 初回起動時


### Import Android Studio Settings

Do not import settingsを選択

万が一エラーが出た場合は「Setup Proxy」をクリック


### Welcomoe

色々書いてあるが全部飛ばして

:Next>


### Install Type

Standerdで良い。

:Next>

### Select UI theme

DarcualかLightどちらかを選べる

色の好みで好きな方で


### verify settings

確認画面

:Next>

### Licence

色々インストールするのでそれぞれチェックを入れていかなければいけない

全部押したら「Finish」

installで5分ぐらい

以下の表示が出たら完了

<pre><code>
Android SDK is up to date.
Running Intel® HAXM installer
Intel HAXM installed successfully!
</code></pre>




## AndroiStudio日本語化 

### 次のサイトに行く

https://github.com/yuuna/IDEA_resources_jp


「Clone or download」をクリックし

「download zip」を選択し解凍

### 解凍後

ZIPファイルを解凍すると「resources_jp.jar」というファイルができます

これを「C:\Program Files\Android\Android Studio\lib」へコピー

### 完了


https://zesys.net/pc/android/android-studio-localizing-japanese/ 






title:Kotlin学習サイト【Android Studio環境構築編】

description:Kotlinは通常androidstudioという統合開発環境で使用する。セットアップの仕方を解説。Android Studioのインストールが必要。合計で20~30分程でできる。


category_script:True


