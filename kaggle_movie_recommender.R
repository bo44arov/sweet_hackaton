rm(list = ls())

library(lubridate)
library(dplyr)
library(stringr)
library(readr)
library(data.table)

####################
# 1.1. Load data
####################

path = "C:\\Users\\Eovil\\Desktop\\Kaggle_Sweet TV_MovieRecommender"
setwd(path)

movies_database <- read_csv(paste0(getwd(), "\\sweettv-movie-recommender\\movies_database.csv"))
nrow(movies_database)
movies_hist <- read_csv(paste0(getwd(), "\\sweettv-movie-recommender\\movies_dataset_10 months.csv"))
nrow(movies_hist)

####################
# 1.2. Process data
####################

# 1.2.1. movies_database

genres_lists <- movies_database %>% select(genres) %>% unlist() %>% str_split(",")
genres_lists

uniq_genres_list <- genres_lists %>%  unlist() %>% str_split(",") %>% unlist() %>%unique()
uniq_genres_list

m_genre <- matrix(nrow = nrow(movies_database), ncol = length(uniq_genres_list), data = 0) %>% as.data.frame()
colnames(m_genre) <- uniq_genres_list

head(m_genre)

for(i in 1:length(genres_lists)) {
  
  for(j in 1:length(genres_lists[[i]])) {
    
    m_genre[i, genres_lists[[i]][j]] <- 1
  }
}

# to add parsing for additional data here
final_data <- cbind(movies_database$id, m_genre,  movies_database$imdb_id,  movies_database$imdb_rating)
colnames(final_data) <- c("id", colnames(m_genre), "imdb_id", "imdb_rating_set")

# 1.2.1. movies_hist



########################################
# 1.3. Create final dataset
########################################



# features
# genres as one hot items
# cluster films
# build prediction