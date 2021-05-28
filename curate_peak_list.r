library(tidyverse)

## Functions

# Drop every column except
#	'medMZ': contains m/z-values,
#	columns starting with 'name': contains peak intensity of samples
drop_columns <- function(df,name){
    data <- df %>%
        select(medMz, starts_with(name))
    return(data)
}

# Remove m/z duplicates
#	Duplicates usually have the same intensity,
#	if this is not the case, the m/z with the highest intensity is kept
remove_dupl <- function(df){
    data <- df %>%
        arrange(medMz, -sum(across(starts_with("PSB")))) %>%
        distinct(medMz, .keep_all = TRUE)
    return(data)
}

# Optional: Sort columns for export
#	Define order:
#		order <- c('medMZ','sample1','sample2',...'samplen')
order_columns <- function(df,order){
    data <- df[,]
}


## Run Script

# Load data
#	Insert path and name
df_pos <- read.csv('.csv')
df_neg <- read.csv('.csv')

# Replace '____' with starting string of samples
name <- '_____'
df_pos <- drop_columns(df_pos, name)
df_neg <- drop_columns(df_neg, name)

df_pos <- remove_dupl(df_pos)
df_neg <- remove_dupl(df_neg)

# Replace '____' with strings of column names
order <- c('____','____')
df_pos <- order_columns(df_pos)
df_neg <- order_columns(df_neg)

# Export
write.csv(df_pos, 'untargeted_pos_input.csv', row.names=FALSE)
write.csv(df_neg, 'untargeted_neg_input.csv', row.names=FALSE)
