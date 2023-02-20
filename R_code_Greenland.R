#R code on Greenland ice melt

#install.package("raster")
#install.package("ggplot2")
library(patchwork)
library(viridis)
library(raster)
library(ggplot2)
library(RStoolbox) #it's mandatory to use geom_raster() in ggplot2
setwd("C:/Users/gioel/OneDrive - Alma Mater Studiorum Università di Bologna/Magistrale/Monitoring/lab/")

#usually a satellite image is composed by different levels, different bricks, to import all the layers we should use 
#"brick" function but to import a single brick/layers the "raster" function is the right one


lst_2000<- raster("lst_2000.tif")
p0<-ggplot() +
  geom_raster(lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) + #if we use geom_raster()
  #without library(RStoolbox) we will get an error by ggplot2
  scale_fill_viridis(option="mako", direction=1, alpha=0.8)+#remember not use "rainbow" or "turbo"
  ggtitle("Temperature 2000")  

lst_2005<- raster("lst_2005.tif")
p5<-ggplot() +
  geom_raster(lst_2005, mapping = aes(x=x, y=y, fill=lst_2005)) + #if we use geom_raster()
  #without library(RStoolbox) we will get an error by ggplot2
  scale_fill_viridis(option="mako", direction=1, alpha=0.8)+#remember not use "rainbow" or "turbo"
  ggtitle("Temperature 2005")  

lst_2010<- raster("lst_2010.tif")
p10<-ggplot() +
  geom_raster(lst_2010, mapping = aes(x=x, y=y, fill=lst_2010)) + #if we use geom_raster()
  #without library(RStoolbox) we will get an error by ggplot2
  scale_fill_viridis(option="mako", direction=1, alpha=0.8)+#remember not use "rainbow" or "turbo"
  ggtitle("Temperature 2010")  

lst_2015<- raster("lst_2015.tif")
p15<-ggplot() +
  geom_raster(lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) + #if we use geom_raster()
  #without library(RStoolbox) we will get an error by ggplot2
  scale_fill_viridis(option="mako", direction=1, alpha=0.8)+#remember not use "rainbow" or "turbo"
  ggtitle("Temperature 2015")

p0+p5+p10+p15

rlist <- list.files(pattern="lst")
rlist

import <- lapply(rlist,raster)
import
TGr <- stack(import)
TGr
plot(TGr)

p1 <- ggplot() +
  geom_raster(TGr[[1]], mapping = aes(x=x, y=y, fill=lst_2000)) +
  ggtitle("lst 2000") +
  scale_fill_viridis(option="mako", alpha=0.8, direction=-1)

p2 <- ggplot() +
  geom_raster(TGr[[4]], mapping = aes(x=x, y=y, fill=lst_2015)) +
  ggtitle("lst 2015") +
  scale_fill_viridis(option="mako", alpha=0.8, direction=-1)

p1 + p2
dift=TGr[[4]]-TGr[[1]]

p3 <- ggplot() +
  geom_raster(dift, mapping = aes(x=x, y=y, fill=layer)) +
  ggtitle("Difference in temperature") +
  scale_fill_viridis(option="inferno", alpha=0.8, direction=-1)

p1+p2+p3
plotRGB(TGr, r=1, g=2, b=4, stretch="lin")

