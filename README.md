![Logo](https://github.com/edegreef/PUMA-reference-genome/blob/master/PUMA-logo.JPG)

This is a repository for scripts I used in improving and annotating the Purple Martin (*Progne subis*) draft genome assembly. These scripts were executed using the Texas A&M High Preformance Research Computing resources (https://hprc.tamu.edu/).

# Improving draft genome assembly
These steps are for polishing and scaffolding a 1.16 Gb reference genome. Starting input files:  
* Assembled reference genome (fasta file)
* PacBio reads (bam files)
* Illumina reads (fastq files)

Steps 1-11 are listed below, with matching numbers in the script file names in the **assembly** folder.

1. Polish genome with [Arrow](https://github.com/PacificBiosciences/GenomicConsensus)  
2. Align reads to the arrow-corrected genome with [BWA](http://bio-bwa.sourceforge.net/bwa.shtml)  
3. Sort, index, and look at stats of aligned bam file with [Samtools](http://www.htslib.org/doc/samtools.html)  
4. Polish genome with [Pilon](https://github.com/broadinstitute/pilon/wiki)  
5. Create interleaved linked reads file with [LongRanger](https://support.10xgenomics.com/genome-exome/software/pipelines/latest/what-is-long-ranger)  
6. Scaffold genome with the [ARKS+LINKS pipline](https://github.com/bcgsc/arks/)  
7. Identify and remove duplicate scaffolds with [bbmap](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/dedupe-guide/)  
8. Shorten scaffold header names and calculate scaffold lengths with `sed`, `cat`, & `awk`
9. Evaluate genome metrics with [QUAST](http://quast.sourceforge.net/docs/manual.html)  
10. Assess genome assembly completeness with [BUSCO](https://busco.ezlab.org/busco_userguide.html#running-busco)  
11. Scan full genome for any contaminants  
  - Download taxonomy database from NCBI, splitting reference genome file into chunks, and making lists ready for BLAST step  
  -Use [BLAST+](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download) for each list of scaffolds, using script largely based from [kdelmore](https://github.com/kdelmore/)  
  - Check for non-eukaryota using `grep`  


# Genome annotation
