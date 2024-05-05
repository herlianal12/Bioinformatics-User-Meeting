# Bioinformatics User Meeting
07 Mei 2024

Instructors:
Lina Herliana, Zahra Noviana, Syam Budi Iryanto, dan Aditya Swardiana

Email: hpc@brin.go.id (bantuan ELSA) atau hpc.admin@brin.go.id (bantuan teknis)

Link to powerpoint: ????

Tujuan: Pengguna HPC khususnya bidang bioinformatics dapat memanfaatkan fasilitas komputasi secara maksimal

Hal yang perlu diperhatikan sebelum hands-on
1. Akun HPC Mahameru BRIN Gen 4 (daftar melalui https://elsa.brin.go.id/layanan/index/%20HPC%20untuk%20%20Bioinformatika%20/6393)
2. Komputer/Laptop
3. Akses Internet

### **Overview**
**Getting ready and Assessing QC**
1. Login
2. Creating screen session
3. Clonning repository
4. Creating environment and installing packages
5. Creating directories
6. Viewing directory structure
7. Accesing local databases
8. Obtaining raw data
9. Submitting job to assessing quality of raw data with fastqc and multiqc
10. Interactive job
11. Transferring results to local computer

**OPTIONAL Unicyler assembly tutorial**

1. Installing packages

2. Creating directories
3. Generating assembly with unicycler
4. Assessing assembly quality with quast
5. Generating annotation with prokka
6. Visualization with IGV


**Tahapan**:
1. Masuk ke HPC Mahameru BRIN menggunakan akun masing-masing melalui terminal (Mac/Linux) atau powershell (Windows)

```
ssh <username>@login2.hpc.brin.go.id
contoh:
ssh lina008@login2.hpc.brin.go.id
```
2. Menggunakan bantuan screen untuk membuat beberapa sesi dan mempertahankan sesi yang ada walau koneksi terputus. User dapat menggunakan aplikasi lain seperti tmux.

```
### Membuat screen session
screen -S training

### Mengakses screen session kembali setelah logout atau putus sambungan
screen -dr training 
```
3. Mengkloning repository pelatihan
```
git clone git@github.com:hpc-mahameru/Bioinformatics-User-Meeting.git
```
4. Membuat environment (tempat menginstall software) di akun user menggunakan Miniforge3 (mamba dan conda)

https://anaconda.org/search

```
module avail
module load bioinformatics/miniforge3/24.3.0-0
mamba create -n training_qc
mamba init
source ~/.bashrc
mamba activate training_qc

###
mamba install -c bioconda fastqc multiqc tree

### Confirm changes: [Y/n] Y
### user sudah bisa menggunakan softwarenya
### untuk melihat software apa saja dan versi berapa yang sudah terinstall
mamba list
```
Untuk lebih mendetail dapat dipelajari link berikut https://conda.io/projects/conda/en/latest/user-guide/getting-started.html
dan https://docs.conda.io/projects/conda/en/latest/_downloads/843d9e0198f2a193a3484886fa28163c/conda-cheatsheet.pdf


5. Membuat folder projek untuk menyimpan data input dan output

```
pwd
cd Bioinformatics-User-Meeting
mkdir -p training
cd training
mkdir raw_data quality_control
cd ~
```

6. Struktur direktori

```
tree Bioinformatics-User-Meeting
```

Bioinformatics-User-Meeting
|-- README.md
|-- template_submision
|   `-- contoh.sh
`-- training
    |-- quality_control
    `-- raw_data

5 directories, 2 files


7. Akses database lokal untuk bioinformatics
```
### list database yang sudah ada (tidak dipakai untuk training hanya informasi)
ls /mgpfs/db/bioinformatics

#HUMANN_DB  MY_CHECKM_FOLDER  MY_KRAKEN2_DB  NCBI_nt  NCBI_tax

### silahkan untuk request penambahan database dengan mengirimkan email dengan judul "Database Bioinformatics", sertakan juga link database
```
8. Download data menggunakan wget atau curl

source: https://training.galaxyproject.org/training-material/topics/assembly/tutorials/unicycler-assembly/tutorial.html
waktu download < 13 menit
```
cd ~
wget https://zenodo.org/record/940733/files/illumina_f.fq -P Bioinformatics-User-Meeting/training/raw_data
wget https://zenodo.org/record/940733/files/illumina_r.fq -P Bioinformatics-User-Meeting/training/raw_data
wget https://zenodo.org/record/940733/files/minion_2d.fq -P Bioinformatics-User-Meeting/training/raw_data
```

9. Submitting job to assessing quality of raw data with fastqc and multiqc dengan sbatch

```
cd ~
cd Bioinformatics-User-Meeting/template_submision
nano contoh.sh
sbatch contoh.sh
squeue
```

#!/bin/bash
#SBATCH --job-name fastqc
#SBATCH --partition short
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --time 01:00:00
#SBATCH --mem 1G


cd ~
time fastqc Bioinformatics-User-Meeting/training/raw_data/* -o Bioinformatics-User-Meeting/training/quality_control


log dapat dilihat di slurm-XXXXX.out

```
cd ~
cd Bioinformatics-User-Meeting/training/quality_control
#illumina_f_fastqc.html  illumina_f_fastqc.zip  illumina_r_fastqc.html  illumina_r_fastqc.zip  minion_2d_fastqc.html  minion_2d_fastqc.zip
```

10. Interactive job submission

```
srun --partition=interactive --pty /bin/bash
mamba activate training_qc
cd Bioinformatics-User-Meeting/training/quality_control
multiqc .
exit
```

```
cd ~/Bioinformatics-User-Meeting/training/quality_control
ls
#illumina_f_fastqc.html  illumina_f_fastqc.zip  illumina_r_fastqc.html  illumina_r_fastqc.zip  minion_2d_fastqc.html  minion_2d_fastqc.zip  multiqc_data  multiqc_report.html
```


11. Transfer data dari HPC Mahameru BRIN ke lokal


```
cd ~/Bioinformatics-User-Meeting/training/quality_control
mkdir html
mv *.html html/
cd html
ls
#illumina_f_fastqc.html  illumina_r_fastqc.html  minion_2d_fastqc.html  multiqc_report.html
```
Buka terminal atau powershell yang baru

```
#contoh:
scp -r lina008@login2.hpc.brin.go.id:~/Bioinformatics-User-Meeting/training/quality_control/html Downloads
#Buka masing-masing html file dengan double klik maka akan muncul report qc dari masing-masing sampel
```

**OPTIONAL Unicyler assembly tutorial**

1. Creating a new environment and installing more packages
```
mamba create -n assembly
mamba activate assembly
mamba install -c bioconda unicycler quast busco prokka igv
mamba install bioconda/label/cf201901::unicycler
```
2. Creating directories
```
cd ~
mkdir Bioinformatics-User-Meeting/training/assembly
```
3. Generating assembly with unicycler
```
cd /mgpfs/home/lina008/Bioinformatics-User-Meeting/template_submision
sbatch assembly.sh
```
4. Assessing assembly quality with quast

5. Generating annotation with prokka
6. Visualization with IGV

