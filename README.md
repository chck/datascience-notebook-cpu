# datascience-notebook-cpu
Ready-to-run Docker images containing JupyterLab on **CPU**

[![dockeri.co](https://dockeri.co/image/chck/datascience-notebook-cpu)](https://hub.docker.com/r/chck/datascience-notebook-cpu)

If you have some **NVIDIA GPUs**, I suggest to use [datascience-notebook-gpu](https://hub.docker.com/r/chck/datascience-notebook-gpu) instead of this.

## Requirements
```
docker==19.03.*
direnv==2.15.*
```

## Included Python Packages
https://github.com/chck/datascience-notebook-cpu/blob/master/Pipfile

## Usage

### Pull image
```
docker pull chck/datascience-notebook-cpu
```

### Generate hashed password
```shell
make passwd

>Enter password:
>Verify password:
>sha1:xxxxxxxxxxxxxxxxxxx
```

### Apply hashed password via direnv with dotenv
```
vi .env
=====
NOTEBOOK_PASSWD=sha1:xxxxxxxxxxxxxxxxxxx
LOCAL_NOTEBOOK_DIR=/path/to/dir/
```

```
direnv allow .
```

### Run container
```
make run
```

### Access JupyterLab
```
open http://(127.0.0.1 or CONTAINER_REMOTE_IP):8887
```
