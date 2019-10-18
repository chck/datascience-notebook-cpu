NAME:=chck/datascience-notebook-cpu
TAG:=python37
IMAGE:=$(NAME):$(TAG)
LATEST:=$(NAME):latest
_:=$(shell direnv allow)

.PHONY: all
all: help

.PHONY: passwd  ## Generate hashed password
passwd:
	docker run --rm -it $(LATEST) "python3 -c 'from notebook.auth import passwd;print(passwd())'"

.PHONY: build  ## Build image
build:
	docker build -t $(IMAGE) -t $(LATEST) .

.PHONY: push  ## Push image
push:
	docker push $(IMAGE)
	docker push $(LATEST)

.PHONY: run  ## Run JupyterLab
run:
	docker run -d --rm -it -p 8887:8888 -v $(LOCAL_NOTEBOOK_DIR):/notebooks $(LATEST) "jupyter lab --notebook-dir=/notebooks --no-browser --allow-root --NotebookApp.password=$(NOTEBOOK_PASSWD)"
	@echo "http://(127.0.0.1 or CONTAINER_REMOTE_IP):8887 is ready!"

.PHONY: help ## View help
help:
	@grep -E '^.PHONY: [a-zA-Z_-]+.*?## .*$$' $(MAKEFILE_LIST) | sed 's/^.PHONY: //g' | awk 'BEGIN {FS = "## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
