#!/bin/sh

input_path="./QC_F_MISSING"
output_path="./input"
fre_fasta=$output_path/Homo_sapiens_assembly38.fasta

mkdir -p $output_path/QC_multiallelics
mkdir -p $output_path/QC_multiallelics_dropped
multiallelics_path=$output_path/QC_multiallelics
multiallelics_path_dropped=$output_path/QC_multiallelics_dropped

for chr in $(seq 1 22); do
       echo "processing chr: $chr"
       bcftools norm --threads 50 --fasta-ref $fre_fasta --multiallelics -any -Oz -o $multiallelics_path/ACAFANGT_FMISSING_multiallelics_chr$chr.vcf.gz $input_path/ACAFANGT_FMISSING_chr$chr.vcf.gz
       echo "done bcftools norm"
       tabix -p vcf $multiallelics_path/ACAFANGT_FMISSING_multiallelics_chr$chr.vcf.gz
       echo "done tabix"

       bcftools isec -C $input_path/ACAFANGT_FMISSING_chr$chr.vcf.gz $multiallelics_path/ACAFANGT_FMISSING_multiallelics_chr$chr.vcf.gz --threads 50 -Oz -o $multiallelics_path_dropped/multiallelics_dropped_chr$chr.vcf.gz -w 1
       echo "done bcftools isec"
       tabix -p vcf $multiallelics_path_dropped/multiallelics_dropped_chr$chr.vcf.gz
       echo "done tabix"
done
