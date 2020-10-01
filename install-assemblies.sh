#!/bin/bash
printf ""
printf "Downloading GRCh37 Reference Assembly (FASTA)\n" 
wget http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch37/reference_genome.fa -O GRCh37.genome.fa 
wget http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch37/reference_genome.fa.fai -O GRCh37.genome.fa.fai

printf "\n"
printf "Downloading GRCh38 Reference Assembly (FASTA)\n" 
wget http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch38/reference_genome.fa -O GRCh38.genome.fa
wget http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch38/reference_genome.fa.fai -O GRCh38.genome.fa.fai 

printf "\n"
printf "Installed Assemblies"