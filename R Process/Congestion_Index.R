########################################
# Preparation for BEYOND 2020
# Author: Jonathan Cohen
# Date: 20-12-2019
####################################


# Loading of libs
library(ggplot2)
library(rgeos)
library(maptools)
library(sf)
library(sfc)
library(tmap)
library(leaflet)
library(rgdal)
library(sp)
library(tmaptools)
library(mapview) 
library(raster)
library(geosphere)
library(gtools)
library(XML)
library(RCurl)
library(pastecs)
library(dplyr)
library(hrbrthemes)
library(ggridges)
library(viridis)
library(RColorBrewer)
library(ggExtra)

# Define functions for the project
viz <- function(file = 'goteborg_clip.shp'){
  
  # Load data as sp and sf
  map_SF <- read_shape(file, as.sf = TRUE)
  map_SP <- read_shape(file, as.sf = FALSE)
  
  mapview(map_SF) 
}
  


viz_map <- function(file = 'goteborg_clip.shp',
                    var_city_id='GRD_ID',
                    city_center_id = '1kmN3846E4438',
                    buff_width = 7250){
                            
  # Load data as sp and sf
  map_SF <- read_shape(file, as.sf = TRUE)
  map_SP <- read_shape(file, as.sf = FALSE)
  
  # Centroids
  centroids <- as.data.frame(centroid(map_SP))
  colnames(centroids) <- c("lon", "lat") 
  centroids <- data.frame("ID" = 1:nrow(centroids), centroids)
  
  
  # Create SpatialPointsDataFrame object
  coordinates(centroids) <- c("lon", "lat") 
  proj4string(centroids) <- proj4string(map_SP) # assign projection
  
  # Get polygons attribute for each centroid point 
  centroids@data <- sp::over(x = centroids, y = map_SP, returnList = FALSE)
  
  print('1')
  city_center <- centroids[centroids[[var_city_id]] == city_center_id,]
  
  print(city_center)
  print('2')
  
  
  buff_x <- buffer(city_center, width=buff_width, dissolve=TRUE)
  
  pts_in_buff<-centroids[!is.na(over(centroids,buff_x)),]
  pts_in_buff <-spTransform(pts_in_buff, CRS(latlong))
  proj4string(pts_in_buff) <- CRS(latlong)
  
  
  
  print(length(pts_in_buff))
  print(length(pts_in_buff)*length(pts_in_buff))
  
  mapview(city_center) +
    mapview(buff_x, col.regions = 'black') # + 
    # mapview(map_SF) #+ mapview(centroids)
  
  
}





load_n_centroid <- function(file = 'GridETRS89_LAEA_PT_1K.shp', 
                            city_center_id = '1kmN1946E2665',
                            var_city_id='GRD_ID - GRD1K_INSP',
                            buff_width = 7250,
                            latlong){
  
  # Load data as sp and sf
  map_SF <- read_shape(file, as.sf = TRUE)
  map_SP <- read_shape(file, as.sf = FALSE)
  
  # Centroids
  centroids <- as.data.frame(centroid(map_SP))
  colnames(centroids) <- c("lon", "lat") 
  centroids <- data.frame("ID" = 1:nrow(centroids), centroids)
  
  
  # Create SpatialPointsDataFrame object
  coordinates(centroids) <- c("lon", "lat") 
  proj4string(centroids) <- proj4string(map_SP) # assign projection
  
  # Get polygons attribute for each centroid point 
  centroids@data <- sp::over(x = centroids, y = map_SP, returnList = FALSE)
  
  
  city_center <- centroids[centroids[[var_city_id]] == city_center_id,]
  
  buff_x <- buffer(city_center, width=buff_width, dissolve=TRUE)
  
  pts_in_buff<-centroids[!is.na(over(centroids,buff_x)),]
  pts_in_buff <-spTransform(pts_in_buff, CRS(latlong))
  proj4string(pts_in_buff) <- CRS(latlong)
  

  return(pts_in_buff)
  }


# Output: pts_in_buff ->study_area



