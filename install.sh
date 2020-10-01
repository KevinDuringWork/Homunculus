#!/bin/bash

printf "Setup Ammonite (ammonite.io)\n"
curl -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.89 Safari/537.36" -L  https://github.com/lihaoyi/Ammonite/releases/download/2.1.1/2.13-2.1.1-bootstrap > amm && chmod +x amm

printf ""
printf "Downloading GRCh37 Reference Assembly (FASTA)\n" 
wget http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch37/reference_genome.fa -O GRCh37.genome.fa 
wget http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch37/reference_genome.fa.fai -O GRCh37.genome.fa.fai

printf "\n"
printf "Downloading GRCh38 Reference Assembly (FASTA)\n" 
wget http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch38/reference_genome.fa -O GRCh38.genome.fa
wget http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch38/reference_genome.fa.fai -O GRCh38.genome.fa.fai 

printf "\n"
printf "Installed"
