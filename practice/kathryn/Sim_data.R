library(raster)
# Make a fake matrix with suitability between 0 and 1
val <- round(runif(9),digits=4)
temp <- matrix(val,3,3)
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
for(i in 1:ncol(m.suit)){
  for(j in 1:nrow(m.suit)){
    pop[i,j] <- n
    n=n+1
  }
}
pop

# Make a weird migration matrix
resist <- matrix(NA,nrow(m.suit)*ncol(m.suit),5)
pops <- matrix(NA,nrow(m.suit)*ncol(m.suit),5)
n<-1
for(i in 1:ncol(m.suit)){
  for(j in 1:nrow(m.suit)){
    resist[n,1] <- n
    pops[n,1] <- n
    if(i+1 <= ncol(m.suit)){
      resist[n,2] <- m.suit[i+1,j]
      pops[n,2] <- pop[i+1,j]
    }
    if(i-1 != 0){
      resist[n,3] <- m.suit[i-1,j]
      pops[n,3] <- pop[i-1,j]
    }
    if(j+1 <= ncol(m.suit)){
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