# Create OD Matrix
create_mat_od <- function(study_area, point_shape='city_pnts'){
  
  study_area <-spTransform(study_area, CRS(latlong))
  proj4string(study_area) <- CRS(latlong)

  study_area@data = data.frame(study_area@data, data.frame('ID' = 1:length(study_area)))
  study_area@data = data.frame(study_area@data, data.frame('X1' = study_area@coords[,2]))
  study_area@data = data.frame(study_area@data, data.frame('X2' = study_area@coords[,1]))
  
  
  writeOGR(study_area, layer = point_shape, 
           getwd(), driver = "ESRI Shapefile", 
           overwrite_layer = TRUE)
  
  
  x <- c(paste(study_area@coords[,2], "+", study_area@coords[,1], sep=''))
  id <- 1:length(study_area)
  
  
  lugares = permutations(n=length(x),r=2,v=x,repeats.allowed=T)
  ids = permutations(n=length(id),r=2,v=id,repeats.allowed=T)
  
  results <- list(lugares,ids)
  
  return(results)
  
  
}



# od_mat <- create_mat_od(pts_in_buff, point_shape='lisbon_pnts')
data_build <- function(od_mat, mode = 'driving', departure = 'now',
                       avoidmsg = '', traffic_model = 'best_guess', keys = key0){
  
  
  lugares <- od_mat[1]
  ids <- od_mat[2]
  
  
  print('matod1')
  
  or <- lugares[[1]][,1]
  de <- lugares[[1]][,2]
  
  print('matod2')
  
  or_id = ids[[1]][,1]
  de_id = ids[[1]][,2]
  
  print('matod3')
  
  data = data.frame(id = 1:length(or), or = or, de = de,
                    or_id = or_id, de_id = de_id)
  #return(data)
  #}
  
  print('matod4')
  
  for (i in 1:length(or)){
    print(i)
    
    key_id = 1
    if(i<=28000){
      key_id = 1
    } 
    
    print('&&&&&&&&&')
    print(keys[key_id])
    print('&&&&&&&&&')    
    url = paste0("maps.googleapis.com/maps/api/distancematrix/xml?origins=", 
                 or[i], "&destinations=", de[i], "&mode=", 
                 mode, "&sensor=", "false", "&units=metric", "&departure_time=", 
                 departure, "&traffic_model=", traffic_model, "&avoid=", avoidmsg)
    
    url = paste0("https://", url, "&key=", keys[key_id])
    print(url)
  
    webpageXML = xmlParse(getURL(url))
    print(webpageXML)
    try(results <-  xmlChildren(xmlRoot(webpageXML)))
    try(rowXML <-  xmlChildren(results$row[[1L]]))
    
    print(xmlValue(results$status))
    
    data$status[i]           = xmlValue(results$status)
    print('status....ok')
    data$or_name[i]          = xmlValue(results$origin_address)
    print('origin....ok')
    data$de_name[i]          = xmlValue(results$destination_address)
    print('dest....ok')
    
    try(data$distance[i]         <- as(rowXML$distance[1]$value[1]$text, 
                                       "numeric"))
    
    print('dist...ok')
    
    try(data$min_dur[i]          <- as(rowXML$duration[1]$value[1]$text, 
                                       "numeric"))
    
    print('dur1....ok')
    
    try(data$min_dur_traffic[i]  <-  as(rowXML$duration_in_traffic[1]$value[1]$text, "numeric"))
    
    print('dur2...ok')
    

    print('#########-----#########')
  }
  
  return(data)
}


# Clean & aggregate
clean_1st <- function(data){
  data_clean <- data
  data_clean <- subset(data_clean, (data$or_id !=data$de_id))
  data_clean[data_clean == 0] <- NA
  
  data_clean$speed_dur <- ((data_clean$distance/1000) / (data_clean$min_dur/60/60))
  data_clean$speed_dur_traffic <- ((data_clean$distance/1000) / (data_clean$min_dur_traffic/60/60))

  
  return(data_clean)

}


