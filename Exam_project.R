install.packages("ncdf4")
install.packages("rnaturalearth")
install.packages("rnaturalearthdata")
intall.packages("raster")
install.packages("RStoolbox")
install.packages("viridis")
install.packages("patchwork")
installed.packages("rgdal")
install.packages("sf")
library(ncdf4)
library(raster)
library(ggplot2)
library(RStoolbox)
library(viridis)
library(patchwork)
library(rgdal)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
setwd("C:/Users/gioel/OneDrive - Alma Mater Studiorum Università di Bologna/Magistrale/Monitoring/lab/")

#import maps of monthly methane surface emissions (Kg/m2/second)
#period of 2019 siberian wild fire was summer 2019 (july-september)
#may
  #may from burning biomass
  mmay_fr <- brick("cams73_latest_ch4_flux_surface_satellite_mm_201905.nc", varname="ch4_emis_biomass_burning")
  names(mmay_fr)<- "May_2019"
  #may from wetlands
  mmay_wl <- brick("cams73_latest_ch4_flux_surface_satellite_mm_201905.nc", varname="ch4_emis_wetlands")
  names(mmay_wl)<- "May_2019"
  #may total emission
  mmay_te <- brick("cams73_latest_ch4_flux_surface_satellite_mm_201905.nc", varname="ch4_emis_total")
  names(mmay_te)<- "May_2019"
  mmay<-stack(mmay_fr,mmay_wl,mmay_te)

#july
  #july from burning biomass
  mjuly_fr <- brick("cams73_latest_ch4_flux_surface_satellite_mm_201907.nc", varname="ch4_emis_biomass_burning")
  names(mjuly_fr)<- "July_2019"
  #july from wetlands
  mjuly_wl <- brick("cams73_latest_ch4_flux_surface_satellite_mm_201907.nc", varname="ch4_emis_wetlands")
  names(mjuly_wl)<- "July_2019"
  #july total emission
  mjuly_te <- brick("cams73_latest_ch4_flux_surface_satellite_mm_201907.nc", varname="ch4_emis_total")
  names(mjuly_te)<- "July_2019"
  mjuly<- stack(mjuly_fr,mjuly_wl,mjuly_te)

#august
  #August from burning biomass
  maugust_fr <- brick("cams73_latest_ch4_flux_surface_satellite_mm_201908.nc", varname="ch4_emis_biomass_burning")
  names(maugust_fr)<- "August_2019"
  #August from wetlands
  maugust_wl <- brick("cams73_latest_ch4_flux_surface_satellite_mm_201908.nc", varname="ch4_emis_wetlands")
  names(maugust_wl)<- "August_2019"
  #August total emission
  maugust_te <- brick("cams73_latest_ch4_flux_surface_satellite_mm_201908.nc", varname="ch4_emis_total")
  names(maugust_te)<- "August_2019"
#semptember
  #semptember from burning biomass
  mseptember_fr <- brick("cams73_latest_ch4_flux_surface_satellite_mm_201909.nc", varname="ch4_emis_biomass_burning")
  names(mseptember_fr)<- "September_2019"
  #september from wetlands
  mseptember_wl <- brick("cams73_latest_ch4_flux_surface_satellite_mm_201909.nc", varname="ch4_emis_wetlands")
  names(mseptember_wl)<- "September_2019"
  #semptember total emission
  mseptember_te <- brick("cams73_latest_ch4_flux_surface_satellite_mm_201909.nc", varname="ch4_emis_total")
  names(mseptember_te)<- "September_2019"

#Create rasterstack by kind of emission (not by month)
  m_fr<- stack(mmay_fr,mjuly_fr,maugust_fr,mseptember_fr)
  m_wl<- stack(mmay_wl,mjuly_wl,maugust_wl,mseptember_wl)
  m_te<- stack(mmay_te,mjuly_te,maugust_te,mseptember_te)
#Set siberian crop coordinates
  x_siberia<-c(80, 175)
  y_siberia<-c(30,80)
  siberia_ext <- c(x_siberia,y_siberia)
#Crop siberian region from the raster stacks
  m_fr<- crop(m_fr,siberia_ext)
  m_wl<- crop(m_wl,siberia_ext)
  m_te<- crop(m_te,siberia_ext)
#Create a sf world map, with also latitude,longitude, continents/countries list
  worldmap <- ne_countries(scale = "medium", type = "map_units", returnclass = "sf")

