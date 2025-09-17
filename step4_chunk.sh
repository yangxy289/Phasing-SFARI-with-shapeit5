#!/bin/sh

input_path="./QC_multiallelics"
output_path="./output"
map_path="./genetic_maps.b38"

mkdir -p $output_path/chunk_vcf
chunk_vcf=$output_path/chunk_vcf

for chr in $(seq 1 22); do
        echo "processing chr: chr$chr"
        /XYFS01/sysu_liusy_2/USER/yangxuanyan/software/glimpse/chunk --input $input_path/ACAFANGT_FMISSING_multiallelics_chr$chr.vcf.gz --map $map_path/chr$chr.b38.gmap.gz --region chr$chr --sequential --output $chunk_vcf/QC_chunks_chr${chr}.txt --threads 50
done
