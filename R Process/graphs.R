
####################################################
# Stats about the city aggregation level
####################################################
setwd('C:/Users/edgardo/Box Sync/01_BEYOND2020/Results')


##############################################################
# 1- Maps and scatters
##############################################################
export_maps_n_graphs(lisbon, city_name='lisbon', lisbon_best, lisbon_worst)
export_maps_n_graphs(amsterdam, city_name='amsterdam', amsterdam_best, amsterdam_worst)
export_maps_n_graphs(goteborg, city_name='goteborg', goteborg_best, goteborg_worst)
export_maps_n_graphs(glasgow, city_name='glasgow', glasgow_best, glasgow_worst)

#######################################################
# 2- Histograms
#######################################################

#Speed
histo_city_s(lisbon)
ggsave('05_lisbon_s.png')

histo_city_s(glasgow)
ggsave('05_glasgow_s.png')

histo_city_s(amsterdam)
ggsave('05_amsterdam_s.png')

histo_city_s(goteborg)
ggsave('05_goteborg_s.png')
##########################################################
# 3- Scatters
#########################################################
city_scatter(lisbon_best, lisbon_worst)
city_scatter(goteborg_best, goteborg_worst)
city_scatter(glasgow_best, glasgow_worst)
city_scatter(amsterdam_best, amsterdam_worst)

city_scatter_s(lisbon_best, lisbon_worst)
ggsave(paste('06_lisbon_s_dif.png',sep=""))

city_scatter_s(goteborg_best, goteborg_worst)
ggsave(paste('06_goteborg_s_dif.png',sep=""))

city_scatter_s(glasgow_best, glasgow_worst)
ggsave(paste('06_glasgow_s_dif.png',sep=""))

city_scatter_s(amsterdam_best, amsterdam_worst)
ggsave(paste('06_amsterdam_s_dif.png',sep=""))




#####################################################################
# 4- scatters
####################################################################
amsterdam_all <- all_for_plt("Amsterdam",amsterdam_best,amsterdam_worst)
lisbon_all    <- all_for_plt("Lisbon",lisbon_best,lisbon_worst)
goteborg_all  <- all_for_plt("Goteborg",goteborg_best,goteborg_worst)
glasgow_all   <- all_for_plt("Glasgow",glasgow_best,glasgow_worst)


# Time difference relative

ggplot() +
  geom_point(data = amsterdam_all, aes(x=distance, 
                                       y=time_diff_rel, col = factor(city_name)), 
             alpha=0.4, size =3/10) + 
  
  geom_point(data = lisbon_all, aes(x=distance, 
                                    y=time_diff_rel, col = factor(city_name)), 
             alpha=0.4, size =3/10) + 
  
  geom_point(data = goteborg_all, aes(x=distance, 
                                      y=time_diff_rel, col = factor(city_name)), 
             alpha=0.1, size =3/10) + 
  
  geom_point(data = glasgow_all, aes(x=distance, 
                                     y=time_diff_rel, col = factor(city_name)), 
             alpha=0.1,size =3/10) +
  
  
  geom_smooth(data = amsterdam_all, aes(x=distance, 
                                        y=time_diff_rel, col = factor(city_name))) +
  
  
  geom_smooth(data = lisbon_all, aes(x=distance, 
                                     y=time_diff_rel, col = factor(city_name))) +
  
  
  geom_smooth(data = goteborg_all, aes(x=distance, 
                                       y=time_diff_rel, col = factor(city_name))) +
  
  
  geom_smooth(data = glasgow_all, aes(x=distance, 
                                      y=time_diff_rel, col = factor(city_name))) +
  
  scale_color_discrete(name = "Case studies") +
  labs(x="Distance", y="Relative time difference") + 
  
  ylim(c(0,0.8)) + xlim(c(0,25000))


ggsave('07_all_continous.png')


