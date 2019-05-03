## global.R ##

# read csv file into a dataframe 
crash_df = read.csv(file = 'cleaned_data.csv', stringsAsFactors = FALSE)
head(crash_df)
# create two variables with Operator and Type column values as choice
choice1 = c("Select All", Operators_list)
choice2 = c("Select All",Type_list)

#create new dataframe grouped by month for tab 3
monthly_df = group_by(crash_df,Month) %>% summarise(count = n())
#create the lists for the selectized inputs
Operators_list = crash_df$Operator %>% unique()
Type_list = crash_df$Type %>% unique()
