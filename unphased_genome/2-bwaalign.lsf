#BSUB -L /bin/bash              
#BSUB -J bwaalign
#BSUB -n 8
#BSUB -R "span[ptile=8]" 
#BSUB -R "rusage[mem=5000]"
#BSUB -M 5000
#BSUB -W 72:00
#BSUB -o stdout.%J
#BSUB -e stderr.%J 
#BSUB -u edegreef@ucdavis.edu
#BSUB -B -N

cd /scratch/user/edegreef/ref_genome/pilon1;
module load BWA/0.7.17-intel-2018b;
module load SAMtools/1.9-intel-2018b;

#First need to index the arrow-corrected genome
bwa index PUMA.arrow.fasta;

#Then can align reads. Using samtools to convert the .sam file output directly to a .bam file to save file space
bwa mem -t 8 PUMA.arrow.fasta P11158_101_S1_L005_R1_001.fastq.gz P11158_101_S1_L005_R2_001.fastq.gz | samtools view -S -b - > illumalign.bam
