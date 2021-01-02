# AWSBPM Docker Image ALL IN ONE

通过Docker快速部署一个AWSBPM服务实例

## Quick Start

快速部署一个服务实例

```bash
docker run -d --name awspaas \
    -v awspaas_database:/var/lib/mysql \
    -v awspaas_doccenter:/AWSBPM/doccenter \
    -v awspaas_apps:/AWSBPM/apps \
    registry.cn-beijing.aliyuncs.com/c521wy/awsbpm:6.3.GA-all-in-one
```

快速部署一个本地开发环境实例

```bash
docker run -it --name awspaas-dev \
    -v awspaas-dev_database:/var/lib/mysql \
    -v awspaas-dev_doccenter:/AWSBPM/doccenter \
    -v /path/to/server.xml:/AWSBPM/bin/conf/server.xml \
    -v /path/to/apps:/AWSBPM/apps \
    -e USE_EXTERNAL_DATABASE=true \
    registry.cn-beijing.aliyuncs.com/c521wy/awsbpm:6.3.GA-all-in-one
```

[docker-compose.yml](https://raw.githubusercontent.com/c521wy/docker-awsbpm/6.3.GA-all-in-one/docker-compose.yml)

## 服务控制

服务列表

| 服务名 | 说明 |
| -- | -- |
| db | 数据库服务 |
| app | 平台app服务 |
| web | 平台web服务 |

服务控制

- 启动服务：docker exec awspaas supervisorctl start `SERVICE_NAME`
- 重启服务：docker exec awspaas supervisorctl restart `SERVICE_NAME`
- 停止服务：docker exec awspaas supervisorctl stop `SERVICE_NAME`

## 平台配置

- 平台安装路径：`/AWSBPM`

## 环境变量配置

| 变量 | 说明 |
| -- | -- |
| DB_AUTO_START | 是否自动启动db服务，默认值为`true`，设置为其他值可阻止服务自启动 |
| USE_EXTERNAL_DATABASE | 是否使用外部数据源，默认值为`false`。使用外部数据源需挂载使用自定义`server.xml`文件。当使用外部数据源时同时也会阻止db服务自动启动 |
| APP_AUTO_START | 是否自动启动app服务，默认值为`true`，设置为其他值可阻止服务自启动 |
| WEB_AUTO_START | 是否自动启动web服务，默认值为`true`，设置为其他值可阻止服务自启动 |

## Volumes

| volume | 说明 |
| -- | -- |
| `/var/lib/mysql` | MySQL数据文件 |
| `/AWSBPM/apps` | 平台应用安装目录 |
| `/AWSBPM/doccenter` | 平台附件存储目录 |
