#downloading taxdb file from NCBI, which will be used in the $BLASTDB path in blast step
wget ftp://ftp.ncbi.nlm.nih.gov/blast/db/taxdb.tar.gz
tar -xzf taxdb.tar.gz

#splitting genome per scaffold
mkdir split_dir
csplit -n 1 -f split_dir/ PUMAphased_12042019.fasta "%^>%" "/^>/" "{*}" -s 
ls -thor split_dir/ | awk '{print $8}' | sed '1d' > list_contigs

#directories for next step
mkdir best_hits blast_out