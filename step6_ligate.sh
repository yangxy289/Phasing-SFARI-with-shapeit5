#!/bin/sh

input_path="./output"
output_path="./tmp_scaffold"
map_path="./genetic_maps.b38"
fam_path="./SSC_WGS_phasing.fam"

mkdir -p $input_path/chunk_vcf
chunk_vcf=$input_path/chunk_vcf

for chr in $(seq 1 22); do
        echo "processing chr: chr$chr"

        > $chunk_vcf/QC_scaffold_chunks_chr$chr.txt
        for chunk in $(awk '{print$1}' $chunk_vcf/QC_chunks_chr$chr.txt); do
                echo "processing chunk: $chunk"
                echo $output_path/QC_scaffold_chunk${chunk}_chr$chr.bcf >> $chunk_vcf/QC_scaffold_chunks_chr$chr.txt
                echo "done chunk$chunk"
        done

        ligate --input $chunk_vcf/QC_scaffold_chunks_chr$chr.txt --pedigree $fam_path --output $output_path/QC_scaffold_chr$chr.bcf --thread 50
        echo "done ligate"
        bcftools index $output_path/QC_scaffold_chr$chr.bcf
        echo "done bcftools index"
done
