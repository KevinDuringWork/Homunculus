# Homunculus

Quick script to spike in SNVs into NA12878. 

1. Get project (git clone https://github.com/KevinDuringWork/Homunculus.git) 
2. Run install-ammonite.sh 
    * Will download Ammonite (runs script)
 
3. Run install-assemblies.sh
    * Will download GRCh37 assembly (fasta) + index (3GB)  
    * Will download GRCh38 assembly (fasta) + index (3GB) 

4. Run install-references.sh 
    * Will download NA12878 (GRCh37) (vcf) + index (128MB) 
    * Will download NA12878 (GRCh38) (vcf) + index (128MB)     

2. Edit input (spike-in.csv) 
    * Indicies are CHROM, POS, ALT, GT (0/1, 1/1) 

3. Run script 
    * sh run.sh GRCH37
    * sh run.sh GRCH38 

4. Output to spike-in.GRCH37.vcf.gz / spike-in.GRCH38.vcf.gz 

__USE for nefarious purposes ONLY!__ 
