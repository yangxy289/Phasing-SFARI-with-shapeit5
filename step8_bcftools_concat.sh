#!/bin/sh

input_path="./chunk_phased"
output_path="./output"

mkdir -p $output_path/QC_phased_common_rare
final_phased_path=$output_path/QC_phased_common_rare
chunk_vcf=$output_path/chunk_vcf

for chr in $(seq 1 22); do
        echo "processing chr: chr$chr"

        > $input_path/QC_phased_common_rare_chunks_chr$chr.txt
        for chunk in $(awk '{print$1}' $chunk_vcf/QC_chunks_chr$chr.txt); do
                echo "processing chunk: $chunk"
                echo $input_path/phased_chr$chr/QC_common_rare_chunk${chunk}_chr$chr.bcf >> $input_path/QC_phased_common_rare_chunks_chr$chr.txt
                echo "done chunk$chunk"
        done

        bcftools concat -n -Ob -o $final_phased_path/QC_phased_common_rare_chr$chr.bcf -f $input_path/QC_phased_common_rare_chunks_chr$chr.txt --thread 50
        echo "done bcftools concat"
        bcftools index $final_phased_path/QC_phased_common_rare_chr$chr.bcf
        echo "done bcftools index"
done
