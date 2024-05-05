#!/bin/bash
#SBATCH --job-name assembly
#SBATCH --partition short
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --time 05:00:00
#SBATCH --mem 100G


cd ~/Bioinformatics-User-Meeting/training/raw_data
time unicycler -1 illumina_f.fq  -2 illumina_r.fq  -l minion_2d.fq -o ~/Bioinformatics-User-Meeting/training/assembly
