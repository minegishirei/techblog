



次のコードを`nginx.deployment.yml`という名前で保存し、 コマンド`kubectl create -f nginx.deployment.yml`を実行してください。

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
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
        image: nginx:1.7.5
        ports:
        - containerPort: 80
```



```yml
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  selector:
    app: nginx
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 80
  externalIPs:
     - <ノードの内部IP>
     - <ノードの内部IP>
```




