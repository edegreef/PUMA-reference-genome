![Logo](https://github.com/edegreef/PUMA-reference-genome/blob/master/PUMA-logo.JPG)

# Improving draft genome assembly
This is a repository for scripts used in polishing and scaffolding the FALCON-assembled reference genome for the Purple Martin (*Progne subis*). These scripts were executed using the Texas A&M High Preformance Research Computing resources (https://hprc.tamu.edu/).

Starting files:
* Assembled reference genome (fasta files)
* PacBio reads (bam files)
* Illumina reads (fastq files)

The same pipeline was used for improving the unphased and phased genomes, with some minor differences to account for file names and memory usage. Steps 1-6 are listed here, with matching numbers in the script file names in this repository. Script files labeled with "2" at the end were used for the phased genome. 

* **Step 1:** Polishing genome with **Arrow** (https://github.com/PacificBiosciences/GenomicConsensus)
* **Step 2:** Aligning reads to the arrow-corrected genome with **BWA**
* **Step 3:** Sorting, indexing, and looking at stats of aligned bam file with **Samtools**
* **Step 4:** Polishing genome with **Pilon** (https://github.com/broadinstitute/pilon/wiki)
* **Step 5:** Creating interleaved linked reads file with **LongRanger** (https://support.10xgenomics.com/genome-exome/software/pipelines/latest/what-is-long-ranger)
* **Step 6:** Scaffolding genome with the **ARKS+LINKS** pipline (https://github.com/bcgsc/arks/)
