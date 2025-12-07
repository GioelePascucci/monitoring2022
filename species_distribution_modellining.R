#install.packages("sdm")
#install.packages("rgdal")
#install.packages("raster")
library(sdm)
library(rgdal)
library(raster)
#"external" in the path is simply a folder inside sdm package
# .shp mean that is a shaped file
file <- system.file("external/species.shp", package="sdm")
species<-shapefile(file)
species
species$Occurrence
plot(species)
#with == (like in Sql) you select only the value equal to 1 (=1)
presences$Occurrence
absences$Occurrence
plot(presences,col='blue',pch=19)
#not use plot again it would eliminate the previous plot
points(absences,col='red',pch=16)
path <- system.file("external", package="sdm")
lst <- list.files(path=path,pattern='asc$',full.names = T)
lst
#Stacking vectors concatenates multiple vectors into a single vector 
preds <- stack(lst)

# plot preds (predictors)
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

# plot predictors and occurrences
plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# model

# set the data for the sdm
datasdm <- sdmData(train=species, predictors=preds)
datasdm
# model
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")
# make the raster output layer
p1 <- predict(m1, newdata=preds) 

# plot the output
plot(p1)
points(species[species$Occurrence == 1,], pch=16)

#final stack
s1<-stack(preds, p1)
plot(s1, col=cl)
#like a normal vector we can change names of stack elements
names(s1) <- c('elevation', 'precipitation', 'temperature', 'vegetation', 'model')
plot(s1, col=cl)


