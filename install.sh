#!/bin/bash

printf "\n"
printf "Downloading GRCh38 Reference Assembly (FASTA)\n" 
wget http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch38/reference_genome.fa -O GRCh38.genome.fa
wget http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch38/reference_genome.fa.fai -O GRCh38.genome.fa.fai 

printf "\n"
printf "Installed Assemblies"
printf "Downloading NA12878-GRCh38 (VCF)\n"
wget https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/NA12878_HG001/latest/GRCh38/HG001_GRCh38_1_22_v4.2.1_benchmark.vcf.gz -O NA12878.GRCh38.vcf.gz
wget https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/NA12878_HG001/latest/GRCh38/HG001_GRCh38_1_22_v4.2.1_benchmark.vcf.gz.tbi -O NA12878.GRCh38.vcf.gz.tbi

printf "Done"
