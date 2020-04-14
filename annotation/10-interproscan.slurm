#!/bin/bash
#SBATCH --export=NONE
#SBATCH --get-user-env=L
#SBATCH --job-name=ipr
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem=8G
#SBATCH --output=stdout.%j
#SBATCH --error=stderr.%j
#SBATCH --mail-type=ALL
#SBATCH --mail-user=edegreef@ucdavis.edu 

cd /scratch/edegreef
module load interproscan/5.40-77.0

interproscan.sh -appl pfam -dp -f TSV -goterms -iprlookup -pa -t p -i PUMA2_03022020_round4.proteins.fasta -o output.iprscan