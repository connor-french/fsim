#convert ascii as output by the raster() package to 
library(data.table)
library(magrittr)
library(stringr)
library(raster)
library(dplyr)


output_files <- function(path, head_lines = 6, k_fun = "multiply", kmax = 1000){
  asc_mat <- fread(path, skip = head_lines) %>% 
    as.matrix() 

  #convert to a square matrix if the input is retangular
  if (dim(asc_mat)[1] != dim(asc_mat)[2]){
    d <- dim(asc_mat)
    asc_mat <- rbind(asc_mat, matrix(-9999, diff(d), ncol(asc_mat)))
  }
  
  print(asc_mat)
  
  #make k matrix
  if (k_fun == "multiply")
    k <- ceiling(asc_mat * kmax)
    
  
  # Make population matrix
  pop <- matrix(1:nrow(m.suit)*ncol(m.suit),nrow(m.suit),ncol(m.suit), byrow = TRUE)
  
  
  # Make a migration matrix
  
  suit <- matrix(-9999,nrow(asc_mat)*ncol(asc_mat),5)
  pops <- matrix(-9999,nrow(asc_mat)*ncol(asc_mat),5)
  print(suit)
  print(pops)
  
  n<-1
  for(i in 1:ncol(asc_mat)){
    for(j in 1:nrow(asc_mat)){
      suit[n,1] <- n
      pops[n,1] <- n
      if(i+1 <= ncol(asc_mat)){
        suit[n,2] <- asc_mat[i+1,j]
        pops[n,2] <- pop[i+1,j]
      }
      if(i-1 != 0){
        suit[n,3] <- asc_mat[i-1,j]
        pops[n,3] <- pop[i-1,j]
      }
      if(j+1 <= ncol(asc_mat)){
        suit[n,4] <- asc_mat[i,j+1]
        pops[n,4] <- pop[i,j+1]
      }
      if(j-1 != 0){
        suit[n,5] <- asc_mat[i,j-1]
        pops[n,5] <- pop[i,j-1]
      }
      n<-n+1
    }
  }
  
  
  
  return(list(pops = pops, suit = suit, k = k))
}


