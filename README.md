# Homunculus

Quick script to spike in SNVs into NA12878. 

1. Get project (git clone https://github.com/KevinDuringWork/Homunculus.git) 

2. Run scala-cli: https://scala-cli.virtuslab.org/install/ 

3. Run download.sh (sh download.sh)
	* Will download GRCh38 assembly (fasta) + index (3GB) 
	* Will download NA12878 

2. Edit input (spike-in.csv) 
    * Indicies are CHROM, POS, ALT, GT (0/1 or 1/1) 

3. Run script 
    * sh run.sh GRCh38 

4. Output to spike-in.GRCh38.vcf.gz 

__USE for nefarious purposes ONLY!__ 
