########################################
# Preparation for BEYOND 2020
# Author: Jonathan Cohen
# Date: 20-12-2019
####################################

# Excecution
################################
# Set up
# setwd('C:/Users/edgardo/Desktop/Congestion/BEYOND2020/Data')
setwd('C:/Users/edgardo/Box Sync/01_BEYOND2020/Code/Data')
seed = set.seed(1609)
latlong = "+init=epsg:4326"


#########################################################
# 1- Merge
#############################################################
############################################
# Lisbon
#######################
lisbon_map_SF_worst <- aggrergate_n_merge_w_grid(
  orig_file = 'GridETRS89_LAEA_PT_1K.shp',
  city_name='lisbon_worst',
  est_type='Pessimistic',
  lisbon_worst, 
  pnts_shp = "lisbon_pnts_1.shp",
  by_merge = 'OBJECTID')

lisbon_map_SF_best <- aggrergate_n_merge_w_grid(
  orig_file = 'GridETRS89_LAEA_PT_1K.shp',
  city_name='lisbon_best',
  est_type='Optimistic',
  lisbon_best, 
  pnts_shp = "lisbon_pnts_1.shp",
  by_merge = 'OBJECTID')



lisbon <- end_of_aggregation(lisbon_map_SF_worst,
                               lisbon_map_SF_best,
                               id_name='OBJECTID',
                             name_of_city = 'Lisbon')

############################################
# Goteborg
#######################
goteborg_map_SF_worst <- aggrergate_n_merge_w_grid(
  orig_file = 'goteborg_clip.shp',
  city_name='goteborg_worst',
  est_type='Pessimistic',
  goteborg_worst, 
  pnts_shp = "goteborg_pnts_1.shp",
  by_merge = 'GRD_ID')

goteborg_map_SF_best <- aggrergate_n_merge_w_grid(
  orig_file = 'goteborg_clip.shp',
  city_name='goteborg_best',
  est_type='Optimistic',
  goteborg_best, 
  pnts_shp = "goteborg_pnts_1.shp",
  by_merge = 'GRD_ID')



goteborg <- end_of_aggregation(goteborg_map_SF_worst,
                               goteborg_map_SF_best,
                               id_name='GRD_ID',
                               name_of_city = 'Goteborg')

############################################
# Amsterdam
#######################
amsterdam_map_SF_worst <- aggrergate_n_merge_w_grid(
  orig_file = 'Amsterdam_clip.shp',
  city_name='amsterdam_worst',
  est_type='Pessimistic',
  amsterdam_worst, 
  pnts_shp = "amsterdam_pnts_1.shp",
  by_merge = 'GRD_ID')

amsterdam_map_SF_best <- aggrergate_n_merge_w_grid(
  orig_file = 'Amsterdam_clip.shp',
  city_name='amsterdam_best',
  est_type='Optimistic',
  amsterdam_best, 
  pnts_shp = "amsterdam_pnts_1.shp",
  by_merge = 'GRD_ID')



amsterdam <- end_of_aggregation(amsterdam_map_SF_worst,
                                amsterdam_map_SF_best,
                               id_name='GRD_ID',
                               name_of_city = 'Amsterdam')


############################################
# Glasgow
#######################
glasgow_map_SF_worst <- aggrergate_n_merge_w_grid(
  orig_file = 'glasgow_clip.shp',
  city_name='glasgow_worst',
  est_type='Pessimistic',
  glasgow_worst, 
  pnts_shp = "glasgow_pnts_1.shp",
  by_merge = 'GRD_ID')

glasgow_map_SF_best <- aggrergate_n_merge_w_grid(
  orig_file = 'glasgow_clip.shp',
  city_name='glasgow_best',
  est_type='Optimistic',
  glasgow_best, 
  pnts_shp = "glasgow_pnts_1.shp",
  by_merge = 'GRD_ID')


glasgow <- end_of_aggregation(glasgow_map_SF_worst,
                              glasgow_map_SF_best,
                              id_name='GRD_ID',
                              name_of_city = 'Glasgow')

#################
# - Checks
#################
glasgow_map_SF_worst$count
glasgow_map_SF_best$count

lisbon_map_SF_worst$count
lisbon_map_SF_best$count

goteborg_map_SF_worst$count
goteborg_map_SF_best$count

amsterdam_map_SF_worst$count
amsterdam_map_SF_best$count

#####################################################
# 2- Map view
#####################################################
mapview(goteborg)

# Distance
mapview(goteborg, zcol = "worst_dist")
mapview(goteborg, zcol = "time_diff")
mapview(goteborg, zcol = "worst_dist")
mapview(goteborg, zcol = "time_diff_min")
mapview(goteborg, zcol = "time_diff_rel")


mapview(goteborg, zcol = "tti")
mapview(glasgow, zcol = "tti")
mapview(lisbon, zcol = "tti")
mapview(amsterdam, zcol = "tti")

mapview(goteborg, zcol = "time_diff_min")
mapview(glasgow, zcol = "time_diff_min")
mapview(lisbon, zcol = "time_diff_min")
mapview(amsterdam, zcol = "time_diff_min")



aggregation(clean_1st(goteborg_best))$count_yes
aggregation(clean_1st(goteborg_worst))$count_yes

aggregation(clean_1st(glasgow_best))$count_yes
aggregation(clean_1st(glasgow_worst))$count_yes

aggregation(clean_1st(amsterdam_best))$count_yes
aggregation(clean_1st(amsterdam_worst))$count_yes

aggregation(clean_1st(lisbon_best))$count_yes
aggregation(clean_1st(lisbon_worst))$count_yes


mapview(goteborg,    zcol  = "best_count_y")
mapview(glasgow,     zcol  = "best_count_y")
mapview(lisbon,      zcol  = "best_count_y")
mapview(amsterdam,   zcol  = "best_count_y")

