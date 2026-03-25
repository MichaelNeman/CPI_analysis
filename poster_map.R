library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(maps)
library(stringr)

WD = "C:\\Users\\mnema\\OneDrive - University of Nebraska at Omaha\\Documents\\School\\00STATS_4420\\Poster\\data_files"
setwd(WD)

#import filter and bind data sets
OECD_percent_changed = read_csv("country_data2.csv")



#get long and lat for world map
map.data = map_data("world")


#rename column
map.data = map.data %>% rename(Country = region)


map_data = merge(x = map.data, y = OECD_percent_changed, by = "Country", all.x = TRUE)
map_data = arrange(map_data, Country, group, order)


ggplot(map_data, aes(x=long, y=lat, group=group)) +
  geom_polygon(aes(fill=log(`2023-01`)), color="grey80", size = 0.2) + theme_light() + 
  scale_color_brewer(type = "div",) +
  labs(fill = 'log of CPI') +
  labs(title = "Variation in CPI Change Equally Distributed") +
  theme(axis.title = element_blank())
  

write.csv(OECD_percent_changed, "OECD_percent_changed.csv")
write.csv(country_data2, "country_data2.csv")
