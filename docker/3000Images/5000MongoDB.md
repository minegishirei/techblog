


## Docker による MongoDB プロジェクトファイル




### MongoDB の docker-compose.yml ファイル

```yml
version: "3"

services:
  mongo:
    image: mongo
    container_name: mongo 
    ports:
      - 27017:27017
    environment:
      - MONGO_INITDB_ROOT_USERNAME=root
      - MONGO_INITDB_ROOT_PASSWORD=pass
    command: "mongod"
```


### MongoDB の Dockerfile ファイル

```Dockerfile
FROM mongo
```




# MongoDB
MongoDB sample DB



## run mongoDB by bash

```sh
docker exec -it mongo bash
```

then

```sh
mongosh
```


