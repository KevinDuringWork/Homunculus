# Homunculus

Quick script to spike in SNVs into NA12878 with just Scala. 

Equivalent to bcftools commands, but using htsjdk. 
Manual editting of VCF introduces syntax errors easily.

Example: 
```
# Generate a template  
bcftools view -h NA12878.GRCh38.vcf.gz > header.vcf
bcftools view --no-header NA12878.GRCh38.vcf.gz | head -1 >> header.vcf
cp header.vcf AR1.vcf

# (.. manually .. edit fields AR1.vcf)
bgzip AR1.vcf && tabix AR1.vcf.gz 
bcftools concat -a -o AR1.merged.vcf.gz -O z NA12878.GRCh38.vcf.gz AR1.vcf.gz
```

1. Get project (git clone https://github.com/KevinDuringWork/Homunculus.git) 

2. Run scala-cli: https://scala-cli.virtuslab.org/install/ 

3. Run download.sh (bash download.sh)
    * Will download GRCh38 assembly (fasta) + index (3GB) 
    * Will download NA12878 

2. Edit input (spike-in.csv) 
    * Indicies are CHROM, POS, ALT, GT (0/1 or 1/1) 

3. Run script (bash run.sh)
    * Will output to spike-in.GRCh38.vcf.gz 

__USE for nefarious purposes ONLY!__ 
