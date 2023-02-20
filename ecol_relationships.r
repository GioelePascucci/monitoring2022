#install.packages("sp")
#the "sp" packages allows to deal with spatial data
library(sp)
#Loads specified data sets, or list the available data sets
data(meuse)
#This data set gives locations and topsoil heavy metal concentrations
#collected in a flood plain of the river Meuse, near the village of Stein (NL)
meuse
#show a dataframe in a graphic way (not inside the terminal)
View(meuse)
#show the dataframe headers and its first lines
head(meuse)
summary(meuse)
#allow to fix/set a specific dataframe without using dataframe$column_name
#to refer to a sepcific column, but only using the column_name
attach(meuse)
plot(cadmium, zinc)
plot(cadmium,lead)
# a matrix of scatterplots is produced
pairs(meuse)

#library(sp)
#data(meuse)
#pairs(meuse)
#head(meuse)
#produce a matrix of scatterplots with only some columns, from third column to sixth one
pairs(meuse[,3:6])
#produce a matrix of scatterplots with only some columns using column names instead saying column numbers
pairs(~ cadmium + copper + lead + zinc, data=meuse)
pairs(~ cadmium + lead + zinc, data=meuse)
pairs(~ cadmium + copper + lead + zinc, data=meuse, col="red")
pairs(~ cadmium + copper + lead + zinc, data=meuse, col="red", pch=17)
pairs(~ cadmium + copper + lead + zinc, data=meuse, col="red", pch=17, cex=3)
sessionInfo()
Sys.time()
