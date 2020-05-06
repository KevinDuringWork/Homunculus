#!/bin/bash

printf "Setup Ammonite (ammonite.io)\n"
curl -L  https://github.com/lihaoyi/Ammonite/releases/download/2.1.1/2.13-2.1.1-bootstrap > amm && chmod +x amm

printf "Downloading GRCh37 Reference Assembly (FASTA)\n" 
curl -L http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch37/GRCh37.p13.genome.fa > GRCh37.p13.genome.fa 
curl -L  http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch37/GRCh37.p13.genome.fa.fai > GRCh37.p13.genome.fa.fai

printf "Downloading NA12878 Variants (VCF)\n"
curl -L ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/NA12878_HG001/latest/GRCh37/HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_PGandRTGphasetransfer.vcf.gz > NA12878.vcf.gz

curl -L ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/NA12878_HG001/latest/GRCh37/HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_PGandRTGphasetransfer.vcf.gz.tbi > NA12878.vcf.gz.tbi

printf "Installed"
