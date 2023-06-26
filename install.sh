#!/bin/bash

printf "\n"
printf "Downloading GRCh38 Reference Assembly (FASTA)\n" 
curl http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch38/reference_genome.fa --output GRCh38.genome.fa
curl http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch38/reference_genome.fa.fai --output GRCh38.genome.fa.fai 

printf "\n"
printf "Downloading NA12878-GRCh38 (VCF)\n"
curl https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/NA12878_HG001/latest/GRCh38/HG001_GRCh38_1_22_v4.2.1_benchmark.vcf.gz --output NA12878.GRCh38.vcf.gz
curl https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/NA12878_HG001/latest/GRCh38/HG001_GRCh38_1_22_v4.2.1_benchmark.vcf.gz.tbi --output NA12878.GRCh38.vcf.gz.tbi

# TODO add Trios 

printf "Done"
