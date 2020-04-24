library(dada2)
library(msa)

mergers <- readRDS("./filtered/mergers.RDS")
getSequences()
ShortRead::writeFasta(fqs,"./test.fasta")

msa()