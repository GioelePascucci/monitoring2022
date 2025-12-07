# Point pattern analysis
# install.packages("spatstat")
library(spatstat)
#import data from an external source
#set the directory which contains the externel source
#for windows
setwd("C:/Users/gioel/OneDrive - Alma Mater Studiorum Università di Bologna/Magistrale/Monitoring/lab")
#header=TRUE allows to identify the first row as the header of each column
covid<-read.table("covid_agg.csv", header=TRUE)
covid
attach(covid)
#Creates an object of class "ppp" representing a point pattern dataset in the two-dimensional plane. x, y, ranges
#x and y have to be array of coordinates, it this case column_names has been used
#in ranges we are indicating the limits of our coordinates, in this case max e min latitute e longitude have been used
covid_planar <- ppp(lon, lat, c(-180,180), c(-90,90))
#The generic function "density" computes kernel density estimates.
#for further information:https://www.statology.org/kernel-density-plot-r/
#in this case it rapresents with several colors the different density of points
density_map <- density(covid_planar)
plot(density_map)
points(covid_planar)

cl <- colorRampPalette(c('yellow','orange','red'))(100) #
plot(density_map, col = cl)
points(covid_planar)

#change the colour of the map
cl <- colorRampPalette(c('blue','yellow','orange','red','magenta'))(100) #
plot(density_map, col = cl)
points(covid_planar)

# install.packages("rgdal")
library(rgdal)
#he function reads an OGR data source and layer into a suitable Spatial vector Object
coastlines <- readOGR("ne_10m_coastline.shp")
#open the plot session and save the future chart in png format
png("figure1.png")
cl <- colorRampPalette(c('pink','green','orange','red','magenta'))(100)
plot(density_map, col = cl)
points(covid_planar, pch = 19, cex = 0.5)
# Putting the coutnries ontop of the map
plot(coastlines, add = TRUE)
#This function closes the specified plot (by default the current device),
#in this case the chart just plot will be saved as "figure1.png"
dev.off()

pdf("figure1.pdf")
cl <- colorRampPalette(c('pink','green','orange','red','magenta'))(100)
plot(density_map, col = cl)
points(covid_planar, pch = 19, cex = 0.5)
plot(coastlines, add = TRUE)
dev.off()

###### interpolate case data

#change the marks attached to a point pattern dataset.
marks(covid_planar) <- cases
#smooth() adds another layer to the plot and allows to better understand the trend of the chart
cases_map <- Smooth(covid_planar)

plot(cases_map, col = cl)
points(covid_planar)
plot(coastlines, add = T)

# install sf (simple features) package by:
# install.packages("sf")
library(sf)
#Convert foreign object to an sf object
Spoints <- st_as_sf(covid, coords = c("lon", "lat"))

cl <- colorRampPalette(c('lightpink2','lightsalmon','tomato1','red3','maroon'))(100)
plot(cases_map, col = cl)
plot(Spoints, cex=Spoints$cases/10000, col = 'purple3', lwd = 3, add=T)

library(rgdal)
# put a smoother to the coastlines by resampling
#he function reads an OGR data source and layer into a suitable Spatial vector Object
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)
