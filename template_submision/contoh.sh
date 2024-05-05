#!/bin/bash
#SBATCH --job-name bgzip
#SBATCH --partition short
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --time 02:00:00
#SBATCH --mem 10G


INDIR=/mgpfs/home/lina008/mucilage/raw_data/fastq_files

for i in ${INDIR}/SRR196002*.fastq
do 
bgzip ${i}
done