aggregation <- function(data){
  data_new <- data.frame()
  data_new <- data.frame(id = unique(data$or))
  data_new[data_new == 0] <- NA
  
  # Means
  data_new$count <- c(aggregate(data[,9], 
            list(data$or),
            FUN=function(x) {sum(!is.na(x))}))$x
  
  
  data_new$dist <- c(aggregate(data[,9], list(data$or),
                               FUN=mean, na.rm=TRUE))$x
  data_new$dur <- c(aggregate(data[,10], list(data$or),
                              FUN=mean, na.rm=TRUE))$x
  data_new$trafdur <- c(aggregate(data[,11], list(data$or),
                                  FUN=mean, na.rm=TRUE))$x
  data_new$spddur <- c(aggregate(data[,12], list(data$or),
                                 FUN=mean, na.rm=TRUE))$x
  data_new$spdtdur <- c(aggregate(data[,13],  list(data$or),
                                  FUN=mean, na.rm=TRUE))$x
  
  return(data_new)
}



aggrergate_n_merge_w_grid <- function(orig_file = 'grid_file',
                                      city_name='lisbon_best',
                                      est_type='Pessimistic or Optimistic',
                                      city_estimate, 
                                      pnts_shp = "lisbon_pnts_1.shp",
                                      by_merge = 'GRD_ID or OBJECTID'){
  
  # Clean the data
  city_estimate_2 <- clean_1st(city_estimate)
  
  # Make a copy of data
  write.csv(city_estimate_2,paste(city_name, '2.csv',sep=''))
  
  # Read the points datafile for future merging
  city_pnts <- read_shape(pnts_shp, as.sf = TRUE)
  
  # Secure the data set before doing operations
  city_estimate_3 <- city_estimate_2
  
  city_estimate_3$type <- c(rep(est_type, length(city_estimate_3$id)))
  
  
  # Aggregate and merge - best
  ##########################################
  agg_city <- aggregation(city_estimate_3)
  
  list_coords <- strsplit(as.character(agg_city$id), "[+]")
  orig_xcoords <- unlist(lapply(list_coords, '[[', 1))
  
  agg_city$x_coord_id <- orig_xcoords
  
  # Merge data -> points
  city_pnts_esti <-  merge(city_pnts, agg_city, by.x = "X1", by.y = "x_coord_id")
  
  city_pnts_esti <- city_pnts_esti[city_pnts_esti$count > 1,]
  
  city_pnts_esti_df <- data.frame(city_pnts_esti)
  
  city_pnts_esti_df <- subset(city_pnts_esti_df, select = -geometry )

  # Merge points -> grid
  map_SF <- read_shape(orig_file, as.sf = TRUE)
  
  city_map_SF <- merge(map_SF, city_pnts_esti_df,  by = by_merge)
  
  return(city_map_SF)
}



# SF is faster
end_of_aggregation <- function(city_map_SF_worst,
                               city_map_SF_best,
                               id_name='OBJECTID or GRD_ID',
                               name_of_city = 'THE CITY NAME HERE'){
  
  
  city_map_SF_worst <- dplyr::select(city_map_SF_worst,
                                     id_name: X2,
                                     worst_dist          = dist,
                                     worst_dura          = dur,
                                     worst_traff_dura    = trafdur,
                                     worst_speed         = spddur,
                                     worst_speed_dura    = spdtdur)

  
  city_map_SF_best <- dplyr::select(city_map_SF_best,
                                    id_name: X2,
                                    best_dist          = dist,
                                    best_dura          = dur,
                                    best_traff_dura    = trafdur,
                                    best_speed         = spddur,
                                    best_speed_dura    = spdtdur)


  
  # merge2
  city_map_SF_best_df <- data.frame(city_map_SF_best)
  city_map <- merge(city_map_SF_worst, city_map_SF_best_df)

  # Worst - Best times
  city_map$time_diff <- (city_map$worst_traff_dura - city_map$best_traff_dura)
  city_map$dist_diff <- (city_map$worst_dist - city_map$best_dist)
  city_map$speed_diff <- (city_map$best_speed_dura - city_map$worst_speed_dura)
  
  # Time in mins
  city_map$time_diff_min <- city_map$time_diff / 60

  # Relative measure
  city_map$time_diff_rel <- (city_map$worst_traff_dura - city_map$best_traff_dura)/(city_map$worst_traff_dura)
  
  # Travel time index
  city_map$tti <- city_map$worst_traff_dura/city_map$best_traff_dura
  
  repeat_val<- length(city_map$tti)
  city_map$city_ <- c(rep(name_of_city, repeat_val))
  
  return(city_map)
}



