FROM cayek/dojo:latest

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

#WORKDIR /root

#ADD https://github.com/Ensembl/ensembl-tools/archive/release/84.zip /root/

#RUN apt-get update && \
#    apt-get install -y unzip tabix curl && \
#    unzip 84.zip && \
#    rm 84.zip

#RUN cpan Archive::Extract DBI CGI Archive::Zip File::Copy::Recursive   # JSON Sereal -- these 2 additional perl modules are used by VEP tests. Leaving them out for now until they re needed

#RUN cd /root/ensembl-tools-release-84/scripts/variant_effect_predictor && \
#    perl INSTALL.pl --AUTO ap --PLUGINS all --NO_HTSLIB

################################################################################
# R package

## Install some external dependencies.
RUN apt-get update \
  && apt-get install -y libcurl4-openssl-dev libgdal1-dev libproj-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds


RUN install2.r --error \
		data.table \
    maps \
    ggplot2 \
		ggthemes \
    reshape2 \
    dplyr \
    gridExtra \
    cowplot \
    ggmap \
    xtable \
    devtools \
    tikzDevice \
    raster \
    sp \
    rgeos \
    rgdal \
    cartography \
    leaflet \
    foreach \
    doParallel \
    DescTools \
    permute \
    rworldmap \
    rasterVis \
		crayon \
		MASS \
		Rcpp \
		lintr \
		lint

RUN R -e 'devtools::install_github("BioShock38/TESS3_encho_sen@8e4b4cc87e12ceeb21d3b768564ed3a7bd17737c")'
RUN R -e 'devtools::install_github("BioShock38/TESS3_encho_sen@e0fac131439ef856171d778f8ed94cfbc63f1c41")'
RUN R -e 'source("https://bioconductor.org/biocLite.R");biocLite("qvalue");biocLite("LEA")'
# RUN R -e 'devtools::install_github("cayek/TESS3/tess3r@093d62e68e376384cd6f6b6fc5790dcf0db7c2cd")'
# do not pass why ?

################################################################################
# additional latex packages

RUN apt-get update && apt-get install -y texlive-science

RUN tlmgr init-usertree \
&& tlmgr option repository ftp://tug.org/historic/systems/texlive/2013/tlnet-final \
     && tlmgr --no-persistent-downloads update --all \
     && tlmgr --no-persistent-downloads install mathdesign \
     && tlmgr --no-persistent-downloads install babel-french \
     && tlmgr --no-persistent-downloads install graphics-def \
     && tlmgr --no-persistent-downloads install xcolor \
     &&	tlmgr --no-persistent-downloads install preview \
     &&	tlmgr --no-persistent-downloads install tikz-cd \
     &&	tlmgr --no-persistent-downloads install pgf \
     && tlmgr --no-persistent-downloads install ifmtarg \
     && tlmgr --no-persistent-downloads install xifthen \
     && tlmgr --no-persistent-downloads install lineno \
     && tlmgr --no-persistent-downloads install lettrine \
     && tlmgr --no-persistent-downloads install datetime \
     && tlmgr --no-persistent-downloads install etoolbox \
     && tlmgr --no-persistent-downloads install fmtcount \
     && tlmgr --no-persistent-downloads install enumitem \
     && tlmgr --no-persistent-downloads install authblk \
     && tlmgr --no-persistent-downloads install lineno
