install.packages("CMplot")
setwd("~/manhat")
library(CMplot)
gwasResult <- read.table("manh",header = T, sep = "\t")
gwasResults1 <- gwasResult[order(gwasResult$CHR),]
gwasResults$SNP1 <- seq(1, nrow(gwasResults), 1)
gwasResults$CHR <- factor(gwasResults$CHR, levels = unique(gwasResults$CHR))
chr <- aggregate(gwasResults$SNP1, by = list(gwasResults$CHR), FUN = median)
SNPs <- gwasResults1[gwasResults1[,4] < 5e-6, 1]
SNP <- read.table("SNP.txt",header = T, sep = "\t")
gene <- read.table("gene.txt",header = T, sep = "\t")
CMplot(gwasResults1,  plot.type=c("m","q"), LOG10=TRUE, ylim=NULL, 
       axis.cex = 0.8,
       highlight = SNP,
       highlight.col = NULL,
       highlight.cex = 0.7,
       highlight.text = gene,      
       highlight.text.col = "black",
       highlight.text.cex = 1,
       threshold = c(5e-6,5e-8),
       threshold.lty = c(2,1), 
       threshold.lwd = c(1,1), 
       threshold.col = c("grey","red"), 
       amplify = TRUE,
       chr.den.col = NULL, 
       signal.col = c("red","green"), 
       signal.cex = c(1,1),
       signal.pch = c(19,19),
       file.name = "f",
       file = "pdf",
       file.output = TRUE,
       verbose = TRUE)
