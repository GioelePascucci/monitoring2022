#install.packages("sp")
#the "sp" packages allows to deal with spatial data
library(sp)
#Loads specified data sets, or list the available data sets
data(meuse)
#This data set gives locations and topsoil heavy metal concentrations
#collected in a flood plain of the river Meuse, near the village of Stein (NL)
meuse
#show the dataframe headers and its first lines
head(meuse)
#set coordinates for spatial data,
#in this case we are indicating the columns with coordinates
coordinates(meuse)=⁓x+y
plot(meuse)
#to show the "zinc" Concentration values in the same coordinates set before
spplot(meuse, "zinc", main="Concentration of zinc")
spplot(meuse, "copper", main="Concentration of copper")
spplot(meuse, c("copper","zinc"))
#to use bubble instead colours to rapresent bigger concentrations
bubble(meuse, "zinc")
bubble(meuse, "lead")
bubble(meuse, "lead", col="red")
sessionInfo()
Sys.time()
