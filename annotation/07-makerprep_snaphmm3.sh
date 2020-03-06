#!/bin/bash

#preparing HMM model for SNAP training to use in last MAKER round

#need to combine .gffs from maker output
module load MAKER/2.31.10-intel-2017A-Python-2.7.12
gff3_merge *.all.gff -o PUMA2_03022020_round3.gff  

#can combine fastas as well, though this isn't necessary input for making the HMM model for snap training
#only combining the maker.proteins and maker.transcripts for now
cat *all.maker.proteins.fasta > PUMA2_03022020_round3.proteins.fasta
cat *all.maker.transcripts.fasta > PUMA2_03022020_round3.transcripts.fasta

#setting up snap directory
mkdir snap/round3
cp PUMA2_03022020_round3.gff snap/round3/PUMA2_03022020_round3.gff
cd snap/round3

#converting .gff file to SNAP format (zff)
maker2zff -n PUMA2_03022020_round3.gff #This outputs genome.ann and genome.dna

#checking info, can look at these outputs to see how many genes, etc
fathom -gene-stats genome.ann genome.dna > stats_output
fathom -validate genome.ann genome.dna > validate_output

#filter and create HMM
fathom -categorize 1000 genome.ann genome.dna
fathom -export 1000 -plus uni.ann uni.dna
forge export.ann export.dna
hmm-assembler.pl train_snap3 . > train_snap3.hmm

echo "hmm for snap done"

#cleaning up folder to prepare for next maker round (optional)
cd /scratch/user/edegreef/ref_genome/annotation
mkdir maker_round3
mv PUMA2* maker_round3
cp maker*ctl maker_round3 #copying ctl files over to keep record of what went into round 3. Need to edit ctl file again for round 4.

