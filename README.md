# TESS3 article scripts

R scripts, data and latex script used for the TESS3 article.

## Docker image

We provide a docker image which embed the software environment used for this project. Thus every build command can be run in the docker container. You can run a the container shell with this command lines:
```
make docker_run
make docker_shell
```

## How to run R scripts

Each figure subdirectory contain the following subdirectory.

### Experiments

You can build experiments with this command line:
```
make experiments
```
However, running these scripts can be long. You can also download their results
(see the section [How to download binary data](## How to download binary data))

### Figures

You can build article figures with this command line:
```
make figures
```

### Rmarkdown

You can build rmarkdowns documents with this command line:
```
make rmarkdowns
```

## How to download binary data

Data and long running script results can be downloaded using this command:
```
make pull_binary
```

## How to compile the article

The latex sources of the article can be compiled using this command:
```
make article
```
## How to reproduce everything
steps :
- install docker
- run containter
- download data
- run experiments scripts (if you have time and a big machin)
- compile article