# Time difference mins
ggplot() +
  geom_point(data = amsterdam_all, aes(x=distance, 
                                       y=time_diff_min, col = factor(city_name)), 
             alpha=0.4, size =3/10) + 
  
  geom_point(data = lisbon_all, aes(x=distance, 
                                    y=time_diff_min, col = factor(city_name)), 
             alpha=0.4, size =3/10) + 
  
  geom_point(data = goteborg_all, aes(x=distance, 
                                      y=time_diff_min, col = factor(city_name)), 
             alpha=0.1, size =3/10) + 
  
  geom_point(data = glasgow_all, aes(x=distance, 
                                     y=time_diff_min, col = factor(city_name)), 
             alpha=0.1,size =3/10) +
  
  
  geom_smooth(data = amsterdam_all, aes(x=distance, 
                                        y=time_diff_min, col = factor(city_name))) +
  
  
  geom_smooth(data = lisbon_all, aes(x=distance, 
                                     y=time_diff_min, col = factor(city_name))) +
  
  
  geom_smooth(data = goteborg_all, aes(x=distance, 
                                       y=time_diff_min, col = factor(city_name))) +
  
  
  geom_smooth(data = glasgow_all, aes(x=distance, 
                                      y=time_diff_min, col = factor(city_name))) +
  
  scale_color_discrete(name = "Case studies") +
  
  labs(x="Distance", y="Time difference (mins)") + 
  
  ylim(c(0,40)) + xlim(c(0,25000)) 

ggsave('07_all_continous2.png')



# TTI

ggplot() +
  geom_point(data = amsterdam_all, aes(x=distance, 
                                       y=tti, col = factor(city_name)), 
             alpha=0.4, size =3/10) + 
  
  geom_point(data = lisbon_all, aes(x=distance, 
                                    y=tti, col = factor(city_name)), 
             alpha=0.4, size =3/10) + 
  
  geom_point(data = goteborg_all, aes(x=distance, 
                                      y=tti, col = factor(city_name)), 
             alpha=0.1, size =3/10) + 
  
  geom_point(data = glasgow_all, aes(x=distance, 
                                     y=tti, col = factor(city_name)), 
             alpha=0.1,size =3/10) +
  
  
  geom_smooth(data = amsterdam_all, aes(x=distance, 
                                        y=tti, col = factor(city_name))) +
  
  
  geom_smooth(data = lisbon_all, aes(x=distance, 
                                     y=tti, col = factor(city_name))) +
  
  
  geom_smooth(data = goteborg_all, aes(x=distance, 
                                       y=tti, col = factor(city_name))) +
  
  
  geom_smooth(data = glasgow_all, aes(x=distance, 
                                      y=tti, col = factor(city_name))) +
  
  scale_color_discrete(name = "Case studies") +
  labs(x="Distance", y="Travel Time Index (TTI)") + xlim(c(0,25000)) + 
  ylim(c(1,4)) 

ggsave('08_tti.png')

#################################################################
# 5- Box plots
##################################################################
# time diff mins
ggplot(lisbon_all, aes(x=distance, y=time_diff_min, fill=cat)) + 
  geom_boxplot(color = "#415262") +
  geom_jitter(color="#8bb4a4", size=0.6, alpha=0.2) + 
  scale_fill_brewer(palette="Greys") + 
  theme(legend.position="none")
ggsave('09_lisbon_box.png')

ggplot(amsterdam_all, aes(x=distance, y=time_diff_min, fill=cat)) + 
  geom_boxplot(color = "#415262") +
  geom_jitter(color="#8bb4a4", size=0.6, alpha=0.2) + 
  scale_fill_brewer(palette="Greys")+ 
  theme(legend.position="none")
ggsave('09_amsterdam_box.png')

ggplot(goteborg_all, aes(x=distance, y=time_diff_min, fill=cat)) +
  geom_boxplot(color = "#415262") +
  geom_jitter(color="#8bb4a4", size=0.6, alpha=0.2) + 
  scale_fill_brewer(palette="Greys")+ 
  theme(legend.position="none")
ggsave('goteborg_box.png')

ggplot(glasgow_all, aes(x=distance, y=time_diff_min, fill=cat)) + 
  geom_boxplot(color = "#415262") +
  geom_jitter(color="#8bb4a4", size=0.6, alpha=0.2) + 
  scale_fill_brewer(palette="Greys")+ 
  theme(legend.position="none")
ggsave('09_glasgow_box.png')

#TTI
ggplot(lisbon_all, aes(x=distance, y=tti, fill=cat)) + 
  geom_boxplot(color = "#415262") +
  geom_jitter(color="#8bb4a4", size=0.6, alpha=0.2) + 
  scale_fill_brewer(palette="Greys") + 
  theme(legend.position="none") + 
  ylim(c(1,4.5))
ggsave('09_lisbon_tti.png')

ggplot(amsterdam_all, aes(x=distance, y=tti, fill=cat)) + 
  geom_boxplot(color = "#415262") +
  geom_jitter(color="#8bb4a4", size=0.6, alpha=0.2) + 
  scale_fill_brewer(palette="Greys")+ 
  theme(legend.position="none") + 
  ylim(c(1,4))
