## global.R ##
library(shinydashboard)
library(shinyWidgets)
library(ggplot2)
library(shiny)
library(plotly)
Sys.setlocale(locale="C")
# read csv file into a dataframe 
crash_df = read.csv(file = 'cleaned_data.csv', stringsAsFactors = FALSE)
# map_df = read.csv(file = "map_data.csv",stringsAsFactors = FALSE)
map_df2 = read.csv(file = "map_data2.csv",stringsAsFactors = FALSE)
head(crash_df)
# create two variables with Operator and Type column values as choice
choice1 = sort(Operators_list)
choice2 = sort(Type_list)
choice3 = sort(year_list)
#create new dataframe grouped by month for tab 3
monthly_df = group_by(crash_df,Month) %>% summarise(count = n())
#create the lists for the selectized inputs
Operators_list = crash_df$Operator %>% unique()
Type_list = crash_df$Type %>% unique()
year_list = crash_df$Year %>% unique()
#ordering the months for tab 3
crash_df$month = factor(crash_df$month, levels = month.abb)
#ordering the dates for tab 2
#crash_df$Date <- factor(crash_df$Date, labels = dates,  ordered = T)
crash_df$Date
head(crash_df)
crash_df$realdate = as.POSIXct(strptime(x = as.character(crash_df$Date),format = "%d/%m/%Y"),format= "%d/%m/%Y")
map_df2$realdate = as.POSIXct(strptime(x = as.character(map_df2$Date),format = "%d/%m/%Y"),format= "%d/%m/%Y")

#creating concatenated column for the crash _df
crash_df = mutate(crash_df,
             concated_column = paste("Operator:",Operator,"\n","Type:", Type,"\n","Ratio:", Ratio,"\n","Ground:",Ground,"\n","Location:",Location))
#creating the concatenated column for the map_df
# map_df = mutate(map_df,
#                   concated_column = paste(Operator, Type,Fatalities, Ratio,Ground,Location, sep = ' \n '))
map_df2 = mutate(map_df2,
                concated_column = paste("Date:",Date,"\n","Operator:",Operator,"\n","Type:", Type,"\n","Fatalities:",Fatalities,"\n","Ratio:", Ratio,"\n","Ground:",Ground,"\n","Location:",Location))
