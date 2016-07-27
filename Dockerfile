FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
################################################################################
# latex

RUN apt-get update && apt-get install -y --no-install-recommends \
	texlive \
	texlive-generic-recommended \
	texlive-latex-recommended \
	texlive-fonts-recommended \
	texlive-extra-utils \
	texlive-font-utils \
	texlive-xetex \
	texlive-luatex \
	fonts-lmodern \
	fonts-font-awesome \
  xzdec \
  latexmk \
	&& apt-get autoclean -y \
	&& apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*

# RUN tlmgr init-usertree \
#     && tlmgr install mathdesign \
#     && tlmgr install babel-french \
#     && tlmgr install graphics-def

################################################################################
# some classic packages
RUN apt-get update \
    && apt-get install -y \
    emacs \
    zsh \
    ssh \
    git \
    perl

# oh-my-zsh
RUN git clone git://github.com/bwithem/oh-my-zsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && chsh -s /bin/zsh
RUN sed -i -E "s/^ZSH_THEME=.*$/ZSH_THEME="af-magic"/" ~/.zshrc

################################################################################
# ensempl api

## change working directory
# WORKDIR $HOME

## install ensembl dependencies
RUN apt-get update && \
    apt-get install -y mysql-client libmysqlclient-dev libssl-dev
RUN cpan DBI DBD::mysql

## clone git repositories
RUN mkdir -p src
WORKDIR $HOME/src
RUN git clone https://github.com/bioperl/bioperl-live.git
WORKDIR $HOME/src/bioperl-live
RUN git checkout bioperl-release-1-6-901
WORKDIR $HOME/src
RUN git clone https://github.com/Ensembl/ensembl-git-tools.git
ENV PATH $HOME/src/ensembl-git-tools/bin:$PATH
RUN git ensembl --clone api
RUN git clone https://github.com/Ensembl/ensembl-tools.git

## update bash profile
RUN echo >> $HOME/.profile && \
echo '# set ensembl perl libraries' >> $HOME/.profile && \
echo PERL5LIB=\$PERL5LIB:$HOME/src/bioperl-live >> $HOME/.profile && \
echo PERL5LIB=\$PERL5LIB:$HOME/src/ensembl/modules >> $HOME/.profile && \
echo PERL5LIB=\$PERL5LIB:$HOME/src/ensembl-compara/modules >> $HOME/.profile && \
echo PERL5LIB=\$PERL5LIB:$HOME/src/ensembl-variation/modules >> $HOME/.profile && \
echo PERL5LIB=\$PERL5LIB:$HOME/src/ensembl-funcgen/modules >> $HOME/.profile && \
echo export PERL5LIB >> $HOME/.profile && \
echo >> $HOME/.profile && \
echo '# set ensembl tools in path' >> $HOME/.profile && \
echo PATH=$HOME/src/ensembl-git-tools/bin:\$PATH && \
echo PATH=$HOME/src/ensembl-tools/scripts/assembly_converter:\$PATH >> $HOME/.profile && \
echo PATH=$HOME/src/ensembl-tools/scripts/id_history_converter:\$PATH >> $HOME/.profile && \
echo PATH=$HOME/src/ensembl-tools/scripts/region_reporter:\$PATH >> $HOME/.profile && \
echo PATH=$HOME/src/ensembl-tools/scripts/variant_effect_predictor:\$PATH >> $HOME/.profile && \
echo export PATH >> $HOME/.profile

## setup environment
ENV PERL5LIB $PERL5LIB:$HOME/src/bioperl-live:$HOME/src/ensembl/modules:$HOME/src/ensembl-compara/modules:$HOME/src/ensembl-variation/modules:$HOME/src/ensembl-funcgen/modules
ENV PATH $HOME/src/ensembl-tools/scripts/assembly_converter:$HOME/src/ensembl-tools/scripts/id_history_converter:$HOME/src/ensembl-tools/scripts/region_reporter:$HOME/src/ensembl-tools/scripts/variant_effect_predictor:$PATH



################################################################################
# vep installation

WORKDIR /root

ADD https://github.com/Ensembl/ensembl-tools/archive/release/84.zip /root/

RUN apt-get update && \
    apt-get install -y unzip tabix curl && \
    unzip 84.zip && \
    rm 84.zip

RUN cpan Archive::Extract DBI CGI Archive::Zip File::Copy::Recursive   # JSON Sereal -- these 2 additional perl modules are used by VEP tests. Leaving them out for now until they re needed

RUN cd /root/ensembl-tools-release-84/scripts/variant_effect_predictor && \
    perl INSTALL.pl --AUTO ap --PLUGINS all --NO_HTSLIB

################################################################################
# R

################################################################################
# R package
#
# RUN R -e 'install.packages(c("data.table", \
#     "maps", \
#     "ggplot2", \
#     "reshape2", \
#     "dplyr", \
#     "gridExtra", \
#     "cowplot", \
#     "ggmap", \
#     "xtable", \
#     "devtools", \
#     "tikzDevice", \
#     "raster", \
#     "sp", \
#     "rgeos", \
#     "rgdal", \
#     "cartography", \
#     "leaflet" \
#     "foreach", \
#     "doParallel", \
#     "DescTools", \
#     "permute", \
#     "rworldmap", \
#     "rasterVis"))'
#
# RUN R -e 'devtools::install_github("BioShock38/TESS3_encho_sen@8e4b4cc87e12ceeb21d3b768564ed3a7bd17737c")'
# RUN R -e 'devtools::install_github("cayek/TESS3/tess3r@experiment")'
# RUN R -e 'devtools::install_github("BioShock38/TESS3_encho_sen@e0fac131439ef856171d778f8ed94cfbc63f1c41")'
# RUN R -e 'source("https://bioconductor.org/biocLite.R");biocLite("qvalue");biocLite("LEA")'