ggsave('09_amsterdam_tti.png')

ggplot(goteborg_all, aes(x=distance, y=tti, fill=cat)) +
  geom_boxplot(color = "#415262") +
  geom_jitter(color="#8bb4a4", size=0.6, alpha=0.2) + 
  scale_fill_brewer(palette="Greys")+ 
  theme(legend.position="none") + 
  ylim(c(1,2))
ggsave('09_goteborg_tti.png')

ggplot(glasgow_all, aes(x=distance, y=tti, fill=cat)) + 
  geom_boxplot(color = "#415262") +
  geom_jitter(color="#8bb4a4", size=0.6, alpha=0.2) + 
  scale_fill_brewer(palette="Greys")+ 
  theme(legend.position="none") + 
  ylim(c(1,3.5))
ggsave('09_glasgow_tti.png')






##################################################################
# 6- All cities - all trips
##################################################################
# rbind(cbind(stack(A), group='A'), cbind(stack(B), group='B'))
all_cities <- rbind(lisbon_all,
                    amsterdam_all,
                    glasgow_all,
                    goteborg_all)

# all
ggplot(na.omit(all_cities[which(all_cities$time_diff_min>0),] ),aes(x= factor(cat), y=time_diff_min))+
  geom_boxplot(color = "#415262") + ylim(c(0,25))
ggsave(paste('10_all_1.png',sep=""))


ggplot(na.omit(all_cities[which(all_cities$time_diff_min>0),] ),
       aes(x=factor(city_name), y=time_diff_min, fill = factor(cat)))+
  geom_boxplot(color = "#415262") + ylim(c(0,25)) +
  labs(y="Time difference (mins)") + 
  scale_fill_brewer(palette="Greys") +
  scale_color_discrete(name = "Distance")
ggsave(paste('10_all_2.png',sep=""))

ggplot(na.omit(all_cities[which(all_cities$time_diff_min>0),] ),
       aes(x=factor(city_name), y=time_diff_rel, fill = factor(cat)))+
  geom_boxplot(color = "#415262") + ylim(c(0,0.8)) +
  labs(y="Time difference (mins)") +
  scale_color_discrete(name = "Distance")+ 
  scale_fill_brewer(palette="Greys") 
ggsave(paste('10_all_3.png',sep=""))

ggplot(na.omit(all_cities[which(all_cities$time_diff_min>0),] ),
       aes(x=factor(cat), y=time_diff_min, fill = factor(city_name)))+
  geom_boxplot(color = "#415262") + ylim(c(0,25)) +
  labs(y="Time difference (mins)") +
  scale_color_discrete(name = "Distance")+ 
  scale_fill_brewer(palette="Accent") 
ggsave(paste('10_all_4.png',sep=""))

ggplot(na.omit(all_cities[which(all_cities$time_diff_min>0),] ),
       aes(x=factor(cat), y=time_diff_rel, fill = factor(city_name)))+
  geom_boxplot(color = "#415262") + ylim(c(0,0.8)) +
  labs(y="Time difference (mins)") +
  scale_color_discrete(name = "Distance")+ 
  scale_fill_brewer(palette="Accent") 
ggsave(paste('10_all_5.png',sep=""))


#############################################################################
# 7- CAT
###############################################################################
#Time difference mins
ggplot(na.omit(all_cities[which(all_cities$time_diff_min>0),] ), 
       aes(x= factor(cat), y=time_diff_min)) + 
  geom_boxplot(color = "#415262") +
  facet_wrap(~city_name, scales='free_y') +
  geom_jitter(color="#8bb4a4", size=0.4, alpha=0.1) +
  labs(x="Distance", y="Time difference (mins)") +
  theme(axis.text.x=element_text(angle=-90, vjust=0.4,hjust=1))
ggsave(paste('11_box_time_flex1.png',sep=""))

ggplot(na.omit(all_cities[which(all_cities$time_diff_min>0),] ), 
       aes(x= factor(cat), y=time_diff_min)) + 
  geom_boxplot(color = "#415262") +
  facet_wrap(~city_name) +
  geom_jitter(color="#8bb4a4", size=0.4, alpha=0.1) +
  labs(x="Distance", y="Time difference (mins)") +
  theme(axis.text.x=element_text(angle=-90, vjust=0.4,hjust=1))  + 
  ylim(c(0,45))
ggsave(paste('11_box_time1.png',sep=""))

