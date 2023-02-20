#build advanced plots using "ggplot2" package
#install.packages("ggplo2") if not yet installed
library(ggplot2)
biofuels <- c(120, 200, 350, 570, 750)
biofuels
oxydative <- c(1200, 1300, 21000, 34000, 50000)
d <- data.frame(biofuels, oxydative)
d
#geom_point() is usefull for scatter plots
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_point()
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_point(size = 5, col = "red")
#add a  line to link the points
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_line()
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_point(size = 5, col = "red") + geom_line()
#geom_polygon() fill with colour the space between the line joining the points
#and a second line which link the first one and the last one
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_polygon()

##################How to import data from an external source##########
#set the directory which contains the externel source
#for windows
setwd("C:/Users/gioel/OneDrive - Alma Mater Studiorum Università di Bologna/Magistrale/Monitoring/lab")
#header=TRUE allows to identify the first row as the header of each column
covid<-read.table("covid_agg.csv", header=TRUE)
covid
#Returns the first parts of a vector, matrix, table, data frame or function
head(covid)
summary(covid)
library(ggplot2)
ggplot(covid,aes(x=lon, y=lat)) + geom_point()
#use the number of cases like sizer for the points in the plot
ggplot(covid,aes(x=lon, y=lat, size=cases)) + geom_point()
sessionInfo()
Sys.time()
