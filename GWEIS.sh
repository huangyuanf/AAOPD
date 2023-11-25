#!/bin/bash
##############
##extract genotype information of patients of parkinson's disease with smoking information
##############
cd ${input_path}
${plink_path}/plink2 --bgen chr{1..22}.bgen --export bgen-1.2 --out filter_chr{1..22}.bgen --keep pd --sample chr{1..22}.sample
export file=`ls ~/*.bgen`
~/bgen.tgz/bin/cat-bgen -g ${file} -og merge_chr.bgen -clobber
~/bgen.tgz/bin/bgenix -g  merge_chr.bgen  -index -clobber

##############
##filter bgen file 
##############
cd ${input_path}
${plink_path}/plink2 --bgen ${input_path}/merge_chr.bgen --maf 0.01 --geno 0.05 --mind 0.05 --hwe 1e-6 --make-bed --out {output_path}/filter

##############
##Run GWEIS and clean output file
##############
cd ${input_path}
${plink_path}/plink2 --bfile filter --keep keeppd --covar cova.txt --pheno pheno.txt --linear interaction --covar-name SMOKE,SEX,T,AAE,PCA1,PCA2,PCA3,PCA4 --pheno-name AAO --parameters 1,2,10 --out GWEIS_out_filter

cat GWEIS_out_filter.AAO.glm.linear |grep -w ADDxSMOKE > SMOKE_AAO_interaction.txt
awk -v OFS="\t" '{prit$3,$1,$2,$NF}' SMOKE_AAO_interaction.txt > manh
