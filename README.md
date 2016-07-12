# TESS3 article scripts

R scripts and data used for the TESS3 article. Each figure code are kept in
correspondant subdirectory.

## Docker image

A docker image is provided and can be run using this command:
```
make run
```
This image embed the software environment used for this scripts

## Run scripts

Each figure subdirectory contain the following subdirectory.

### Experiments

You can build experiments whith this command line:
```
make figures
```
However, running these scripts can be long. You can also download their results
(see the section Download binary data)

### Figures

You can build figure whith this command line:
```
make experiments
```

### Rmarkdown

You can build rmarkdowns documents whith this command line:
```
make rmarkdowns
```

## Downlaod binary data

Data and long running script results can be downloaded using this command:
```
make pull_binary
```
