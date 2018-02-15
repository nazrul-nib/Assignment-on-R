getwd()
setwd("C:/Users/User/Desktop")
install.packages("RISmed")
library(seqinr)
source("https://bioconductor.org/biocLite.R")
biocLite("Biostrings")
library("Biostrings")




############################################################################
library('RISmed')

getPubmedData <- function(searchString, fileName){
  
  #print('Geting summary')
  search_query <- EUtilsSummary(searchString, retmax=200)
  summary(search_query)
  
  print("Retriving NCBI records")
  records<- EUtilsGet(search_query)
  class(records)
  
  pubmed_data <- data.frame('PubmedID'=PMID(records),'Title'=ArticleTitle(records),'Abstract'=AbstractText(records),'Journal'=Title(records),'Volume'=Volume(records), 'Issue'=Issue(records)) 
  
  print('Writing to file - PubmedData.csv')
  write.csv(pubmed_data, file = paste(fileName, '.csv'))
  
  return(pubmed_data)
}

#help(EUtilsSummary)
plantdivision <- getPubmedData("cancer", "cancer")





#https://amunategui.github.io/pubmed-query/



