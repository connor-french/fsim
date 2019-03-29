#convert ascii as output by the raster() package to 
library(data.table)
library(magrittr)
library(stringr)
library(raster)
library(dplyr)

function(path, head_lines = 0){
  asc_vec <- fread(path, skip = head_lines) %>% 
    as.matrix() %>% 
    t() %>% 
    as.vector() %>% 
    tibble::enframe(c("pop")) %>% 
    transmute(pop, suitability = value)
  
  
  return(asc_vec)
}
