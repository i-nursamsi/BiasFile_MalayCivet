#### THIS IS A SIMPLE CODE TO CREATE A BIAS FILE FOR MAXENT SDM
#### Author: ILYAS NURSAMSI
#### Created: 230614




#install all of the necessary packages
install.packages(c('dismo', 'raster'))

#Call all of the necessary packages
library(dismo) # interface with MaxEnt
library(raster) # spatial data manipulation
library(MASS) # for 2D kernel density function
library(magrittr) # for piping functionality, i.e., %>%
library(maptools) # reading shapefiles
library(sf)

#call all of the data needed
occu <- read.csv('Data/Viverra_tangalunga_records_maxent_230614.csv') # The occurrance data
raster <- brick('Data/Forest Integrity SEA Aligned 1km Res NA (0) EPSG4087.tif') #The environmental data to which the grain size and extent should be the same 


#we need to remove the species name column first
occu1 <- occu[,-1]

#rasterize the occu points
occuras <- rasterize(occu1, raster, 1)
plot(occuras)

#mask it to the whole SEA
occur.SEA <- mask(occuras, raster) %>% crop(raster)

presences <- which(values(occur.SEA) == 1)
pres.locs <- coordinates(occur.SEA)[presences, ]

dens <- kde2d(pres.locs[,1], pres.locs[,2], n = c(nrow(occur.SEA), ncol(occur.SEA)))
dens.ras <- raster(dens)
plot(dens.ras)




library(sf)

# Read the CSV file
occu <- read.csv('Data/Viverra_tangalunga_records_maxent_230614.csv')

# Check the coordinate system
coord_sys <- st_crs(occu)

# Print the coordinate system
print(coord_sys)
