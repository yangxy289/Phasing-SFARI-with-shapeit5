#!/bin/sh

vcf_path="./QC_multiallelics"
chunk_path="./chunk_vcf"
scaffold_path="./tmp_scaffold"
map_path="./genetic_maps.b38"
fam_path="./SSC_WGS_phasing.fam"
output_path="./chunk_phased"

mkdir -p $output_path

for chr in $(seq 1 22); do
        echo "processing chr: $chr"
        mkdir -p $output_path/phased_chr$chr

        while read LINE; do
                CHK=$(echo $LINE | awk '{ print $1; }')
                SRG=$(echo $LINE | awk '{ print $3; }')
                IRG=$(echo $LINE | awk '{ print $4; }')
                echo "processing: "
                echo "chunk: $CHK"
                echo "scaffold-region: $SRG"
                echo "input-region: $IRG"

                phase_rare --input $vcf_path/ACAFANGT_FMISSING_multiallelics_chr$chr.vcf.gz --scaffold $scaffold_path/QC_scaffold_chr$chr.bcf --pedigree $fam_path --map $map_path/chr$chr.b38.gmap.gz --input-region $IRG --scaffold-region $SRG --output $output_path/phased_chr$chr/QC_common_rare_chunk${CHK}_chr$chr.bcf --thread 50
                echo "done chunk$CHK"

        done < $chunk_path/QC_chunks_chr$chr.txt

done
