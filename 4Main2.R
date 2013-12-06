# This is the main.R script for visualizing the amount of Twitter messages in the Netherlands
# author: Niene Boeijen
# reg.nr. 900918-088-070
# 05-12-2013

# First set own working directory
setwd("E:/Last_Assignment")
# loading libraries
library(extrafont)
library(rgdal)
library(ggplot2)
library(base)
library(raster)
library(RPostgreSQL)
library(maps)
library(OpenStreetMap)
library(animation)
library(sp)

# Installing nececerly packages and loading in the data
source("1Prepare.R")
source("2ReadData.R") # only possible from WUR network to set up database connection!

# Adding extra columns to data
tweets$date <- format(tweets$tweet_datetime, "%m-%d")
tweets$hour <- as.numeric(format(tweets$tweet_datetime, "%H"))
tweets$datetime <- format(tweets$tweet_datetime, "%m-%d %H")


####################################################################################
# The next files, give a HTML animation of twitter images:
# Want every hour of all days plotted? 
source("day_hour.R")
# Want the average amount of tweets per hour? # 
source("average_per_hour.R")
# Want the amount of tweets per day? 
source("number_day.R")


