#brick to import all, like a unique block
#used "brick" because the image imported is composed by four bands NIR (infrared) one,
#Green one,Red one and Blue one. The main problem is that we can only choose 3 bands
#to show and so we decide to assign a color every band, usually vegetation is the NIR band
#sometimes, unknow band order may happen, in this case we have to search a metadata files
#or try to assign order to bands and analyse the showed result in order to understand
#the order.
#a river in different periods of remote sensing may be colored with different color
#this effect depends by th amount of sediment/soil inside th river
#darker river--> less sediment/soil
#lighter river--> more sediment/soil
#informations go from 0 to 255 because it's an  eight-image (2^(n-1)).
#unsupervised classification--->all it's done by the application (unsupervised)
#even if in classification plot we see a graduation between 1.0 and 2.0 in reality
#in the image we have only class 1 (agriculture field) or class 2 (forest)
#R uses a dot to separate integer from decimal
#function data.frame(column names)
#with the use "+" we can simply add element to an a ggplot chart
#stat="identity" deal with the use of real data not mean or deviance, leaves the data unchanged
#the "pathwork" package allow to make chart conftontation more easily than the function "par)
#with the package "viridis" we are able to select preconfigured palette colors
#remnember to avoid problematic palette for daltonism problem, like the raimbow one


#install.packages("raster")
#install.packages("RStoolbox")

library(raster)
library(RStoolbox)
setwd("C:/Users/gioel/OneDrive - Alma Mater Studiorum Università di Bologna/Magistrale/Monitoring/lab/"
p224r63_2011 <- brick("p224r63_2011_masked.grd")

p224r63_2011

plot(p224r63_2011)

cl <- colorRampPalette(c('black','grey','light grey'))(100) #
plot(p224r63_2011, col=cl)


par(mfrow=c(2,2))

clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) #
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c('dark green','green','light green'))(100) #
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c('dark red','red','pink'))(100) #
plot(p224r63_2011$B3_sre, col=clr)


clnir <- colorRampPalette(c('red','orange','yellow'))(100) #
plot(p224r63_2011$B4_sre, col=clnir)


plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#

par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")



p224r63_2011 <- brick("p224r63_2011_masked.grd")

p224r63_2011

plot(p224r63_2011)

cl <- colorRampPalette(c('black','grey','light grey'))(100) #
plot(p224r63_2011, col=cl)


par(mfrow=c(2,2))

clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) #
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c('dark green','green','light green'))(100) #
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c('dark red','red','pink'))(100) #
plot(p224r63_2011$B3_sre, col=clr)


clnir <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=clnir)

# dev.off()
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#

par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
