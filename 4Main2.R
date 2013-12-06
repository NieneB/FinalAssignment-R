# This is the main.R script for visualizing the amount of Twitter messages in the Netherlands
# Final assignment for the course: Applied Geo-scripting
# author: Niene Boeijen
# reg.nr. 900918-088-070
# date: 05-12-2013

# First set own working directory
setwd("E:/Last_Assignment/FinalAssignment-R")

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

# Installing packages - if needed
source("1Prepare.R")
# Loading in data from WUR database
source("2ReadData.R") # only possible from WUR network to set up database connection!

# Adding extra columns to data file
tweets$date <- format(tweets$tweet_datetime, "%m-%d")
tweets$hour <- as.numeric(format(tweets$tweet_datetime, "%H"))
tweets$datetime <- format(tweets$tweet_datetime, "%m-%d %H")


####################################################################################
# The next files, give a HTML animation of twitter images
# It takes a while but a html file will open automatically
# Allow content to be showed and enjoy! 

# Want the average amount of tweets per hour? #  Medium
source("average_per_hour.R")

# Want the amount of tweets per day?  # long/medium
source("number_day.R")

# Want every hour of all days plotted?  # long
source("day_hour.R")

