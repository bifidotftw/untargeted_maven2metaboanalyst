library(tidyverse)


## Functions

# Combine Dataframes
combine_df <- function(df1,df2){
    data <- rbind(df1,df2)
    return(data)
}

# Remove duplicates
#	Duplicate with higher gamma-p-value is kept
remove_dupl <- function(df){
    data <- df %>%
        arrange(Gamma) %>%
        distinct(X, .keep_all = TRUE)
    return(data)
}

# Calculate Enrichment & -log10(p), the values that are used for plotting in Metaboanalyst
calc_enrich_logp <- function(df){
    data <- df %>%
        mutate(enrichment = Hits.sig/Expected,
               neg_log10_p = -log10(FET)
              )
}


## Run

# Define name for export
name <- 'untargeted_kegg_pathways_grp1vsgrp2.csv'

# Load data
df_pos <- read.csv('01_untargeted_pos_result_kegg_pathways_grp1vsgrp2.csv')
df_neg <- read.csv('01_untargeted_neg_result_kegg_pathways_grp1vsgrp2.csv')

data <- combine_df(df_pos,df_neg)
data <- remove_dupl(data)
data <- calc_enrich_logp(data)

# Export
write.csv(data, name, row.names=FALSE)
