#!/bin/bash

printf "Setup Ammonite (ammonite.io)\n"
curl -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.89 Safari/537.36" -L  https://github.com/lihaoyi/Ammonite/releases/download/2.1.1/2.13-2.1.1-bootstrap > amm && chmod +x amm

printf ""
printf "Downloading GRCh37 Reference Assembly (FASTA)\n" 
wget http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch37/reference_genome.fa -O GRCh37.genome.fa 
wget http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch37/reference_genome.fa.fai -O GRCh37.genome.fa.fai

printf ""
printf "Downloading NA12878-GRCh37 (VCF)\n"
wget ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/NA12878_HG001/latest/GRCh37/HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_PGandRTGphasetransfer.vcf.gz -O NA12878.GRCh37.vcf.gz
wget ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/NA12878_HG001/latest/GRCh37/HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_PGandRTGphasetransfer.vcf.gz.tbi -O NA12878.GRCh37.vcf.gz.tbi

printf "\n"
printf "Downloading GRCh38 Reference Assembly (FASTA)\n" 
wget http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch38/reference_genome.fa -O GRCh38.genome.fa
wget http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch38/reference_genome.fa.fai -O GRCh38.genome.fa.fai 

printf "\n"
printf "Downloading NA12878-GRCh38 (VCF)\n"
wget ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/NA12878_HG001/latest/GRCh38/HG001_GRCh38_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_PGandRTGphasetransfer.vcf.gz -O NA12878.GRCh38.vcf.gz
wget ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/NA12878_HG001/latest/GRCh38/HG001_GRCh38_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_PGandRTGphasetransfer.vcf.gz.tbi -O NA12878.GRCh38.vcf.gz.tbi

printf "\n"
printf "Installed"