# Graphs
#1- Histogram
histo_city <- function(city_name){
  city_name <- as.data.frame(city_name)
  
  repeat_val_bad <- length(city_name$worst_dura)
  repeat_val_good <- length(city_name$worst_dura)
  
  city_hist <- data.frame(
    type = c( rep("Average condition", repeat_val_bad), 
              rep("Morning rush hour", repeat_val_bad),
              rep("Free flow traffic", repeat_val_good)
    ),
    value = c(city_name$worst_dura/60, 
              city_name$worst_traff_dura/60,
              city_name$best_traff_dura/60)
  )

  # Plot 0
  ggplot(data=city_hist, aes(x=value, group=type, fill=type)) +
    geom_density(adjust=1.5, alpha=.4) +
    theme_ipsum()
  
}


# Graphs
#1- Histogram - speed
histo_city_s <- function(city_name){
  city_name <- as.data.frame(city_name)
  
  repeat_val_bad <- length(city_name$worst_dura)
  repeat_val_good <- length(city_name$worst_dura)
  
  city_hist <- data.frame(
    type = c( rep("Average condition (Speed)", repeat_val_bad), 
              rep("Morning rush hour (Speed)", repeat_val_bad),
              rep("Free flow traffic (Speed)", repeat_val_good)
    ),
    value = c(city_name$worst_speed, 
              city_name$worst_speed_dura,
              city_name$best_speed_dura)
  )
  
  # Plot 0
  ggplot(data=city_hist, aes(x=value, group=type, fill=type)) +
    geom_density(adjust=1.5, alpha=.4) +
    xlim(c(10,85))+
    theme_ipsum()
  
}




#2 - scatter
city_scatter <- function(city_name_best, city_name_worst){
  
  city_name_worst <- clean_1st(city_name_worst)
  city_name_best <- clean_1st(city_name_best)
  
  city_name_worst$type <- c(rep('Morning Rush hour', length(city_name_worst$id)))
  city_name_best$type  <- c(rep('Free flow', length(city_name_best$id)))
  
  all <- do.call('rbind', list(city_name_worst,city_name_best))
  
  
  ggplot(all, 
         aes(x=distance , 
             y=min_dur_traffic , 
             hape=type, color=type)) + 
    geom_point(alpha = 4/10)
}

city_scatter_s <- function(city_name_best, city_name_worst){
  
  city_name_worst <- clean_1st(city_name_worst)
  city_name_best <- clean_1st(city_name_best)
  
  city_name_worst$type <- c(rep('Morning Rush hour', length(city_name_worst$id)))
  city_name_best$type  <- c(rep('Free flow', length(city_name_best$id)))
  
  all <- do.call('rbind', list(city_name_worst,city_name_best))
  
  
  ggplot(all, 
         aes(x=distance , 
             y=speed_dur_traffic, 
             hape=type, color=type)) +
    geom_point(alpha = 4/10) + 
    ylim(c(0,100))
}



#3-histogram
plot_multi_histogram <- function(df, feature, label_column) {
  plt <- ggplot(df, aes(x=eval(parse(text=feature)), fill=eval(parse(text=label_column)))) +
    geom_histogram(alpha=0.7, position="identity", aes(y = ..density..), color="black") +
    geom_density(alpha=0.7) +
    geom_vline(aes(xintercept=mean(eval(parse(text=feature)))), color="black", linetype="dashed", size=1) +
    labs(x=feature, y = "Density")
  plt + guides(fill=guide_legend(title=label_column))
}





