#!/usr/bin/env bash

#######################################################################################################
# Generate input `bams` CSV file for stringtie and rMATS analysis using the splicing pipeline:
# https://github.com/TheJacksonLaboratory/splicing-pipelines-nf
# Requires:
  # Bash
  # Files:
    # input_sample_ids_path (`reads` file) - plain text file containing a header and list of sample IDs
#######################################################################################################

# Change
input_sample_ids_path="data/testdata/tcga/uuids.txt"
output_bams_csv_path="bams.csv"
team_id="5ec2c818d663c5c2cd3bd991"
user_id="5b59e0cf7cbd27320976585f"
project_id="5ef4c95b143fa0011331809d"
job_id="5f07058c143fa00113ada37b"

# Don't change
results_dir="gs://cloudosinputdata/deploit/teams/${team_id}/users/${user_id}/projects/${project_id}/jobs/${job_id}/results/results"
bams_dir="${results_dir}/star_mapped"
bam_suffix="Aligned.sortedByCoord.out.bam"
bai_suffix="${bam_suffix}.bai"

# Create bams.csv file
echo sample_id,bam,bai > $output_bams_csv_path
sed 1d $input_sample_ids_path | while read sample_id; do
  bam_path="${bams_dir}/${sample_id}/${sample_id}.${bam_suffix}/${sample_id}.${bam_suffix}"
  bai_path="${bams_dir}/${sample_id}/${sample_id}.${bai_suffix}/${sample_id}.${bai_suffix}"
  echo "${sample_id},${bam_path},${bai_path}" >> $output_bams_csv_path
done