#!/bin/sh

input_path="./QC_multiallelics"
output_path="./output"
map_path="./genetic_maps.b38"
fam_path="./SSC_WGS_phasing.fam"

mkdir -p $output_path/tmp_scaffold
scaffold_path=$output_path/tmp_scaffold
chunk_path=$output_path/chunk_vcf

for chr in $(seq 1 22); do
        echo "processing chr: $chr"
        while read LINE; do
                CHK=$(echo $LINE | awk '{ print $1; }')
                IRG=$(echo $LINE | awk '{ print $4; }')
                echo "processing chunk: $CHK"
                phase_common --input $input_path/ACAFANGT_FMISSING_multiallelics_chr$chr.vcf.gz --filter-maf 0.001 --pedigree $fam_path --region $IRG --map $map_path/chr$chr.b38.gmap.gz --output $scaffold_path/QC_scaffold_chunk${CHK}_chr$chr.bcf --thread 50
                echo "done phase_common"
        done < $chunk_path/QC_chunks_chr$chr.txt
done
