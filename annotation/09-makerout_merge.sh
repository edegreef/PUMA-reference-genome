#!/bin/bash

#combine .gffs from maker output
module load MAKER/2.31.10-intel-2017A-Python-2.7.12
gff3_merge *.all.gff -o PUMA2_03022020_round4.gff  

# combining the maker.proteins and maker.transcripts
cat *all.maker.proteins.fasta > PUMA2_03022020_round4.proteins.fasta
cat *all.maker.transcripts.fasta > PUMA2_03022020_round4.transcripts.fasta

#cleaning up folder
cd /scratch/user/edegreef/ref_genome/annotation
mkdir maker_round4
mv PUMA2* maker_round4
mv maker*ctl maker_round4

