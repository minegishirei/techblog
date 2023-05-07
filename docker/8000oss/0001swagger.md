
## Docker EnginのAPI

Docker EnginにはAPIが存在します。
必ずしもdockerコマンドから実行する必要はなく、 **HTTPプロトコルでAPIに欲しいイメージ、コンテナを伝えることができればいいです。**

今回はそんなDocker EnginのAPIを翻訳していきます。

Docker EnginのAPIはSwagger形式で書かれているので、それをMarkdownとして起こしました。

以下参考のurlです。

- Swaggerファイルの場所

[https://github.com/moby/moby/blob/d3dec8fae1af0857a02ca5402101634f9e1785e3/docs/api/v1.42.yaml:embed:cite]

- swaggerのymlをMarkdownに変換するサイト

[https://swagger-markdown-ui.netlify.app/:embed:cite]




[:contents]




# Docker Engine API

Engine APIは、Docker Engine によって提供される HTTP APIです。
Dockerクライアントはエンジンとの連携のためにAPIを使用するため、 **Dockerクライアントができることは、すべてAPI を使用して行うことができます。**

ほとんどのDockerのクライアントコマンドはAPIのエンドポイントと一対一対応してます。
例えば、 `docker ps`コマンドで得られるDockerのプロセス情報は、`GET /containers/json`で同じ情報を得られます。

ですが当然その例外も存在し、例えばコンテナを実行する際には複数のAPIを呼び出す必要があります。


# Errors

APIのエラーメッセージは通常のHTTPステータスコードで表されます。

JSONのフォーマットは以下の通りです。

```
{
  "message": "page not found"
}
```

# Versioning

The API is usually changed in each release, so API calls are versioned to
ensure that clients don't break. To lock to a specific version of the API,
you prefix the URL with its version, for example, call `/v1.30/info` to use
the v1.30 version of the `/info` endpoint. If the API version specified in
the URL is not supported by the daemon, a HTTP `400 Bad Request` error message
is returned.

If you omit the version-prefix, the current version of the API (v1.42) is used.
For example, calling `/info` is the same as calling `/v1.42/info`. Using the
API without a version-prefix is deprecated and will be removed in a future release.

Engine releases in the near future should support this version of the API,
so your client will continue to work even if it is talking to a newer Engine.

The API uses an open schema model, which means server may add extra properties
to responses. Likewise, the server will ignore any extra query parameters and
request body properties. When you write clients, you need to ignore additional
properties in responses to ensure they do not break when talking to newer
daemons.


# Authentication

Authentication for registries is handled client side. The client has to send
authentication details to various endpoints that need to communicate with
registries, such as `POST /images/(name)/push`. These are sent as
`X-Registry-Auth` header as a [base64url encoded](https://tools.ietf.org/html/rfc4648#section-5)
(JSON) string with the following structure:

```
{
  "username": "string",
  "password": "string",
  "email": "string",
  "serveraddress": "string"
}
```

The `serveraddress` is a domain/IP without a protocol. Throughout this
structure, double quotes are required.

If you have already got an identity token from the [`/auth` endpoint](#operation/SystemAuth),
you can just pass this instead of credentials:

```
{
  "identitytoken": "9cbaf023786cd7..."
}
```


## Version: 1.42

### /containers/json

#### GET
##### Summary:

List containers

##### Description:

Returns a list of containers. For details on the format, see the
[inspect endpoint](#operation/ContainerInspect).

Note that it uses a different, smaller representation of a container
than inspecting a single container. For example, the list of linked
containers is not propagated .


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| all | query | Return all containers. By default, only running containers are shown.  | No | boolean |
| limit | query | Return this number of most recently created containers, including non-running ones.  | No | integer |
| size | query | Return the size of container as fields `SizeRw` and `SizeRootFs`.  | No | boolean |
| filters | query | Filters to process on the container list, encoded as JSON (a `map[string][]string`). For example, `{"status": ["paused"]}` will only return paused containers.  Available filters:  - `ancestor`=(`<image-name>[:<tag>]`, `<image id>`, or `<image@digest>`) - `before`=(`<container id>` or `<container name>`) - `expose`=(`<port>[/<proto>]`|`<startport-endport>/[<proto>]`) - `exited=<int>` containers with exit code of `<int>` - `health`=(`starting`|`healthy`|`unhealthy`|`none`) - `id=<ID>` a container's ID - `isolation=`(`default`|`process`|`hyperv`) (Windows daemon only) - `is-task=`(`true`|`false`) - `label=key` or `label="key=value"` of a container label - `name=<name>` a container's name - `network`=(`<network id>` or `<network name>`) - `publish`=(`<port>[/<proto>]`|`<startport-endport>/[<proto>]`) - `since`=(`<container id>` or `<container name>`) - `status=`(`created`|`restarting`|`running`|`removing`|`paused`|`exited`|`dead`) - `volume`=(`<volume name>` or `<mount point destination>`)  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [ [ContainerSummary](#ContainerSummary) ] |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/create

#### POST
##### Summary:

Create a container

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | query | Assign the specified name to the container. Must match `/?[a-zA-Z0-9][a-zA-Z0-9_.-]+`.  | No | string |
| platform | query | Platform in the format `os[/arch[/variant]]` used for image lookup.  When specified, the daemon checks if the requested image is present in the local image cache with the given OS and Architecture, and otherwise returns a `404` status.  If the option is not set, the host's native OS and Architecture are used to look up the image in the image cache. However, if no platform is passed and the given image does exist in the local image cache, but its OS or architecture does not match, the container is created with the available image, and a warning is added to the `Warnings` field in the response, for example;      WARNING: The requested image's platform (linux/arm64/v8) does not              match the detected host platform (linux/amd64) and no              specific platform was requested  | No | string |
| body | body | Container to create | Yes | [ContainerConfig](#ContainerConfig) & object |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 201 | Container created successfully | [ContainerCreateResponse](#ContainerCreateResponse) |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 404 | no such image | [ErrorResponse](#ErrorResponse) |
| 409 | conflict | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/json

#### GET
##### Summary:

Inspect a container

##### Description:

Return low-level information about a container.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| size | query | Return the size of container as fields `SizeRw` and `SizeRootFs` | No | boolean |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | object |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/top

#### GET
##### Summary:

List processes running inside a container

##### Description:

On Unix systems, this is done by running the `ps` command. This endpoint
is not supported on Windows.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| ps_args | query | The arguments to pass to `ps`. For example, `aux` | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | object |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/logs

#### GET
##### Summary:

Get container logs

##### Description:

Get `stdout` and `stderr` logs from a container.

Note: This endpoint works only for containers with the `json-file` or
`journald` logging driver.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| follow | query | Keep connection after returning logs. | No | boolean |
| stdout | query | Return logs from `stdout` | No | boolean |
| stderr | query | Return logs from `stderr` | No | boolean |
| since | query | Only return logs since this time, as a UNIX timestamp | No | integer |
| until | query | Only return logs before this time, as a UNIX timestamp | No | integer |
| timestamps | query | Add timestamps to every log line | No | boolean |
| tail | query | Only return this number of log lines from the end of the logs. Specify as an integer or `all` to output all log lines.  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | logs returned as a stream in response body. For the stream format, [see the documentation for the attach endpoint](#operation/ContainerAttach). Note that unlike the attach endpoint, the logs endpoint does not upgrade the connection and does not set Content-Type.  | binary |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/changes

#### GET
##### Summary:

Get changes on a container’s filesystem

##### Description:

Returns which files in a container's filesystem have been added, deleted,
or modified. The `Kind` of modification can be one of:

- `0`: Modified
- `1`: Added
- `2`: Deleted


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | The list of changes | [ object ] |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/export

#### GET
##### Summary:

Export a container

##### Description:

Export the contents of a container as a tarball.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/stats

#### GET
##### Summary:

Get container stats based on resource usage

##### Description:

This endpoint returns a live stream of a container’s resource usage
statistics.

The `precpu_stats` is the CPU statistic of the *previous* read, and is
used to calculate the CPU usage percentage. It is not an exact copy
of the `cpu_stats` field.

If either `precpu_stats.online_cpus` or `cpu_stats.online_cpus` is
nil then for compatibility with older daemons the length of the
corresponding `cpu_usage.percpu_usage` array should be used.

On a cgroup v2 host, the following fields are not set
* `blkio_stats`: all fields other than `io_service_bytes_recursive`
* `cpu_stats`: `cpu_usage.percpu_usage`
* `memory_stats`: `max_usage` and `failcnt`
Also, `memory_stats.stats` fields are incompatible with cgroup v1.

To calculate the values shown by the `stats` command of the docker cli tool
the following formulas can be used:
* used_memory = `memory_stats.usage - memory_stats.stats.cache`
* available_memory = `memory_stats.limit`
* Memory usage % = `(used_memory / available_memory) * 100.0`
* cpu_delta = `cpu_stats.cpu_usage.total_usage - precpu_stats.cpu_usage.total_usage`
* system_cpu_delta = `cpu_stats.system_cpu_usage - precpu_stats.system_cpu_usage`
* number_cpus = `lenght(cpu_stats.cpu_usage.percpu_usage)` or `cpu_stats.online_cpus`
* CPU usage % = `(cpu_delta / system_cpu_delta) * number_cpus * 100.0`


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| stream | query | Stream the output. If false, the stats will be output once and then it will disconnect.  | No | boolean |
| one-shot | query | Only get a single stat instead of waiting for 2 cycles. Must be used with `stream=false`.  | No | boolean |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | object |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/resize

#### POST
##### Summary:

Resize a container TTY

##### Description:

Resize the TTY for a container.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| h | query | Height of the TTY session in characters | No | integer |
| w | query | Width of the TTY session in characters | No | integer |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | cannot resize container | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/start

#### POST
##### Summary:

Start a container

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| detachKeys | query | Override the key sequence for detaching a container. Format is a single character `[a-Z]` or `ctrl-<value>` where `<value>` is one of: `a-z`, `@`, `^`, `[`, `,` or `_`.  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | no error |  |
| 304 | container already started |  |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/stop

#### POST
##### Summary:

Stop a container

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| signal | query | Signal to send to the container as an integer or string (e.g. `SIGINT`).  | No | string |
| t | query | Number of seconds to wait before killing the container | No | integer |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | no error |  |
| 304 | container already stopped |  |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/restart

#### POST
##### Summary:

Restart a container

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| signal | query | Signal to send to the container as an integer or string (e.g. `SIGINT`).  | No | string |
| t | query | Number of seconds to wait before killing the container | No | integer |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | no error |  |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/kill

#### POST
##### Summary:

Kill a container

##### Description:

Send a POSIX signal to a container, defaulting to killing to the
container.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| signal | query | Signal to send to the container as an integer or string (e.g. `SIGINT`).  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | no error |  |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 409 | container is not running | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/update

#### POST
##### Summary:

Update a container

##### Description:

Change various configuration options of a container without having to
recreate it.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| update | body |  | Yes | [Resources](#Resources) & object |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | The container has been updated. | object |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/rename

#### POST
##### Summary:

Rename a container

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| name | query | New name for the container | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | no error |  |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 409 | name already in use | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/pause

#### POST
##### Summary:

Pause a container

##### Description:

Use the freezer cgroup to suspend all processes in a container.

Traditionally, when suspending a process the `SIGSTOP` signal is used,
which is observable by the process being suspended. With the freezer
cgroup the process is unaware, and unable to capture, that it is being
suspended, and subsequently resumed.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | no error |  |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/unpause

#### POST
##### Summary:

Unpause a container

##### Description:

Resume a container which has been paused.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | no error |  |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/attach

#### POST
##### Summary:

Attach to a container

##### Description:

Attach to a container to read its output or send it input. You can attach
to the same container multiple times and you can reattach to containers
that have been detached.

Either the `stream` or `logs` parameter must be `true` for this endpoint
to do anything.

See the [documentation for the `docker attach` command](https://docs.docker.com/engine/reference/commandline/attach/)
for more details.

### Hijacking

This endpoint hijacks the HTTP connection to transport `stdin`, `stdout`,
and `stderr` on the same socket.

This is the response from the daemon for an attach request:

```
HTTP/1.1 200 OK
Content-Type: application/vnd.docker.raw-stream

[STREAM]
```

After the headers and two new lines, the TCP connection can now be used
for raw, bidirectional communication between the client and server.

To hint potential proxies about connection hijacking, the Docker client
can also optionally send connection upgrade headers.

For example, the client sends this request to upgrade the connection:

```
POST /containers/16253994b7c4/attach?stream=1&stdout=1 HTTP/1.1
Upgrade: tcp
Connection: Upgrade
```

The Docker daemon will respond with a `101 UPGRADED` response, and will
similarly follow with the raw stream:

```
HTTP/1.1 101 UPGRADED
Content-Type: application/vnd.docker.raw-stream
Connection: Upgrade
Upgrade: tcp

[STREAM]
```

### Stream format

When the TTY setting is disabled in [`POST /containers/create`](#operation/ContainerCreate),
the HTTP Content-Type header is set to application/vnd.docker.multiplexed-stream
and the stream over the hijacked connected is multiplexed to separate out
`stdout` and `stderr`. The stream consists of a series of frames, each
containing a header and a payload.

The header contains the information which the stream writes (`stdout` or
`stderr`). It also contains the size of the associated frame encoded in
the last four bytes (`uint32`).

It is encoded on the first eight bytes like this:

```go
header := [8]byte{STREAM_TYPE, 0, 0, 0, SIZE1, SIZE2, SIZE3, SIZE4}
```

`STREAM_TYPE` can be:

- 0: `stdin` (is written on `stdout`)
- 1: `stdout`
- 2: `stderr`

`SIZE1, SIZE2, SIZE3, SIZE4` are the four bytes of the `uint32` size
encoded as big endian.

Following the header is the payload, which is the specified number of
bytes of `STREAM_TYPE`.

The simplest way to implement this protocol is the following:

1. Read 8 bytes.
2. Choose `stdout` or `stderr` depending on the first byte.
3. Extract the frame size from the last four bytes.
4. Read the extracted size and output it on the correct output.
5. Goto 1.

### Stream format when using a TTY

When the TTY setting is enabled in [`POST /containers/create`](#operation/ContainerCreate),
the stream is not multiplexed. The data exchanged over the hijacked
connection is simply the raw data from the process PTY and client's
`stdin`.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| detachKeys | query | Override the key sequence for detaching a container.Format is a single character `[a-Z]` or `ctrl-<value>` where `<value>` is one of: `a-z`, `@`, `^`, `[`, `,` or `_`.  | No | string |
| logs | query | Replay previous logs from the container.  This is useful for attaching to a container that has started and you want to output everything since the container started.  If `stream` is also enabled, once all the previous output has been returned, it will seamlessly transition into streaming current output.  | No | boolean |
| stream | query | Stream attached streams from the time the request was made onwards.  | No | boolean |
| stdin | query | Attach to `stdin` | No | boolean |
| stdout | query | Attach to `stdout` | No | boolean |
| stderr | query | Attach to `stderr` | No | boolean |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 101 | no error, hints proxy about hijacking |  |
| 200 | no error, no upgrade header found |  |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/attach/ws

#### GET
##### Summary:

Attach to a container via a websocket

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| detachKeys | query | Override the key sequence for detaching a container.Format is a single character `[a-Z]` or `ctrl-<value>` where `<value>` is one of: `a-z`, `@`, `^`, `[`, `,`, or `_`.  | No | string |
| logs | query | Return logs | No | boolean |
| stream | query | Return stream | No | boolean |
| stdin | query | Attach to `stdin` | No | boolean |
| stdout | query | Attach to `stdout` | No | boolean |
| stderr | query | Attach to `stderr` | No | boolean |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 101 | no error, hints proxy about hijacking |  |
| 200 | no error, no upgrade header found |  |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/wait

#### POST
##### Summary:

Wait for a container

##### Description:

Block until a container stops, then returns the exit code.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| condition | query | Wait until a container state reaches the given condition.  Defaults to `not-running` if omitted or empty.  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | The container has exit. | [ContainerWaitResponse](#ContainerWaitResponse) |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}

#### DELETE
##### Summary:

Remove a container

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| v | query | Remove anonymous volumes associated with the container. | No | boolean |
| force | query | If the container is running, kill it before removing it. | No | boolean |
| link | query | Remove the specified link associated with the container. | No | boolean |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | no error |  |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 409 | conflict | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/archive

#### GET
##### Summary:

Get an archive of a filesystem resource in a container

##### Description:

Get a tar archive of a resource in the filesystem of container id.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| path | query | Resource in the container’s filesystem to archive. | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 400 | Bad parameter | [ErrorResponse](#ErrorResponse) |
| 404 | Container or path does not exist | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

#### PUT
##### Summary:

Extract an archive of files or folders to a directory in a container

##### Description:

Upload a tar archive to be extracted to a path in the filesystem of container id.
`path` parameter is asserted to be a directory. If it exists as a file, 400 error
will be returned with message "not a directory".


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the container | Yes | string |
| path | query | Path to a directory in the container to extract the archive’s contents into.  | Yes | string |
| noOverwriteDirNonDir | query | If `1`, `true`, or `True` then it will be an error if unpacking the given content would cause an existing directory to be replaced with a non-directory and vice versa.  | No | string |
| copyUIDGID | query | If `1`, `true`, then it will copy UID/GID maps to the dest file or dir  | No | string |
| inputStream | body | The input stream must be a tar archive compressed with one of the following algorithms: `identity` (no compression), `gzip`, `bzip2`, or `xz`.  | Yes | binary |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | The content was extracted successfully |  |
| 400 | Bad parameter | [ErrorResponse](#ErrorResponse) |
| 403 | Permission denied, the volume or container rootfs is marked as read-only. | [ErrorResponse](#ErrorResponse) |
| 404 | No such container or path does not exist inside the container | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /containers/prune

#### POST
##### Summary:

Delete stopped containers

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| filters | query | Filters to process on the prune list, encoded as JSON (a `map[string][]string`).  Available filters: - `until=<timestamp>` Prune containers created before this timestamp. The `<timestamp>` can be Unix timestamps, date formatted timestamps, or Go duration strings (e.g. `10m`, `1h30m`) computed relative to the daemon machine’s time. - `label` (`label=<key>`, `label=<key>=<value>`, `label!=<key>`, or `label!=<key>=<value>`) Prune containers with (or without, in case `label!=...` is used) the specified labels.  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error | object |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /images/json

#### GET
##### Summary:

List Images

##### Description:

Returns a list of images on the server. Note that it uses a different, smaller representation of an image than inspecting a single image.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| all | query | Show all images. Only images from a final layer (no children) are shown by default. | No | boolean |
| filters | query | A JSON encoded value of the filters (a `map[string][]string`) to process on the images list.  Available filters:  - `before`=(`<image-name>[:<tag>]`,  `<image id>` or `<image@digest>`) - `dangling=true` - `label=key` or `label="key=value"` of an image label - `reference`=(`<image-name>[:<tag>]`) - `since`=(`<image-name>[:<tag>]`,  `<image id>` or `<image@digest>`)  | No | string |
| shared-size | query | Compute and show shared size as a `SharedSize` field on each image. | No | boolean |
| digests | query | Show digest information as a `RepoDigests` field on each image. | No | boolean |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Summary image data for the images matching the query | [ [ImageSummary](#ImageSummary) ] |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /build

#### POST
##### Summary:

イメージファイルをビルドします。

ビルドの際には`Dockerfile`を含むtar圧縮ファイルを送信する必要があります。

##### Description:

`Dockerfile`を含むtar圧縮ファイルからDockerイメージを作ります。

ビルドの際には、`Dockerfile`は通常はアーカイブのルートにある想定で動作しますが、`dockerfile` パラメータを指定することで、別のパスに配置したり、別の名前を付けたりすることができます。

[`Dockerfile`についての詳しい動作はこちらをご確認ください。](https://docs.docker.com/engine/reference/builder/).

`Docker`デーモンは、ビルドを開始する前に「`Dockerfile`」の事前検証を実行し、構文が正しくない場合はエラーを返します。
その後、新しいイメージの ID が出力されるまで、`Dockerfile`に記述された各命令が1行ずつ実行されます。

HTTPコネクションが途切れた場合、buildは中断されます。



##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| inputStream | body | `Dockerfile`を含む圧縮されたファイル。圧縮形式は次のいずれかの通り。gzip, bzip2, xz. | No | binary |
| dockerfile | query | 圧縮されたフォルダー内での`Dockerfile`のファイルパス. このオプションは`remote`と外部の`Dockerfile`の場所が指定されば場合には無視されます。 | No | string |
| t | query | 新しく作られるDockerイメージの名前とタグである。形式は`name:tag`。`tag`側を省略した場合、`latest`が自動的にバージョンとして付けられる。  | No | string |
| extrahosts | query | Extra hosts to add to /etc/hosts | No | string |
| remote | query | GitのリポジトリのURIやHTTP/HTTPS形式のURL。 このurlがテキストファイルを指し示す場合は、それが`Dockerfile`であるかのようにbuildされる。このurlが圧縮されたフォルダーであれば、それをダウンロードした上でそれを元にbuildされる。 | No | string |
| q | query | build中の詳細なログ出力をコントロールします。| No | boolean |
| nocache | query | Imageをビルドする際にキャッシュを使用するかをコントロールします。 | No | boolean |
| cachefrom | query | JSON array of images used for build cache resolution. | No | string |
| pull | query | Attempt to pull the image even if an older image exists locally. | No | string |
| rm | query | Remove intermediate containers after a successful build. | No | boolean |
| forcerm | query | Always remove intermediate containers, even upon failure. | No | boolean |
| memory | query | Set memory limit for build. | No | integer |
| memswap | query | Total memory (memory + swap). Set as `-1` to disable swap. | No | integer |
| cpushares | query | CPU shares (relative weight). | No | integer |
| cpusetcpus | query | CPUs in which to allow execution (e.g., `0-3`, `0,1`). | No | string |
| cpuperiod | query | The length of a CPU period in microseconds. | No | integer |
| cpuquota | query | Microseconds of CPU time that the container can get in a CPU period. | No | integer |
| buildargs | query | JSON map of string pairs for build-time variables. Users pass these values at build-time. Docker uses the buildargs as the environment context for commands run via the `Dockerfile` RUN instruction, or for variable expansion in other `Dockerfile` instructions. This is not meant for passing secret values.  For example, the build arg `FOO=bar` would become `{"FOO":"bar"}` in JSON. This would result in the query parameter `buildargs={"FOO":"bar"}`. Note that `{"FOO":"bar"}` should be URI component encoded.  [Read more about the buildargs instruction.](https://docs.docker.com/engine/reference/builder/#arg)  | No | string |
| shmsize | query | Size of `/dev/shm` in bytes. The size must be greater than 0. If omitted the system uses 64MB. | No | integer |
| squash | query | Squash the resulting images layers into a single layer. *(Experimental release only.)* | No | boolean |
| labels | query | Arbitrary key/value labels to set on the image, as a JSON map of string pairs. | No | string |
| networkmode | query | Sets the networking mode for the run commands during build. Supported standard values are: `bridge`, `host`, `none`, and `container:<name|id>`. Any other value is taken as a custom network's name or ID to which this container should connect to.  | No | string |
| Content-type | header |  | No | string |
| X-Registry-Config | header | This is a base64-encoded JSON object with auth configurations for multiple registries that a build may refer to.  The key is a registry URL, and the value is an auth configuration object, [as described in the authentication section](#section/Authentication). For example:  ``` {   "docker.example.com": {     "username": "janedoe",     "password": "hunter2"   },   "https://index.docker.io/v1/": {     "username": "mobydock",     "password": "conta1n3rize14"   } } ```  Only the registry domain name (and port if not the default 443) are required. However, for legacy reasons, the Docker Hub registry must be specified with both a `https://` prefix and a `/v1/` suffix even though Docker will prefer to use the v2 registry API.  | No | string |
| platform | query | Platform in the format os[/arch[/variant]] | No | string |
| target | query | Target build stage | No | string |
| outputs | query | BuildKit output configuration | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 400 | Bad parameter | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /build/prune

#### POST
##### Summary:

Delete builder cache

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| keep-storage | query | Amount of disk space in bytes to keep for cache | No | long |
| all | query | Remove all types of build cache | No | boolean |
| filters | query | A JSON encoded value of the filters (a `map[string][]string`) to process on the list of build cache objects.  Available filters:  - `until=<duration>`: duration relative to daemon's time, during which build cache was not used, in Go's duration format (e.g., '24h') - `id=<id>` - `parent=<id>` - `type=<string>` - `description=<string>` - `inuse` - `shared` - `private`  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error | object |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /images/create

#### POST
##### Summary:

イメージを作成します。

##### Description:

レジストリからプルするか、インポートしてイメージを作成します。


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| fromImage | query | プルするイメージの名前。名前には、タグまたはダイジェストを含めることができます。**このパラメーターは、イメージをプルする場合にのみ使用できます。**  HTTP 接続が閉じている場合、プルはキャンセルされます。| No | string |
| fromSrc | query | インポートするソース。値は、Imageを取得できる URL か、要求本文から画像を読み取るための「-」です。このパラメーターは、Imageをインポートする場合にのみ使用できます。| No | string |
| repo | query | Repository name given to an image when it is imported. The repo may include a tag. This parameter may only be used when importing an image. | No | string |
| tag | query | Tag or digest. If empty when pulling an image, this causes all tags for the given image to be pulled. | No | string |
| message | query | Set commit message for imported image. | No | string |
| inputImage | body | Image content if the value `-` has been specified in fromSrc query parameter | No | string |
| X-Registry-Auth | header | A base64url-encoded auth configuration.  Refer to the [authentication section](#section/Authentication) for details.  | No | string |
| changes | query | Apply `Dockerfile` instructions to the image that is created, for example: `changes=ENV DEBUG=true`. Note that `ENV DEBUG=true` should be URI component encoded.  Supported `Dockerfile` instructions: `CMD`|`ENTRYPOINT`|`ENV`|`EXPOSE`|`ONBUILD`|`USER`|`VOLUME`|`WORKDIR`  | No | [ string ] |
| platform | query | Platform in the format os[/arch[/variant]].  When used in combination with the `fromImage` option, the daemon checks if the given image is present in the local image cache with the given OS and Architecture, and otherwise attempts to pull the image. If the option is not set, the host's native OS and Architecture are used. If the given image does not exist in the local image cache, the daemon attempts to pull the image with the host's native OS and Architecture. If the given image does exists in the local image cache, but its OS or architecture does not match, a warning is produced.  When used with the `fromSrc` option to import an image from an archive, this option sets the platform information for the imported image. If the option is not set, the host's native OS and Architecture are used for the imported image.  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 404 | repository does not exist or no read access | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /images/{name}/json

#### GET
##### Summary:

Inspect an image

##### Description:

Return low-level information about an image.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | Image name or id | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error | [ImageInspect](#ImageInspect) |
| 404 | No such image | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /images/{name}/history

#### GET
##### Summary:

Get the history of an image

##### Description:

Return parent layers of an image.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | Image name or ID | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | List of image layers | [ object ] |
| 404 | No such image | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /images/{name}/push

#### POST
##### Summary:

Push an image

##### Description:

Push an image to a registry.

If you wish to push an image on to a private registry, that image must
already have a tag which references the registry. For example,
`registry.example.com/myimage:latest`.

The push is cancelled if the HTTP connection is closed.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | Image name or ID. | Yes | string |
| tag | query | The tag to associate with the image on the registry. | No | string |
| X-Registry-Auth | header | A base64url-encoded auth configuration.  Refer to the [authentication section](#section/Authentication) for details.  | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error |  |
| 404 | No such image | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /images/{name}/tag

#### POST
##### Summary:

Tag an image

##### Description:

Tag an image so that it becomes part of a repository.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | Image name or ID to tag. | Yes | string |
| repo | query | The repository to tag in. For example, `someuser/someimage`. | No | string |
| tag | query | The name of the new tag. | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 201 | No error |  |
| 400 | Bad parameter | [ErrorResponse](#ErrorResponse) |
| 404 | No such image | [ErrorResponse](#ErrorResponse) |
| 409 | Conflict | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /images/{name}

#### DELETE
##### Summary:

Remove an image

##### Description:

Remove an image, along with any untagged parent images that were
referenced by that image.

Images can't be removed if they have descendant images, are being
used by a running container or are being used by a build.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | Image name or ID | Yes | string |
| force | query | Remove the image even if it is being used by stopped containers or has other tags | No | boolean |
| noprune | query | Do not delete untagged parent images | No | boolean |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | The image was deleted successfully | [ [ImageDeleteResponseItem](#ImageDeleteResponseItem) ] |
| 404 | No such image | [ErrorResponse](#ErrorResponse) |
| 409 | Conflict | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /images/search

#### GET
##### Summary:

Search images

##### Description:

Search for an image on Docker Hub.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| term | query | Term to search | Yes | string |
| limit | query | Maximum number of results to return | No | integer |
| filters | query | A JSON encoded value of the filters (a `map[string][]string`) to process on the images list. Available filters:  - `is-automated=(true|false)` - `is-official=(true|false)` - `stars=<number>` Matches images that has at least 'number' stars.  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error | [ object ] |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /images/prune

#### POST
##### Summary:

Delete unused images

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| filters | query | Filters to process on the prune list, encoded as JSON (a `map[string][]string`). Available filters:  - `dangling=<boolean>` When set to `true` (or `1`), prune only    unused *and* untagged images. When set to `false`    (or `0`), all unused images are pruned. - `until=<string>` Prune images created before this timestamp. The `<timestamp>` can be Unix timestamps, date formatted timestamps, or Go duration strings (e.g. `10m`, `1h30m`) computed relative to the daemon machine’s time. - `label` (`label=<key>`, `label=<key>=<value>`, `label!=<key>`, or `label!=<key>=<value>`) Prune images with (or without, in case `label!=...` is used) the specified labels.  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error | object |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /auth

#### POST
##### Summary:

Check auth configuration

##### Description:

Validate credentials for a registry and, if available, get an identity
token for accessing the registry without password.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| authConfig | body | Authentication to check | No | [AuthConfig](#AuthConfig) |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | An identity token was generated successfully. | object |
| 204 | No error |  |
| 401 | Auth error | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /info

#### GET
##### Summary:

Get system information

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error | [SystemInfo](#SystemInfo) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /version

#### GET
##### Summary:

Get version

##### Description:

Returns the version of Docker that is running and various information about the system that Docker is running on.

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [SystemVersion](#SystemVersion) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /_ping

#### GET
##### Summary:

Ping

##### Description:

This is a dummy endpoint you can use to test if the server is accessible.

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | string |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /commit

#### POST
##### Summary:

Create a new image from a container

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| containerConfig | body | The container configuration | No | [ContainerConfig](#ContainerConfig) |
| container | query | The ID or name of the container to commit | No | string |
| repo | query | Repository name for the created image | No | string |
| tag | query | Tag name for the create image | No | string |
| comment | query | Commit message | No | string |
| author | query | Author of the image (e.g., `John Hannibal Smith <hannibal@a-team.com>`) | No | string |
| pause | query | Whether to pause the container before committing | No | boolean |
| changes | query | `Dockerfile` instructions to apply while committing | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 201 | no error | [IdResponse](#IdResponse) |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /events

#### GET
##### Summary:

Monitor events

##### Description:

Stream real-time events from the server.

Various objects within Docker report events when something happens to them.

Containers report these events: `attach`, `commit`, `copy`, `create`, `destroy`, `detach`, `die`, `exec_create`, `exec_detach`, `exec_start`, `exec_die`, `export`, `health_status`, `kill`, `oom`, `pause`, `rename`, `resize`, `restart`, `start`, `stop`, `top`, `unpause`, `update`, and `prune`

Images report these events: `delete`, `import`, `load`, `pull`, `push`, `save`, `tag`, `untag`, and `prune`

Volumes report these events: `create`, `mount`, `unmount`, `destroy`, and `prune`

Networks report these events: `create`, `connect`, `disconnect`, `destroy`, `update`, `remove`, and `prune`

The Docker daemon reports these events: `reload`

Services report these events: `create`, `update`, and `remove`

Nodes report these events: `create`, `update`, and `remove`

Secrets report these events: `create`, `update`, and `remove`

Configs report these events: `create`, `update`, and `remove`

The Builder reports `prune` events


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| since | query | Show events created since this timestamp then stream new events. | No | string |
| until | query | Show events created until this timestamp then stop streaming. | No | string |
| filters | query | A JSON encoded value of filters (a `map[string][]string`) to process on the event list. Available filters:  - `config=<string>` config name or ID - `container=<string>` container name or ID - `daemon=<string>` daemon name or ID - `event=<string>` event type - `image=<string>` image name or ID - `label=<string>` image or container label - `network=<string>` network name or ID - `node=<string>` node ID - `plugin`=<string> plugin name or ID - `scope`=<string> local or swarm - `secret=<string>` secret name or ID - `service=<string>` service name or ID - `type=<string>` object to filter by, one of `container`, `image`, `volume`, `network`, `daemon`, `plugin`, `node`, `service`, `secret` or `config` - `volume=<string>` volume name  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [EventMessage](#EventMessage) |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /system/df

#### GET
##### Summary:

Get data usage information

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| type | query | Object types, for which to compute and return data.  | No | [ string ] |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | object |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /images/{name}/get

#### GET
##### Summary:

Export an image

##### Description:

Get a tarball containing all images and metadata for a repository.

If `name` is a specific name and tag (e.g. `ubuntu:latest`), then only that image (and its parents) are returned. If `name` is an image ID, similarly only that image (and its parents) are returned, but with the exclusion of the `repositories` file in the tarball, as there were no image names referenced.

### Image tarball format

An image tarball contains one directory per image layer (named using its long ID), each containing these files:

- `VERSION`: currently `1.0` - the file format version
- `json`: detailed layer information, similar to `docker inspect layer_id`
- `layer.tar`: A tarfile containing the filesystem changes in this layer

The `layer.tar` file contains `aufs` style `.wh..wh.aufs` files and directories for storing attribute changes and deletions.

If the tarball defines a repository, the tarball should also include a `repositories` file at the root that contains a list of repository and tag names mapped to layer IDs.

```json
{
  "hello-world": {
    "latest": "565a9d68a73f6706862bfe8409a7f659776d4d60a8d096eb4a3cbce6999cc2a1"
  }
}
```


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | Image name or ID | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | binary |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /images/get

#### GET
##### Summary:

Export several images

##### Description:

Get a tarball containing all images and metadata for several image
repositories.

For each value of the `names` parameter: if it is a specific name and
tag (e.g. `ubuntu:latest`), then only that image (and its parents) are
returned; if it is an image ID, similarly only that image (and its parents)
are returned and there would be no names referenced in the 'repositories'
file for this image ID.

For details on the format, see the [export image endpoint](#operation/ImageGet).


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| names | query | Image names to filter by | No | [ string ] |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | binary |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /images/load

#### POST
##### Summary:

Import images

##### Description:

Load a set of images and tags into a repository.

For details on the format, see the [export image endpoint](#operation/ImageGet).


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| imagesTarball | body | Tar archive containing images | No | binary |
| quiet | query | Suppress progress details during load. | No | boolean |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /containers/{id}/exec

#### POST
##### Summary:

Create an exec instance

##### Description:

Run a command inside a running container.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| execConfig | body | Exec configuration | Yes | object |
| id | path | ID or name of container | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 201 | no error | [IdResponse](#IdResponse) |
| 404 | no such container | [ErrorResponse](#ErrorResponse) |
| 409 | container is paused | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /exec/{id}/start

#### POST
##### Summary:

Start an exec instance

##### Description:

Starts a previously set up exec instance. If detach is true, this endpoint
returns immediately after starting the command. Otherwise, it sets up an
interactive session with the command.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| execStartConfig | body |  | No | object |
| id | path | Exec instance ID | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error |  |
| 404 | No such exec instance | [ErrorResponse](#ErrorResponse) |
| 409 | Container is stopped or paused | [ErrorResponse](#ErrorResponse) |

### /exec/{id}/resize

#### POST
##### Summary:

Resize an exec instance

##### Description:

Resize the TTY session used by an exec instance. This endpoint only works
if `tty` was specified as part of creating and starting the exec instance.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | Exec instance ID | Yes | string |
| h | query | Height of the TTY session in characters | No | integer |
| w | query | Width of the TTY session in characters | No | integer |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error |  |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 404 | No such exec instance | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /exec/{id}/json

#### GET
##### Summary:

Inspect an exec instance

##### Description:

Return low-level information about an exec instance.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | Exec instance ID | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error | object |
| 404 | No such exec instance | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /volumes

#### GET
##### Summary:

List volumes

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| filters | query | JSON encoded value of the filters (a `map[string][]string`) to process on the volumes list. Available filters:  - `dangling=<boolean>` When set to `true` (or `1`), returns all    volumes that are not in use by a container. When set to `false`    (or `0`), only volumes that are in use by one or more    containers are returned. - `driver=<volume-driver-name>` Matches volumes based on their driver. - `label=<key>` or `label=<key>:<value>` Matches volumes based on    the presence of a `label` alone or a `label` and a value. - `name=<volume-name>` Matches all or part of a volume name.  | No | string (json) |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Summary volume data that matches the query | [VolumeListResponse](#VolumeListResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /volumes/create

#### POST
##### Summary:

Create a volume

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| volumeConfig | body | Volume configuration | Yes | [VolumeCreateOptions](#VolumeCreateOptions) |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 201 | The volume was created successfully | [Volume](#Volume) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /volumes/{name}

#### GET
##### Summary:

Inspect a volume

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | Volume name or ID | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error | [Volume](#Volume) |
| 404 | No such volume | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

#### PUT
##### Summary:

"Update a volume. Valid only for Swarm cluster volumes"


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | The name or ID of the volume | Yes | string |
| body | body | The spec of the volume to update. Currently, only Availability may change. All other fields must remain unchanged.  | No | object |
| version | query | The version number of the volume being updated. This is required to avoid conflicting writes. Found in the volume's `ClusterVolume` field.  | Yes | long |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 404 | no such volume | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

#### DELETE
##### Summary:

Remove a volume

##### Description:

Instruct the driver to remove the volume.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | Volume name or ID | Yes | string |
| force | query | Force the removal of the volume | No | boolean |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | The volume was removed |  |
| 404 | No such volume or volume driver | [ErrorResponse](#ErrorResponse) |
| 409 | Volume is in use and cannot be removed | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /volumes/prune

#### POST
##### Summary:

Delete unused volumes

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| filters | query | Filters to process on the prune list, encoded as JSON (a `map[string][]string`).  Available filters: - `label` (`label=<key>`, `label=<key>=<value>`, `label!=<key>`, or `label!=<key>=<value>`) Prune volumes with (or without, in case `label!=...` is used) the specified labels. - `all` (`all=true`) - Consider all (local) volumes for pruning and not just anonymous volumes.  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error | object |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /networks

#### GET
##### Summary:

List networks

##### Description:

Returns a list of networks. For details on the format, see the
[network inspect endpoint](#operation/NetworkInspect).

Note that it uses a different, smaller representation of a network than
inspecting a single network. For example, the list of containers attached
to the network is not propagated in API versions 1.28 and up.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| filters | query | JSON encoded value of the filters (a `map[string][]string`) to process on the networks list.  Available filters:  - `dangling=<boolean>` When set to `true` (or `1`), returns all    networks that are not in use by a container. When set to `false`    (or `0`), only networks that are in use by one or more    containers are returned. - `driver=<driver-name>` Matches a network's driver. - `id=<network-id>` Matches all or part of a network ID. - `label=<key>` or `label=<key>=<value>` of a network label. - `name=<network-name>` Matches all or part of a network name. - `scope=["swarm"|"global"|"local"]` Filters networks by scope (`swarm`, `global`, or `local`). - `type=["custom"|"builtin"]` Filters networks by type. The `custom` keyword returns all user-defined networks.  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error | [ [Network](#Network) ] |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /networks/{id}

#### GET
##### Summary:

Inspect a network

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | Network ID or name | Yes | string |
| verbose | query | Detailed inspect output for troubleshooting | No | boolean |
| scope | query | Filter the network by scope (swarm, global, or local) | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error | [Network](#Network) |
| 404 | Network not found | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

#### DELETE
##### Summary:

Remove a network

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | Network ID or name | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | No error |  |
| 403 | operation not supported for pre-defined networks | [ErrorResponse](#ErrorResponse) |
| 404 | no such network | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /networks/create

#### POST
##### Summary:

Create a network

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| networkConfig | body | Network configuration | Yes | object |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 201 | No error | object |
| 403 | operation not supported for pre-defined networks | [ErrorResponse](#ErrorResponse) |
| 404 | plugin not found | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /networks/{id}/connect

#### POST
##### Summary:

Connect a container to a network

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | Network ID or name | Yes | string |
| container | body |  | Yes | object |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error |  |
| 403 | Operation not supported for swarm scoped networks | [ErrorResponse](#ErrorResponse) |
| 404 | Network or container not found | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /networks/{id}/disconnect

#### POST
##### Summary:

Disconnect a container from a network

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | Network ID or name | Yes | string |
| container | body |  | Yes | object |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error |  |
| 403 | Operation not supported for swarm scoped networks | [ErrorResponse](#ErrorResponse) |
| 404 | Network or container not found | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /networks/prune

#### POST
##### Summary:

Delete unused networks

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| filters | query | Filters to process on the prune list, encoded as JSON (a `map[string][]string`).  Available filters: - `until=<timestamp>` Prune networks created before this timestamp. The `<timestamp>` can be Unix timestamps, date formatted timestamps, or Go duration strings (e.g. `10m`, `1h30m`) computed relative to the daemon machine’s time. - `label` (`label=<key>`, `label=<key>=<value>`, `label!=<key>`, or `label!=<key>=<value>`) Prune networks with (or without, in case `label!=...` is used) the specified labels.  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error | object |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /plugins

#### GET
##### Summary:

List plugins

##### Description:

Returns information about installed plugins.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| filters | query | A JSON encoded value of the filters (a `map[string][]string`) to process on the plugin list.  Available filters:  - `capability=<capability name>` - `enable=<true>|<false>`  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | No error | [ [Plugin](#Plugin) ] |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /plugins/privileges

#### GET
##### Summary:

Get plugin privileges

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| remote | query | The name of the plugin. The `:latest` tag is optional, and is the default if omitted.  | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [ [PluginPrivilege](#PluginPrivilege) ] |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /plugins/pull

#### POST
##### Summary:

Install a plugin

##### Description:

Pulls and installs a plugin. After the plugin is installed, it can be
enabled using the [`POST /plugins/{name}/enable` endpoint](#operation/PostPluginsEnable).


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| remote | query | Remote reference for plugin to install.  The `:latest` tag is optional, and is used as the default if omitted.  | Yes | string |
| name | query | Local name for the pulled plugin.  The `:latest` tag is optional, and is used as the default if omitted.  | No | string |
| X-Registry-Auth | header | A base64url-encoded auth configuration to use when pulling a plugin from a registry.  Refer to the [authentication section](#section/Authentication) for details.  | No | string |
| body | body |  | No | [ [PluginPrivilege](#PluginPrivilege) ] |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | no error |  |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /plugins/{name}/json

#### GET
##### Summary:

Inspect a plugin

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | The name of the plugin. The `:latest` tag is optional, and is the default if omitted.  | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [Plugin](#Plugin) |
| 404 | plugin is not installed | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /plugins/{name}

#### DELETE
##### Summary:

Remove a plugin

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | The name of the plugin. The `:latest` tag is optional, and is the default if omitted.  | Yes | string |
| force | query | Disable the plugin before removing. This may result in issues if the plugin is in use by a container.  | No | boolean |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [Plugin](#Plugin) |
| 404 | plugin is not installed | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /plugins/{name}/enable

#### POST
##### Summary:

Enable a plugin

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | The name of the plugin. The `:latest` tag is optional, and is the default if omitted.  | Yes | string |
| timeout | query | Set the HTTP client timeout (in seconds) | No | integer |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 404 | plugin is not installed | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /plugins/{name}/disable

#### POST
##### Summary:

Disable a plugin

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | The name of the plugin. The `:latest` tag is optional, and is the default if omitted.  | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 404 | plugin is not installed | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /plugins/{name}/upgrade

#### POST
##### Summary:

Upgrade a plugin

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | The name of the plugin. The `:latest` tag is optional, and is the default if omitted.  | Yes | string |
| remote | query | Remote reference to upgrade to.  The `:latest` tag is optional, and is used as the default if omitted.  | Yes | string |
| X-Registry-Auth | header | A base64url-encoded auth configuration to use when pulling a plugin from a registry.  Refer to the [authentication section](#section/Authentication) for details.  | No | string |
| body | body |  | No | [ [PluginPrivilege](#PluginPrivilege) ] |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | no error |  |
| 404 | plugin not installed | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /plugins/create

#### POST
##### Summary:

Create a plugin

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | query | The name of the plugin. The `:latest` tag is optional, and is the default if omitted.  | Yes | string |
| tarContext | body | Path to tar containing plugin rootfs and manifest | No | binary |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | no error |  |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /plugins/{name}/push

#### POST
##### Summary:

Push a plugin

##### Description:

Push a plugin to the registry.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | The name of the plugin. The `:latest` tag is optional, and is the default if omitted.  | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 404 | plugin not installed | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### /plugins/{name}/set

#### POST
##### Summary:

Configure a plugin

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | The name of the plugin. The `:latest` tag is optional, and is the default if omitted.  | Yes | string |
| body | body |  | No | [ string ] |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | No error |  |
| 404 | Plugin not installed | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /nodes

#### GET
##### Summary:

List nodes

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| filters | query | Filters to process on the nodes list, encoded as JSON (a `map[string][]string`).  Available filters: - `id=<node id>` - `label=<engine label>` - `membership=`(`accepted`|`pending`)` - `name=<node name>` - `node.label=<node label>` - `role=`(`manager`|`worker`)`  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [ [Node](#Node) ] |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /nodes/{id}

#### GET
##### Summary:

Inspect a node

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | The ID or name of the node | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [Node](#Node) |
| 404 | no such node | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

#### DELETE
##### Summary:

Delete a node

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | The ID or name of the node | Yes | string |
| force | query | Force remove a node from the swarm | No | boolean |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 404 | no such node | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /nodes/{id}/update

#### POST
##### Summary:

Update a node

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | The ID of the node | Yes | string |
| body | body |  | No | [NodeSpec](#NodeSpec) |
| version | query | The version number of the node object being updated. This is required to avoid conflicting writes.  | Yes | long |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 404 | no such node | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /swarm

#### GET
##### Summary:

Inspect swarm

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [Swarm](#Swarm) |
| 404 | no such swarm | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /swarm/init

#### POST
##### Summary:

Initialize a new swarm

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | Yes | object |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | string |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is already part of a swarm | [ErrorResponse](#ErrorResponse) |

### /swarm/join

#### POST
##### Summary:

Join an existing swarm

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | Yes | object |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is already part of a swarm | [ErrorResponse](#ErrorResponse) |

### /swarm/leave

#### POST
##### Summary:

Leave a swarm

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| force | query | Force leave swarm, even if this is the last manager or that it will break the cluster.  | No | boolean |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /swarm/update

#### POST
##### Summary:

Update a swarm

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | Yes | [SwarmSpec](#SwarmSpec) |
| version | query | The version number of the swarm object being updated. This is required to avoid conflicting writes.  | Yes | long |
| rotateWorkerToken | query | Rotate the worker join token. | No | boolean |
| rotateManagerToken | query | Rotate the manager join token. | No | boolean |
| rotateManagerUnlockKey | query | Rotate the manager unlock key. | No | boolean |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /swarm/unlockkey

#### GET
##### Summary:

Get the unlock key

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | object |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /swarm/unlock

#### POST
##### Summary:

Unlock a locked manager

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | Yes | object |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /services

#### GET
##### Summary:

List services

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| filters | query | A JSON encoded value of the filters (a `map[string][]string`) to process on the services list.  Available filters:  - `id=<service id>` - `label=<service label>` - `mode=["replicated"|"global"]` - `name=<service name>`  | No | string |
| status | query | Include service status, with count of running and desired tasks.  | No | boolean |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [ [Service](#Service) ] |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /services/create

#### POST
##### Summary:

Create a service

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | Yes | [ServiceSpec](#ServiceSpec) & object |
| X-Registry-Auth | header | A base64url-encoded auth configuration for pulling from private registries.  Refer to the [authentication section](#section/Authentication) for details.  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 201 | no error | object |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 403 | network is not eligible for services | [ErrorResponse](#ErrorResponse) |
| 409 | name conflicts with an existing service | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /services/{id}

#### GET
##### Summary:

Inspect a service

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of service. | Yes | string |
| insertDefaults | query | Fill empty fields with default values. | No | boolean |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [Service](#Service) |
| 404 | no such service | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

#### DELETE
##### Summary:

Delete a service

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of service. | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 404 | no such service | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /services/{id}/update

#### POST
##### Summary:

Update a service

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of service. | Yes | string |
| body | body |  | Yes | [ServiceSpec](#ServiceSpec) & object |
| version | query | The version number of the service object being updated. This is required to avoid conflicting writes. This version number should be the value as currently set on the service *before* the update. You can find the current version by calling `GET /services/{id}`  | Yes | integer |
| registryAuthFrom | query | If the `X-Registry-Auth` header is not specified, this parameter indicates where to find registry authorization credentials.  | No | string |
| rollback | query | Set to this parameter to `previous` to cause a server-side rollback to the previous service spec. The supplied spec will be ignored in this case.  | No | string |
| X-Registry-Auth | header | A base64url-encoded auth configuration for pulling from private registries.  Refer to the [authentication section](#section/Authentication) for details.  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [ServiceUpdateResponse](#ServiceUpdateResponse) |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 404 | no such service | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /services/{id}/logs

#### GET
##### Summary:

Get service logs

##### Description:

Get `stdout` and `stderr` logs from a service. See also
[`/containers/{id}/logs`](#operation/ContainerLogs).

**Note**: This endpoint works only for services with the `local`,
`json-file` or `journald` logging drivers.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID or name of the service | Yes | string |
| details | query | Show service context and extra details provided to logs. | No | boolean |
| follow | query | Keep connection after returning logs. | No | boolean |
| stdout | query | Return logs from `stdout` | No | boolean |
| stderr | query | Return logs from `stderr` | No | boolean |
| since | query | Only return logs since this time, as a UNIX timestamp | No | integer |
| timestamps | query | Add timestamps to every log line | No | boolean |
| tail | query | Only return this number of log lines from the end of the logs. Specify as an integer or `all` to output all log lines.  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | logs returned as a stream in response body | binary |
| 404 | no such service | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /tasks

#### GET
##### Summary:

List tasks

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| filters | query | A JSON encoded value of the filters (a `map[string][]string`) to process on the tasks list.  Available filters:  - `desired-state=(running | shutdown | accepted)` - `id=<task id>` - `label=key` or `label="key=value"` - `name=<task name>` - `node=<node id or name>` - `service=<service name>`  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [ [Task](#Task) ] |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /tasks/{id}

#### GET
##### Summary:

Inspect a task

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID of the task | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [Task](#Task) |
| 404 | no such task | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /tasks/{id}/logs

#### GET
##### Summary:

Get task logs

##### Description:

Get `stdout` and `stderr` logs from a task.
See also [`/containers/{id}/logs`](#operation/ContainerLogs).

**Note**: This endpoint works only for services with the `local`,
`json-file` or `journald` logging drivers.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID of the task | Yes | string |
| details | query | Show task context and extra details provided to logs. | No | boolean |
| follow | query | Keep connection after returning logs. | No | boolean |
| stdout | query | Return logs from `stdout` | No | boolean |
| stderr | query | Return logs from `stderr` | No | boolean |
| since | query | Only return logs since this time, as a UNIX timestamp | No | integer |
| timestamps | query | Add timestamps to every log line | No | boolean |
| tail | query | Only return this number of log lines from the end of the logs. Specify as an integer or `all` to output all log lines.  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | logs returned as a stream in response body | binary |
| 404 | no such task | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /secrets

#### GET
##### Summary:

List secrets

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| filters | query | A JSON encoded value of the filters (a `map[string][]string`) to process on the secrets list.  Available filters:  - `id=<secret id>` - `label=<key> or label=<key>=value` - `name=<secret name>` - `names=<secret name>`  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [ [Secret](#Secret) ] |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /secrets/create

#### POST
##### Summary:

Create a secret

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | No | [SecretSpec](#SecretSpec) & object |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 201 | no error | [IdResponse](#IdResponse) |
| 409 | name conflicts with an existing object | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /secrets/{id}

#### GET
##### Summary:

Inspect a secret

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID of the secret | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [Secret](#Secret) |
| 404 | secret not found | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

#### DELETE
##### Summary:

Delete a secret

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID of the secret | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | no error |  |
| 404 | secret not found | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /secrets/{id}/update

#### POST
##### Summary:

Update a Secret

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | The ID or name of the secret | Yes | string |
| body | body | The spec of the secret to update. Currently, only the Labels field can be updated. All other fields must remain unchanged from the [SecretInspect endpoint](#operation/SecretInspect) response values.  | No | [SecretSpec](#SecretSpec) |
| version | query | The version number of the secret object being updated. This is required to avoid conflicting writes.  | Yes | long |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 404 | no such secret | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /configs

#### GET
##### Summary:

List configs

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| filters | query | A JSON encoded value of the filters (a `map[string][]string`) to process on the configs list.  Available filters:  - `id=<config id>` - `label=<key> or label=<key>=value` - `name=<config name>` - `names=<config name>`  | No | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [ [Config](#Config) ] |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /configs/create

#### POST
##### Summary:

Create a config

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | No | [ConfigSpec](#ConfigSpec) & object |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 201 | no error | [IdResponse](#IdResponse) |
| 409 | name conflicts with an existing object | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /configs/{id}

#### GET
##### Summary:

Inspect a config

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID of the config | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error | [Config](#Config) |
| 404 | config not found | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

#### DELETE
##### Summary:

Delete a config

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | ID of the config | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 204 | no error |  |
| 404 | config not found | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /configs/{id}/update

#### POST
##### Summary:

Update a Config

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | The ID or name of the config | Yes | string |
| body | body | The spec of the config to update. Currently, only the Labels field can be updated. All other fields must remain unchanged from the [ConfigInspect endpoint](#operation/ConfigInspect) response values.  | No | [ConfigSpec](#ConfigSpec) |
| version | query | The version number of the config object being updated. This is required to avoid conflicting writes.  | Yes | long |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | no error |  |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 404 | no such config | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |
| 503 | node is not part of a swarm | [ErrorResponse](#ErrorResponse) |

### /distribution/{name}/json

#### GET
##### Summary:

Get image information from the registry

##### Description:

Return image digest and platform information by contacting the registry.


##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | path | Image name or id | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | descriptor and platform information | [DistributionInspect](#DistributionInspect) |
| 401 | Failed authentication or no image found | [ErrorResponse](#ErrorResponse) |
| 500 | Server error | [ErrorResponse](#ErrorResponse) |

### /session

#### POST
##### Summary:

Initialize interactive session

##### Description:

Start a new interactive session with a server. Session allows server to
call back to the client for advanced capabilities.

### Hijacking

This endpoint hijacks the HTTP connection to HTTP2 transport that allows
the client to expose gPRC services on that connection.

For example, the client sends this request to upgrade the connection:

```
POST /session HTTP/1.1
Upgrade: h2c
Connection: Upgrade
```

The Docker daemon responds with a `101 UPGRADED` response follow with
the raw stream:

```
HTTP/1.1 101 UPGRADED
Connection: Upgrade
Upgrade: h2c
```


##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 101 | no error, hijacking successful |  |
| 400 | bad parameter | [ErrorResponse](#ErrorResponse) |
| 500 | server error | [ErrorResponse](#ErrorResponse) |

### Models


#### Port

An open port on a container

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| IP | string (ip-address) | Host IP address that the container's port is mapped to | No |
| PrivatePort | integer (uint16) | Port on the container | Yes |
| PublicPort | integer (uint16) | Port exposed on the host | No |
| Type | string |  | Yes |

#### MountPoint

MountPoint represents a mount point configuration inside the container.
This is used for reporting the mountpoints in use by a container.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Type | string | The mount type:  - `bind` a mount of a file or directory from the host into the container. - `volume` a docker volume with the given `Name`. - `tmpfs` a `tmpfs`. - `npipe` a named pipe from the host into the container. - `cluster` a Swarm cluster volume  | No |
| Name | string | Name is the name reference to the underlying data defined by `Source` e.g., the volume name.  | No |
| Source | string | Source location of the mount.  For volumes, this contains the storage location of the volume (within `/var/lib/docker/volumes/`). For bind-mounts, and `npipe`, this contains the source (host) part of the bind-mount. For `tmpfs` mount points, this field is empty.  | No |
| Destination | string | Destination is the path relative to the container root (`/`) where the `Source` is mounted inside the container.  | No |
| Driver | string | Driver is the volume driver used to create the volume (if it is a volume).  | No |
| Mode | string | Mode is a comma separated list of options supplied by the user when creating the bind/volume mount.  The default is platform-specific (`"z"` on Linux, empty on Windows).  | No |
| RW | boolean | Whether the mount is mounted writable (read-write).  | No |
| Propagation | string | Propagation describes how mounts are propagated from the host into the mount point, and vice-versa. Refer to the [Linux kernel documentation](https://www.kernel.org/doc/Documentation/filesystems/sharedsubtree.txt) for details. This field is not used on Windows.  | No |

#### DeviceMapping

A device mapping between the host and container

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| PathOnHost | string |  | No |
| PathInContainer | string |  | No |
| CgroupPermissions | string |  | No |

#### DeviceRequest

A request for devices to be sent to device drivers

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Driver | string |  | No |
| Count | integer |  | No |
| DeviceIDs | [ string ] |  | No |
| Capabilities | [ [ string ] ] | A list of capabilities; an OR list of AND lists of capabilities.  | No |
| Options | object | Driver-specific options, specified as a key/value pairs. These options are passed directly to the driver.  | No |

#### ThrottleDevice

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Path | string | Device path | No |
| Rate | long | Rate | No |

#### Mount

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Target | string | Container path. | No |
| Source | string | Mount source (e.g. a volume name, a host path). | No |
| Type | string | The mount type. Available types:  - `bind` Mounts a file or directory from the host into the container. Must exist prior to creating the container. - `volume` Creates a volume with the given name and options (or uses a pre-existing volume with the same name and options). These are **not** removed when the container is removed. - `tmpfs` Create a tmpfs with the given options. The mount source cannot be specified for tmpfs. - `npipe` Mounts a named pipe from the host into the container. Must exist prior to creating the container. - `cluster` a Swarm cluster volume  | No |
| ReadOnly | boolean | Whether the mount should be read-only. | No |
| Consistency | string | The consistency requirement for the mount: `default`, `consistent`, `cached`, or `delegated`. | No |
| BindOptions | object | Optional configuration for the `bind` type. | No |
| VolumeOptions | object | Optional configuration for the `volume` type. | No |
| TmpfsOptions | object | Optional configuration for the `tmpfs` type. | No |

#### RestartPolicy

The behavior to apply when the container exits. The default is not to
restart.

An ever increasing delay (double the previous delay, starting at 100ms) is
added before each restart to prevent flooding the server.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string | - Empty string means not to restart - `no` Do not automatically restart - `always` Always restart - `unless-stopped` Restart always except when the user has manually stopped the container - `on-failure` Restart only when the container exit code is non-zero  | No |
| MaximumRetryCount | integer | If `on-failure` is used, the number of times to retry before giving up.  | No |

#### Resources

A container's resources (cgroups config, ulimits, etc)

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| CpuShares | integer | An integer value representing this container's relative CPU weight versus other containers.  | No |
| Memory | long | Memory limit in bytes. | No |
| CgroupParent | string | Path to `cgroups` under which the container's `cgroup` is created. If the path is not absolute, the path is considered to be relative to the `cgroups` path of the init process. Cgroups are created if they do not already exist.  | No |
| BlkioWeight | integer | Block IO weight (relative weight). | No |
| BlkioWeightDevice | [ object ] | Block IO weight (relative device weight) in the form:  ``` [{"Path": "device_path", "Weight": weight}] ```  | No |
| BlkioDeviceReadBps | [ [ThrottleDevice](#ThrottleDevice) ] | Limit read rate (bytes per second) from a device, in the form:  ``` [{"Path": "device_path", "Rate": rate}] ```  | No |
| BlkioDeviceWriteBps | [ [ThrottleDevice](#ThrottleDevice) ] | Limit write rate (bytes per second) to a device, in the form:  ``` [{"Path": "device_path", "Rate": rate}] ```  | No |
| BlkioDeviceReadIOps | [ [ThrottleDevice](#ThrottleDevice) ] | Limit read rate (IO per second) from a device, in the form:  ``` [{"Path": "device_path", "Rate": rate}] ```  | No |
| BlkioDeviceWriteIOps | [ [ThrottleDevice](#ThrottleDevice) ] | Limit write rate (IO per second) to a device, in the form:  ``` [{"Path": "device_path", "Rate": rate}] ```  | No |
| CpuPeriod | long | The length of a CPU period in microseconds. | No |
| CpuQuota | long | Microseconds of CPU time that the container can get in a CPU period.  | No |
| CpuRealtimePeriod | long | The length of a CPU real-time period in microseconds. Set to 0 to allocate no time allocated to real-time tasks.  | No |
| CpuRealtimeRuntime | long | The length of a CPU real-time runtime in microseconds. Set to 0 to allocate no time allocated to real-time tasks.  | No |
| CpusetCpus | string | CPUs in which to allow execution (e.g., `0-3`, `0,1`).  | No |
| CpusetMems | string | Memory nodes (MEMs) in which to allow execution (0-3, 0,1). Only effective on NUMA systems.  | No |
| Devices | [ [DeviceMapping](#DeviceMapping) ] | A list of devices to add to the container. | No |
| DeviceCgroupRules | [ string ] | a list of cgroup rules to apply to the container | No |
| DeviceRequests | [ [DeviceRequest](#DeviceRequest) ] | A list of requests for devices to be sent to device drivers.  | No |
| KernelMemoryTCP | long | Hard limit for kernel TCP buffer memory (in bytes). Depending on the OCI runtime in use, this option may be ignored. It is no longer supported by the default (runc) runtime.  This field is omitted when empty.  | No |
| MemoryReservation | long | Memory soft limit in bytes. | No |
| MemorySwap | long | Total memory limit (memory + swap). Set as `-1` to enable unlimited swap.  | No |
| MemorySwappiness | long | Tune a container's memory swappiness behavior. Accepts an integer between 0 and 100.  | No |
| NanoCpus | long | CPU quota in units of 10<sup>-9</sup> CPUs. | No |
| OomKillDisable | boolean | Disable OOM Killer for the container. | No |
| Init | boolean | Run an init inside the container that forwards signals and reaps processes. This field is omitted if empty, and the default (as configured on the daemon) is used.  | No |
| PidsLimit | long | Tune a container's PIDs limit. Set `0` or `-1` for unlimited, or `null` to not change.  | No |
| Ulimits | [ object ] | A list of resource limits to set in the container. For example:  ``` {"Name": "nofile", "Soft": 1024, "Hard": 2048} ```  | No |
| CpuCount | long | The number of usable CPUs (Windows only).  On Windows Server containers, the processor resource controls are mutually exclusive. The order of precedence is `CPUCount` first, then `CPUShares`, and `CPUPercent` last.  | No |
| CpuPercent | long | The usable percentage of the available CPUs (Windows only).  On Windows Server containers, the processor resource controls are mutually exclusive. The order of precedence is `CPUCount` first, then `CPUShares`, and `CPUPercent` last.  | No |
| IOMaximumIOps | long | Maximum IOps for the container system drive (Windows only) | No |
| IOMaximumBandwidth | long | Maximum IO in bytes per second for the container system drive (Windows only).  | No |

#### Limit

An object describing a limit on resources which can be requested by a task.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| NanoCPUs | long |  | No |
| MemoryBytes | long |  | No |
| Pids | long | Limits the maximum number of PIDs in the container. Set `0` for unlimited.  | No |

#### ResourceObject

An object describing the resources which can be advertised by a node and
requested by a task.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| NanoCPUs | long |  | No |
| MemoryBytes | long |  | No |
| GenericResources | [GenericResources](#GenericResources) |  | No |

#### GenericResources

User-defined resources can be either Integer resources (e.g, `SSD=3`) or
String resources (e.g, `GPU=UUID1`).


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| GenericResources | array | User-defined resources can be either Integer resources (e.g, `SSD=3`) or String resources (e.g, `GPU=UUID1`).  |  |

#### HealthConfig

A test to perform to check that the container is healthy.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Test | [ string ] | The test to perform. Possible values are:  - `[]` inherit healthcheck from image or parent image - `["NONE"]` disable healthcheck - `["CMD", args...]` exec arguments directly - `["CMD-SHELL", command]` run command with system's default shell  | No |
| Interval | long | The time to wait between checks in nanoseconds. It should be 0 or at least 1000000 (1 ms). 0 means inherit.  | No |
| Timeout | long | The time to wait before considering the check to have hung. It should be 0 or at least 1000000 (1 ms). 0 means inherit.  | No |
| Retries | integer | The number of consecutive failures needed to consider a container as unhealthy. 0 means inherit.  | No |
| StartPeriod | long | Start period for the container to initialize before starting health-retries countdown in nanoseconds. It should be 0 or at least 1000000 (1 ms). 0 means inherit.  | No |

#### Health

Health stores information about the container's healthcheck results.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Status | string | Status is one of `none`, `starting`, `healthy` or `unhealthy`  - "none"      Indicates there is no healthcheck - "starting"  Starting indicates that the container is not yet ready - "healthy"   Healthy indicates that the container is running correctly - "unhealthy" Unhealthy indicates that the container has a problem  | No |
| FailingStreak | integer | FailingStreak is the number of consecutive failures | No |
| Log | [ [HealthcheckResult](#HealthcheckResult) ] | Log contains the last few results (oldest first)  | No |

#### HealthcheckResult

HealthcheckResult stores information about a single run of a healthcheck probe


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Start | dateTime | Date and time at which this check started in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.  | No |
| End | string (dateTime) | Date and time at which this check ended in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.  | No |
| ExitCode | integer | ExitCode meanings:  - `0` healthy - `1` unhealthy - `2` reserved (considered unhealthy) - other values: error running probe  | No |
| Output | string | Output from last check | No |

#### HostConfig

Container configuration that depends on the host we are running on

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| HostConfig |  | Container configuration that depends on the host we are running on |  |

#### ContainerConfig

Configuration for a container that is portable between hosts.

When used as `ContainerConfig` field in an image, `ContainerConfig` is an
optional field containing the configuration of the container that was last
committed when creating the image.

Previous versions of Docker builder used this field to store build cache,
and it is not in active use anymore.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Hostname | string | The hostname to use for the container, as a valid RFC 1123 hostname.  | No |
| Domainname | string | The domain name to use for the container.  | No |
| User | string | The user that commands are run as inside the container. | No |
| AttachStdin | boolean | Whether to attach to `stdin`. | No |
| AttachStdout | boolean | Whether to attach to `stdout`. | No |
| AttachStderr | boolean | Whether to attach to `stderr`. | No |
| ExposedPorts | object | An object mapping ports to an empty object in the form:  `{"<port>/<tcp|udp|sctp>": {}}`  | No |
| Tty | boolean | Attach standard streams to a TTY, including `stdin` if it is not closed.  | No |
| OpenStdin | boolean | Open `stdin` | No |
| StdinOnce | boolean | Close `stdin` after one attached client disconnects | No |
| Env | [ string ] | A list of environment variables to set inside the container in the form `["VAR=value", ...]`. A variable without `=` is removed from the environment, rather than to have an empty value.  | No |
| Cmd | [ string ] | Command to run specified as a string or an array of strings.  | No |
| Healthcheck | [HealthConfig](#HealthConfig) |  | No |
| ArgsEscaped | boolean | Command is already escaped (Windows only) | No |
| Image | string | The name (or reference) of the image to use when creating the container, or which was used when the container was created.  | No |
| Volumes | object | An object mapping mount point paths inside the container to empty objects.  | No |
| WorkingDir | string | The working directory for commands to run in. | No |
| Entrypoint | [ string ] | The entry point for the container as a string or an array of strings.  If the array consists of exactly one empty string (`[""]`) then the entry point is reset to system default (i.e., the entry point used by docker when there is no `ENTRYPOINT` instruction in the `Dockerfile`).  | No |
| NetworkDisabled | boolean | Disable networking for the container. | No |
| MacAddress | string | MAC address of the container. | No |
| OnBuild | [ string ] | `ONBUILD` metadata that were defined in the image's `Dockerfile`.  | No |
| Labels | object | User-defined key/value metadata. | No |
| StopSignal | string | Signal to stop a container as a string or unsigned integer.  | No |
| StopTimeout | integer | Timeout to stop a container in seconds. | No |
| Shell | [ string ] | Shell for when `RUN`, `CMD`, and `ENTRYPOINT` uses a shell.  | No |

#### NetworkingConfig

NetworkingConfig represents the container's networking configuration for
each of its interfaces.
It is used for the networking configs specified in the `docker create`
and `docker network connect` commands.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| EndpointsConfig | object | A mapping of network name to endpoint configuration for that network.  | No |

#### NetworkSettings

NetworkSettings exposes the network settings in the API

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Bridge | string | Name of the network's bridge (for example, `docker0`). | No |
| SandboxID | string | SandboxID uniquely represents a container's network stack. | No |
| HairpinMode | boolean | Indicates if hairpin NAT should be enabled on the virtual interface.  | No |
| LinkLocalIPv6Address | string | IPv6 unicast address using the link-local prefix. | No |
| LinkLocalIPv6PrefixLen | integer | Prefix length of the IPv6 unicast address. | No |
| Ports | [PortMap](#PortMap) |  | No |
| SandboxKey | string | SandboxKey identifies the sandbox | No |
| SecondaryIPAddresses | [ [Address](#Address) ] |  | No |
| SecondaryIPv6Addresses | [ [Address](#Address) ] |  | No |
| EndpointID | string | EndpointID uniquely represents a service endpoint in a Sandbox.  <p><br /></p>  > **Deprecated**: This field is only propagated when attached to the > default "bridge" network. Use the information from the "bridge" > network inside the `Networks` map instead, which contains the same > information. This field was deprecated in Docker 1.9 and is scheduled > to be removed in Docker 17.12.0  | No |
| Gateway | string | Gateway address for the default "bridge" network.  <p><br /></p>  > **Deprecated**: This field is only propagated when attached to the > default "bridge" network. Use the information from the "bridge" > network inside the `Networks` map instead, which contains the same > information. This field was deprecated in Docker 1.9 and is scheduled > to be removed in Docker 17.12.0  | No |
| GlobalIPv6Address | string | Global IPv6 address for the default "bridge" network.  <p><br /></p>  > **Deprecated**: This field is only propagated when attached to the > default "bridge" network. Use the information from the "bridge" > network inside the `Networks` map instead, which contains the same > information. This field was deprecated in Docker 1.9 and is scheduled > to be removed in Docker 17.12.0  | No |
| GlobalIPv6PrefixLen | integer | Mask length of the global IPv6 address.  <p><br /></p>  > **Deprecated**: This field is only propagated when attached to the > default "bridge" network. Use the information from the "bridge" > network inside the `Networks` map instead, which contains the same > information. This field was deprecated in Docker 1.9 and is scheduled > to be removed in Docker 17.12.0  | No |
| IPAddress | string | IPv4 address for the default "bridge" network.  <p><br /></p>  > **Deprecated**: This field is only propagated when attached to the > default "bridge" network. Use the information from the "bridge" > network inside the `Networks` map instead, which contains the same > information. This field was deprecated in Docker 1.9 and is scheduled > to be removed in Docker 17.12.0  | No |
| IPPrefixLen | integer | Mask length of the IPv4 address.  <p><br /></p>  > **Deprecated**: This field is only propagated when attached to the > default "bridge" network. Use the information from the "bridge" > network inside the `Networks` map instead, which contains the same > information. This field was deprecated in Docker 1.9 and is scheduled > to be removed in Docker 17.12.0  | No |
| IPv6Gateway | string | IPv6 gateway address for this network.  <p><br /></p>  > **Deprecated**: This field is only propagated when attached to the > default "bridge" network. Use the information from the "bridge" > network inside the `Networks` map instead, which contains the same > information. This field was deprecated in Docker 1.9 and is scheduled > to be removed in Docker 17.12.0  | No |
| MacAddress | string | MAC address for the container on the default "bridge" network.  <p><br /></p>  > **Deprecated**: This field is only propagated when attached to the > default "bridge" network. Use the information from the "bridge" > network inside the `Networks` map instead, which contains the same > information. This field was deprecated in Docker 1.9 and is scheduled > to be removed in Docker 17.12.0  | No |
| Networks | object | Information about all networks that the container is connected to.  | No |

#### Address

Address represents an IPv4 or IPv6 IP address.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Addr | string | IP address. | No |
| PrefixLen | integer | Mask length of the IP address. | No |

#### PortMap

PortMap describes the mapping of container ports to host ports, using the
container's port-number and protocol as key in the format `<port>/<protocol>`,
for example, `80/udp`.

If a container's port is mapped for multiple protocols, separate entries
are added to the mapping table.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| PortMap | object | PortMap describes the mapping of container ports to host ports, using the container's port-number and protocol as key in the format `<port>/<protocol>`, for example, `80/udp`.  If a container's port is mapped for multiple protocols, separate entries are added to the mapping table.  |  |

#### PortBinding

PortBinding represents a binding between a host IP address and a host
port.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| HostIp | string | Host IP address that the container's port is mapped to. | No |
| HostPort | string | Host port number that the container's port is mapped to. | No |

#### GraphDriverData

Information about the storage driver used to store the container's and
image's filesystem.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string | Name of the storage driver. | Yes |
| Data | object | Low-level storage metadata, provided as key/value pairs.  This information is driver-specific, and depends on the storage-driver in use, and should be used for informational purposes only.  | Yes |

#### ImageInspect

Information about an image in the local image cache.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Id | string | ID is the content-addressable ID of an image.  This identifier is a content-addressable digest calculated from the image's configuration (which includes the digests of layers used by the image).  Note that this digest differs from the `RepoDigests` below, which holds digests of image manifests that reference the image.  | No |
| RepoTags | [ string ] | List of image names/tags in the local image cache that reference this image.  Multiple image tags can refer to the same image, and this list may be empty if no tags reference the image, in which case the image is "untagged", in which case it can still be referenced by its ID.  | No |
| RepoDigests | [ string ] | List of content-addressable digests of locally available image manifests that the image is referenced from. Multiple manifests can refer to the same image.  These digests are usually only available if the image was either pulled from a registry, or if the image was pushed to a registry, which is when the manifest is generated and its digest calculated.  | No |
| Parent | string | ID of the parent image.  Depending on how the image was created, this field may be empty and is only set for images that were built/created locally. This field is empty if the image was pulled from an image registry.  | No |
| Comment | string | Optional message that was set when committing or importing the image.  | No |
| Created | string | Date and time at which the image was created, formatted in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.  | No |
| Container | string | The ID of the container that was used to create the image.  Depending on how the image was created, this field may be empty.  | No |
| ContainerConfig | [ContainerConfig](#ContainerConfig) |  | No |
| DockerVersion | string | The version of Docker that was used to build the image.  Depending on how the image was created, this field may be empty.  | No |
| Author | string | Name of the author that was specified when committing the image, or as specified through MAINTAINER (deprecated) in the Dockerfile.  | No |
| Config | [ContainerConfig](#ContainerConfig) |  | No |
| Architecture | string | Hardware CPU architecture that the image runs on.  | No |
| Variant | string | CPU architecture variant (presently ARM-only).  | No |
| Os | string | Operating System the image is built to run on.  | No |
| OsVersion | string | Operating System version the image is built to run on (especially for Windows).  | No |
| Size | long | Total size of the image including all layers it is composed of.  | No |
| VirtualSize | long | Total size of the image including all layers it is composed of.  In versions of Docker before v1.10, this field was calculated from the image itself and all of its parent images. Docker v1.10 and up store images self-contained, and no longer use a parent-chain, making this field an equivalent of the Size field.  This field is kept for backward compatibility, but may be removed in a future version of the API.  | No |
| GraphDriver | [GraphDriverData](#GraphDriverData) |  | No |
| RootFS | object | Information about the image's RootFS, including the layer IDs.  | No |
| Metadata | object | Additional metadata of the image in the local cache. This information is local to the daemon, and not part of the image itself.  | No |

#### ImageSummary

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Id | string | ID is the content-addressable ID of an image.  This identifier is a content-addressable digest calculated from the image's configuration (which includes the digests of layers used by the image).  Note that this digest differs from the `RepoDigests` below, which holds digests of image manifests that reference the image.  | Yes |
| ParentId | string | ID of the parent image.  Depending on how the image was created, this field may be empty and is only set for images that were built/created locally. This field is empty if the image was pulled from an image registry.  | Yes |
| RepoTags | [ string ] | List of image names/tags in the local image cache that reference this image.  Multiple image tags can refer to the same image, and this list may be empty if no tags reference the image, in which case the image is "untagged", in which case it can still be referenced by its ID.  | Yes |
| RepoDigests | [ string ] | List of content-addressable digests of locally available image manifests that the image is referenced from. Multiple manifests can refer to the same image.  These digests are usually only available if the image was either pulled from a registry, or if the image was pushed to a registry, which is when the manifest is generated and its digest calculated.  | Yes |
| Created | integer | Date and time at which the image was created as a Unix timestamp (number of seconds sinds EPOCH).  | Yes |
| Size | long | Total size of the image including all layers it is composed of.  | Yes |
| SharedSize | long | Total size of image layers that are shared between this image and other images.  This size is not calculated by default. `-1` indicates that the value has not been set / calculated.  | Yes |
| VirtualSize | long | Total size of the image including all layers it is composed of.  In versions of Docker before v1.10, this field was calculated from the image itself and all of its parent images. Docker v1.10 and up store images self-contained, and no longer use a parent-chain, making this field an equivalent of the Size field.  This field is kept for backward compatibility, but may be removed in a future version of the API.  | Yes |
| Labels | object | User-defined key/value metadata. | Yes |
| Containers | integer | Number of containers using this image. Includes both stopped and running containers.  This size is not calculated by default, and depends on which API endpoint is used. `-1` indicates that the value has not been set / calculated.  | Yes |

#### AuthConfig

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| username | string |  | No |
| password | string |  | No |
| email | string |  | No |
| serveraddress | string |  | No |

#### ProcessConfig

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| privileged | boolean |  | No |
| user | string |  | No |
| tty | boolean |  | No |
| entrypoint | string |  | No |
| arguments | [ string ] |  | No |

#### Volume

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string | Name of the volume. | Yes |
| Driver | string | Name of the volume driver used by the volume. | Yes |
| Mountpoint | string | Mount path of the volume on the host. | Yes |
| CreatedAt | string (dateTime) | Date/Time the volume was created. | No |
| Status | object | Low-level details about the volume, provided by the volume driver. Details are returned as a map with key/value pairs: `{"key":"value","key2":"value2"}`.  The `Status` field is optional, and is omitted if the volume driver does not support this feature.  | No |
| Labels | object | User-defined key/value metadata. | Yes |
| Scope | string | The level at which the volume exists. Either `global` for cluster-wide, or `local` for machine level.  | Yes |
| ClusterVolume | [ClusterVolume](#ClusterVolume) |  | No |
| Options | object | The driver specific options used when creating the volume.  | Yes |
| UsageData | object | Usage details about the volume. This information is used by the `GET /system/df` endpoint, and omitted in other endpoints.  | No |

#### VolumeCreateOptions

Volume configuration

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string | The new volume's name. If not specified, Docker generates a name.  | No |
| Driver | string | Name of the volume driver to use. | No |
| DriverOpts | object | A mapping of driver options and values. These options are passed directly to the driver and are driver specific.  | No |
| Labels | object | User-defined key/value metadata. | No |
| ClusterVolumeSpec | [ClusterVolumeSpec](#ClusterVolumeSpec) |  | No |

#### VolumeListResponse

Volume list response

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Volumes | [ [Volume](#Volume) ] | List of volumes | No |
| Warnings | [ string ] | Warnings that occurred when fetching the list of volumes.  | No |

#### Network

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string |  | No |
| Id | string |  | No |
| Created | string (dateTime) |  | No |
| Scope | string |  | No |
| Driver | string |  | No |
| EnableIPv6 | boolean |  | No |
| IPAM | [IPAM](#IPAM) |  | No |
| Internal | boolean |  | No |
| Attachable | boolean |  | No |
| Ingress | boolean |  | No |
| Containers | object |  | No |
| Options | object |  | No |
| Labels | object |  | No |

#### IPAM

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Driver | string | Name of the IPAM driver to use. | No |
| Config | [ [IPAMConfig](#IPAMConfig) ] | List of IPAM configuration options, specified as a map:  ``` {"Subnet": <CIDR>, "IPRange": <CIDR>, "Gateway": <IP address>, "AuxAddress": <device_name:IP address>} ```  | No |
| Options | object | Driver-specific options, specified as a map. | No |

#### IPAMConfig

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Subnet | string |  | No |
| IPRange | string |  | No |
| Gateway | string |  | No |
| AuxiliaryAddresses | object |  | No |

#### NetworkContainer

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string |  | No |
| EndpointID | string |  | No |
| MacAddress | string |  | No |
| IPv4Address | string |  | No |
| IPv6Address | string |  | No |

#### BuildInfo

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| id | string |  | No |
| stream | string |  | No |
| error | string |  | No |
| errorDetail | [ErrorDetail](#ErrorDetail) |  | No |
| status | string |  | No |
| progress | string |  | No |
| progressDetail | [ProgressDetail](#ProgressDetail) |  | No |
| aux | [ImageID](#ImageID) |  | No |

#### BuildCache

BuildCache contains information about a build cache record.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| ID | string | Unique ID of the build cache record.  | No |
| Parent | string | ID of the parent build cache record.  > **Deprecated**: This field is deprecated, and omitted if empty.  | No |
| Parents | [ string ] | List of parent build cache record IDs.  | No |
| Type | string | Cache record type.  | No |
| Description | string | Description of the build-step that produced the build cache.  | No |
| InUse | boolean | Indicates if the build cache is in use.  | No |
| Shared | boolean | Indicates if the build cache is shared.  | No |
| Size | integer | Amount of disk space used by the build cache (in bytes).  | No |
| CreatedAt | string (dateTime) | Date and time at which the build cache was created in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.  | No |
| LastUsedAt | string (dateTime) | Date and time at which the build cache was last used in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.  | No |
| UsageCount | integer |  | No |

#### ImageID

Image ID or Digest

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| ID | string |  | No |

#### CreateImageInfo

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| id | string |  | No |
| error | string |  | No |
| errorDetail | [ErrorDetail](#ErrorDetail) |  | No |
| status | string |  | No |
| progress | string |  | No |
| progressDetail | [ProgressDetail](#ProgressDetail) |  | No |

#### PushImageInfo

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| error | string |  | No |
| status | string |  | No |
| progress | string |  | No |
| progressDetail | [ProgressDetail](#ProgressDetail) |  | No |

#### ErrorDetail

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| code | integer |  | No |
| message | string |  | No |

#### ProgressDetail

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| current | integer |  | No |
| total | integer |  | No |

#### ErrorResponse

Represents an error.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| message | string | The error message. | Yes |

#### IdResponse

Response to an API call that returns just an Id

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Id | string | The id of the newly created object. | Yes |

#### EndpointSettings

Configuration for a network endpoint.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| IPAMConfig | [EndpointIPAMConfig](#EndpointIPAMConfig) |  | No |
| Links | [ string ] |  | No |
| Aliases | [ string ] |  | No |
| NetworkID | string | Unique ID of the network.  | No |
| EndpointID | string | Unique ID for the service endpoint in a Sandbox.  | No |
| Gateway | string | Gateway address for this network.  | No |
| IPAddress | string | IPv4 address.  | No |
| IPPrefixLen | integer | Mask length of the IPv4 address.  | No |
| IPv6Gateway | string | IPv6 gateway address.  | No |
| GlobalIPv6Address | string | Global IPv6 address.  | No |
| GlobalIPv6PrefixLen | long | Mask length of the global IPv6 address.  | No |
| MacAddress | string | MAC address for the endpoint on this network.  | No |
| DriverOpts | object | DriverOpts is a mapping of driver options and values. These options are passed directly to the driver and are driver specific.  | No |

#### EndpointIPAMConfig

EndpointIPAMConfig represents an endpoint's IPAM configuration.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| IPv4Address | string |  | No |
| IPv6Address | string |  | No |
| LinkLocalIPs | [ string ] |  | No |

#### PluginMount

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string |  | Yes |
| Description | string |  | Yes |
| Settable | [ string ] |  | Yes |
| Source | string |  | Yes |
| Destination | string |  | Yes |
| Type | string |  | Yes |
| Options | [ string ] |  | Yes |

#### PluginDevice

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string |  | Yes |
| Description | string |  | Yes |
| Settable | [ string ] |  | Yes |
| Path | string |  | Yes |

#### PluginEnv

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string |  | Yes |
| Description | string |  | Yes |
| Settable | [ string ] |  | Yes |
| Value | string |  | Yes |

#### PluginInterfaceType

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Prefix | string |  | Yes |
| Capability | string |  | Yes |
| Version | string |  | Yes |

#### PluginPrivilege

Describes a permission the user has to accept upon installing
the plugin.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string |  | No |
| Description | string |  | No |
| Value | [ string ] |  | No |

#### Plugin

A plugin for the Engine API

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Id | string |  | No |
| Name | string |  | Yes |
| Enabled | boolean | True if the plugin is running. False if the plugin is not running, only installed. | Yes |
| Settings | object | Settings that can be modified by users. | Yes |
| PluginReference | string | plugin remote reference used to push/pull the plugin | No |
| Config | object | The config of a plugin. | Yes |

#### ObjectVersion

The version number of the object such as node, service, etc. This is needed
to avoid conflicting writes. The client must send the version number along
with the modified specification when updating these objects.

This approach ensures safe concurrency and determinism in that the change
on the object may not be applied if the version number has changed from the
last read. In other words, if two update requests specify the same base
version, only one of the requests can succeed. As a result, two separate
update requests that happen at the same time will not unintentionally
overwrite each other.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Index | integer (uint64) |  | No |

#### NodeSpec

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string | Name for the node. | No |
| Labels | object | User-defined key/value metadata. | No |
| Role | string | Role of the node. | No |
| Availability | string | Availability of the node. | No |

#### Node

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| ID | string |  | No |
| Version | [ObjectVersion](#ObjectVersion) |  | No |
| CreatedAt | string (dateTime) | Date and time at which the node was added to the swarm in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.  | No |
| UpdatedAt | string (dateTime) | Date and time at which the node was last updated in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.  | No |
| Spec | [NodeSpec](#NodeSpec) |  | No |
| Description | [NodeDescription](#NodeDescription) |  | No |
| Status | [NodeStatus](#NodeStatus) |  | No |
| ManagerStatus | [ManagerStatus](#ManagerStatus) |  | No |

#### NodeDescription

NodeDescription encapsulates the properties of the Node as reported by the
agent.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Hostname | string |  | No |
| Platform | [Platform](#Platform) |  | No |
| Resources | [ResourceObject](#ResourceObject) |  | No |
| Engine | [EngineDescription](#EngineDescription) |  | No |
| TLSInfo | [TLSInfo](#TLSInfo) |  | No |

#### Platform

Platform represents the platform (Arch/OS).


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Architecture | string | Architecture represents the hardware architecture (for example, `x86_64`).  | No |
| OS | string | OS represents the Operating System (for example, `linux` or `windows`).  | No |

#### EngineDescription

EngineDescription provides information about an engine.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| EngineVersion | string |  | No |
| Labels | object |  | No |
| Plugins | [ object ] |  | No |

#### TLSInfo

Information about the issuer of leaf TLS certificates and the trusted root
CA certificate.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| TrustRoot | string | The root CA certificate(s) that are used to validate leaf TLS certificates.  | No |
| CertIssuerSubject | string | The base64-url-safe-encoded raw subject bytes of the issuer. | No |
| CertIssuerPublicKey | string | The base64-url-safe-encoded raw public key bytes of the issuer.  | No |

#### NodeStatus

NodeStatus represents the status of a node.

It provides the current status of the node, as seen by the manager.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| State | [NodeState](#NodeState) |  | No |
| Message | string |  | No |
| Addr | string | IP address of the node. | No |

#### NodeState

NodeState represents the state of a node.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| NodeState | string | NodeState represents the state of a node. |  |

#### ManagerStatus

ManagerStatus represents the status of a manager.

It provides the current status of a node's manager component, if the node
is a manager.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Leader | boolean |  | No |
| Reachability | [Reachability](#Reachability) |  | No |
| Addr | string | The IP address and port at which the manager is reachable.  | No |

#### Reachability

Reachability represents the reachability of a node.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Reachability | string | Reachability represents the reachability of a node. |  |

#### SwarmSpec

User modifiable swarm configuration.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string | Name of the swarm. | No |
| Labels | object | User-defined key/value metadata. | No |
| Orchestration | object | Orchestration configuration. | No |
| Raft | object | Raft configuration. | No |
| Dispatcher | object | Dispatcher configuration. | No |
| CAConfig | object | CA configuration. | No |
| EncryptionConfig | object | Parameters related to encryption-at-rest. | No |
| TaskDefaults | object | Defaults for creating tasks in this cluster. | No |

#### ClusterInfo

ClusterInfo represents information about the swarm as is returned by the
"/info" endpoint. Join-tokens are not included.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| ID | string | The ID of the swarm. | No |
| Version | [ObjectVersion](#ObjectVersion) |  | No |
| CreatedAt | string (dateTime) | Date and time at which the swarm was initialised in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.  | No |
| UpdatedAt | string (dateTime) | Date and time at which the swarm was last updated in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.  | No |
| Spec | [SwarmSpec](#SwarmSpec) |  | No |
| TLSInfo | [TLSInfo](#TLSInfo) |  | No |
| RootRotationInProgress | boolean | Whether there is currently a root CA rotation in progress for the swarm  | No |
| DataPathPort | integer (uint32) | DataPathPort specifies the data path port number for data traffic. Acceptable port range is 1024 to 49151. If no port is set or is set to 0, the default port (4789) is used.  | No |
| DefaultAddrPool | [ string (CIDR) ] | Default Address Pool specifies default subnet pools for global scope networks.  | No |
| SubnetSize | integer (uint32) | SubnetSize specifies the subnet size of the networks created from the default subnet pool.  | No |

#### JoinTokens

JoinTokens contains the tokens workers and managers need to join the swarm.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Worker | string | The token workers can use to join the swarm.  | No |
| Manager | string | The token managers can use to join the swarm.  | No |

#### Swarm

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Swarm | object |  |  |

#### TaskSpec

User modifiable task configuration.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| PluginSpec | object | Plugin spec for the service.  *(Experimental release only.)*  <p><br /></p>  > **Note**: ContainerSpec, NetworkAttachmentSpec, and PluginSpec are > mutually exclusive. PluginSpec is only used when the Runtime field > is set to `plugin`. NetworkAttachmentSpec is used when the Runtime > field is set to `attachment`.  | No |
| ContainerSpec | object | Container spec for the service.  <p><br /></p>  > **Note**: ContainerSpec, NetworkAttachmentSpec, and PluginSpec are > mutually exclusive. PluginSpec is only used when the Runtime field > is set to `plugin`. NetworkAttachmentSpec is used when the Runtime > field is set to `attachment`.  | No |
| NetworkAttachmentSpec | object | Read-only spec type for non-swarm containers attached to swarm overlay networks.  <p><br /></p>  > **Note**: ContainerSpec, NetworkAttachmentSpec, and PluginSpec are > mutually exclusive. PluginSpec is only used when the Runtime field > is set to `plugin`. NetworkAttachmentSpec is used when the Runtime > field is set to `attachment`.  | No |
| Resources | object | Resource requirements which apply to each individual container created as part of the service.  | No |
| RestartPolicy | object | Specification for the restart policy which applies to containers created as part of this service.  | No |
| Placement | object |  | No |
| ForceUpdate | integer | A counter that triggers an update even if no relevant parameters have been changed.  | No |
| Runtime | string | Runtime is the type of runtime specified for the task executor.  | No |
| Networks | [ [NetworkAttachmentConfig](#NetworkAttachmentConfig) ] | Specifies which networks the service should attach to. | No |
| LogDriver | object | Specifies the log driver to use for tasks created from this spec. If not present, the default one for the swarm will be used, finally falling back to the engine default if not specified.  | No |

#### TaskState

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| TaskState | string |  |  |

#### Task

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| ID | string | The ID of the task. | No |
| Version | [ObjectVersion](#ObjectVersion) |  | No |
| CreatedAt | string (dateTime) |  | No |
| UpdatedAt | string (dateTime) |  | No |
| Name | string | Name of the task. | No |
| Labels | object | User-defined key/value metadata. | No |
| Spec | [TaskSpec](#TaskSpec) |  | No |
| ServiceID | string | The ID of the service this task is part of. | No |
| Slot | integer |  | No |
| NodeID | string | The ID of the node that this task is on. | No |
| AssignedGenericResources | [GenericResources](#GenericResources) |  | No |
| Status | object |  | No |
| DesiredState | [TaskState](#TaskState) |  | No |
| JobIteration | [ObjectVersion](#ObjectVersion) | If the Service this Task belongs to is a job-mode service, contains the JobIteration of the Service this Task was created for. Absent if the Task was created for a Replicated or Global Service.  | No |

#### ServiceSpec

User modifiable configuration for a service.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string | Name of the service. | No |
| Labels | object | User-defined key/value metadata. | No |
| TaskTemplate | [TaskSpec](#TaskSpec) |  | No |
| Mode | object | Scheduling mode for the service. | No |
| UpdateConfig | object | Specification for the update strategy of the service. | No |
| RollbackConfig | object | Specification for the rollback strategy of the service. | No |
| Networks | [ [NetworkAttachmentConfig](#NetworkAttachmentConfig) ] | Specifies which networks the service should attach to. | No |
| EndpointSpec | [EndpointSpec](#EndpointSpec) |  | No |

#### EndpointPortConfig

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string |  | No |
| Protocol | string |  | No |
| TargetPort | integer | The port inside the container. | No |
| PublishedPort | integer | The port on the swarm hosts. | No |
| PublishMode | string | The mode in which port is published.  <p><br /></p>  - "ingress" makes the target port accessible on every node,   regardless of whether there is a task for the service running on   that node or not. - "host" bypasses the routing mesh and publish the port directly on   the swarm node where that service is running.  | No |

#### EndpointSpec

Properties that can be configured to access and load balance a service.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Mode | string | The mode of resolution to use for internal load balancing between tasks.  | No |
| Ports | [ [EndpointPortConfig](#EndpointPortConfig) ] | List of exposed ports that this service is accessible on from the outside. Ports can only be provided if `vip` resolution mode is used.  | No |

#### Service

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| ID | string |  | No |
| Version | [ObjectVersion](#ObjectVersion) |  | No |
| CreatedAt | string (dateTime) |  | No |
| UpdatedAt | string (dateTime) |  | No |
| Spec | [ServiceSpec](#ServiceSpec) |  | No |
| Endpoint | object |  | No |
| UpdateStatus | object | The status of a service update. | No |
| ServiceStatus | object | The status of the service's tasks. Provided only when requested as part of a ServiceList operation.  | No |
| JobStatus | object | The status of the service when it is in one of ReplicatedJob or GlobalJob modes. Absent on Replicated and Global mode services. The JobIteration is an ObjectVersion, but unlike the Service's version, does not need to be sent with an update request.  | No |

#### ImageDeleteResponseItem

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Untagged | string | The image ID of an image that was untagged | No |
| Deleted | string | The image ID of an image that was deleted | No |

#### ServiceUpdateResponse

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Warnings | [ string ] | Optional warning messages | No |

#### ContainerSummary

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Id | string | The ID of this container | No |
| Names | [ string ] | The names that this container has been given | No |
| Image | string | The name of the image used when creating this container | No |
| ImageID | string | The ID of the image that this container was created from | No |
| Command | string | Command to run when starting the container | No |
| Created | long | When the container was created | No |
| Ports | [ [Port](#Port) ] | The ports exposed by this container | No |
| SizeRw | long | The size of files that have been created or changed by this container | No |
| SizeRootFs | long | The total size of all the files in this container | No |
| Labels | object | User-defined key/value metadata. | No |
| State | string | The state of this container (e.g. `Exited`) | No |
| Status | string | Additional human-readable status of this container (e.g. `Exit 0`) | No |
| HostConfig | object |  | No |
| NetworkSettings | object | A summary of the container's network settings | No |
| Mounts | [ [MountPoint](#MountPoint) ] |  | No |

#### Driver

Driver represents a driver (network, logging, secrets).

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string | Name of the driver. | Yes |
| Options | object | Key/value map of driver-specific options. | No |

#### SecretSpec

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string | User-defined name of the secret. | No |
| Labels | object | User-defined key/value metadata. | No |
| Data | string | Base64-url-safe-encoded ([RFC 4648](https://tools.ietf.org/html/rfc4648#section-5)) data to store as secret.  This field is only used to _create_ a secret, and is not returned by other endpoints.  | No |
| Driver | [Driver](#Driver) | Name of the secrets driver used to fetch the secret's value from an external secret store.  | No |
| Templating | [Driver](#Driver) | Templating driver, if applicable  Templating controls whether and how to evaluate the config payload as a template. If no driver is set, no templating is used.  | No |

#### Secret

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| ID | string |  | No |
| Version | [ObjectVersion](#ObjectVersion) |  | No |
| CreatedAt | string (dateTime) |  | No |
| UpdatedAt | string (dateTime) |  | No |
| Spec | [SecretSpec](#SecretSpec) |  | No |

#### ConfigSpec

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string | User-defined name of the config. | No |
| Labels | object | User-defined key/value metadata. | No |
| Data | string | Base64-url-safe-encoded ([RFC 4648](https://tools.ietf.org/html/rfc4648#section-5)) config data.  | No |
| Templating | [Driver](#Driver) | Templating driver, if applicable  Templating controls whether and how to evaluate the config payload as a template. If no driver is set, no templating is used.  | No |

#### Config

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| ID | string |  | No |
| Version | [ObjectVersion](#ObjectVersion) |  | No |
| CreatedAt | string (dateTime) |  | No |
| UpdatedAt | string (dateTime) |  | No |
| Spec | [ConfigSpec](#ConfigSpec) |  | No |

#### ContainerState

ContainerState stores container's running state. It's part of ContainerJSONBase
and will be returned by the "inspect" command.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Status | string | String representation of the container state. Can be one of "created", "running", "paused", "restarting", "removing", "exited", or "dead".  | No |
| Running | boolean | Whether this container is running.  Note that a running container can be _paused_. The `Running` and `Paused` booleans are not mutually exclusive:  When pausing a container (on Linux), the freezer cgroup is used to suspend all processes in the container. Freezing the process requires the process to be running. As a result, paused containers are both `Running` _and_ `Paused`.  Use the `Status` field instead to determine if a container's state is "running".  | No |
| Paused | boolean | Whether this container is paused. | No |
| Restarting | boolean | Whether this container is restarting. | No |
| OOMKilled | boolean | Whether this container has been killed because it ran out of memory.  | No |
| Dead | boolean |  | No |
| Pid | integer | The process ID of this container | No |
| ExitCode | integer | The last exit code of this container | No |
| Error | string |  | No |
| StartedAt | string | The time when this container was last started. | No |
| FinishedAt | string | The time when this container last exited. | No |
| Health | [Health](#Health) |  | No |

#### ContainerCreateResponse

OK response to ContainerCreate operation

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Id | string | The ID of the created container | Yes |
| Warnings | [ string ] | Warnings encountered when creating the container | Yes |

#### ContainerWaitResponse

OK response to ContainerWait operation

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| StatusCode | long | Exit code of the container | Yes |
| Error | [ContainerWaitExitError](#ContainerWaitExitError) |  | No |

#### ContainerWaitExitError

container waiting error, if any

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Message | string | Details of an error | No |

#### SystemVersion

Response of Engine API: GET "/version"


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Platform | object |  | No |
| Components | [ object ] | Information about system components  | No |
| Version | string | The version of the daemon | No |
| ApiVersion | string | The default (and highest) API version that is supported by the daemon  | No |
| MinAPIVersion | string | The minimum API version that is supported by the daemon  | No |
| GitCommit | string | The Git commit of the source code that was used to build the daemon  | No |
| GoVersion | string | The version Go used to compile the daemon, and the version of the Go runtime in use.  | No |
| Os | string | The operating system that the daemon is running on ("linux" or "windows")  | No |
| Arch | string | The architecture that the daemon is running on  | No |
| KernelVersion | string | The kernel version (`uname -r`) that the daemon is running on.  This field is omitted when empty.  | No |
| Experimental | boolean | Indicates if the daemon is started with experimental features enabled.  This field is omitted when empty / false.  | No |
| BuildTime | string | The date and time that the daemon was compiled.  | No |

#### SystemInfo

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| ID | string | Unique identifier of the daemon.  <p><br /></p>  > **Note**: The format of the ID itself is not part of the API, and > should not be considered stable.  | No |
| Containers | integer | Total number of containers on the host. | No |
| ContainersRunning | integer | Number of containers with status `"running"`.  | No |
| ContainersPaused | integer | Number of containers with status `"paused"`.  | No |
| ContainersStopped | integer | Number of containers with status `"stopped"`.  | No |
| Images | integer | Total number of images on the host.  Both _tagged_ and _untagged_ (dangling) images are counted.  | No |
| Driver | string | Name of the storage driver in use. | No |
| DriverStatus | [ [ string ] ] | Information specific to the storage driver, provided as "label" / "value" pairs.  This information is provided by the storage driver, and formatted in a way consistent with the output of `docker info` on the command line.  <p><br /></p>  > **Note**: The information returned in this field, including the > formatting of values and labels, should not be considered stable, > and may change without notice.  | No |
| DockerRootDir | string | Root directory of persistent Docker state.  Defaults to `/var/lib/docker` on Linux, and `C:\ProgramData\docker` on Windows.  | No |
| Plugins | [PluginsInfo](#PluginsInfo) |  | No |
| MemoryLimit | boolean | Indicates if the host has memory limit support enabled. | No |
| SwapLimit | boolean | Indicates if the host has memory swap limit support enabled. | No |
| KernelMemoryTCP | boolean | Indicates if the host has kernel memory TCP limit support enabled. This field is omitted if not supported.  Kernel memory TCP limits are not supported when using cgroups v2, which does not support the corresponding `memory.kmem.tcp.limit_in_bytes` cgroup.  | No |
| CpuCfsPeriod | boolean | Indicates if CPU CFS(Completely Fair Scheduler) period is supported by the host.  | No |
| CpuCfsQuota | boolean | Indicates if CPU CFS(Completely Fair Scheduler) quota is supported by the host.  | No |
| CPUShares | boolean | Indicates if CPU Shares limiting is supported by the host.  | No |
| CPUSet | boolean | Indicates if CPUsets (cpuset.cpus, cpuset.mems) are supported by the host.  See [cpuset(7)](https://www.kernel.org/doc/Documentation/cgroup-v1/cpusets.txt)  | No |
| PidsLimit | boolean | Indicates if the host kernel has PID limit support enabled. | No |
| OomKillDisable | boolean | Indicates if OOM killer disable is supported on the host. | No |
| IPv4Forwarding | boolean | Indicates IPv4 forwarding is enabled. | No |
| BridgeNfIptables | boolean | Indicates if `bridge-nf-call-iptables` is available on the host. | No |
| BridgeNfIp6tables | boolean | Indicates if `bridge-nf-call-ip6tables` is available on the host. | No |
| Debug | boolean | Indicates if the daemon is running in debug-mode / with debug-level logging enabled.  | No |
| NFd | integer | The total number of file Descriptors in use by the daemon process.  This information is only returned if debug-mode is enabled.  | No |
| NGoroutines | integer | The  number of goroutines that currently exist.  This information is only returned if debug-mode is enabled.  | No |
| SystemTime | string | Current system-time in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.  | No |
| LoggingDriver | string | The logging driver to use as a default for new containers.  | No |
| CgroupDriver | string | The driver to use for managing cgroups.  | No |
| CgroupVersion | string | The version of the cgroup.  | No |
| NEventsListener | integer | Number of event listeners subscribed. | No |
| KernelVersion | string | Kernel version of the host.  On Linux, this information obtained from `uname`. On Windows this information is queried from the <kbd>HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\</kbd> registry value, for example _"10.0 14393 (14393.1198.amd64fre.rs1_release_sec.170427-1353)"_.  | No |
| OperatingSystem | string | Name of the host's operating system, for example: "Ubuntu 16.04.2 LTS" or "Windows Server 2016 Datacenter"  | No |
| OSVersion | string | Version of the host's operating system  <p><br /></p>  > **Note**: The information returned in this field, including its > very existence, and the formatting of values, should not be considered > stable, and may change without notice.  | No |
| OSType | string | Generic type of the operating system of the host, as returned by the Go runtime (`GOOS`).  Currently returned values are "linux" and "windows". A full list of possible values can be found in the [Go documentation](https://golang.org/doc/install/source#environment).  | No |
| Architecture | string | Hardware architecture of the host, as returned by the Go runtime (`GOARCH`).  A full list of possible values can be found in the [Go documentation](https://golang.org/doc/install/source#environment).  | No |
| NCPU | integer | The number of logical CPUs usable by the daemon.  The number of available CPUs is checked by querying the operating system when the daemon starts. Changes to operating system CPU allocation after the daemon is started are not reflected.  | No |
| MemTotal | long | Total amount of physical memory available on the host, in bytes.  | No |
| IndexServerAddress | string | Address / URL of the index server that is used for image search, and as a default for user authentication for Docker Hub and Docker Cloud.  | No |
| RegistryConfig | [RegistryServiceConfig](#RegistryServiceConfig) |  | No |
| GenericResources | [GenericResources](#GenericResources) |  | No |
| HttpProxy | string | HTTP-proxy configured for the daemon. This value is obtained from the [`HTTP_PROXY`](https://www.gnu.org/software/wget/manual/html_node/Proxies.html) environment variable. Credentials ([user info component](https://tools.ietf.org/html/rfc3986#section-3.2.1)) in the proxy URL are masked in the API response.  Containers do not automatically inherit this configuration.  | No |
| HttpsProxy | string | HTTPS-proxy configured for the daemon. This value is obtained from the [`HTTPS_PROXY`](https://www.gnu.org/software/wget/manual/html_node/Proxies.html) environment variable. Credentials ([user info component](https://tools.ietf.org/html/rfc3986#section-3.2.1)) in the proxy URL are masked in the API response.  Containers do not automatically inherit this configuration.  | No |
| NoProxy | string | Comma-separated list of domain extensions for which no proxy should be used. This value is obtained from the [`NO_PROXY`](https://www.gnu.org/software/wget/manual/html_node/Proxies.html) environment variable.  Containers do not automatically inherit this configuration.  | No |
| Name | string | Hostname of the host. | No |
| Labels | [ string ] | User-defined labels (key/value metadata) as set on the daemon.  <p><br /></p>  > **Note**: When part of a Swarm, nodes can both have _daemon_ labels, > set through the daemon configuration, and _node_ labels, set from a > manager node in the Swarm. Node labels are not included in this > field. Node labels can be retrieved using the `/nodes/(id)` endpoint > on a manager node in the Swarm.  | No |
| ExperimentalBuild | boolean | Indicates if experimental features are enabled on the daemon.  | No |
| ServerVersion | string | Version string of the daemon.  > **Note**: the [standalone Swarm API](https://docs.docker.com/swarm/swarm-api/) > returns the Swarm version instead of the daemon  version, for example > `swarm/1.2.8`.  | No |
| ClusterStore | string | URL of the distributed storage backend.   The storage backend is used for multihost networking (to store network and endpoint information) and by the node discovery mechanism.  <p><br /></p>  > **Deprecated**: This field is only propagated when using standalone Swarm > mode, and overlay networking using an external k/v store. Overlay > networks with Swarm mode enabled use the built-in raft store, and > this field will be empty.  | No |
| ClusterAdvertise | string | The network endpoint that the Engine advertises for the purpose of node discovery. ClusterAdvertise is a `host:port` combination on which the daemon is reachable by other hosts.  <p><br /></p>  > **Deprecated**: This field is only propagated when using standalone Swarm > mode, and overlay networking using an external k/v store. Overlay > networks with Swarm mode enabled use the built-in raft store, and > this field will be empty.  | No |
| Runtimes | object | List of [OCI compliant](https://github.com/opencontainers/runtime-spec) runtimes configured on the daemon. Keys hold the "name" used to reference the runtime.  The Docker daemon relies on an OCI compliant runtime (invoked via the `containerd` daemon) as its interface to the Linux kernel namespaces, cgroups, and SELinux.  The default runtime is `runc`, and automatically configured. Additional runtimes can be configured by the user and will be listed here.  | No |
| DefaultRuntime | string | Name of the default OCI runtime that is used when starting containers.  The default can be overridden per-container at create time.  | No |
| Swarm | [SwarmInfo](#SwarmInfo) |  | No |
| LiveRestoreEnabled | boolean | Indicates if live restore is enabled.  If enabled, containers are kept running when the daemon is shutdown or upon daemon start if running containers are detected.  | No |
| Isolation | string | Represents the isolation technology to use as a default for containers. The supported values are platform-specific.  If no isolation value is specified on daemon start, on Windows client, the default is `hyperv`, and on Windows server, the default is `process`.  This option is currently not used on other platforms.  | No |
| InitBinary | string | Name and, optional, path of the `docker-init` binary.  If the path is omitted, the daemon searches the host's `$PATH` for the binary and uses the first result.  | No |
| ContainerdCommit | [Commit](#Commit) |  | No |
| RuncCommit | [Commit](#Commit) |  | No |
| InitCommit | [Commit](#Commit) |  | No |
| SecurityOptions | [ string ] | List of security features that are enabled on the daemon, such as apparmor, seccomp, SELinux, user-namespaces (userns), and rootless.  Additional configuration options for each security feature may be present, and are included as a comma-separated list of key/value pairs.  | No |
| ProductLicense | string | Reports a summary of the product license on the daemon.  If a commercial license has been applied to the daemon, information such as number of nodes, and expiration are included.  | No |
| DefaultAddressPools | [ object ] | List of custom default address pools for local networks, which can be specified in the daemon.json file or dockerd option.  Example: a Base "10.10.0.0/16" with Size 24 will define the set of 256 10.10.[0-255].0/24 address pools.  | No |
| Warnings | [ string ] | List of warnings / informational messages about missing features, or issues related to the daemon configuration.  These messages can be printed by the client as information to the user.  | No |

#### PluginsInfo

Available plugins per type.

<p><br /></p>

> **Note**: Only unmanaged (V1) plugins are included in this list.
> V1 plugins are "lazily" loaded, and are not returned in this list
> if there is no resource using the plugin.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Volume | [ string ] | Names of available volume-drivers, and network-driver plugins. | No |
| Network | [ string ] | Names of available network-drivers, and network-driver plugins. | No |
| Authorization | [ string ] | Names of available authorization plugins. | No |
| Log | [ string ] | Names of available logging-drivers, and logging-driver plugins. | No |

#### RegistryServiceConfig

RegistryServiceConfig stores daemon registry services configuration.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| AllowNondistributableArtifactsCIDRs | [ string ] | List of IP ranges to which nondistributable artifacts can be pushed, using the CIDR syntax [RFC 4632](https://tools.ietf.org/html/4632).  Some images (for example, Windows base images) contain artifacts whose distribution is restricted by license. When these images are pushed to a registry, restricted artifacts are not included.  This configuration override this behavior, and enables the daemon to push nondistributable artifacts to all registries whose resolved IP address is within the subnet described by the CIDR syntax.  This option is useful when pushing images containing nondistributable artifacts to a registry on an air-gapped network so hosts on that network can pull the images without connecting to another server.  > **Warning**: Nondistributable artifacts typically have restrictions > on how and where they can be distributed and shared. Only use this > feature to push artifacts to private registries and ensure that you > are in compliance with any terms that cover redistributing > nondistributable artifacts.  | No |
| AllowNondistributableArtifactsHostnames | [ string ] | List of registry hostnames to which nondistributable artifacts can be pushed, using the format `<hostname>[:<port>]` or `<IP address>[:<port>]`.  Some images (for example, Windows base images) contain artifacts whose distribution is restricted by license. When these images are pushed to a registry, restricted artifacts are not included.  This configuration override this behavior for the specified registries.  This option is useful when pushing images containing nondistributable artifacts to a registry on an air-gapped network so hosts on that network can pull the images without connecting to another server.  > **Warning**: Nondistributable artifacts typically have restrictions > on how and where they can be distributed and shared. Only use this > feature to push artifacts to private registries and ensure that you > are in compliance with any terms that cover redistributing > nondistributable artifacts.  | No |
| InsecureRegistryCIDRs | [ string ] | List of IP ranges of insecure registries, using the CIDR syntax ([RFC 4632](https://tools.ietf.org/html/4632)). Insecure registries accept un-encrypted (HTTP) and/or untrusted (HTTPS with certificates from unknown CAs) communication.  By default, local registries (`127.0.0.0/8`) are configured as insecure. All other registries are secure. Communicating with an insecure registry is not possible if the daemon assumes that registry is secure.  This configuration override this behavior, insecure communication with registries whose resolved IP address is within the subnet described by the CIDR syntax.  Registries can also be marked insecure by hostname. Those registries are listed under `IndexConfigs` and have their `Secure` field set to `false`.  > **Warning**: Using this option can be useful when running a local > registry, but introduces security vulnerabilities. This option > should therefore ONLY be used for testing purposes. For increased > security, users should add their CA to their system's list of trusted > CAs instead of enabling this option.  | No |
| IndexConfigs | object |  | No |
| Mirrors | [ string ] | List of registry URLs that act as a mirror for the official (`docker.io`) registry.  | No |

#### IndexInfo

IndexInfo contains information about a registry.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Name | string | Name of the registry, such as "docker.io".  | No |
| Mirrors | [ string ] | List of mirrors, expressed as URIs.  | No |
| Secure | boolean | Indicates if the registry is part of the list of insecure registries.  If `false`, the registry is insecure. Insecure registries accept un-encrypted (HTTP) and/or untrusted (HTTPS with certificates from unknown CAs) communication.  > **Warning**: Insecure registries can be useful when running a local > registry. However, because its use creates security vulnerabilities > it should ONLY be enabled for testing purposes. For increased > security, users should add their CA to their system's list of > trusted CAs instead of enabling this option.  | No |
| Official | boolean | Indicates whether this is an official registry (i.e., Docker Hub / docker.io)  | No |

#### Runtime

Runtime describes an [OCI compliant](https://github.com/opencontainers/runtime-spec)
runtime.

The runtime is invoked by the daemon via the `containerd` daemon. OCI
runtimes act as an interface to the Linux kernel namespaces, cgroups,
and SELinux.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| path | string | Name and, optional, path, of the OCI executable binary.  If the path is omitted, the daemon searches the host's `$PATH` for the binary and uses the first result.  | No |
| runtimeArgs | [ string ] | List of command-line arguments to pass to the runtime when invoked.  | No |

#### Commit

Commit holds the Git-commit (SHA1) that a binary was built from, as
reported in the version-string of external tools, such as `containerd`,
or `runC`.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| ID | string | Actual commit ID of external tool. | No |
| Expected | string | Commit ID of external tool expected by dockerd as set at build time.  | No |

#### SwarmInfo

Represents generic information about swarm.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| NodeID | string | Unique identifier of for this node in the swarm. | No |
| NodeAddr | string | IP address at which this node can be reached by other nodes in the swarm.  | No |
| LocalNodeState | [LocalNodeState](#LocalNodeState) |  | No |
| ControlAvailable | boolean |  | No |
| Error | string |  | No |
| RemoteManagers | [ [PeerNode](#PeerNode) ] | List of ID's and addresses of other managers in the swarm.  | No |
| Nodes | integer | Total number of nodes in the swarm. | No |
| Managers | integer | Total number of managers in the swarm. | No |
| Cluster | [ClusterInfo](#ClusterInfo) |  | No |

#### LocalNodeState

Current local status of this node.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| LocalNodeState | string | Current local status of this node. |  |

#### PeerNode

Represents a peer-node in the swarm

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| NodeID | string | Unique identifier of for this node in the swarm. | No |
| Addr | string | IP address and ports at which this node can be reached.  | No |

#### NetworkAttachmentConfig

Specifies how a service should be attached to a particular network.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Target | string | The target network for attachment. Must be a network name or ID.  | No |
| Aliases | [ string ] | Discoverable alternate names for the service on this network.  | No |
| DriverOpts | object | Driver attachment options for the network target.  | No |

#### EventActor

Actor describes something that generates events, like a container, network,
or a volume.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| ID | string | The ID of the object emitting the event | No |
| Attributes | object | Various key/value attributes of the object, depending on its type.  | No |

#### EventMessage

EventMessage represents the information an event contains.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Type | string | The type of object emitting the event | No |
| Action | string | The type of event | No |
| Actor | [EventActor](#EventActor) |  | No |
| scope | string | Scope of the event. Engine events are `local` scope. Cluster (Swarm) events are `swarm` scope.  | No |
| time | long | Timestamp of event | No |
| timeNano | long | Timestamp of event, with nanosecond accuracy | No |

#### OCIDescriptor

A descriptor struct containing digest, media type, and size, as defined in
the [OCI Content Descriptors Specification](https://github.com/opencontainers/image-spec/blob/v1.0.1/descriptor.md).


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| mediaType | string | The media type of the object this schema refers to.  | No |
| digest | string | The digest of the targeted content.  | No |
| size | long | The size in bytes of the blob.  | No |

#### OCIPlatform

Describes the platform which the image in the manifest runs on, as defined
in the [OCI Image Index Specification](https://github.com/opencontainers/image-spec/blob/v1.0.1/image-index.md).


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| architecture | string | The CPU architecture, for example `amd64` or `ppc64`.  | No |
| os | string | The operating system, for example `linux` or `windows`.  | No |
| os.version | string | Optional field specifying the operating system version, for example on Windows `10.0.19041.1165`.  | No |
| os.features | [ string ] | Optional field specifying an array of strings, each listing a required OS feature (for example on Windows `win32k`).  | No |
| variant | string | Optional field specifying a variant of the CPU, for example `v7` to specify ARMv7 when architecture is `arm`.  | No |

#### DistributionInspect

Describes the result obtained from contacting the registry to retrieve
image metadata.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Descriptor | [OCIDescriptor](#OCIDescriptor) |  | Yes |
| Platforms | [ [OCIPlatform](#OCIPlatform) ] | An array containing all platforms supported by the image.  | Yes |

#### ClusterVolume

Options and information specific to, and only present on, Swarm CSI
cluster volumes.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| ID | string | The Swarm ID of this volume. Because cluster volumes are Swarm objects, they have an ID, unlike non-cluster volumes. This ID can be used to refer to the Volume instead of the name.  | No |
| Version | [ObjectVersion](#ObjectVersion) |  | No |
| CreatedAt | string (dateTime) |  | No |
| UpdatedAt | string (dateTime) |  | No |
| Spec | [ClusterVolumeSpec](#ClusterVolumeSpec) |  | No |
| Info | object | Information about the global status of the volume.  | No |
| PublishStatus | [ object ] | The status of the volume as it pertains to its publishing and use on specific nodes  | No |

#### ClusterVolumeSpec

Cluster-specific options used to create the volume.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Group | string | Group defines the volume group of this volume. Volumes belonging to the same group can be referred to by group name when creating Services.  Referring to a volume by group instructs Swarm to treat volumes in that group interchangeably for the purpose of scheduling. Volumes with an empty string for a group technically all belong to the same, emptystring group.  | No |
| AccessMode | object | Defines how the volume is used by tasks.  | No |

#### Topology

A map of topological domains to topological segments. For in depth
details, see documentation for the Topology object in the CSI
specification.


| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Topology | object | A map of topological domains to topological segments. For in depth details, see documentation for the Topology object in the CSI specification.  |  |