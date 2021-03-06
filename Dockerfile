FROM r-base:3.3.3

RUN apt-get update
RUN apt-get install -y libssl-dev
RUN apt-get install -y libcurl4-gnutls-dev
RUN apt-get install -y libxml2-dev

RUN apt-get install -y python3-pip
RUN pip3 install luigi

RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages('tidyverse')"
RUN Rscript -e "install.packages('argparser')"
RUN Rscript -e "install.packages('feather')"
RUN Rscript -e "install.packages('rstan')"
RUN Rscript -e "install.packages('parallel')"
RUN Rscript -e "install.packages('viridis')"
RUN Rscript -e "install.packages('reshape2')"
RUN Rscript -e "install.packages('data.table')"
RUN Rscript -e "install.packages('devtools')"
RUN Rscript -e "devtools::install_github('krisrs1128/ggscaffold')"
RUN Rscript -e "devtools::install_github('krisrs1128/nmfSim')"
RUN Rscript -e "devtools::install_github('krisrs1128/boot_expers/ldaSim')"
RUN Rscript -e "source('http://bioconductor.org/biocLite.R'); biocLite('phyloseq')"

COPY README.md /home/
COPY src/ /home/src/
COPY data/antibiotics-study/abt.rda /home/data/antibiotics-study/abt.rda