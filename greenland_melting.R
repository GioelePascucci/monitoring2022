# R code on Greenland ice melt

# Install necessary packages if not already installed
# install.packages("raster")
# install.packages("ggplot2")

# Load required libraries
library(patchwork)   # To combine multiple ggplot plots
library(viridis)     # Preconfigured color palettes
library(raster)      # For raster data manipulation
library(ggplot2)     # For plotting
library(RStoolbox)   # Required for geom_raster() in ggplot2

# Set working directory to the folder containing raster files
setwd("C:/Users/gioel/OneDrive - Alma Mater Studiorum Università di Bologna/Magistrale/Monitoring/lab/")

# Usually, a satellite image is composed of multiple levels or bricks.
# To import all layers at once, use the "brick" function.
# To import a single layer, use the "raster" function.

# Load raster files for different years
lst_2000 <- raster("lst_2000.tif")
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

# Plot temperature raster for 2000 using ggplot2
p0 <- ggplot() +
  geom_raster(lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) +  # geom_raster requires RStoolbox
  scale_fill_viridis(option="mako", direction=1, alpha=0.8) +       # Use viridis palette, avoid "rainbow" or "turbo"
  ggtitle("Temperature 2000")  

# Plot temperature raster for 2005
p5 <- ggplot() +
  geom_raster(lst_2005, mapping = aes(x=x, y=y, fill=lst_2005)) + 
  scale_fill_viridis(option="mako", direction=1, alpha=0.8) +
  ggtitle("Temperature 2005")  

# Plot temperature raster for 2010
p10 <- ggplot() +
  geom_raster(lst_2010, mapping = aes(x=x, y=y, fill=lst_2010)) + 
  scale_fill_viridis(option="mako", direction=1, alpha=0.8) +
  ggtitle("Temperature 2010")  

# Plot temperature raster for 2015
p15 <- ggplot() +
  geom_raster(lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) + 
  scale_fill_viridis(option="mako", direction=1, alpha=0.8) +
  ggtitle("Temperature 2015")

# Combine the four yearly temperature plots side by side
p0 + p5 + p10 + p15

# List all raster files starting with "lst" in the working directory
rlist <- list.files(pattern="lst")
rlist

# Import all listed rasters as RasterLayer objects
import <- lapply(rlist, raster)
import

# Stack all imported rasters into a single RasterStack object
TGr <- stack(import)
TGr
plot(TGr)  # Plot the RasterStack

# Plot first raster (2000) from the stack
p1 <- ggplot() +
  geom_raster(TGr[[1]], mapping = aes(x=x, y=y, fill=lst_2000)) +
  ggtitle("lst 2000") +
  scale_fill_viridis(option="mako", alpha=0.8, direction=-1)

# Plot last raster (2015) from the stack
p2 <- ggplot() +
  geom_raster(TGr[[4]], mapping = aes(x=x, y=y, fill=lst_2015)) +
  ggtitle("lst 2015") +
  scale_fill_viridis(option="mako", alpha=0.8, direction=-1)

# Combine 2000 and 2015 plots side by side
p1 + p2

# Calculate the difference in temperature between 2015 and 2000
dift = TGr[[4]] - TGr[[1]]

# Plot the temperature difference
p3 <- ggplot() +
  geom_raster(dift, mapping = aes(x=x, y=y, fill=layer)) +
  ggtitle("Difference in temperature") +
  scale_fill_viridis(option="inferno", alpha=0.8, direction=-1)

# Combine all three plots: 2000, 2015, and their difference
p1 + p2 + p3

# Plot RGB composite of the raster stack using bands 1, 2, and 4
plotRGB(TGr, r=1, g=2, b=4, stretch="lin")
