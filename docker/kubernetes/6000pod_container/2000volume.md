





個々のコンテナには独自のファイルシステムが存在します。
しかしこれらのファイルシステムはエフェメラルであり、再起動してしまえばその情報は失われてしまいます。

この性質上、コンテナはステートレスであり、再起動すれば必ず初期化してくれます。


ところが、より複雑なアプリケーションではストレージを永続化し、ほかのコンテナと共有したい場面が出てきます。
Kubernetesのvolumeオブジェクトはそのどちらのニーズにも対応することが出来ます。



## デフォルトのストレージ:emptyDirボリューム

エフェメラルなストレージは`emptyDir`ボリュームであり、これは空の状態から使用が始まるストレージです。
このデータはPodが存続する限りは保存されますが、Podが再起動されれば再び空になります。

想定としてはキャッシュファイルやデータパイプラインの一時作業場所、Linuxファイルシステムの`tmp`ストレージ、あるいはコンテナ同士のファイル共有にも使用できます。

以下は`nginx`と`git`サーバーを`emptyDir`で共有するPodリソースです。

```yml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-git-pod
spec:
  volumes:
    - name: shared-data
      emptyDir: {}
  containers:
    - name: nginx-container
      image: nginx:latest
      ports:
        - containerPort: 80
    - name: git-container
      image: alpine/git
      command: ["git", "clone", "https://github.com/your-username/your-repo.git", "/app"]
      volumeMounts:
        - mountPath: /cache
          name: shared-data
```

まず初めに、`spec`項目の最初で`volumes`を宣言しています。

```yml
  volumes:
    - name: shared-data
      emptyDir: {}
```

これで、どのコンテナからも`shared-data`ボリュームを使うことが出来ますが、実際に使うには、`volumeMounts`キーワードで呼び出す必要があります。


```yml
    - name: git-container
      image: alpine/git
      command: ["git", "clone", "https://github.com/your-username/your-repo.git", "/app"]
      volumeMounts:
        - mountPath: /cache
          name: shared-data
```

これで、新しいストレージをコンテナ内からアクセスできるようになりました。






## 永続ボリューム


```yml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: standard
  hostPath:
    path: /data
```











