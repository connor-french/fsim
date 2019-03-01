library(raster)

r <- raster(resolution = 5)
r[] <- runif(ncell(r))
one <-ncol(r) / 2

s <- rep(c(rep(1, one), rep(0, one)), 13) 
t <- rep(c(rep(0, one), rep(1, one)), 13)
j <- rep(0, ncell(r) - (length(s) + length(t)))

f <- c(s, j, t)

r[] <- f
plot(r)
writeRaster(r, 
            filename = "/Users/connorfrench/Dropbox/Old_Mac/School_Stuff/CUNY/fsim/practice/connor_sim_raster_2pop.asc",
            format = "ascii")


r_trial <- raster("/Users/connorfrench/Dropbox/Old_Mac/School_Stuff/CUNY/fsim/practice/connor_sim_raster_2pop.asc")
plot(r_trial)
