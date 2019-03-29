library(raster)
# Make a fake matrix with suitability between 0 and 1
val <- round(runif(12),digits=4)
temp <- matrix(val,3,4)
suit <- raster(temp)
plot(suit)
suit

# Transform suitability into carrying capacity
suit_val <- getValues(suit)
K <- round(suit_val*1000)
K

# Transform suitability into resistance (-ish thing)
m.suit <- as.matrix(suit)
# Make this weird matrix
n<-1
pop <- matrix(NA,nrow(m.suit),ncol(m.suit))
for(i in 1:nrow(m.suit)){
  for(j in 1:ncol(m.suit)){
    pop[i,j] <- n
    n=n+1
  }
}
pop

# Make a weird migration matrix
resist <- matrix(NA,nrow(m.suit)*ncol(m.suit),5)
pops <- matrix(NA,nrow(m.suit)*ncol(m.suit),5)
n<-1
for(i in 1:nrow(m.suit)){
  for(j in 1:ncol(m.suit)){
    resist[n,1] <- n
    pops[n,1] <- n
    if(i+1 <= nrow(m.suit)){
      resist[n,2] <- m.suit[i+1,j]
      pops[n,2] <- pop[i+1,j]
    }
    if(i-1 != 0){
      resist[n,3] <- m.suit[i-1,j]
      pops[n,3] <- pop[i-1,j]
    }
    if(j+1 <= nrow(m.suit)){
      resist[n,4] <- m.suit[i,j+1]
      pops[n,4] <- pop[i,j+1]
    }
    if(j-1 != 0){
      resist[n,5] <- m.suit[i,j-1]
      pops[n,5] <- pop[i,j-1]
    }
    n<-n+1
  }
}
resist
pops

write.table(K,"~/Desktop/Slime/K.txt", row.names=FALSE, col.names=FALSE)
write.table(resist,"~/Desktop/Slime/resist.txt", row.names=FALSE, col.names=FALSE, quote=FALSE)
write.table(pops,"~/Desktop/Slime/pops.txt", row.names=FALSE, col.names=FALSE, quote=FALSE)


library(vcfR)
library(adegenet)
library(ggplot2)

VCF <- read.vcfR("~/Desktop/Slime/slim_practice.vcf")
GL <- vcfR2genlight(VCF)


pca <- glPca(GL)
dat <- as.data.frame(pca$scores)


ggplot(dat, aes(x=dat[,1], y=dat[,2])) + 
  geom_point(alpha=0.5, size=4) + xlab("PC1") + ylab("PC2") +
  #scale_color_manual(name="Site", values=c("darkred","darkorange1")) +
  theme_minimal() + scale_x_continuous(breaks=seq(-20,30,10)) +
  theme(axis.text = element_text(size=14), axis.title = element_text(size=18),
        panel.grid.minor = element_blank(), legend.position = "none")
