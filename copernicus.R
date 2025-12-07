# R_code_snow.r

# Copernicus dataset:
# i

# Register and log in to Copernicus to download data from the Cryosphere service.
# The download arrow should be blue.
# Info: https://land.copernicus.eu/global/content/sce-nhemi-product-s-npp-viirs-data-affected

# Install necessary package for reading NetCDF files if not already installed
# install.packages("ncdf4")

# Load required libraries
library(ncdf4)       # To handle NetCDF (.nc) files
library(raster)      # For raster data manipulation
library(ggplot2)     # For plotting
library(RStoolbox)   # Remote sensing tools (optional here)
library(viridis)     # Preconfigured color palettes
library(patchwork)   # Combine multiple ggplot plots

# Usually, a satellite image is composed of multiple levels or bricks.
# To import all layers at once, we use the "brick" function.
# To import a single layer, we use the "raster" function.
snow <- raster("C:/Users/gioel/OneDrive - Alma Mater Studiorum Università di Bologna/Magistrale/Monitoring/lab/c_gls_SCE_202012210000_NHEMI_VIIRS_V1.0.1.nc")

# Plot the snow cover raster using ggplot2
ggplot() +
  geom_raster(snow, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
  scale_fill_viridis(option="mako") # Use viridis palette, avoid "rainbow" or "turbo"

# Crop the raster to focus on Europe
ext <- c(-20, 70, 20, 75)           # xmin, xmax, ymin, ymax
snow_europe <- crop(snow, ext)      # Crop raster to Europe

# Plot cropped Europe raster
ggplot() +
  geom_raster(snow_europe, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
  scale_fill_viridis(option="mako")

# Create separate plots for comparison
p1 <- ggplot() +
  geom_raster(snow, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
  scale_fill_viridis(option="mako")

p2 <- ggplot() +
  geom_raster(snow_europe, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
  scale_fill_viridis(option="mako")

# Combine the two plots side by side using patchwork
p1 + p2

#----------
