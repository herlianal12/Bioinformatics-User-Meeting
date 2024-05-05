# Bioinformatics User Meeting
07 Mei 2024

Instructors:
Lina Herliana, Zahra Noviana, Syam Budi Iryanto, dan Aditya Swardiana

Email: hpc@brin.go.id (bantuan ELSA) atau hpc.admin@brin.go.id (bantuan teknis)

Link to powerpoint: ????

Tujuan: Pengguna HPC khususnya bidang bioinformatics dapat memanfaatkan fasilitas komputasi secara maksimal

Hal yang perlu diperhatikan sebelum hands-on
1. Akun aktif HPC Mahameru BRIN Gen 4 (daftar melalui https://elsa.brin.go.id/layanan/index/%20HPC%20untuk%20%20Bioinformatika%20/6393)
2. Laptop
3. Akses Internet

### **Overview**
**Persiapan and Evaluasi kualitas hasil sekuensing (QC)**
1. Masuk ke HPC (Login)
2. Membuat screen session
3. Mengkloning repositori
4. Membuat environment and menginstall packages/software
5. Membuat direktori
6. Melihat struktur direktori
8. Mengunduh data mentah (raw data)
9. Mengirimkan job dengan sbatch
10. Menggunakan interaktif job
11. Mentransfer atau mengunduh file dari HPC ke komputer user

**OPTIONAL Unicyler assembly tutorial**

1. Membuat environment baru dan menginstall packages/software
2. Membuat direktori baru
3. Melakukan assembly dengan unicycler
4. Mengevaluasi kualitas assembly dengan quast
5. Mengakses database lokal
6. Melakukan anotasi dengan prokka
7. Mengvisualisasikan hasil dengan IGV


**Tahapan**:
1. Masuk ke HPC Mahameru BRIN menggunakan akun masing-masing melalui terminal (Mac/Linux) atau powershell (Windows)

```
ssh <username>@login2.hpc.brin.go.id
contoh:
ssh lina008@login2.hpc.brin.go.id
```
<img width="587" alt="Screenshot 2024-05-05 at 19 38 04" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/f0b88b62-582b-4574-b894-fdf129bab0c4">

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

Tools atau software bioinformatics dapat dilihat pada https://anaconda.org/search

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

### untuk melihat software apa saja dan versi berapa yang sudah terinstall
mamba list

### untuk mengecek apakah tools sudah bisa digunakan
fastqc --help
multiqc --help
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

6. Melihat struktur direktori

```
tree Bioinformatics-User-Meeting
```
<img width="209" alt="Screenshot 2024-05-05 at 19 32 48" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/86f77bdf-ae97-4e5d-bbfc-f0d2bc2782a7">

7. Mengunduh data mentah dengan wget

source: https://training.galaxyproject.org/training-material/topics/assembly/tutorials/unicycler-assembly/tutorial.html
waktu unduh data < 13 menit
```
cd ~
wget https://zenodo.org/record/940733/files/illumina_f.fq -P Bioinformatics-User-Meeting/training/raw_data
wget https://zenodo.org/record/940733/files/illumina_r.fq -P Bioinformatics-User-Meeting/training/raw_data
wget https://zenodo.org/record/940733/files/minion_2d.fq -P Bioinformatics-User-Meeting/training/raw_data
```

8. Mengirimkan job untuk mengevaluasi kualitas dengan sbatch
   
```
cd ~
cd Bioinformatics-User-Meeting/template_submision
nano contoh.sh
sbatch contoh.sh
squeue
```

<img width="834" alt="Screenshot 2024-05-05 at 19 45 45" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/cc6659da-3e08-4ffb-8ac4-3d201ee14be0">

Hasil:
```
cd ~
cd Bioinformatics-User-Meeting/training/quality_control
#illumina_f_fastqc.html  illumina_f_fastqc.zip  illumina_r_fastqc.html  illumina_r_fastqc.zip  minion_2d_fastqc.html  minion_2d_fastqc.zip
```

9. Menggunakan interaktif job submission
    
```
srun --partition=interactive --pty /bin/bash
mamba activate training_qc
cd Bioinformatics-User-Meeting/training/quality_control
multiqc .
exit
```
Hasil:
```
cd ~/Bioinformatics-User-Meeting/training/quality_control
ls
#illumina_f_fastqc.html  illumina_f_fastqc.zip  illumina_r_fastqc.html  illumina_r_fastqc.zip  minion_2d_fastqc.html  minion_2d_fastqc.zip  multiqc_data  multiqc_report.html
```


10. Transfer data dari HPC Mahameru BRIN ke lokal

Memindahkan file html ke folder baru dengan nama html
```
cd ~/Bioinformatics-User-Meeting/training/quality_control
mkdir html
mv *.html html/
cd html
ls
#illumina_f_fastqc.html  illumina_r_fastqc.html  minion_2d_fastqc.html  multiqc_report.html
```

Buka terminal atau powershell yang baru untuk transfer file

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
5. Akses database lokal untuk bioinformatics
```
### list database yang sudah ada (tidak dipakai untuk training hanya informasi)
ls /mgpfs/db/bioinformatics
```
<img width="792" alt="Screenshot 2024-05-05 at 19 37 05" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/571a36e0-49a9-4d15-9e07-2f0a8402ba48">

Silahkan untuk request penambahan database dengan mengirimkan email dengan judul "Database Bioinformatics", sertakan juga link database
6. Generating annotation with prokka
7. Visualization with IGV

