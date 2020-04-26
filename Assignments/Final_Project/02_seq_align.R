library(dada2)
library(msa)

seqtab <- readRDS("./filtered/seqtab.RDS")

uniq_seqtab<- getUniques(seqtab, collapse = TRUE, silence = FALSE)
uniquesToFasta(uniq_seqtab, "./filtered/uniq_seqtab.fas")
head(uniq_seqtab)

seqs <- readDNAStringSet("./filtered/uniq_seqtab.fas", format="fasta")
seqs

align <- msa(seqs, method = "Muscle")


getSequences()
ShortRead::writeFasta(fqs,"./test.fasta")

msa()