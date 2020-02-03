# Gitea Helm Chart
A community [Gitea](https://gitea.com/) helm chart with a more powerful and extensible archtecture design for the long run 

## Installation

```
helm install --name caryyu/gitea
```

## Uninstallation

```
helm delete --purge gitea
```

## What Init-Container does

### Admin User

```
config:
  init:
    adminUser: caryyu
    adminPassword: caryyu
    adminEmail: caryyu@example.com
```

### SSO & Authentication

```
config:
  init:
    authEnabled: false
    authName: alicloud
    authProvider: openidConnect
    authKey: "xxxxxx"
    authSecret: "xxxxxx"
    authAutoDiscoverUrl: "https://oauth.aliyun.com/.well-known/openid-configuration"
```

## Configuration
The following tables list the configurable parameters of this chart and their default values.

| Parameter                     | Description           | Default               |
| ----------------------------- | --------------------- | --------------------- |
| image.repository              | the image name        | gitea/gitea           |
| image.tag                     | the image tag         | 1.9.3                 |
| image.pullPolicy              | k8s image pull policy | IfNotPresent          |
| replicaCount                  | number of replicas    | 1                     |
| podAnnotations                | pod's annotation      | {}                    |
| service.type                  | service type          | ClusterIP             |
| service.labels                | service labels        | []                    |
| service.annotations           | service annotations   | []                    |
| service.selector              | service selector      | []                    |
| mysql.enabled                 | mysql enabling        | true                  |
| mysql.image                   | mysql image name      | mysql                 |
| mysql.imageTag                | mysql image tag       | 5                     |
| mysql.mysqlUser               | mysql username        | gitea                 |
| mysql.mysqlPassword           | mysql password        | gitea                 |
| mysql.mysqlDatabase           | mysql database name   | gitea                 |
| mysql.mysqlAllowEmptyPassword | allow empty password  | false                 |
| mysql.timezone                | datbase time zone     | Asia/Shanghai         |
| mysql.persistence.enabled     | database pvc enabling | false                 |
| config.server.domain          | -                     | localhost             |
| config.server.rootUrl         | -                     | http://localhost:3000 |
| config.server.sshDomain       | -                     | localhost             |
| config.server.offlineMode     | -                     | false                 |
| config.database.dbType        | -                     | mysql                 |
| config.database.host          | -                     | gitea-mysql           |
| config.database.port          | -                     | 3306                  |
| config.database.name          | -                     | gitea                 |
| config.database.user          | -                     | gitea                 |
| config.database.passwd        | -                     | gitea                 |
| config.security.installLock   | -                     | true                  |
 