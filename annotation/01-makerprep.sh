#!/bin/bash

#1)Preparing the REFERENCE GENOME files
#split genome into multiple chunks before running MAKER (to run multiple jobs at once to speed up the process, otherwise it will take a very long time)
module load MAKER/2.31.10-intel-2017A-Python-2.7.12
fasta_tool -chunks 5 /scratch/user/edegreef/ref_genome/PUMA2_03022020.fasta

#MAKER doesn't work well with sequence header names longer than 78 characters, so make sure the header names are short enough
#use sed to adjust sequence headers (I already did this in the assembly process but I am listing code here too)
#example: change sequence name from ">scaffold18,17137285,f3Z17137285" to ">scaffold18"
#sed -r 's/\,.+//' PUMA2_03022020_00.fasta > PUMA2_03022020_00_renamed.fasta
#sed -r 's/\,.+//' PUMA2_03022020_01.fasta > PUMA2_03022020_01_renamed.fasta
#sed -r 's/\,.+//' PUMA2_03022020_02.fasta > PUMA2_03022020_02_renamed.fasta
#sed -r 's/\,.+//' PUMA2_03022020_03.fasta > PUMA2_03022020_03_renamed.fasta
#sed -r 's/\,.+//' PUMA2_03022020_04.fasta > PUMA2_03022020_04_renamed.fasta


#2)Downloading the protein data from ensembl (normally people use RNA & proteins, but I do not have RNA for my genome so I am only using protein data)

#chicken
wget ftp://ftp.ensembl.org/pub/release-99/fasta/gallus_gallus/pep/Gallus_gallus.GRCg6a.pep.all.fa.gz
gunzip Gallus_gallus.GRCg6a.pep.all.fa.gz
mv Gallus_gallus.GRCg6a.pep.all.fa chicken_pep_all.fa

#zebra finch
wget ftp://ftp.ensembl.org/pub/release-99/fasta/taeniopygia_guttata/pep/Taeniopygia_guttata.bTaeGut1_v1.p.pep.all.fa.gz
gunzip Taeniopygia_guttata.bTaeGut1_v1.p.pep.all.fa.gz
mv Taeniopygia_guttata.bTaeGut1_v1.p.pep.all.fa zebrafinch_pep_all.fa

#collared flycatcher
wget ftp://ftp.ensembl.org/pub/release-99/fasta/ficedula_albicollis/pep/Ficedula_albicollis.FicAlb_1.4.pep.all.fa.gz
gunzip Ficedula_albicollis.FicAlb_1.4.pep.all.fa.gz
mv Ficedula_albicollis.FicAlb_1.4.pep.all.fa flycatcher_pep_all.fa

mkdir model_proteins
mv *_pep_all.fa model_proteins


#3)Obtaining the MAKER control files (maker_bopts.ctl, maker_exe.ctl, and maker_opts.ctl)
module load MAKER/2.31.10-intel-2017A-Python-2.7.12
cp /scratch/datasets/maker/2.31.10/*ctl /scratch/user/edegreef/ref_genome/annotation 


#Next step is to edit parameters the maker_opts.ctl file and run maker