![Logo](https://github.com/edegreef/PUMA-reference-genome/blob/master/PUMA-logo.JPG)

This is a repository for scripts I used in improving and annotating the Purple Martin (*Progne subis*) draft genome assembly. These scripts were executed using the Texas A&M High Preformance Research Computing resources (https://hprc.tamu.edu/).

# Improving draft genome assembly
Starting input files (_with my file sizes as example_)
* Assembled reference genome (_1 fasta file 1.16GB_) 
* PacBio reads (_5 bam files totalling 83GB_)
* Illumina reads (_3 fastq files totalling 75GB_)

The main steps in this assembly improvement are polishing the genome with **Arrow** and **Pilon**, and scaffolding it with **ARKS+LINKS**. There are some intermediate steps in between these programs to create necessary input files. In addition, I also checked for duplicate scaffolds, contaminants, and assessed genome quality. All steps are listed below (approximate run time in parentheses) with matching numbers to the script file names in the **assembly** folder. [:file_folder:](https://github.com/edegreef/PUMA-reference-genome/tree/master/assembly)

1. Polish genome using [Arrow](https://github.com/skoren/ArrowGrid), with PacBio subreads.bam files listed in `input.fofn` file (_run time 2 days_)
2. Align illumina reads to the arrow-corrected genome using [BWA](http://bio-bwa.sourceforge.net/bwa.shtml) (_run time 1.5 days_)
3. Sort, index, and look at stats of aligned bam file with [samtools](http://www.htslib.org/doc/samtools.html) (_run time 2.5 hrs_)
4. Polish genome using [Pilon](https://github.com/broadinstitute/pilon/wiki) (_run time 12 hrs_)
5. Create interleaved linked reads file from illumina reads using [LongRanger](https://support.10xgenomics.com/genome-exome/software/pipelines/latest/what-is-long-ranger) (_run time ~2 days_)
6. Scaffold genome using the [ARKS+LINKS pipline](https://github.com/bcgsc/arks/) (_run time 13 hrs_)
7. Identify and remove duplicate scaffolds with [bbmap](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/dedupe-guide/) (_run time ~2 min_)
8. Shorten scaffold header names and calculate scaffold lengths with `sed`, `cat`, & `awk` (_run time ~2 min_)
9. Evaluate genome metrics with [QUAST](http://quast.sourceforge.net/docs/manual.html) (_run time 4 min_)
10. Assess genome assembly completeness with [BUSCO](https://busco.ezlab.org/busco_userguide.html#running-busco) (_run time 3-4 days_)
11. Scan full genome for any contaminants (_step ii. run time ~3.5 days, with full genome split over 5 jobs_)
     1. Download taxonomy database from NCBI, splitting reference genome file into chunks, and making lists ready for BLAST step
     2. Use [BLAST+](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download) for each list of scaffolds, using script largely based from [kdelmore](https://github.com/kdelmore/)
     3. Check outputs for non-eukaryota using `grep`


# Genome annotation
This annotation pipeline uses **[MAKER](https://www.yandell-lab.org/software/maker.html)**, running multiple rounds and using programs such as repeatmasker, exonerate, snap, and augustus. All steps are listed below (approximate run time in parentheses) with matching numbers to the script file names in the **annotation** folder. [:file_folder:](https://github.com/edegreef/PUMA-reference-genome/tree/master/annotation) _Note:_ Normally people use both RNA & protein data for annotation, however, I am only using protein evidence. These following instructions are using protein evidence only (and for bird data).

1. Prepare input files for running the first round of MAKER, including optionally splitting genome file into multiple chunks (to save time), downloading model data from [ensembl](http://ensembl.org/) (chicken, zebra finch, flycatcher), and obtaining maker control files
2. First round of MAKER
     1. Prepare `maker_opts.ctl` file with adjusted parameters to run **RepeatMasker** and **Exonerate**, and a few other parameter changes (protein=_protein fasta files_, model_org=aves, protein2genome=1, cpus=20, min_contig=5000). I added the "02-" in the file name to organize opts file for this step since we will be editing and using this file again later. Should remove the "02-" in the name when running maker.
     2. Run `maker_run.lsf`. This script is largely based off from [TAMU's GCATemplates](https://github.tamu.edu/), creating a temporary directory for the large number of files MAKER will create. **I ran 5 of these scripts (maker_run0.lsf, maker_run1.lsf, maker_run2.lsf....), adjusted for each genome chunk created in Step 1** so I can still use the same maker_opts.ctl file for each job. (_run time 2 days - with 5 genome chunks running simultaneously (total 1.14GB)_)
3. Create HMM model using .gff files from maker's outputs (_run time ~10 min_)
4. Second round of MAKER
     1. Prepare `maker_opts.ctl` file with updated parameters to **train SNAP** (maker_gff=_merged gff file from round1_, protein_pass=1, rm_pass=1, snaphmm=_hmm file created in step 3_, protein=#remove, model_org=#remove, repeat_protein=#remove, protein2genome=0, pred_stats=1)
     2. Run same job script files used in first round of maker: `maker_run0.lsf`, `maker_run1.lsf`, `maker_run2.lsf`... (_run time 4 hours - with 5 chunks running simultaneously_)
5. Create 2nd HMM model using .gff files from 2nd round of maker (_run time ~10 min_)
6. Third round of MAKER
     1. Prepare `maker_opts.ctl` file with updated parameters to **re-train SNAP** and include **Augustus** chicken model (maker_gff=_merged gff file from round2_, snaphmm=_hmm file created in step 5_, augustus_species=chicken)
     2. Run same job script files used in previous rounds of maker: `maker_run0.lsf`, `maker_run1.lsf`, `maker_run2.lsf`... (_run time 15 hours - with 5 chunks running simultaneously_)
7. Create 3rd HMM model using .gff files from 3rd round of maker (_run time ~10 min_)
8. Fourth round of MAKER
     1. Prepare `maker_opts.ctl` file with updated parameters to **re-train SNAP** and include **Augsutus** chicken model, and filter AED values (maker_gff=_merged gff file from round3_, snaphmm=_hmm file created in step 7_, AED_threshold=0.5)
     2. Run same job script files used in previous rounds of maker: `maker_run0.lsf`, `maker_run1.lsf`, `maker_run2.lsf`... (_run time 15 hours - with 5 chunks running simultaneously_)
9. Merge outputs from 4th round of maker (_run time ~few min_)
10. Run [InterProScan](https://github.com/ebi-pf-team/interproscan/wiki/HowToRun) with the proteins fasta file from maker outputs. Two code scripts are listed here in this step, the .lsf file is for the [TAMU HPRC](https://hprc.tamu.edu/) where `-goterms` was not available, and the .slurm file was used on [Compute Canada](https://www.computecanada.ca/) which included `-goterms`. (_run time 7 hours_).
11. Blast proteins fasta file with [uniprot](https://www.uniprot.org/) protein data (chicken, zebra finch, flycatcher) using [BLAST+](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download) (_run time 7.5 hrs_)
12. Prep files for integrating maker, interproscan, and blastp outputs (_run time 5 min_)
13. Add functional info to blastp outputs (_run time 2 min_)
14. Update interproscan outputs (_run time 2 min_)
