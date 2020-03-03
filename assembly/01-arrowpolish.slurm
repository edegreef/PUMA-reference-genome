#!/bin/bash
#SBATCH --export=NONE
#SBATCH --get-user-env=L
#SBATCH --job-name=arrowpolish
#SBATCH --time=2-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=28
#SBATCH --mem=54G
#SBATCH --output=stdout.%j
#SBATCH --error=stderr.%j
#SBATCH --mail-type=ALL
#SBATCH --mail-user=edegreef@ucdavis.edu 

cd /scratch/user/edegreef/ref_genome
module load ArrowGrid_HPRC/0.6.0-iomkl-2017b
source activate pbbioconda

arrow.sh -w 2-00:00:00 -g ps_144_001.contigset.polished_assembly.fasta -p PUMA2

#In addition to the input fasta file, need to have "input.fofn" file listing the subreads.bam files in the same directory.