#Time difference rel
ggplot(na.omit(all_cities[which(all_cities$time_diff_rel>0),] ), 
       aes(x= factor(cat), y=time_diff_rel)) + 
  geom_boxplot(color = "#415262") +
  facet_wrap(~city_name) +
  geom_jitter(color="#8bb4a4", size=0.4, alpha=0.1) +
  labs(x="Distance", y="Time difference (Relative)") +
  theme(axis.text.x=element_text(angle=-90, vjust=0.4,hjust=1)) +
  ylim(c(0,0.8))

ggsave(paste('11_box_timerel_flex1.png',sep=""))

ggplot(na.omit(all_cities[which(all_cities$time_diff_rel>0 &
                                  all_cities$time_diff_rel<0.8),] ), 
       aes(x= factor(cat), y=time_diff_rel)) + 
  geom_boxplot(color = "#415262", scales='free_y') +
  facet_wrap(~city_name, scales='free_y') +
  geom_jitter(color="#8bb4a4", size=0.4, alpha=0.1) +
  labs(x="Distance", y="Time difference (Relative)") +
  theme(axis.text.x=element_text(angle=-90, vjust=0.4,hjust=1)) 

ggsave(paste('11_box_timerel1.png',sep=""))


# TTI
ggplot(na.omit(all_cities[which(all_cities$time_diff_rel>0),] ), 
       aes(x= factor(cat), y=tti)) + 
  geom_boxplot(color = "#415262") +
  facet_wrap(~city_name) +
  geom_jitter(color="#8bb4a4", size=0.4, alpha=0.1) +
  labs(x="Distance", y="Travel Time Index (TTI)") +
  theme(axis.text.x=element_text(angle=-90, vjust=0.4,hjust=1)) +
  ylim(c(1,4.5))
ggsave(paste('11_tti.png',sep=""))


ggplot(na.omit(all_cities[which(all_cities$time_diff_rel>0 &
                                  all_cities$time_diff_rel<0.8),] ), 
       aes(x= factor(cat), y=tti)) + 
  geom_boxplot(color = "#415262", scales='free_y') +
  facet_wrap(~city_name, scales='free_y') +
  geom_jitter(color="#8bb4a4", size=0.4, alpha=0.1) +
  labs(x="Distance", y="Travel Time Index (TTI)") +
  theme(axis.text.x=element_text(angle=-90, vjust=0.4,hjust=1)) 
ggsave(paste('11_tti1.png',sep=""))



#############################################################################
# 8- CAT2
###################################################################################
# Time difference
ggplot(na.omit(all_cities[which(all_cities$time_diff_min>0),] ), 
       aes(x= factor(cat2), y=time_diff_min)) + 
  geom_boxplot(color = "#415262") +
  facet_wrap(~city_name, scales='free_y') +
  geom_jitter(color="#8bb4a4", size=0.4, alpha=0.1) +
  labs(x="Distance", y="Time difference (mins)") +
  theme(axis.text.x=element_text(angle=-90, vjust=0.4,hjust=1))
ggsave(paste('12_box_time_flex.png',sep=""))

ggplot(na.omit(all_cities[which(all_cities$time_diff_min>0),] ), 
       aes(x= factor(cat2), y=time_diff_min)) + 
  geom_boxplot(color = "#415262") +
  facet_wrap(~city_name) +
  geom_jitter(color="#8bb4a4", size=0.4, alpha=0.1) +
  labs(x="Distance", y="Time difference (mins)") +
  theme(axis.text.x=element_text(angle=-90, vjust=0.4,hjust=1))  + 
  ylim(c(0,45))
ggsave(paste('12_box_time.png',sep=""))

# Time difference relative
ggplot(na.omit(all_cities[which(all_cities$time_diff_rel>0),] ), 
       aes(x= factor(cat2), y=time_diff_rel)) + 
  geom_boxplot(color = "#415262") +
  facet_wrap(~city_name) +
  geom_jitter(color="#8bb4a4", size=0.4, alpha=0.1) +
  labs(x="Distance", y="Time difference (Relative)") +
  theme(axis.text.x=element_text(angle=-90, vjust=0.4,hjust=1)) +
  ylim(c(0,0.8))

ggsave(paste('12_box_timerel_flex.png',sep=""))

ggplot(na.omit(all_cities[which(all_cities$time_diff_rel>0 & all_cities$time_diff_rel<0.8),] ), 
       aes(x= factor(cat2), y=time_diff_rel)) + 
  geom_boxplot(color = "#415262", scales='free_y') +
  facet_wrap(~city_name, scales='free_y') +
  geom_jitter(color="#8bb4a4", size=0.4, alpha=0.1) +
  labs(x="Distance", y="Time difference (Relative)") +
  theme(axis.text.x=element_text(angle=-90, vjust=0.4,hjust=1)) 

