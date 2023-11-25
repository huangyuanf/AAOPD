#!/bin/bash
##extract individuals with 
##filter 
cd ${input_path}
${input_path}/plink2 --bgen ${input_path}/smoke.bgen --maf 0.01 --geno 0.05 --mind 0.05 --hwe 1e-6 --make-bed --out {output_path}/filter

##Run GWEIS and clean output file
cd ${input_path}
${input_path}plink2 --bfile filter --keep keeppd --covar cova.txt --pheno pheno.txt --linear interaction --covar-name SMOKE,SEX,T,AAE,PCA1,PCA2,PCA3,PCA4 --pheno-name AAO --parameters 1,2,10 --pfilter 5e-6 --1 --out GWEIS_out_filter

cat 
