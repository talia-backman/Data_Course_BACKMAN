library(dada2)
library(purrr)
library(tidyr)
library(ggplot2)
library(readxl)

path <- "./PlateData" 
list.files(path)
                
fnFs <- sort(list.files(path, pattern="R1_001.fastq", full.names = TRUE, recursive = TRUE))
fnFs
fnRs <- sort(list.files(path, pattern="R2_001.fastq", full.names = TRUE, recursive = TRUE))
# Extract sample names
sample.names <- sapply(strsplit(basename(fnFs), "_"), `[`, 1)
sample.names
                
plotQualityProfile(fnFs[1:2])
plotQualityProfile(fnRs[1:2])
                
                
# Place filtered files in filtered/ subdirectory
filtFs <- file.path(path, "filtered", paste0(sample.names, "_F_filt.fastq"))
filtRs <- file.path(path, "filtered", paste0(sample.names, "_R_filt.fastq"))
names(filtFs) <- sample.names
names(filtRs) <- sample.names
                
out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs,
                                     maxN=0, maxEE=c(2,2), truncQ=2, rm.phix=TRUE,
                                     compress=TRUE, multithread=TRUE) 
head(out)
                
errF <- learnErrors(filtFs, multithread=TRUE)
errR <- learnErrors(filtRs, multithread=TRUE)
                
plotErrors(errF, nominalQ=TRUE)
plotErrors(errR, nominalQ=TRUE)
                
derepFs <- derepFastq(filtFs, verbose=TRUE)
derepRs <- derepFastq(filtRs, verbose=TRUE)
# Name the derep-class objects by the sample names
names(derepFs) <- sapply(strsplit(basename(filtFs), "_"), `[`, 1)
names(derepRs) <- sapply(strsplit(basename(filtRs), "_"), `[`, 1)
                
dadaFs <- dada(derepFs, err=errF, multithread=TRUE)
dadaRs <- dada(derepRs, err=errR, multithread=TRUE)
                
dadaFs[[1]]
                
seqtab <- makeSequenceTable(dadaFs)
dim(seqtab)

#save seqtab and dada as RDS
saveRDS(dadaFs, "./filtered/dadaFs.RDS")
saveRDS(dadaRs, "./filtered/dadaRs.RDS")
saveRDS(derepFs, "./filtered/derepFs.RDS")
saveRDS(derepRs, "./filtered/derepRs.RDS")
saveRDS(errF, "./filtered/errF.RDS")
saveRDS(errR, "./filtered/errR.RDS")
saveRDS(seqtab, "./filtered/seqtab.RDS")
