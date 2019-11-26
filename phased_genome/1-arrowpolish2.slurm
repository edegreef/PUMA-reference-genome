#!/bin/bash
#SBATCH --export=NONE
#SBATCH --get-user-env=L
#SBATCH --job-name=arrowpolish2
#SBATCH --time=2-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=28
#SBATCH --mem=54G
#SBATCH --output=stdout.%j
#SBATCH --error=stderr.%j
#SBATCH --mail-type=ALL
#SBATCH --mail-user=edegreef@ucdavis.edu 

cd /scratch/user/edegreef/ref_genome/arrow2_phased
module load ArrowGrid_HPRC/0.6.0-iomkl-2017b
source activate pbbioconda

arrow.sh -w 2-00:00:00 -g P11158_101.phased.fasta -p PUMAphased