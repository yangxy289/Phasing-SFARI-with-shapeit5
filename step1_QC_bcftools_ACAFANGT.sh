#!/bin/sh

input_path="./SSC_WGS_pvcf"
output_path="./input"

mkdir -p $output_path/VCF_extract_ACAFANGT

for chr in $(seq 1 22); do
        echo "processing chr: $chr"
        bcftools annotate -x ^INFO/AC,^INFO/AF,^INFO/AN,^FORMAT/GT --threads 50 -Oz -o $output_path/VCF_extract_ACAFANGT/extract_ACAFANGT_chr$chr.vcf.gz $input_path/CCDG_9000JG_B01_GRM_WGS_2019-03-21_chr$chr.recalibrated_variants.flagged.vcf.gz
        echo "done bcftools"
        tabix -p vcf $output_path/VCF_extract_ACAFANGT/extract_ACAFANGT_chr$chr.vcf.gz
        echo "done tabix"
done
