#!/bin/bash
#SBATCH --job-name quast
#SBATCH --partition short
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --time 01:00:00
#SBATCH --mem 10G


cd ~
time quast Bioinformatics-User-Meeting/training/assembly/assembly.fasta -o Bioinformatics-User-Meeting/training/quality_assembly
