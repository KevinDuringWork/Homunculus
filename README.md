# Homunculus

Quick script to spike in SNVs into NA12878. 

1. Get project (git clone https://github.com/KevinDuringWork/Homunculus.git) 
1. Run install.sh (sh install.sh)
    * Will download Ammonite (runs script) 
    * Will download GRCh37 genome (fasta) + index (3GB)  
    * Will download NA12878 (vcf) + index (128MB) 

2. Edit input (spike-in.csv) 
    * Indicides are CHROM, POS, ALT, GT (0/1, 1/1) 

3. Run script (sh run.sh) 
4. Output to spike-in.vcf.gz 

__USE for nefarious purposes ONLY!__ 