ggsave(paste('12_box_timerel.png',sep=""))

# TTI
ggplot(na.omit(all_cities[which(all_cities$time_diff_rel>0),] ), 
       aes(x= factor(cat2), y=tti)) + 
  geom_boxplot(color = "#415262") +
  facet_wrap(~city_name) +
  geom_jitter(color="#8bb4a4", size=0.4, alpha=0.1) +
  labs(x="Distance", y="Travel Time Index (TTI)") +
  theme(axis.text.x=element_text(angle=-90, vjust=0.4,hjust=1)) +
  ylim(c(1,4.5))
ggsave(paste('12_tti_cat2.png',sep=""))


ggplot(na.omit(all_cities[which(all_cities$time_diff_rel>0 &
                                  all_cities$time_diff_rel<0.8),] ), 
       aes(x= factor(cat2), y=tti)) + 
  geom_boxplot(color = "#415262", scales='free_y') +
  facet_wrap(~city_name, scales='free_y') +
  geom_jitter(color="#8bb4a4", size=0.4, alpha=0.1) +
  labs(x="Distance", y="Travel Time Index (TTI)") +
  theme(axis.text.x=element_text(angle=-90, vjust=0.4,hjust=1)) 
ggsave(paste('12_tti1_cat2.png',sep=""))




###############################################################################
ggplot(na.omit(all_cities[which(all_cities$time_diff_min>0 & all_cities$time_diff_min<=30 ),] ), 
       aes(x= factor(cat), y=time_diff_min)) + 
  geom_boxplot(color = "#415262") +
  facet_wrap(~city_name, scales='free_y') +
  geom_jitter(color="#8bb4a4", size=0.4, alpha=0.1) +
  labs(x="Distance", y="Time difference (mins)") +
  theme(axis.text.x=element_text(angle=-90, vjust=0.4,hjust=1))
ggsave(paste('12_box_time_flex3.png',sep=""))


##############################################################
ggplot(na.omit(avgs), 
       aes(x=cat, y=time_diff_min, fill=city_name)) +
  geom_bar(stat='identity', position='dodge') + 
  labs(x="Distance", y="Time difference (mins)") +
  scale_fill_manual("Case Studies", 
                    values = c(
                      "Amsterdam" = "#f5bc20", 
                      "Goteborg" = "#20f5bc", 
                      "Glasgow" = "#2092f5",
                      "Lisbon" = "#f5207c")) 
ggsave(paste('13_box_hist_mean1.png',sep=""))


ggplot(na.omit(avgs), aes(x=cat, y=time_diff_rel, fill=city_name)) +
  geom_bar(stat='identity', position='dodge') + 
  labs(x="Distance", y="Time difference (Relative)") +
  scale_fill_manual("Case Studies", 
                    values = c(
                      "Amsterdam" = "#f5bc20", 
                      "Goteborg" = "#20f5bc", 
                      "Glasgow" = "#2092f5",
                      "Lisbon" = "#f5207c")) 
ggsave(paste('13_box_hist_mean2.png',sep=""))



ggplot(na.omit(avgs), aes(x=cat, y=tti, fill=city_name)) +
  geom_bar(stat='identity', position='dodge') + 
  labs(x="Distance", y="Travel Time Index (TTI)") +
  scale_fill_manual("Case Studies", 
                    values = c(
                      "Amsterdam" = "#f5bc20", 
                      "Goteborg" = "#20f5bc", 
                      "Glasgow" = "#2092f5",
                      "Lisbon" = "#f5207c")) 
ggsave(paste('13_ttibox_hist_mean2.png',sep=""))


#################################################################

ggplot(na.omit(avgs1), aes(y=time_diff_rel, x=city_name)) +
  geom_bar(stat='identity', position='dodge') + 
  labs(x="Distance", y="Time difference (Relative)") +
  scale_fill_manual("Case Studies", 
                    values = c(
                      "Amsterdam" = "#f5bc20", 
                      "Goteborg" = "#20f5bc", 
                      "Glasgow" = "#2092f5",
                      "Lisbon" = "#f5207c")) 
ggsave(paste('14_rel_min.png',sep=""))

