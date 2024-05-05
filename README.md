# Bioinformatics User Meeting
07 Mei 2024

Instructors:
Lina Herliana, Zahra Noviana, Syam Budi Iryanto, Ihsan Nugraha, dan Aditya Swardiana

Email: hpc@brin.go.id (bantuan ELSA) atau hpc.admin@brin.go.id (bantuan teknis)


Tujuan: Pengguna HPC khususnya bidang bioinformatics dapat memanfaatkan fasilitas komputasi secara maksimal

Hal yang perlu diperhatikan sebelum hands-on
1. Akun HPC Mahameru BRIN (daftar melalui https://elsa.brin.go.id/layanan/index/%20HPC%20untuk%20%20Bioinformatika%20/6393)
2. Komputer/Laptop
3. Akses Internet

### **Overview**
**Getting ready**
1. Login
2. Creating screen session
3. Clonning repository
4. Creating environment and installing packages
5. Creating directories
6. Viewing directory structure
7. Accesing local databases
8. Preparing script for submission

~~#Unicyler assembly tutorial#~~
~~9. Obtaining raw data~~
~~10. Assesing quality of raw data with fastqc and multiqc~~
~~11. Generating assembly with unicycler~~
~~12. Assessing assembly quality with quast~~
~~13. Generating annotation with prokka~~
~~14. Visualization with IGV~~


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

### Mengakses screen session
screen -dr training 
```
3. Mengkloning repository pelatihan
```
git clone https://github.com/BRIN-HPC/Bioinformatics-User-Meeting.git
```
4. Membuat environment (tempat menginstall software) di akun user menggunakan Anaconda3 (conda) atau Miniforge3 (mamba dan conda)

https://anaconda.org/search

```
###module load bioinformatics/anaconda3/2023.09-0
module load bioinformatics/miniforge3/24.3.0-0
conda create -n training_qc
conda init
source ~/.bashrc
conda activate training_qc

###
mamba install -c bioconda fastqc multiqc tree
### user sudah bisa menggunakan softwarenya
### untuk melihat software apa saja dan versi berapa yang sudah terinstall
conda list
```
Untuk lebih mendetail dapat dipelajari link berikut https://conda.io/projects/conda/en/latest/user-guide/getting-started.html
dan https://docs.conda.io/projects/conda/en/latest/_downloads/843d9e0198f2a193a3484886fa28163c/conda-cheatsheet.pdf


5. Membuat folder projek untuk menyimpan data input dan output

```
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

7. Akses database lokal untuk bioinformatics
```
### list database yang sudah ada
ls /mgpfs/db/bioinformatics

### silahkan untuk request penambahan database dengan mengirimkan email dengan judul "Database Bioinformatics", sertakan juga link database
```
8. Preparing script for submission


## Unicyler assembly tutorial

10. Download data menggunakan wget atau curl

source: https://training.galaxyproject.org/training-material/topics/assembly/tutorials/unicycler-assembly/tutorial.html

```
wget https://zenodo.org/record/940733/files/illumina_f.fq -P raw_data
wget https://zenodo.org/record/940733/files/illumina_r.fq -P raw_data
wget https://zenodo.org/record/940733/files/minion_2d.fq -P raw_data
```

9. Pengecekan kualitas data

```
fastqc training/raw_data/* 
```

10. Submit job

```
sbatch quality_control.sh
squeue
```

11. Transfer data dari lokal ke HPC Mahameru BRIN dan sebaliknya

```

```

