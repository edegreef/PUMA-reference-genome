#These are notes for quick steps on command line, described below, including removing duplicates with BBMAP, and calculating scaffold lengths.

cd /scratch/user/edegreef/ref_genome

#copying recent genome file from arks folder with a cleaner name
cp arkslinks/PUMA2.arrow.pilon_c5_m50-10000_k30_r0.05_e30000_z500_l5_a0.3.scaffolds.fa PUMA2.arrow.pilon.arks.fasta

#checking/removing duplicates & containments using BBMAP
module load BBMap/38.44-Java-1.8.0
dedupe.sh in=PUMA2.arrow.pilon.arks.fasta out=PUMA2.arrow.pilon.arks.dup.fasta outd=duplicates.fasta

#no duplicate scaffolds found, continuing to use the PUMA2.arrow.pilon.arks.fasta file
#shortening scaffold header names to just "scaffold#"
sed -r 's/\,.+//' PUMA2.arrow.pilon.arks.fasta > PUMA2.arrow.pilon.arks.rename.fasta

#renaming final genome file
mv PUMA2.arrow.pilon.arks.rename.fasta PUMA2_03022020.fasta

#calculating scaffold lengths
cat PUMA2_03022020.fasta | awk '$0 ~ ">" {print c; c=0;printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }' > scaffoldlengths.csv