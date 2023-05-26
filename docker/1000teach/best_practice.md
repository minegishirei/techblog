



Dockerfileを書くときに



https://12factor.net/


https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#create-ephemeral-containers

https://docs.docker.jp/develop/develop-images/dockerfile_best-practices.html


https://docs.docker.com/develop/develop-images/dockerfile_best-practices/




Dockerではローカルやリモートに存在するbuildコンテキストを元にイメージを作成することができます。
イメージを作り出すのに、必ずしもDockerfileは必要ありません。

echo -e 'FROM busybox\nRUN echo "hello world"' | docker build -

dockerイメージをワンライナーで生成する技法は次のような状況で役に立つでしょう。

- 一回限り、一時的なイメージが必要
- Dockerfileを残したくない

