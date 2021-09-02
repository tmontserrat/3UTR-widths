#!/bin/bash

# Script to extract al the 3' UTR from a gtf file and output a
# tab delimited file with useful information

# Extract the lines about 3UTR
bioawk -c gff '$feature ~ /3UTR/ {print $0}' hg19-knownGene.gtf > three_utr.gff

# Cut fields of interest
cut -f 1,4,5,7,9 three_utr.gff > three_utr_regions.txt

# Extract the 9th field
cut -f 5 three_utr_regions.txt > metadata.txt

# Extract all but 9th field
cut -f 1,2,3,4 three_utr_regions.txt > three_utr_prepared.txt

# Paste the metadata columns to the tab file with 3' UTR
paste three_utr_prepared.txt metadata.txt > three_utr_regions_info.txt

# Compute the width for each 3' UTR
awk '{print $3-$2+1}' three_utr_regions_info.txt > width.txt

# Add width column
paste three_utr_regions_info.txt width.txt > three_utr_width.txt

# Reorder columns
awk -F"\t" '{print $1,$2,$3,$6,$4,$5}' three_utr_width.txt > three_utr_info.txt

# Sorting by width
sort -k4,4nr three_utr_info.txt > three_utr_info_sorted.txt

# Remove all intermediate data generated
rm three_utr.gff three_utr_regions.txt metadata.txt three_utr_prepared.txt 
rm three_utr_regions_info.txt width.txt three_utr_width.txt three_utr_info.txt






