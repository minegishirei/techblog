



バックアップ体制

Kubernetesは宣言的なIaCです。
これに乗っ取れば、すべてのKuberentesリソースを記述するデータは、kubernetesが保有するデータベース`etcd`に保存されます。
この`etcd`を絶対的に正とする運用により、Kubernetes内の一部のDeploymentsをあなたが削除しても、`etcd`の情報から再びDeploymentsが自動作成されます。

しかしそれでも、Kubernetesにはバックアップが必要です。
例えばデータベースのレプリケーションをサポートしたとしても、AWSコンソールから誤って「削除」を押しただけで事故が起きてしまいます。




## Velero

Veleroはオープンソースソフトウェアで、クラスタの状態と永続データをバックアップし復元できます。
Veleroは、データの損失や災害復旧の際にクラスターを以前の状態に戻すために、クラスターのリソース、ボリューム、設定などのスナップショットを取り、それらをリモート場所に保存する機能を提供します。

### Veleroを導入する

BackupStorageLocation（バックアップストレージロケーション）は、Veleroの一部で、バックアップデータを保存する場所を指定するための概念です。

以下の設定により、バックアップをawsのs3の`sample-strage`に保存しています。

```yml
apiVersion: velero.io/v1
kind: BackupStorageLocation
metadata:
  name: aws-s3
  namespace: velero
spec:
  provider: aws
  objectStorage:
    bucket: sample-strage
  config:
    region: your-aws-region
```


### Veleroの永続ボリュームのバックアップ

`VolumeSnapshotLocation`を使用することで永続ボリュームのバックアップも作成することが出来ます。

```yml
apiVersion: velero.io/v1
kind: VolumeSnapshotLocation
metadata:
  name: aws-snapshot-location
  namespace: velero
spec:
  provider: aws
  config:
    region: your-aws-region
```



## Veleroによるバックアップの作成

`velero backup`コマンドを使うことで、バックアップを作成することが出来ます。
`Velero`サーバーはKubernetes APIに対してクエリを実行し、ユーザが指定したセレクタに一致するリソースでバックアップを作成します。

```sh
velero backup create <バックアップ名>
```

クラウドでVeleroでバックアップを作成した場合、S3にファイルを保存します。


## Veleroにバックアップの取得

Veleroで作成したバックアップの一覧を取得するには、`get`コマンドを使用します。

```sh
velero backup get
```


## Veleroにてデータの復元

Veleroでのバックアップの復元には、`download`コマンドを使用します。

```sh
velero backup download <バックアップ名>
```

ダウンロードされるファイルはtar.gz形式のアーカイブなので、通常のファイルのように解凍できます。


## バックアップのスケジューリング

バックアップとはスケジューリングとセットになります。

Veleroにおいてはそのバックアップスケジュールも組み込まれており、`create`コマンドのオプションにクーロン形式で指定することが可能です。

```sh
velero schedule create daily-backup --schedule="0 0 * * *"
```

上記のコマンドは毎日午前0時にバックアップが作成されます。




page:https://minegishirei.hatenablog.com/entry/2023/11/11/121553



