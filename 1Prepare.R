### setting working directory #####

### installing packages ##########
install.packages("RPostgreSQL")
install.packages("OpenStreetMap")
install.packages("animation")
install.packages("rgdal")
install.packages("gdalUtils", repos="http://R-Forge.R-project.org", dependencies=TRUE)
install.packages("sp", dependencies=TRUE)
install.packages("iterators" , dependencies= TRUE)
install.packages("ggplot2", dependencies= TRUE)
install.packages('extrafont')

library(extrafont)
font_import(y)
loadfonts(device="win")

### loading libraries ############
library(rgdal)
library(ggplot2)
#library(maptools)
#library(RColorBrewer)
#library(foreign)
library(base)
library(raster)
library(RPostgreSQL)
#library(gdalUtils)
library(maps)
library(OpenStreetMap)
library(animation)
library(sp)

