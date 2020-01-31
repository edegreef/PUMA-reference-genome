# Checking genome for contaminants
This folder contains the steps for checking for any contamination across the entire genome. Steps 1 & 2 are based off of kdelmore's scripts (https://github.com/kdelmore), with some modifications.

**Step 1: blastprep:** This step downloads the taxonomy database from NCBI, which will help ID the blast hits. The path to this taxdb file is needed for step 2 (I saved it in a "ncbi" folder). The code in blastprep also splits the genome into multiple contigs, and creates a list of all the chunks. Splitting helps run parallel jobs to help speed up the run time. A separate list is necessary for each job (i.e. listA could contain scaffolds 0-1000, listB with 10001-2000, etc). I used a total of 20 lists/jobs to finish blasting a 2Gb for a run time of 7 days together.
Finally, making two directories, used for outputs from step 2.

**Step 2: blastcontigs.lsf:** This is the job file for blasting one list/part with the NCBI nucleotide database. Edit line 26 for each list.

**Step 3: besthits:** After all blast runs are completed, this merges the best_hits outputs into one file, with select columns. Then, search for any prokaryota in the blast hits.
