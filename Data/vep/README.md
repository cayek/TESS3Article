################################################################################
# TAIR 9 vep cache

## ddl data
- fasta file: 
 ftp://ftp.arabidopsis.org/home/tair/Genes/TAIR9_genome_release/TAIR9_chr_all.fas
- gene file:
 https://www.arabidopsis.org/download_files/Genes/TAIR9_genome_release/tair9_gff3/TAIR9_GFF3_genes.gff
 
## create vep cache
perl gtf2vep.pl -i TAIR9_GFF3_genes.gff -f TAIR9_chr_all.fas -d 84 -s arabidopsis_thaliana

################################################################################
# TAIR 10 vep cache

## ddl 
- ftp://ftp.ensemblgenomes.org/pub/plants/current/vep/arabidopsis_thaliana_vep_31_TAIR10.tar.gz