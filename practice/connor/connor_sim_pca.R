####find.clusters and DAPC of genetic data###
library(vcfR) #load in vcfR package to convert vcf to genlight
library(adegenet) #load in adegenet package for find.clusters and DAPC
#set working directory to where the vcf file is


#read in the vcf file
vcf <- read.vcfR('/Users/connorfrench/Desktop/connor_practice_nosplit.vcf')
#convert vcf to genlight obj
gen <- vcfR2genlight(vcf)

#conduct pca of SNPs
genpca <- glPca(gen, scale = TRUE)

#scatterplot of first two pc scores
plot(genpca$scores[,1], genpca$scores[,2])
