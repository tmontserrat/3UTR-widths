#!/bin/bash

# Script to extract al the 3' UTR from a gtf file and output a
# tab delimited file with useful information

# Extract the lines about 3UTR
bioawk -c gff '$feature ~ /3UTR/ {print $0}' hg19-knownGene.gtf > three_utr.gff

# Cut fields of interest
cut -f 1,4,5,7,9 three_utr.gff > three_utr_regions.txt

# Compute the width for each 3' UTR
awk '{print $3-$2+1}' three_utr_regions.txt > width.txt

# Add width column
paste three_utr_regions.txt width.txt > three_utr_width.txt

# Reorder columns
awk -F"\t" -v OFS="\t" '{print $1,$2,$3,$6,$4,$5}' three_utr_width.txt > three_utr_info.txt

# Sorting by width
sort -k4,4nr three_utr_info.txt > three_utr_info_sorted.txt

# Extract all gene ID
cut -f6 three_utr_info_sorted.txt | awk -F" " '{print $4}' | sed 's/"//g' | sed 's/;//g' > transcript_id.txt

# Replacing metadata for transcript ID
cut -f1,2,3,4,5 three_utr_info_sorted.txt > three_utr_ranges.txt
paste three_utr_ranges.txt transcript_id.txt > three_utr_width_genes.txt

# Keeping the transcript ID and the width and sorting
cut -f4,6 three_utr_width_genes.txt | sort -k2,2 > three_utr_width_sorted.txt

# Computing the total width of 3' UTR of all transcripts
awk -v OFS="\t" '{a[$2] += $1} END{for (i in a) print i,a[i]}' three_utr_width_sorted.txt | sort -k2,2nr > three_utr_widths.txt  

# Remove intermediate files
rm three_utr.gff three_utr_regions.txt width.txt three_utr_width.txt three_utr_info.txt
rm three_utr_info_sorted.txt transcript_id.txt three_utr_ranges.txt three_utr_width_genes.txt
rm three_utr_width_sorted.txt
