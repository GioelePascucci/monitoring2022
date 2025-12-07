# Brick to import all bands together as a single block.
# The term "brick" is used because the imported image is composed of four bands:
# NIR (infrared), Green, Red, and Blue. The main issue is that we can choose
# only three bands to display at once, so we assign one color to each band.
# Vegetation is usually associated with the NIR band.
# Sometimes, the band order may be unknown; in such cases, we must search for
# metadata files or try assigning band orders and visually analyze the result
# to determine the correct order.
# A river may appear with different colors in remote sensing images taken at
# different times. This effect depends on the amount of sediment/soil in the river:
# darker river → less sediment/soil
# lighter river → more sediment/soil
# Pixel values range from 0 to 255 because this is an 8-bit image (2^(n-1)).
# Unsupervised classification → everything is processed automatically by the application.
# Even if the classification plot shows a gradient between 1.0 and 2.0,
# in the image we actually have only class 1 (agricultural field) or class 2 (forest).
# R uses a dot to separate integers from decimals.
# Function data.frame(column names)
# With the "+" operator we can simply add elements to a ggplot chart.
# stat = "identity" uses raw data, not means or deviations; it leaves the data unchanged.
# The "patchwork" package allows easier chart comparison than using the "par" function.
# With the "viridis" package we can select preconfigured color palettes.
# Remember to avoid problematic palettes for color-blind users, such as the rainbow one.


# Install necessary packages if not already installed
#install.packages("raster")
#install.packages("RStoolbox")

# Load required libraries
library(raster)
library(RStoolbox)

# Set working directory (where the image file is located)
setwd("C:/Users/gioel/OneDrive - Alma Mater Studiorum Università di Bologna/Magistrale/Monitoring/lab/")

# Load the raster image as a brick (multi-band raster)
p224r63_2011 <- brick("p224r63_2011_masked.grd")

# Print summary of the raster brick
p224r63_2011

# Plot all bands of the raster brick
plot(p224r63_2011)

# Create a grayscale color palette for plotting single band images
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plot(p224r63_2011, col=cl)

# Arrange plotting area for 2x2 plots
par(mfrow=c(2,2))

# Create color palettes for each band and plot them individually

# Blue band palette
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
plot(p224r63_2011$B1_sre, col=clb)

# Green band palette
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)

# Red band palette
clr <- colorRampPalette(c('dark red','red','pink'))(100) 
plot(p224r63_2011$B3_sre, col=clr)

# NIR band palette
clnir <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(p224r63_2011$B4_sre, col=clnir)

# Plot RGB composites using different band combinations
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") # Red-Green-Blue
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") # NIR-Red-Green
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") # Red-NIR-Green
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin") # Red-Green-NIR

# Repeat RGB plots in a 2x2 layout for comparison
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

# Reload the raster brick (optional, redundant)
p224r63_2011 <- brick("p224r63_2011_masked.grd")

# Print summary of the raster brick again
p224r63_2011

# Plot all bands again with grayscale
plot(p224r63_2011)
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plot(p224r63_2011, col=cl)

# Plot individual bands again using the color palettes
par(mfrow=c(2,2))
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
plot(p224r63_2011$B1_sre, col=clb)
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)
clr <- colorRampPalette(c('dark red','red','pink'))(100) 
plot(p224r63_2011$B3_sre, col=clr)
clnir <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=clnir)

# Plot RGB composites again
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

# Repeat RGB plots in 2x2 layout again
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
