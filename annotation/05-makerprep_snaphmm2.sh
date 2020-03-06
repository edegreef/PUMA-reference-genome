#!/bin/bash

#preparing HMM model for SNAP training to use in next MAKER round

#need to combine .gffs from maker output
module load MAKER/2.31.10-intel-2017A-Python-2.7.12
gff3_merge *.all.gff -o PUMA2_03022020_round2.gff  

#can combine fastas as well, though this isn't necessary input for making the HMM model for snap training
#only combining the maker.proteins and maker.transcripts for now
cat *all.maker.proteins.fasta > PUMA2_03022020_round2.proteins.fasta
cat *all.maker.transcripts.fasta > PUMA2_03022020_round2.transcripts.fasta

#setting up snap directory
mkdir snap/round2
cp PUMA2_03022020_round2.gff snap/round1/PUMA2_03022020_round2.gff
cd snap/round2

#converting .gff file to SNAP format (zff)
maker2zff -n PUMA2_03022020_round2.gff #This outputs genome.ann and genome.dna

#checking info, can look at these outputs to see how many genes, etc
fathom -gene-stats genome.ann genome.dna > stats_output
fathom -validate genome.ann genome.dna > validate_output

#filter and create HMM
fathom -categorize 1000 genome.ann genome.dna
fathom -export 1000 -plus uni.ann uni.dna
forge export.ann export.dna
hmm-assembler.pl train_snap2 . > train_snap2.hmm

echo "hmm for snap done"

#cleaning up folder to prepare for next maker round (optional)
cd /scratch/user/edegreef/ref_genome/annotation
mkdir maker_round2
mv PUMA2* maker_round2
cp maker*ctl maker_round2 #copying ctl files over to keep record of what went into round 2. Need to edit ctl file again for round 3.

