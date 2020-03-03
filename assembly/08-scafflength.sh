#These are notes for quick steps on command line, including calculating length of each scaffold

#no duplicate scaffolds found in previous step, so I am continuing to use the PUMA2.arrow.pilon.arks.fasta file

#shortening scaffold header names to just "scaffold#"
sed -r 's/\,.+//' PUMA2.arrow.pilon.arks.fasta > PUMA2.arrow.pilon.arks.rename.fasta

#renaming final genome file
mv PUMA2.arrow.pilon.arks.rename.fasta PUMA2_03022020.fasta

#calculating scaffold lengths
cat PUMA2_03022020.fasta | awk '$0 ~ ">" {print c; c=0;printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }' > scaffoldlengths.csv
