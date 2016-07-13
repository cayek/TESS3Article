.PHONY : all run shell start stop rm build push \
rm_image pull rstudio-server push_binary pull_binary rm_binary test_deployment

all:

################################################################################
# docker
IMAGE_NAME = cayek/tess3_article:latest
CONTAINER_NAME = tess3_article

run:
	docker run -it --name $(CONTAINER_NAME) -w /data -v $(shell pwd):/data -d -P $(IMAGE_NAME)

shell:
	docker exec -it $(CONTAINER_NAME) zsh

rstudio-server:
	$(INTERNET_BROWSER) $(shell docker port $(CONTAINER_NAME) 8787) &

start:
	docker start $(CONTAINER_NAME)

stop:
	docker stop $(CONTAINER_NAME)

rm_container:
	docker rm $(CONTAINER_NAME)

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

BINARY_FILE_ALL = $(wildcard Figure4/Experiments/Results/*.RData Figure3/Experiments/Results/*.RData Figure2/Experiments/Results/*.RData Figure1/Experiments/Results/*.RData Figure5/Experiments/Results/TAIR9/*.RData Figure5/Experiments/Results/TAIR8/*.RData Data/AthalianaGegMapLines/call_method_75/*.RData)
# filter too big file
BINARY_FILE = $(filter-out Figure5/Experiments/Results/TAIR9/tess3.K110.rep5.RData, $(BINARY_FILE_ALL))

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

rm_binary:
	rm -i $(BINARY_FILE)

################################################################################
# deployment

test_deployment:
	Rscript testdeployment.R
