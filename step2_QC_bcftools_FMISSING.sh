
########################## F_MISSING #######################
input_path="/XYFS01/sysu_liusy_2/USER/yangxuanyan/ASD/SSC/WGS/2.phasing/input/VCF_extract_ACAFANGT"
output_path="/XYFS01/sysu_liusy_2/USER/yangxuanyan/ASD/SSC/WGS/2.phasing/input"

mkdir -p $output_path/QC_F_MISSING
mkdir -p $output_path/QC_F_MISSING_dropped
F_MISSING_path=$output_path/QC_F_MISSING
F_MISSING_dropped_path=$output_path/QC_F_MISSING_dropped

for chr in $(seq 1 22); do
       echo "processing chr: $chr"
       bcftools view -e 'F_MISSING > 0.10' $input_path/extract_ACAFANGT_chr$chr.vcf.gz --threads 50 -Oz -o $F_MISSING_path/ACAFANGT_FMISSING_chr$chr.vcf.gz
       echo "done bcftools view"
       tabix -p vcf $F_MISSING_path/ACAFANGT_FMISSING_chr$chr.vcf.gz
       echo "done tabix"

       bcftools isec -C $input_path/extract_ACAFANGT_chr$chr.vcf.gz $F_MISSING_path/ACAFANGT_FMISSING_chr$chr.vcf.gz --threads 50 -Oz -o $F_MISSING_dropped_path/FMISSING_dropped_chr$chr.vcf.gz -w 1
       echo "done bcftools isec"
       tabix -p vcf $F_MISSING_dropped_path/FMISSING_dropped_chr$chr.vcf.gz
       echo "done tabix"
done
