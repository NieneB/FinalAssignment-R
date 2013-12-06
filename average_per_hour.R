# Final assignment for the course: Applied Geo-scripting
# author: Niene Boeijen
# reg.nr. 900918-088-070
# date: 05-12-2013

# This is plotting averages per hour script
# A list is made of all hours
# The average amount per hour is calculated

# subset 
list.hours <- by(tweets, tweets$hour, subset)
list.days <- by(tweets, tweets$date, subset)
n <- length(list.days)

# Making list of dataframes with average tweets per hour
tweets.average <- lapply(list.hours, function(x){
  coordinates(x) <- c("longitude", "latitude")
  proj4string(x) <- pr                                                 
  tweet1 <- spTransform(x, c)  
  tweet2 <- rasterize(tweet1, r, field = tweet1$gid, fun= 'count', na.rm = TRUE)
  tweet3 <- rasterToPoints(tweet2)
  tweet4 <- data.frame(tweet3)
  tweet4$nr <- n
  tweet4$average <- tweet4$layer/tweet4$n
  return(tweet4)
})
save(tweets.average, file = "average_tweet_hour.rda", compress = "xz")

# Getting the right names

list.names <- lapply(list.hours, function(x){
  list <- paste(format(min(x$tweet_datetime), "%H:%M"), "-",
                format(max(x$tweet_datetime), "%H:%M"))
})

names(tweets.average) <- list.names

# Animated GIF
saveHTML(lapply(names(tweets.average), function(q){
  p <- ggplot(tweets.average[[q]], aes(x,y, fill= average)) +
    stat_density2d(geom = "polygon",na.rm = TRUE, alpha = 0.3)+
    geom_raster() +
    scale_fill_continuous(name= "Number of tweets\nper 500m2", low= "#9AE4E8", 
                          high="#8B0000",guide= "colourbar",  space= "Lab", 
                          limits = c(0,5), breaks = c(0,1,2,3,4,5)) +
    guides(fill = guide_colorbar(barwidth = 1.5, barheight = 10, 
                                 ticks = FALSE, label.hjust = 1)) +
    xlim(3.2,7.24)+
    ylim(50.75,53.75) +
    
    geom_text(label = paste("Time:",q), x= 6.2 , y = 53.6, size = 5, 
              colour = "white", family =  "Trebuchet MS"  ) +
    theme(
      legend.position = c(0.15,0.75),
      legend.background = element_blank(),
      panel.background = element_rect(fill='#1A1A1A', colour='#9AE4E8'),
      plot.background = element_rect(fill = "#9AE4E8"),
      panel.border = element_blank(),
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      text = element_text(face = "italic", colour = "#9AE4E8", size = 15 ))+
     
    ggtitle("~ The average number of tweets per hour ~\nin the Netherlands")+
    theme(plot.title = element_text(colour = "Black", face = "bold",
                                    size = 20, family = "Georgia", vjust = 1))
  
  plot(p)
}), 
         img.name = "Rplot", 
         title = "Average",
         outdir = "average_hour2",
         htmlfile = 'Average.html',
         verbose = FALSE,
         interval = 0.8
)