#4- Export maps
export_maps_n_graphs <- function(city, 
                                 city_name='city_name',
                                 city_best, 
                                 city_worst){
  
  variable = c("worst_dist", "worst_dura", "worst_traff_dura", 
               "best_dura", "best_traff_dura", "speed_diff", 
               "time_diff_min","time_diff_rel","tti")
  
  for (i in 1:length(variable)){
    print(i)
  
    map <- mapview(city, zcol = variable[i])
    print(paste(getwd(), "/",city_name, variable[i], ".png",sep=""))
    mapshot(map, file = paste(getwd(), "/",city_name,'_', variable[i], ".png",sep=""))
  }
  
    
  histo_city(city)
  ggsave(paste('01_hist_',city_name,'.png',sep=""))

  
  city_scatter(city_best, city_worst)
  ggsave(paste('02_scatter_min_dif_',city_name,'.png',sep=""))
  
  histo_city_s(city)
  ggsave(paste('03_hist_s_',city_name,'.png',sep=""))
  
  
  city_scatter_s(city_best, city_worst)
  ggsave(paste('04_scatter_s_dif_',city_name,'.png',sep=""))
  
  
}


all_for_plt <- function(city_name='',city_best, city_worst){
  #print('6')
  city_best_3 <- clean_1st(city_best)
  
  city_worst_3 <- clean_1st(city_worst)
  #print('6')
  city_best_3[city_best_3 == 0] <- NA
  city_worst_3[city_worst_3 == 0] <- NA
  #print('6')
  city_all_worst<- dplyr::select(city_worst_3,
                                id: distance,
                                worst_dura          = min_dur,
                                worst_traff_dura    = min_dur_traffic,
                                worst_speed         = speed_dur,
                                worst_speed_dura    = speed_dur_traffic)
  #print(head(city_all_best))


  city_all_best <- dplyr::select(city_best_3,
                                  id: distance,
                                  best_dura          = min_dur,
                                  best_traff_dura    = min_dur_traffic,
                                  best_speed         = speed_dur,
                                  best_speed_dura    = speed_dur_traffic)
  #print(head(city_all_worst))
  city_all <- merge(city_all_best, city_all_worst)
  #print('6')
  
  # Worst - Best times
  city_all$time_diff <- (city_all$worst_traff_dura - city_all$best_traff_dura)
  
  #print('7')
  # Time in mins
  city_all$time_diff_min <- city_all$time_diff / 60
  #print('8')
  # Relative measure
  city_all$time_diff_rel <- (city_all$worst_traff_dura - city_all$best_traff_dura)/(city_all$worst_traff_dura)
  #print('9')
  
  # Relative measure
  city_all$tti <- city_all$worst_traff_dura/city_all$best_traff_dura
  
  city_all <- city_all[!(city_all$time_diff_rel <= -10),]
  
  
  repeat_val<- length(city_all$time_diff_rel)
  
  
  city_all$city_name <- c(rep(city_name, repeat_val))
  
  city_all$cat<- cut(city_all$distance, 
                     breaks=seq(0, 30000, by=5000), 
                     labels=c("0-5000",
                              "5000-10000",
                              "10000-15000",
                              "15000-20000",
                              "20000-25000",
                              "25000-30000"))
  
  city_all$cat2<- cut(city_all$distance, 
                     breaks=seq(0, 30000, by=2500), 
                     labels=c("0-2500", "2500-5000",
                              "5000-7500","7500-10000",
                              "10000-12500","12500-15000",
                              "15000-17500","17500-20000",
                              "20000-22500","22500-25000",
                              "25000-27500","27500-30000"))
  
  return(city_all)
  
  
  
}


# Aggregate and get data avergaes for plotting
avgs <- as.data.frame(all_cities %>%
                        group_by(city_name,cat) %>%
                        summarise_each(funs(mean)))

avgs = subset(avgs, select = -c(or,de,status, or_name, de_name,cat2))


avgs<-avgs[!(avgs$cat=="25000-30000" ),]

positions <- c("Goteborg", "Amsterdam", "Glasgow", "Lisbon")
avgs$city_name <- factor(avgs$city_name, levels = positions)


##############################################################

avgs1 <- as.data.frame(na.omit(subset(all_cities, 
                              select = -c(or,de,status, or_name, de_name,cat2,cat))) %>%
                        group_by(city_name) %>%
                        summarise_each(funs(mean)))



positions <- c("Goteborg", "Amsterdam", "Glasgow", "Lisbon")
avgs1$city_name <- factor(avgs1$city_name, levels = positions)




