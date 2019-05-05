my_df = read.csv(file = 'cleaned_data.csv', stringsAsFactors = FALSE)
cities = read.csv(file = 'worldcities.csv', stringsAsFactors = FALSE)

# cleaning
cities = cities[!duplicated(cities$city), ]
cities = cities[!duplicated(cities$lat), ]

my_df$Location = tolower(my_df$Location)
cities$city = tolower(cities$city)
head(my_df$Location)
library(dplyr)
library(tidyr)
# my_df$Location = strsplit((my_df$Location), ",")
# separate_rows(my_df, Location, sep = ",")
my_df = my_df %>% 
  mutate(city = strsplit(as.character(Location), ",")) %>%
  unnest(city)
head(my_df)
my_df
head(cities)
new_df = merge(my_df, cities, by = "city")
new_df

sum(is.na(new_df$lat))

write.csv(new_df, file = "map_data2.csv")

