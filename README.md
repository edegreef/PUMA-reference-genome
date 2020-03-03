![Logo](https://github.com/edegreef/PUMA-reference-genome/blob/master/PUMA-logo.JPG)

This is a repository for scripts I used in improving and annotating the Purple Martin (*Progne subis*) draft genome assembly. These scripts were executed using the Texas A&M High Preformance Research Computing resources (https://hprc.tamu.edu/).

# Improving draft genome assembly
Starting input files (_with my file sizes as example_)
* Assembled reference genome (_1 fasta file 1.16GB_) 
* PacBio reads (_5 bam files totalling 83GB_)
* Illumina reads (_3 fastq files totalling 75GB_)

The main steps in this assembly improvement are polishing the genome with **Arrow** and **Pilon**, and scaffolding it with **ARKS+LINKS**. There are some intermediate steps in between these programs to create necessary input files. In addition, I also checked for duplicate scaffolds, contaminants, and assessed genome quality. All steps are listed below (approximate run time in parentheses) with matching numbers to the script file names in the **assembly** folder. [:file_folder:](https://github.com/edegreef/PUMA-reference-genome/tree/master/assembly)

1. Polish genome using [Arrow](https://github.com/PacificBiosciences/GenomicConsensus), with PacBio subreads.bam files listed in `input.fofn` file (_run time 2 days_)
2. Align illumina reads to the arrow-corrected genome using [BWA](http://bio-bwa.sourceforge.net/bwa.shtml) (_run time 1.5 days_)
3. Sort, index, and look at stats of aligned bam file with [samtools](http://www.htslib.org/doc/samtools.html) (_run time 2.5 hrs_)
4. Polish genome using [Pilon](https://github.com/broadinstitute/pilon/wiki) (_run time 12 hrs_)
5. Create interleaved linked reads file from illumina reads using [LongRanger](https://support.10xgenomics.com/genome-exome/software/pipelines/latest/what-is-long-ranger) (_run time ~2 days_)
6. Scaffold genome using the [ARKS+LINKS pipline](https://github.com/bcgsc/arks/) (_run time 13 hrs_)
7. Identify and remove duplicate scaffolds with [bbmap](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/dedupe-guide/) (_run time ~2 min_)
8. Shorten scaffold header names and calculate scaffold lengths with `sed`, `cat`, & `awk` (_run time ~2 min_)
9. Evaluate genome metrics with [QUAST](http://quast.sourceforge.net/docs/manual.html) (_run time 4 min_)
10. Assess genome assembly completeness with [BUSCO](https://busco.ezlab.org/busco_userguide.html#running-busco) (_run time 3-4 days_)
11. Scan full genome for any contaminants (_step ii. run time ~6-7 days, with full genome split over 5 jobs_)
     1. Download taxonomy database from NCBI, splitting reference genome file into chunks, and making lists ready for BLAST step
     2. Use [BLAST+](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download) for each list of scaffolds, using script largely based from [kdelmore](https://github.com/kdelmore/)
     3. Check outputs for non-eukaryota using `grep`


# Genome annotation [in progress]
This annotation pipeline uses **[MAKER](https://www.yandell-lab.org/software/maker.html)**, running multiple rounds and using programs such as repeatmasker, exonerate, snap, and augustus. All steps are listed below (approximate run time in parentheses) with matching numbers to the script file names in the **annotation** folder. [:file_folder:](https://github.com/edegreef/PUMA-reference-genome/tree/master/annotation) Starting input file is the genome fasta (_my genome is 1.14 GB_).

1. Prepare input files for running the first round of MAKER, including optionally splitting genome file into multiple chunks (to save time), downloading model data from [ensembl](http://ensembl.org/), and preparing maker_opts.ctl file (_run time a few minutes_)

