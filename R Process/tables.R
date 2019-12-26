library(stargazer)
library(xtable)
library(dplyr)

all_cities_tbl <- rbind(all_for_tbl("Amsterdam",clean_1st(amsterdam_best),clean_1st(amsterdam_worst)),
                        all_for_tbl("Lisbon",clean_1st(lisbon_best),clean_1st(lisbon_worst)),
                        all_for_tbl("Goteborg",clean_1st(goteborg_best),clean_1st(goteborg_worst)),
                        all_for_tbl("Glasgow",clean_1st(glasgow_best),clean_1st(glasgow_worst))
                        )

# or use all_cities

stargazer(lisbon$tti)

tapply(all_cities_tbl$tti, all_cities_tbl$city_name, summary)

tti_table <- na.omit(all_cities_tbl) %>% 
  group_by(city_name) %>% 
  summarize(Routes = length(tti)*2,
            N= length(tti),
            Mean = mean(tti),
            S.D. = sd(tti),
            Min = min(tti),
            Max = max(tti)
            )

time_diff_table <- na.omit(all_cities_tbl) %>% 
  group_by(city_name) %>% 
  summarize(Routes = length(time_diff_min)*2,
            N= length(time_diff_min),
            Mean = mean(time_diff_min),
            S.D. = sd(time_diff_min),
            Min = min(time_diff_min),
            Max = max(time_diff_min)
  )

tti_table
time_diff_table

xtable(time_diff_table)
xtable(tti_table)



colnames(lisbon)
colnames(amsterdam)
colnames(goteborg)
colnames(glasgow)

         
         
for_tbl <- do.call('rbind', list(subset(lisbon, 
                             select = c(time_diff_min, time_diff_rel, tti, city_)), 
                      subset(amsterdam, 
                             select = c(time_diff_min, time_diff_rel, tti, city_)), 
                      subset(glasgow, 
                             select = c(time_diff_min, time_diff_rel, tti, city_)), 
                      subset(goteborg, 
                             select = c(time_diff_min, time_diff_rel, tti, city_))
))


for_tbl$geometry <- NULL

all_time_diff_table <- as_tibble(na.omit(for_tbl) %>% 
  group_by(city_) %>% 
  summarize(Routes = length(time_diff_min)*2,
            N= length(time_diff_min),
            Mean = mean(time_diff_min),
            S.D. = sd(time_diff_min),
            Min = min(time_diff_min),
            Max = max(time_diff_min)
  )
)

all_tti_table <-  as_tibble(na.omit(for_tbl) %>% 
  group_by(city_) %>% 
  summarize(Routes = length(tti)*2,
            N= length(tti),
            Mean = mean(tti),
            S.D. = sd(tti),
            Min = min(tti),
            Max = max(tti)
  )
)

xtable(all_time_diff_table)
xtable(all_tti_table)


as_tibble()

