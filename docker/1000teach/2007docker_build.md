

[:contents]


## `--build-arg=[]`:Dockerfileの変数に変更を加える

Dockerの`docker build --build-arg=[]`オプションは、**ビルド時にDockerfile内で変数に変更を加えます**

`--build-arg`オプションを使用するには、Dockerfile内で`ARG`命令を使用して変数を定義する必要があります。例えば、以下のようなDockerfileがあるとします。

```dockerfile
FROM ubuntu:latest

ARG ENVIRONMENT
ENV ENVIRONMENT ${ENVIRONMENT}

CMD ["echo", "Current environment: $ENVIRONMENT"]
```

このDockerfileは、`ENVIRONMENT`という環境変数を定義し、`CMD`命令でその値を使用しています。

`--build-arg`オプションを使用してビルド時に値を渡すには、次のようにコマンドを実行します。

```css
$ docker build --build-arg ENVIRONMENT=production -t myimage .
```

この例では、`ENVIRONMENT`変数に`production`という値を渡しています。ビルドが完了すると、`myimage`という名前のイメージが作成されます。

ビルド時に複数の環境変数を渡す場合は、`--build-arg`オプションを複数回使用することができます。例えば、次のように書きます。

```css
$ docker build --build-arg ENVIRONMENT=production --build-arg PORT=8080 -t myimage .
```

この例では、`ENVIRONMENT`変数に`production`、`PORT`変数に`8080`という値を渡しています。


## `--cpu-shares`:DockerfileのCPUリソースを変える

Dockerの`docker run --cpu-shares`オプションは、コンテナのCPUリソースの配分を調整するために使用されます。このオプションは、コンテナ内で実行されるプロセスが使用できるCPUリソースの割合を指定することができます。

`--cpu-shares`オプションを使用するには、次のようにコマンドを実行します。

```sh
$ docker run --cpu-shares=<CPU_SHARES> <IMAGE>
```

ここで、`<CPU_SHARES>`はコンテナに割り当てるCPUリソースの割合を指定する数値です。数値が大きいほど、コンテナに割り当てられるCPUリソースが多くなります。数値が小さいほど、コンテナに割り当てられるCPUリソースが少なくなります。デフォルトの値は1024で、この値を指定すると、コンテナには1つのCPUコアが割り当てられます。


たとえば、`--cpu-shares=512`を指定すると、コンテナに割り当てられるCPUリソースはデフォルトの半分になります。同様に、`--cpu-shares=2048`を指定すると、コンテナにはデフォルトの2倍のCPUリソースが割り当てられます。

注意点として、`--cpu-shares`オプションは、ホストマシンのCPUリソースが限られている場合にのみ効果があります。また、このオプションは、単一のコンテナ内でのCPUリソースの配分のみを調整するため、複数のコンテナが同時に実行される場合には、`--cpu-shares`オプションだけではうまくCPUリソースの配分を制御できない場合があります。その場合は、Docker Swarmなどのオーケストレーションツールを使用して、より細かい制御を行う必要があります。








































































































