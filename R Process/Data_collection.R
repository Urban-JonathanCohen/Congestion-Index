########################################
# Preparation for BEYOND 2020
# Author: Jonathan Cohen
# Date: 20-12-2019
####################################

#####################################
# 0- Search for city center
#####################################
viz('GridETRS89_LAEA_PT_1K.shp')
viz('goteborg_clip.shp')
viz('glasgow_clip.shp')
viz('Amsterdam_clip.shp')


#####################################
# 1- Viz 
#######################################
viz_map('GridETRS89_LAEA_PT_1K.shp', 
        var_city_id='GRD1K_INSP',
        city_center_id ='1kmN1946E2665',
        buff_width = 7250)

viz_map('goteborg_clip.shp', 
        var_city_id='GRD_ID',
        city_center_id ='1kmN3846E4438',
        buff_width = 6500)

viz_map('glasgow_clip.shp', 
        var_city_id='GRD_ID',
        city_center_id ='1kmN3727E3434',
        buff_width = 6500)

viz_map('Amsterdam_clip.shp', 
        var_city_id='GRD_ID',
        city_center_id ='1kmN3263E3973',
        buff_width = 6500)


#####################################
# 2- Create OD points 
#######################################
lisbon_od_pnts <- load_n_centroid(file = 'GridETRS89_LAEA_PT_1K.shp', 
                                  city_center_id = '1kmN1946E2665',
                                  var_city_id='GRD1K_INSP',
                                  buff_width = 7250,
                                  latlong)


goteborg_od_pnts <- load_n_centroid(file = 'goteborg_clip.shp', 
                                    city_center_id = '1kmN3846E4438',
                                    var_city_id='GRD_ID',
                                    buff_width = 6500,
                                    latlong)


glasgow_od_pnts <- load_n_centroid(file = 'glasgow_clip.shp', 
                                   city_center_id = '1kmN3727E3434',
                                   var_city_id='GRD_ID',
                                   buff_width = 6500,
                                   latlong)


amsterdam_od_pnts <- load_n_centroid(file = 'Amsterdam_clip.shp', 
                                     city_center_id = '1kmN3263E3973',
                                     var_city_id='GRD_ID',
                                     buff_width = 6500,
                                     latlong)


############################################################
# 3- Viz OD Points
############################################################
mapview(lisbon_od_pnts)
mapview(goteborg_od_pnts)
mapview(amsterdam_od_pnts)
mapview(glasgow_od_pnts)


############################################################
# 3- Make OD matrix
############################################################
lisbon_od <- create_mat_od(lisbon_od_pnts, point_shape='lisbon_pnts')
goteborg_od <- create_mat_od(goteborg_od_pnts, point_shape='goteborg_pnts')
amsterdam_od <- create_mat_od(amsterdam_od_pnts, point_shape='amsterdam_pnts')
glasgow_od <- create_mat_od(glasgow_od_pnts, point_shape='glasgow_pnts')




#############################################################
# 4- Fetch data from google
#############################################################
# Worst: Departure time
# Date and time: GMT: Thursday, October 15, 2020 8:30:00 AM
# dep_time_worst = '1602750600'

# Best: Departure time
# Date and time: Wednesday, July 15, 2020 3:30:00 AM
# dep_time_best = '1594783800'

# key_1 = ''
# keys = c(key_1,
#          key_1)


#############################################################
# Goteborg
#############################################################
# 1. Worst
# goteborg_worst <- data_build(goteborg_od, key = keys, 
#                            departure= dep_time_worst,  
#                            traffic_model = 'pessimistic')
# Write of files
# write.csv(goteborg_worst,'goteborg_worst.csv')

#
#2. Best
# goteborg_best <- data_build(goteborg_od, key = keys, 
#                          departure= dep_time_best,  
#                          traffic_model = 'optimistic') 
# Write of files
# write.csv(goteborg_best,'goteborg_best.csv')


###############################################################################
# Amsterdam
###############################################################################
# 1. Worst
# amsterdam_worst <- data_build(amsterdam_od, key = keys, 
#                             departure= dep_time_worst,  
#                             traffic_model = 'pessimistic') 
# Write of files
# write.csv(amsterdam_worst,'amsterdam_worst.csv')

# 2. Best
# amsterdam_best <- data_build(amsterdam_od, key = keys, 
#                            departure= dep_time_best,  
#                            traffic_model = 'optimistic')
# Write of files
# write.csv(amsterdam_best,'amsterdam_best.csv')



###############################################################################
# Glasgow
###############################################################################
# 1. Worst
# glasgow_worst <- data_build(glasgow_od, key = keys, 
#                              departure= dep_time_worst,  
#                              traffic_model = 'pessimistic') 
# Write of files
# write.csv(glasgow_worst,'glasgow_worst.csv')

# 2. Best
# glasgow_best <- data_build(glasgow_od, key = keys, 
#                             departure= dep_time_best,  
#                             traffic_model = 'optimistic') 
# Write of files
# write.csv(amsterdam_best,'glasgow_best.csv')


#################################################################
# lisbon
###############################################################
# 1. Worst
# lisbon_worst <- data_build(lisbon_od, key = keys, 
#                           departure= dep_time_worst,  
#                           traffic_model = 'pessimistic') 
#
# Write of files
# write.csv(lisbon_worst,'lisbon_worst.csv')

# 2. Best
# lisbon_best <- data_build(lisbon_od, key = keys, 
#                          departure= dep_time_best,  
#                          traffic_model = 'optimistic') 
# Write of files
# write.csv(lisbon_best,'lisbon_best.csv')
