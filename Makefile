.PHONY : all run shell start stop rm build force_rm push rm_image pull rstudio-server

all:

################################################################################
# docker
IMAGE_NAME = cayek/tess3_article:latest
CONTAINER_NAME = tess3_article

run:
	docker run -it --name $(CONTAINER_NAME) -w /data -v $(shell pwd):/data -d -P $(IMAGE_NAME)

shell:
	docker exec -it $(CONTAINER_NAME) bash

rstudio-server:
	$(INTERNET_BROWSER) $(shell docker port labnotebook 8787) &

start:
	docker start $(CONTAINER_NAME)

stop:
	docker stop $(CONTAINER_NAME)

rm:
	docker rm $(CONTAINER_NAME)

force_rm:
	docker rm -f $(CONTAINER_NAME)

build: Dockerfile
	docker build -t $(IMAGE_NAME) .

push:
	docker push $(IMAGE_NAME)

login:
	docker login --username=cayek --email=kevin-ca@club-internet.fr

rm_image:
	docker rmi -f $(IMAGE_NAME)

pull:
	docker pull $(IMAGE_NAME)

################################################################################
# binary

BINARY_FILE = Figure5/Experiments/Results/TAIR9/tess3K6.sigmaHeat1.5.RData Figure5/Experiments/Results/TAIR9/variogram.RData

push_binary: 
	git checkout binary
	git add $(BINARY_FILE)
	git commit -m "binary" 
	git push -f binary_remote binary:master
	git reset --soft HEAD~
	git reset
	git checkout master

pull_binary:
	git fetch git@github.com:cayek/TESS3ArticleBinary.git master --depth=1
	git merge FETCH_HEAD -m "binary"
	git reset --soft HEAD~
	git reset

