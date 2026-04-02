# otus-docker-dz
#### Задание:
- Создать свой кастомный образ nginx на базе alpine. После запуска nginx должен отдавать кастомную страницу (достаточно изменить дефолтную страницу nginx).
- Определена разница между контейнером и образом, написан вывод.
- Написан ответ на вопрос: Можно ли в контейнере собрать ядро?
- Собранный образ запушин в docker hub и дана ссылку на репозиторий.\
Контейнер - запущенная "программа", рабочий процесс в системе, потребляет ресурсы. Образ - файл на диске (архив).  
Поскольку в образ можно скопировать любые файлы и каталоги, не вижу проблем со сборкой ядра.<br>

#### Код:
```
u24@Ubuntu22:~/Docker$ sudo docker image build otusdz
[+] Building 0.0s (0/0)                                           docker:default
ERROR: failed to build: unable to prepare context: path "otusdz" not found
u24@Ubuntu22:~/Docker$ sudo docker image build .
[+] Building 55.5s (10/10) FINISHED                               docker:default
 => [internal] load build definition from Dockerfile                        0.0s
 => => transferring dockerfile: 177B                                        0.0s
 => [internal] load metadata for docker.io/library/alpine:latest            4.8s
 => [auth] library/alpine:pull token for registry-1.docker.io               0.0s
 => [internal] load .dockerignore                                           0.0s
 => => transferring context: 2B                                             0.0s
 => [1/4] FROM docker.io/library/alpine:latest@sha256:25109184c71bdad752c8  4.7s
 => => resolve docker.io/library/alpine:latest@sha256:25109184c71bdad752c8  0.0s
 => => sha256:a40c03cbb81c59bfb0e0887ab0b1859727075da7b9cc576a 611B / 611B  0.0s
 => => sha256:589002ba0eaed121a1dbf42f6648f29e5be55d5c8a6e 3.86MB / 3.86MB  4.1s
 => => sha256:25109184c71bdad752c8312a8623239686a9a2071e88 9.22kB / 9.22kB  0.0s
 => => sha256:59855d3dceb3ae53991193bd03301e082b2a7faa56a5 1.02kB / 1.02kB  0.0s
 => => extracting sha256:589002ba0eaed121a1dbf42f6648f29e5be55d5c8a6ee0f8e  0.4s
 => [internal] load build context                                           0.1s
 => => transferring context: 1.89kB                                         0.0s
 => [2/4] RUN apk add --no-cache python3                                   43.9s
 => [3/4] WORKDIR /app                                                      0.1s
 => [4/4] COPY index.html .                                                 0.0s
 => exporting to image                                                      1.6s
 => => exporting layers                                                     1.6s
 => => writing image sha256:111bb798d09e75889c90fac4f38c44a1522a25c4ed93a9  0.0s
u24@Ubuntu22:~/Docker$ sudo docker image tag 111bb798d09e otusdz
u24@Ubuntu22:~/Docker$ sudo docker images -a
                                                             i Info →   U  In Use
IMAGE                         ID             DISK USAGE   CONTENT SIZE   EXTRA
ksasha15/my-otus-repo:first   d5039192234e        224MB             0B
otusdz:latest                 111bb798d09e       49.4MB             0B
u24@Ubuntu22:~/Docker$ sudo docker images -a
                                                             i Info →   U  In Use
IMAGE                         ID             DISK USAGE   CONTENT SIZE   EXTRA
ksasha15/my-otus-repo:first   d5039192234e        224MB             0B
<untagged>                    111bb798d09e       49.4MB             0B

u24@Ubuntu22:~/Docker$ ss -tlnp
State    Recv-Q   Send-Q     Local Address:Port      Peer Address:Port  Process
LISTEN   0        4096             0.0.0.0:8000           0.0.0.0:*
LISTEN   0        4096       127.0.0.53%lo:53             0.0.0.0:*
LISTEN   0        64               0.0.0.0:42999          0.0.0.0:*
LISTEN   0        4096             0.0.0.0:40899          0.0.0.0:*
LISTEN   0        4096          127.0.0.54:53             0.0.0.0:*
LISTEN   0        4096             0.0.0.0:42483          0.0.0.0:*
LISTEN   0        4096             0.0.0.0:55773          0.0.0.0:*
LISTEN   0        244            127.0.0.1:5432           0.0.0.0:*
LISTEN   0        4096             0.0.0.0:52623          0.0.0.0:*
LISTEN   0        4096             0.0.0.0:111            0.0.0.0:*
LISTEN   0        511              0.0.0.0:80             0.0.0.0:*
LISTEN   0        64               0.0.0.0:2049           0.0.0.0:*
LISTEN   0        4096             0.0.0.0:22             0.0.0.0:*
LISTEN   0        100              0.0.0.0:25             0.0.0.0:*
u24@Ubuntu22:~/Docker$ sudo docker images
                                                             i Info →   U  In Use
IMAGE                         ID             DISK USAGE   CONTENT SIZE   EXTRA
ksasha15/my-otus-repo:first   d5039192234e        224MB             0B
ksasha15/otusdz:latest        111bb798d09e       49.4MB             0B    U
otusdz:latest                 111bb798d09e       49.4MB             0B    U
u24@Ubuntu22:~/Docker$ sudo docker push ksasha15/otusdz
Using default tag: latest
The push refers to repository [docker.io/ksasha15/otusdz]
f65dc5df682a: Pushed
a1d799bfcede: Pushed
fcc436cc7563: Pushed
989e799e6349: Mounted from ksasha15/nginx
latest: digest: sha256:eb2078267f199947a5db5a5cec4b441e9c6bd8ae77b013d1a961f4d47f909371 size: 1153
u24@Ubuntu22:~/Docker$
```

