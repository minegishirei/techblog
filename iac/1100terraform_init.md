







## 作業ディレクトリの中身

terraformの作業ディレクトリは次の者が含まれます。

### terrafromリソースファイル

寺フォームが管理するリソースを記述する寺フォーム構成ファイルです。
通常ユーザーが管理する、`.tf`ファイルが存在します。


### キャッシュファイル(`.terraform`ディレクトリ)

terraformがキャッシュされたプロバイダープラグインとモジュールを管理するディレクトリです。
`terraform init`コマンドで実行されます。
キャッシュなのであまり重要ではないです。


### 状態データ(`.tfstate`ファイルorディレクトリ)

Terraformにおける神のファイルです。
Terraformによって作成される**現在の構成の状態を記録してある**ファイルで、Terraformによって管理されます。




## Terraformの作業ディレクトリの初期化(`terraform init`)

Terraformでは、`teraform init`コマンドを使用して作業ディレクトリを初期化します。

このコマンドを実行しなければ、プロジェクトにかかわるほかのコマンドは一切実行できず、実行したとしてもエラーを出します。


## `terraform init`のオプション

### -input=true

場合によっては入力値を求めます。入力値に誤りがある場合はエラーが出ます。

### -lock=false

stateのリロードー処理時に、stateファイルのロックを無効にします。


### -lock-timeout=<数値>

Terraformがstateファイルのロックを取得するための最大の待ち時間です。
デフォルトでは0秒で、ほかのプロセスによってすでにロックを取得されていた場合、即座にエラーになることを意味します。


### --no-color

色がなくなります。


### -upgrade

modulesやpluginsのインストールステップに関するアップデートを行います。







## 備考

title:Terraformのinitのオプション一覧

category_script:True

redirect:https://minegishirei.hatenablog.com/entry/2023/01/27/120400