ggplot(na.omit(avgs1), aes(y=time_diff_min, x=city_name)) +
  geom_bar(stat='identity', position='dodge') + 
  labs(x="Distance", y="Time difference (Minutes)") +
  scale_fill_manual("Case Studies", 
                    values = c(
                      "Amsterdam" = "#f5bc20", 
                      "Goteborg" = "#20f5bc", 
                      "Glasgow" = "#2092f5",
                      "Lisbon" = "#f5207c")) 

ggsave(paste('14_min_avg.png',sep=""))

ggplot(na.omit(avgs1), aes(y=tti, x=city_name)) +
  geom_bar(stat='identity', position='dodge') + 
  labs(x="Distance", y="Travel Time Index (TTI)") +
  scale_fill_manual("Case Studies", 
                    values = c(
                      "Amsterdam" = "#f5bc20", 
                      "Goteborg" = "#20f5bc", 
                      "Glasgow" = "#2092f5",
                      "Lisbon" = "#f5207c")) 

ggsave(paste('14_tti_avg.png',sep=""))





################################################################
# 9- Histograms and scatter for the city
################################################################
glas_t <-  ggplot(glasgow, aes(x=best_dist , y=time_diff_min)) + geom_point(alpha = 4/10) +
  labs(x="Distance", y="Time difference (mins)")
lisb_t <-  ggplot(lisbon, aes(x=best_dist , y=time_diff_min)) + geom_point(alpha = 4/10) +
  labs(x="Distance", y="Time difference (mins)")
amst_t <-  ggplot(amsterdam, aes(x=best_dist, y=time_diff_min)) + geom_point(alpha = 4/10) +
  labs(x="Distance", y="Time difference (mins)")
gote_t <-  ggplot(goteborg, aes(x=best_dist , y=time_diff_min)) + geom_point(alpha = 4/10) +
  labs(x="Distance", y="Time difference (mins)")


glas_r <-  ggplot(glasgow, aes(x=best_dist , y=tti)) + geom_point(alpha = 4/10) +
  labs(x="Distance", y="Travel Time Index (TTI)")
lisb_r <-  ggplot(lisbon, aes(x=best_dist , y=tti)) + geom_point(alpha = 4/10) +
  labs(x="Distance", y="Travel Time Index (TTI)")
amst_r <-  ggplot(amsterdam, aes(x=best_dist, y=tti)) + geom_point(alpha = 4/10) +
  labs(x="Distance", y="Travel Time Index (TTI)")
gote_r <-  ggplot(goteborg, aes(x=best_dist , y=tti)) + geom_point(alpha = 4/10) +
  labs(x="Distance", y="Travel Time Index (TTI)")


glas_s <-  ggplot(glasgow, aes(x=best_dist , y=speed_diff)) + geom_point(alpha = 4/10) +
  labs(x="Distance", y="Speed difference (Km/h)")
lisb_s <-  ggplot(lisbon, aes(x=best_dist , y=speed_diff)) + geom_point(alpha = 4/10) +
  labs(x="Distance", y="Speed difference (Km/h")
amst_s <-  ggplot(amsterdam, aes(x=best_dist, y=speed_diff)) + geom_point(alpha = 4/10) +
  labs(x="Distance", y="Speed difference (Km/h")
gote_s <-  ggplot(goteborg, aes(x=best_dist , y=speed_diff)) + geom_point(alpha = 4/10) +
  labs(x="Distance", y="TSpeed difference (Km/h")





ggsave('15_time_glas.png', ggMarginal(glas_t, type="histogram"))
ggsave('15_rel_glas.png', ggMarginal(glas_r, type="histogram"))
ggsave('15_speed_glas.png', ggMarginal(glas_s, type="histogram"))

ggsave('15_time_lisb.png', ggMarginal(lisb_t, type="histogram"))
ggsave('15_rel_lisb.png', ggMarginal(lisb_r, type="histogram"))
ggsave('15_speed_lisb.png', ggMarginal(lisb_s, type="histogram"))

ggsave('15_time_ams.png', ggMarginal(amst_t, type="histogram"))
ggsave('15_rel_ams.png',ggMarginal(amst_r, type="histogram"))
ggsave('15_speed_amst.png', ggMarginal(amst_s, type="histogram"))

ggsave('15_time_got.png', ggMarginal(gote_t, type="histogram"))
ggsave('15_rel_got.png', ggMarginal(gote_r, type="histogram"))
ggsave('15_speed_got.png', ggMarginal(gote_s, type="histogram"))



########################################################################
# 10- STATS AND TABLES
########################################################################

