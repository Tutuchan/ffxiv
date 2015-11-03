library(RSQLite)
library(dplyr)
library(tidyr)
# Load data
players_src <- src_sqlite("data/players-20150801.db")
dfData <- tbl(players_src, "players")
glimpse(dfData)

# Tidy data
tidy_levels <- function(v){
  if(any(v == "")) v[v == ""] <- "0"
  as.numeric(v)
}

testDK <- dfData %>% 
  # mutate_each(funs(as.numeric), starts_with('level')) %>% 
  filter(level_darkknight != "") %>% 
  select(id, level_darkknight) %>% 
  collect %>% 
  mutate_each(funs(tidy_levels), starts_with('level'))


