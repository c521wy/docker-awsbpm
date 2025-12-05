# awsbpm docker image

## environment

| name                  | required | default | comment                                                                |
|-----------------------|:--------:|:-------:|------------------------------------------------------------------------|
| DB_AUTO_START         |    N     |  true   | auto start db service or not                                           |
| USE_EXTERNAL_DATABASE |    N     |  false  | use external datasource or not, can also prevent db service auto start |
| APP_AUTO_START        |    N     |  true   | auto start app service or not                                          |
| WEB_AUTO_START        |    N     |  true   | auto start web service or not                                          |

## volumes

| volume            | comment |
|-------------------|---------|
| /var/lib/mysql    |         |
| /AWSBPM/apps      |         |
| /AWSBPM/doccenter |         |

## expose

| port | comment          |
|------|------------------|
| 8088 | web              |
| 8000 | jvm remote debug |
| 3306 | mysql            |

## service control

| service_name | comment |
|--------------|---------|
| db           |         |
| app          |         |
| web          |         |

```shell
# service control
supervisorctl { start | stop | restart } { service_name }

# service status
supervisorctl status
```

## docker-compose

```yaml
services:
  awsbpm:
    image: git.hd.caiweiqiang.cn:5001/docker-images/awsbpm:6.3.ga-all-in-one
    environment:
      - DB_AUTO_START=true
      - USE_EXTERNAL_DATABASE=false
      - APP_AUTO_START=true
      - WEB_AUTO_START=true
    volumes:
      - mysql:/var/lib/mysql
      - apps:/AWSBPM/apps
      - doccenter:/AWSBPM/doccenter
    network_mode: bridge
    ports:
      - "8088:8088"
      - "8000:8000"
      - "3306:3306"

volumes:
  mysql:
  apps:
  doccenter:
```