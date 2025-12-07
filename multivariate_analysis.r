#install.packages(vegan)
##vegan is used for vegetational ecology
library('vegan')
#set the directory which contains the externel source
#for windows
setwd("C:/Users/gioel/OneDrive - Alma Mater Studiorum Università di Bologna/Magistrale/Monitoring/lab")
#load an entire R project, an entire workspace
load("biomes_multivar.RData")
#like in linux terminal use ls() to show file inside R project
ls()
haed(biomes)
#
multivar<-decorana(biomes)
plot(multivar)
