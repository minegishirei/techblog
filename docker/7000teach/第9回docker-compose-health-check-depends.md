


## `healthcheck`とサンプルコード

**以下のコードでは`app`は`db`に依存しており、`db`が起動していなければエラーが出てしまうため、その問題を解決するべく`healthcheck`を使用しております。**

```yml
version: '3'

services:
    app:
        image: koda/docker-knowledge
        volumes:
            - ./volumes/knowledge:/root/.knowledge
        ports:
            - "8080:8080"
        restart: always
        depends_on:
            db:
                condition: service_healthy ##### here #####
    db:
        image: postgres:9
        environment:
            - POSTGRES_USER=postgres
            - POSTGRES_PASSWORD=admin123
            - POSTGRES_DB=knowledge_production
        volumes:
            - ./volumes/postgres/data:/var/lib/postgresql/data
        restart: always
        healthcheck: ##### here #####
            test: "psql -U postgres"
            interval: 3s
            timeout: 3s
            retries: 100
            start_period: 10s
```

- `app`は`db`に依存しており、`db`が起動していなければエラーが出てしまう
- 上記の問題を解消するために`depends_on`の`condition`でヘルスチェックが合格しているかどうかを確認している。
- healthcheckでは`psql -U postgres`でログインできるかどうかでサーバーが起動しているかどうかを確認している。






