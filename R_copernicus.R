# R_code_snow.r

# Copernicus set:
# i

# Register and Login
# Download data from Criosphere
# The arrow should be blue
# Info: https://land.copernicus.eu/global/content/sce-nhemi-product-s-npp-viirs-data-affected

# install.packages("ncdf4")
library(ncdf4)
library(raster)
library(ggplot2)
library(RStoolbox)
library(viridis)
library(patchwork)

#usually a satellite image is composed by different levels, different bricks, to import all the layers we should use 
#"brick" function but to import a single brick/layers the "raster" function is the right one
snow <- raster("C:/Users/gioel/OneDrive - Alma Mater Studiorum Università di Bologna/Magistrale/Monitoring/lab/c_gls_SCE_202012210000_NHEMI_VIIRS_V1.0.1.nc")

ggplot() +
  geom_raster(snow, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
  scale_fill_viridis(option="mako")#remember not use "rainbow" or "turbo"

# Crop over Europe
ext <- c(-20, 70, 20, 75)
snow_europe <- crop(snow, ext)
ggplot() +
  geom_raster(snow_europe, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
  scale_fill_viridis(option="mako")

p1 <- ggplot() +
  geom_raster(snow, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
  scale_fill_viridis(option="mako")

p2 <- ggplot() +
  geom_raster(snow_europe, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
  scale_fill_viridis(option="mako")

p1 + p2

#----------