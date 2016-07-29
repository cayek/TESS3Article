.PHONY: all test_deployment figures

all:

################################################################################
# figures and article

figures:
	$(MAKE) figures -C Figure1
	$(MAKE) figures -C Figure2
	$(MAKE) figures -C Figure3
	$(MAKE) figures -C Figure4
	$(MAKE) figures -C Figure5

article: figures
	$(MAKE) -C Article

################################################################################
# docker
IMAGE_NAME = cayek/tess3_article:latest
CONTAINER_NAME = tess3_article

include	docker.mk

################################################################################
# binary

include	binary.mk

################################################################################
# deployment

test_deployment:
	Rscript testdeployment.R
