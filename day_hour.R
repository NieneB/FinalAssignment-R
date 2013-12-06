# Final assignment for the course: Applied Geo-scripting
# author: Niene Boeijen
# reg.nr. 900918-088-070
# date: 05-12-2013

# This is plotting amount of tweets per hour per day script
# Because it produces a lot of output the script may take a while!! 
# A list is made of all days and hours
# The amount is calculated


# subset 
list.hour.day <- by(tweets,tweets$datetime, subset)

# making list of dataframes of number per hour for all days
tweets.day.hour <- lapply(list.hour.day, function(x){
  coordinates(x) <- c("longitude", "latitude")
  proj4string(x) <- pr                                                 
  tweet1 <- spTransform(x, c)  
  tweet2 <- rasterize(tweet1, r, field = tweet1$gid, fun= 'count', na.rm = TRUE)
  tweet3 <- rasterToPoints(tweet2)
  tweet4 <- data.frame(tweet3)
  return(tweet4)
})

save(tweets.day.hour, file = "number_tweet_day_hour.rda", compress = "xz")

# Save GIF HTML
saveHTML(lapply(names(tweets.day.hour), function(q){
  p <- ggplot(tweets.day.hour[[q]], aes(x,y, fill= layer)) +
    stat_density2d(geom = "polygon",na.rm = TRUE, alpha = 0.3)+
    geom_raster() +
    scale_fill_continuous(name= "Number of tweets\nper 100m2", low= "#9AE4E8", 
                          high="#8B0000",guide= "colourbar",  space= "Lab", 
                          limits = c(0,100), breaks = c(0,5,10,20,100)) +
    guides(fill = guide_colorbar(barwidth = 1.5, barheight = 10, 
                                 ticks = FALSE, label.hjust = 1)) +
    xlim(3.2,7.24)+
    ylim(50.75,53.75) +
    geom_text(label = paste("Date & Time:",q), x= 6.2 , y = 53.6, size = 5,
              colour = "white", family =  "Trebuchet MS"  )+
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
      text = element_text(face = "italic", colour = "#9AE4E8", size = 15 )) +
    
    ggtitle("~ The number of tweets per hour per day ~\nin the Netherlands")+
    theme(plot.title = element_text(colour = "Black", face = "bold",
                                    size = 20, family = "Georgia", vjust = 1))
  plot(p)
}), 
         img.name = "img.name1.png", 
         title = "day hour",
         outdir = "gif_day_hour",
         htmlfile = 'day_hour.html',
         verbose = FALSE,
         interval = 0.8
)

