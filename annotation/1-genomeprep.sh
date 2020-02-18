#!/bin/bash

#Splitting genome into 10 chunks before running MAKER (to run multiple jobs at once to spee up the process)

module load MAKER/2.31.10-intel-2017A-Python-2.7.12
fasta_tool -chunks 10 PUMAphased_12042019.fasta

#Changing sequence header names to "scaffold#" instead of long string of unecessary characters. MAKER doesn't work well on names longer than 78 characters.
#Example: Changed sequence name from ">scaffold18,17137285,f3Z17137285" to ">scaffold18"
sed -r 's/\,.+//' PUMAphased_12042019_00.fasta > PUMAp_12042019_00_renamed.fasta
sed -r 's/\,.+//' PUMAphased_12042019_01.fasta > PUMAp_12042019_01_renamed.fasta
sed -r 's/\,.+//' PUMAphased_12042019_02.fasta > PUMAp_12042019_02_renamed.fasta
sed -r 's/\,.+//' PUMAphased_12042019_03.fasta > PUMAp_12042019_03_renamed.fasta
sed -r 's/\,.+//' PUMAphased_12042019_04.fasta > PUMAp_12042019_04_renamed.fasta
sed -r 's/\,.+//' PUMAphased_12042019_05.fasta > PUMAp_12042019_05_renamed.fasta
sed -r 's/\,.+//' PUMAphased_12042019_06.fasta > PUMAp_12042019_06_renamed.fasta
sed -r 's/\,.+//' PUMAphased_12042019_07.fasta > PUMAp_12042019_07_renamed.fasta
sed -r 's/\,.+//' PUMAphased_12042019_08.fasta > PUMAp_12042019_08_renamed.fasta
sed -r 's/\,.+//' PUMAphased_12042019_09.fasta > PUMAp_12042019_09_renamed.fasta