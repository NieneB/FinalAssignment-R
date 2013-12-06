# This is 2ReadData.R script
# To run this script is only possible from WUR network to set up database connection!
# Twitter list is accessed
# a empty raster with defined settings is created

##################### getting twitter data ##############

if(file.exists("data\\all_tweet.rda")) {
  load("data\\all_tweet.rda")
} else {
    drv <- dbDriver("PostgreSQL")
    con <- dbConnect(drv, dbname = "gis", user = "gisuser", password = "user", host = "10.75.14.108")
    dbListTables(con)
    dbGetInfo(drv)
    summary(con)
    tweets <- dbReadTable(con,name="geotweets")
    save(tweets, file = "data\\all_tweet.rda", compress = "xz")
}

#################### empty raster with right extent, projection and resolution ########

ex <- c(3.2,7.24,50.75,53.75)                                     # Extent NL
pr <- "+proj=sterea +lat_0=52.0922178 +lon_0=5.23155              # Projection RDnew
    +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel
    +units=m +no_defs"
c <- CRS(pr)                                                      # CRS RDnew

res <- 0.01                                                       # Resolution to be defined


# making empty raster
r <- raster()
proj4string(r) <- c
extent(r) <- ex
res(r) <- res
r