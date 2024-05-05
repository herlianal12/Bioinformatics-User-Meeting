#!/bin/bash
#SBATCH --job-name annotation
#SBATCH --partition short
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --time 01:00:00
#SBATCH --mem 100G


cd ~/Bioinformatics-User-Meeting/training/assembly

time prokka assembly.fasta -o ~/Bioinformatics-User-Meeting/training/annotation --genus Escherichia --species coli --strain C-1 --usegenus
