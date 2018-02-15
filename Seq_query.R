getwd()
setwd("C:/Users/User/Desktop")
install.packages("RISmed")
source("https://bioconductor.org/biocLite.R")
biocLite("Biostrings")
library("Biostrings")

library(seqinr)

getncbiseq <- function(accession)
{
  require("seqinr") # this function requires the SeqinR R package
  # first find which ACNUC database the accession is stored in:
  dbs <- c("genbank","refseq","refseqViruses","bacterial")
  numdbs <- length(dbs)
  for (i in 1:numdbs)
  {
    db <- dbs[i]
    choosebank(db)
    # check if the sequence is in ACNUC database 'db':
    resquery <- try(query(".tmpquery", paste("AC=", accession)), silent = TRUE)
    if (!(inherits(resquery, "try-error")))
    {
      queryname <- "query2"
      thequery <- paste("AC=",accession,sep=" " )
      query2 <- query(`queryname`,`thequery`)
      # see if a sequence was retrieved:
      seq <- getSequence(query2$req[[1]])
      closebank()
      return(seq)
    }
    closebank()
  }
  print(paste("ERROR: accession",accession,"was not found"))
}
accessions <- scan("naz.txt" , character())
#accessions

for(i in 1:2)
{
  B_lamda1 <- getncbiseq(accessions[i]);
  print(myseq)
  
}


#B_lamda1 <- getncbiseq("AE003852")
B_lamda1[1:50]
length(B_lamda1)
#B_lamda_1 <- c2s(B_lamda1)
B_lamda1
write.fasta(names="B_lamda-1", sequences=B_lamda1, file.out="B_lamda.fasta") 

B_lamda_2 <- read.fasta(file = "B_lamda.fasta") 
B_lamda_phage <- B_lamda_2[[1]]
B_lamda_phage
starts <- seq(1,length(B_lamda_phage) -4000, by=4000)
starts
n <- length(starts)
n
chunkGCs <- numeric(n)

for (i in 1:n)
{
  chunk <- B_lamda_phage[starts[i]: (starts[i]+3999)]
  chunkGC <- GC(chunk)
  print(chunkGC)
  
  chunkGCs[i] <- chunkGC
  
  
}

chunkGCs
plot(starts, chunkGCs, type="b", xlab = "Nucleotide start position", ylab = "GC content in B_lamda Phage", main = "Graph for assesing GC content of B lamda Phage genome")
####################################
library(swirl)
swirl()

