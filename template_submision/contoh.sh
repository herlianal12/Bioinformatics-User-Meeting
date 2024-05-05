#!/bin/bash
#SBATCH --job-name fastqc
#SBATCH --partition short
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --time 01:00:00
#SBATCH --mem 1G


cd ~
time fastqc Bioinformatics-User-Meeting/training/raw_data/* -o Bioinformatics-User-Meeting/training/quality_control
