# get 3' UTR lengths and transcripts

# load library
library(GenomicFeatures)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(magrittr)
txdb <-  TxDb.Hsapiens.UCSC.hg19.knownGene

# extract all 3' UTR regions by transcript
threeUTR <- threeUTRsByTranscript(txdb, use.name=TRUE)

# extract the names of the transcripts
transcripts_three_UTR <- names(threeUTR)

# keys and column for the query
keys <- transcripts_three_UTR
columns <- c("GENEID", "TXEND", "TXSTART", "TXSTRAND", "TXCHROM")

# query
df_three_utr <- select(txdb, 
                       keys=transcripts_three_UTR, 
                       columns=c(columns), 
                       keytype="TXNAME")

# computing the width of the 3' UTR regions
threeUTR_df <- as.data.frame(threeUTR)
threeUTR_df <- threeUTR_df %>% 
  dplyr::group_by(group, group_name) %>% 
  dplyr::summarize(sum(width))

# adding the information
df_three_utr$width_3_UTR <- threeUTR_df$`sum(width)`

# ordering
df_three_utr_sorted <- df_three_utr[order(as.numeric(df_three_utr$width_3_UTR), 
                                         decreasing=TRUE), ]

# # first lines
# head(df_three_utr_sorted)
