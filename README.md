# relation-3UTR-transcripts-genes

These are scripts to extract the 3' UTR regions from the genome *Hsapiens.UCSC.hg19.knownGene* and output a table with a relation of the transcripts with the 3' UTR and other useful information.  

There are two scripts with a slightly different output: a R script and a Bash script. However, both do the same task. 

You can get the data for the shell script using:  

  $ curl https://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/genes/hg19.knownGene.gtf.gz > hg19-knownGene.gtf.gz
  $ gunzip hg19-knownGene.gtf.gz