#Save the plots for furture analyses (Kg of carbon/m2/second)
  
  #plot of burning biomass methane emission (pm_fr)
  pm_fr_may<-ggplot() + 
    ggtitle("CH4 emission - biomass burning (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(m_fr[[1]], mapping = aes(x=x, y=y, fill=May_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  pm_fr_july<-ggplot() + 
    ggtitle("CH4 emission - biomass burning (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(m_fr[[2]], mapping = aes(x=x, y=y, fill=July_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  pm_fr_august<- ggplot() + 
    ggtitle("CH4 emission - biomass burning (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(m_fr[[3]], mapping = aes(x=x, y=y, fill=August_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  pm_fr_september<- ggplot() + 
    ggtitle("CH4 emission - biomass burning (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(m_fr[[4]], mapping = aes(x=x, y=y, fill=September_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  pm_fr<-pm_fr_may+pm_fr_july+pm_fr_august+pm_fr_september #patchwork of burning biomass plots
  #export the plot
  png("methane_burnemission.png")
  print(pm_fr)
  dev.off()
  #plot of wetlands methane emission (pm_wl)
  pm_wl_may<-ggplot() + 
    ggtitle("CH4 wetland emissions (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(m_wl[[1]], mapping = aes(x=x, y=y, fill=May_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  pm_wl_july<-ggplot() + 
    ggtitle("CH4 wetland emissions (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(m_wl[[2]], mapping = aes(x=x, y=y, fill=July_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  pm_wl_august<- ggplot() + 
    ggtitle("CH4 wetland emissions (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(m_wl[[3]], mapping = aes(x=x, y=y, fill=August_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  pm_wl_september<- ggplot() + 
    ggtitle("CH4 wetland emissions (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(m_wl[[4]], mapping = aes(x=x, y=y, fill=September_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  pm_wl<-pm_wl_may+pm_wl_july+pm_wl_august+pm_wl_september #patchwork of wetlands plots
  #Save wetland methane emission 
  png("methane_wlemission.png")
  print(pm_wl)
  dev.off()
  #plot of total methane emission (pm_te)
  pm_te_may<-ggplot() + 
    ggtitle("Total CH4 emissions (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(m_te[[1]], mapping = aes(x=x, y=y, fill=May_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  pm_te_july<-ggplot() + 
    ggtitle("Total CH4 emissions (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(m_te[[2]], mapping = aes(x=x, y=y, fill=July_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  pm_te_august<- ggplot() + 
    ggtitle("Total CH4 emissions (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(m_te[[3]], mapping = aes(x=x, y=y, fill=August_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  pm_te_september<- ggplot() + 
    ggtitle("Total CH4 emissions (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(m_te[[4]], mapping = aes(x=x, y=y, fill=September_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  pm_te<-pm_te_may+pm_te_july+pm_te_august+pm_te_september #patchwork of total emissions plots
  
  #Save boxplot of wetland methane emission 
  png("boxplot_wlemission.png")
  boxplot(m_wl,outline=F,horizontal=F,axes=T,main="Wetland methane emissiom (Siberia, 2019)",col="blue", ylab="KgC/m^2*S", xlab="Month")
  dev.off()
  #Save boxplot of total methane emission 
  png("boxplot_teemission.png")
  boxplot(m_te,outline=F,horizontal=F,axes=T,main="Total methane emissiom (Siberia, 2019)",col="blue", ylab="KgC/m^2*S", xlab="Month")
  dev.off()
    
#import maps of monthly co2 surface emissions by biosphere/inland (Kg of carbon/m2/second)
  #may
  cmay_fr <- brick("cams73_latest_co2_flux_surface_mm_201905.nc", varname="flux_apos_bio")
  names(cmay_fr)<- "May_2019"
  #July
  cjuly_fr <- brick("cams73_latest_co2_flux_surface_mm_201907.nc", varname="flux_apos_bio")
  names(cjuly_fr)<- "July_2019"
  #August
  caugust_fr <- brick("cams73_latest_co2_flux_surface_mm_201908.nc", varname="flux_apos_bio")
  names(caugust_fr)<- "August_2019"
  #September
  cseptember_fr <- brick("cams73_latest_co2_flux_surface_mm_201909.nc", varname="flux_apos_bio")
  names(cseptember_fr)<- "September_2019"
  
  #Create a new stack and crop it
  c_fr<-stack(cmay_fr,cjuly_fr,caugust_fr,cseptember_fr)
  c_fr<-crop(c_fr,siberia_ext)
  #make plot and add world map 
  p_cfr_may<-ggplot() + 
    ggtitle("Inland Co2 emissions (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(c_fr[[1]], mapping = aes(x=x, y=y, fill=May_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  p_cfr_july<-ggplot() + 
    ggtitle("Inland Co2 emissions (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(c_fr[[2]], mapping = aes(x=x, y=y, fill=July_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  p_cfr_august<- ggplot() + 
    ggtitle("Inland Co2 emissions (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(c_fr[[3]], mapping = aes(x=x, y=y, fill=August_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  p_cfr_september<- ggplot() + 
    ggtitle("Inland Co2 emissions (Siberia, 2019)")+
    geom_sf(data = worldmap) +
    coord_sf(xlim =x_siberia, ylim = y_siberia, expand = FALSE) +
    theme_bw()+
    xlab("Longitude") + ylab("Latitude")+
    geom_raster(c_fr[[4]], mapping = aes(x=x, y=y, fill=September_2019))+
    scale_fill_viridis(option="viridis", alpha=0.8,direction=1)
  p_cfr<-p_cfr_may+p_cfr_july+p_cfr_august+p_cfr_september #patchwork of co2 emission
  #export plot of CO2 emissiom
  png("boxplot_co2emission.png")
  boxplot(c_fr,outline=F,horizontal=F,axes=T,main="Inland CO2 net-emission (Siberia, 2019)",col="red", ylab="KgC/m^2*S", xlab="Month")
  dev.off()
#import maps of albedo and create a stack
#data of albedo deal with the same timeline of wildfire (summer 2019)

  #import the albedo raster layers
  #be sure that WD is correctly set, otherwise use an absolute directory path
  rlist_2019<-list.files(pattern="albedo_2019")
  import_2019 <- lapply(rlist_2019,raster)
  albedo_2019 <-stack(import_2019)
  rlist_2018<-list.files(pattern="albedo_2018")
  import_2018 <- lapply(rlist_2018,raster)
  albedo_2018 <-stack(import_2018)
  #Rename layers
  names(albedo_2019)<- c("June","July","August_13rd","August_24th","September")
  names(albedo_2018)<- c("July","August_13rd")
  #crop albedo stack over siberia
  albedo_2019<-crop(albedo_2019,siberia_ext)
  albedo_2018<-crop(albedo_2018,siberia_ext)
  #create a stack for albedo 2018 vs albedo 2019 (same months)
  albedo_18vs19<-stack(albedo_2018[[2]],albedo_2019[[3]])
  names(albedo_18vs19)<-c("August_2018","August_2019")
  #check and plot the albedo stacks
  plot(albedo_2019,main="Albedo (Siberia,2019)")
  #boxplot with correction of outliers and export
  png("albedo_19.png")
  boxplot(albedo_2019,outline=F,horizontal=F,axes=T,main="Albedo (Siberia,2019)",col="orange", ylab="Albedo", xlab="Month")
  dev.off()
  
  png("albedo_18vs19.png")
  boxplot(albedo_18vs19,outline=F,horizontal=F,axes=T,main="Albedo (Siberia, 2018 vs 2019)",col=c("yellow","orange"), ylab="Albedo", xlab="Month")
  dev.off()
#import maps of surface temperature and create a stack
#data of surface temperature deal with the same timeline of wildfire (summer 2019)   
  
  surtemp_june<-raster("surftemp_201906210000.nc",varname="MIN") 
  surtemp_july<-raster("surftemp_201907210000.nc",varname="MIN")
  surtemp_aug1<-raster("surftemp_201908010000.nc",varname="MIN")
  surtemp_aug2<-raster("surftemp_201908210000.nc",varname="MIN")
  surtemp_sept<-raster("surftemp_201909110000.nc",varname="MIN")
  surface_temp<-stack(surtemp_june,surtemp_july,surtemp_aug1,surtemp_aug2,surtemp_sept)
  #Rename layers
  names(surface_temp)<- c("June","July_31st","August_11st","August_31st","September")
  #crop surface_temp stack over siberia
  surface_temp<-crop(surface_temp,siberia_ext)
  #check and plot the surface_temp stack
  #plot(surface_temp,main="Minimum temperature (Siberia,2019)")  # unit-->Kelvin
  #boxplot with correction of outliers
  #boxplot_surtemp<-boxplot(surface_temp,outline=F,horizontal=F,axes=T,main="Minimum temperature (Siberia,2019)",col="brown", ylab="Temperature (K)", xlab="Month")    
  #export it
  png("surface_temp.png")
  boxplot(surface_temp,outline=F,horizontal=F,axes=T,main="Minimum temperature (Siberia,2019)",col="brown", ylab="Temperature (K)", xlab="Month")
  dev.off()