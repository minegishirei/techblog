



次のコードを`nginx.deployment.yml`という名前で保存し、 コマンド`kubectl create -f nginx.deployment.yml`を実行してください。

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx  # または公式のNginxイメージを使用
        ports:
        - containerPort: 80
```



```yml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: NodePort
```

```sh
kubectl apply -f .\nginx.service.yaml
```





http://localhost/







