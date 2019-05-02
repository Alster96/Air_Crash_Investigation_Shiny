## global.R ##

# read csv file into a dataframe 
crash_df = read.csv(file = 'cleaned_data.csv', stringsAsFactors = FALSE)
head(crash_df)
# create two variables with Operator and Type column values as choice
#choice1
#choice2