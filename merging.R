my_df = read.csv(file = 'cleaned_data.csv', stringsAsFactors = FALSE)
cities = read.csv(file = 'worldcitiespop.csv', stringsAsFactors = FALSE)

# cleaning
cities = cities[!duplicated(cities$City), ]
cities = cities[!duplicated(cities$Latitude), ]

my_df$Location = tolower(my_df$Location)
head(my_df$Location)
library(dplyr)
library(tidyr)
# my_df$Location = strsplit((my_df$Location), ",")
# separate_rows(my_df, Location, sep = ",")
my_df = my_df %>% 
  mutate(City = strsplit(as.character(Location), ",")) %>%
  unnest(City)
head(my_df)
my_df
head(cities)
new_df = merge(my_df, cities, by = "City")
new_df

new_df = na.omit(new_df, cols = "Latitude")

write.csv(new_df, file = "map_data.csv")

