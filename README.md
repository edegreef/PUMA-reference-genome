![Logo](https://github.com/edegreef/PUMA-reference-genome/blob/master/PUMA-logo.JPG)

This is a repository for scripts I used in improving and annotating the Purple Martin (*Progne subis*) draft genome assembly. These scripts were executed using the Texas A&M High Preformance Research Computing resources (https://hprc.tamu.edu/).

# Improving draft genome assembly
These steps are for polishing and scaffolding a 1.16 Gb reference genome. Starting input files:  
* Assembled reference genome (fasta file)
* PacBio reads (bam files)
* Illumina reads (fastq files)

Steps 1-11 are listed below, with matching numbers in the script file names in the **assembly** folder.

1. Polishing genome with [Arrow](https://github.com/PacificBiosciences/GenomicConsensus)  
2. Aligning reads to the arrow-corrected genome with [BWA](http://bio-bwa.sourceforge.net/bwa.shtml)  
3. Sorting, indexing, and looking at stats of aligned bam file with [Samtools](http://www.htslib.org/doc/samtools.html)  
4. Polishing genome with [Pilon](https://github.com/broadinstitute/pilon/wiki)  
5. Creating interleaved linked reads file with [LongRanger](https://support.10xgenomics.com/genome-exome/software/pipelines/latest/what-is-long-ranger)  
6. Scaffolding genome with the [ARKS+LINKS pipline](https://github.com/bcgsc/arks/)  
7. Identifying and removing duplicate scaffolds with [bbmap](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/dedupe-guide/)  
8. Shortening scaffold header names and calculating scaffold lengths with `sed`, `cat`, & `awk`
9. Evaluating genome metrics with [QUAST](http://quast.sourceforge.net/docs/manual.html)  
10. Assessing genome assembly completeness with [BUSCO](https://busco.ezlab.org/busco_userguide.html#running-busco)  
11. Full genome scan for any contaminants 
  1. Downloading taxonomy database from NCBI, splitting reference genome file into chunks, and making lists ready for BLAST step
  2. Using [BLAST+](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download) for each list of scaffolds, using script largely based of [kdelmore's](https://github.com/kdelmore/)
  3. Checking for non-eukaryota using `grep`


# Genome annotation
These steps are for annotating the reference genome using **MAKER**. Usually people include mRNA data from model organisms, but since I did not have any RNA data for my project, I only used protein evidence. 

Starting files for steps 1-5:
* Reference genome (fasta file)
* Protein info from model species: chicken, flycatcher, zebra finch (fasta files, obtained from ensembl.org)
* maker control files (ctl files, obtained from maker dataset files- editing the maker_opts.ctl file for each round)

Starting files for steps 6-#:
* gff file only?? from the maker rounds
* uniprot trEMBL data for the model species: chicken, flycatcher, zebra finch (___)

Steps 1-# are listed below, with matching numbers in script files names in the "annotation" folder.

**Step 1:** Prepping reference genome files before running MAKER  
**Step 2:** First round of MAKER, using **RepeatMasker** and **EXONERATE**. [editing, still coming]  
**Step 3:** Second round of MAKER, training **SNAP** [in progress]  
**Step 4:** Third round of MAKER, training **SNAP**, + adding in **AUGUSTUS**  
**Step 5:** Fourth round of MAKER, training **SNAP** for the final time + checking stats??  
**Step 6:** Identifying proteins using **BLASTP**  

