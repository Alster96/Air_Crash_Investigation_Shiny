## global.R ##
library(shinydashboard)
library(shinyWidgets)
library(ggplot2)
library(shiny)
library(plotly)
Sys.setlocale(locale="C")
# read csv file into a dataframe 
crash_df = read.csv(file = 'cleaned_data.csv', stringsAsFactors = FALSE)
head(crash_df)
# create two variables with Operator and Type column values as choice
choice1 = sort(Operators_list)
choice2 = sort(Type_list)
#create new dataframe grouped by month for tab 3
monthly_df = group_by(crash_df,Month) %>% summarise(count = n())
#create the lists for the selectized inputs
Operators_list = crash_df$Operator %>% unique()
Type_list = crash_df$Type %>% unique()
#ordering the months for tab 3
crash_df$month = factor(crash_df$month, levels = month.abb)
#ordering the dates for tab 2
crash_df$Date <- factor(crash_df$Date, labels = dates,  ordered = T)
crash_df$Date
head(crash_df)
crash_df$realdate = as.POSIXct(strptime(x = as.character(crash_df$Date),format = "%d/%m/%Y"),format= "%d/%m/%Y")
#creating concatenated column 
crash_df = mutate(crash_df,
             concated_column = paste(Operator, Type, Ratio,Ground,Location, sep = ' \n '))

