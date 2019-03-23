#convert ascii as output by the raster() package to 
library(data.table)
library(magrittr)
library(stringr)
library(dplyr)

trial.asc <- fread("/Users/connorfrench/Dropbox/Old_Mac/School_Stuff/MastersProject/Chapter_2/landscape_genetics_2019/resistance_ga_results/all.combrep_1/single.surface/clim_current_frictionlayer.asc", 
                   skip = 6) %>% 
  as.matrix()


trial.vec <- setNames(melt(trial.asc), c("x", "y", "suitability")) %>% 
  mutate(y = str_sub(y, -1)) %>% 
  mutate(suitability = floor(suitability)) %>% 
  mutate(pops = row_number()) %>% 
  select(pops, everything()) #move column to front


  
fwrite(trial.vec, "~/Desktop/trial_vec.csv")



stocks <- tibble(
  time = as.Date('2009-01-01') + 0:9,
  X = rnorm(10, 0, 1),
  Y = rnorm(10, 0, 2),
  Z = rnorm(10, 0, 4)
)

gather(stocks, "stock", "price", -time)
stocks %>% gather("stock", "price", -time)