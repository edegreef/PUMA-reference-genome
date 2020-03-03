#downloading taxdb file from NCBI, which will be used in the $BLASTDB path in blast step
wget ftp://ftp.ncbi.nlm.nih.gov/blast/db/taxdb.tar.gz
tar -xzf taxdb.tar.gz

#move taxdb files to new ncbi folder
mkdir ncbi
mv taxdb.btd ncbi/taxdb.btd
mv taxdb.bti ncbi/taxdb.bti
mv taxdb.tar.gz ncbi/taxdb.tar.gz

#splitting genome per scaffold
mkdir split_dir
csplit -n 1 -f split_dir/ /scratch/user/edegreef/ref_genome/PUMA2_03022020.fasta "%^>%" "/^>/" "{*}" -s 
ls -thor split_dir/ | awk '{print $8}' | sed '1d' > list_contigs

#for the 2,896 scaffolds, I manually split the list_contigs into 5 lists (A-E) to run multiple jobs (11b-blastn.lsf) at once to save time

#directories for next step
mkdir best_hits blast_out