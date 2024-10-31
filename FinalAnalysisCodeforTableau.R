### Google Data Analytics Capstone ###

#Final Analysis#

#install and load packages
install.packages("tidyverse")
install.packages("lubridate")
install.packages("dplyr")
install.packages("hms")
install.packages("data.table")

library(tidyverse)
library(lubridate)
library(dplyr)
library(hms)
library(data.table)

#Set Working directory
setwd("C:/Users/abiga/OneDrive/Documents/SELF-STUDY FILES/Data Analytics Files/Google Data Analytics/Case Study/RAW .csv file")

#load original .csv files, a years worth of data from October 2023 to September 2024

oct23_df <-fread("202310-divvy-tripdata.csv")
nov23_df <-fread("202311-divvy-tripdata.csv")
dec23_df <-fread("202312-divvy-tripdata.csv")
jan24_df <-fread("202401-divvy-tripdata.csv")
feb24_df <-fread("202402-divvy-tripdata.csv")
mar24_df <-fread("202403-divvy-tripdata.csv")
apr24_df <-fread("202404-divvy-tripdata.csv")
may24_df <-fread("202405-divvy-tripdata.csv")
jun24_df <-fread("202406-divvy-tripdata.csv")
jul24_df <-fread("202407-divvy-tripdata.csv")
aug24_df <-fread("202408-divvy-tripdata.csv")
sept24_df <-fread("202409-divvy-tripdata.csv")

#combine all data frames using bind_rows into one year view
cyclistic_df <- bind_rows(oct23_df,nov23_df,dec23_df,jan24_df,feb24_df,mar24_df,apr24_df,may24_df,jun24_df,jul24_df,aug24_df,sept24_df)

#view the structure of the combined data frame
str(cyclistic_df)

#preview th first few rows of the combined data frame
head(cyclistic_df)

#remove individual monthly data frames to clear up space in the environment
rm(oct23_df,nov23_df,dec23_df,jan24_df,feb24_df,mar24_df,apr24_df,may24_df,jun24_df,jul24_df,aug24_df,sept24_df)

#view column names using colnames
colnames(cyclistic_df)

#create a new data frame that will contain all my new columns for analysis
analysis_df <- cyclistic_df

#calculate ride duration in minutes and create a column for it
analysis_df <- analysis_df %>%
  mutate(ride_duration = as.numeric(difftime(ended_at,started_at, units="mins")))

install.packages("lubridate")
library(lubridate)

#Create columns for a day of week, month, day, year, time, hour
#Extract Day of the Week
analysis_df$started_at <-ymd_hms(analysis_df$started_at)
analysis_df <-analysis_df %>%
  mutate(day_of_week = lubridate::wday(started_at, label = TRUE))

analysis_df <- analysis_df %>%
  mutate(
    year = year(started_at), #extracts the year
    month = month(started_at),#extracts the month
    day = day(started_at), #extracts the day
    time = format(started_at, "%H:%M:%S"), #extracts time
    hour = hour(started_at) #extracts the hour
  )

#Create column for different seasons: Winter, Spring, Summer, Fall
analysis_df <- analysis_df %>%
  mutate(season=case_when(month %in% c(12,1,2) ~ "Winter",
                          month %in% c(3,4,5) ~ "Spring",
                          month %in% c(6,7,8) ~ "Summer",
                          month %in% c(9,10,11) ~ "Fall"))

#Create a column for different time_of_day : Night, Morning, Afternoon, Evening
analysis_df <- analysis_df %>%
  mutate(time_of_day = case_when(hour >= 0 & hour < 6 ~ "Night",
                                 hour >= 6 & hour < 12 ~ "Morning",
                                 hour >= 12 & hour < 18 ~ "Afternoon",
                                 hour >= 18 & hour < 24 ~ "Evening"))

#Cleaning of the data

#Remove rows with NA values
analysis_df <- na.omit(analysis_df)

#Remove duplicates
analysis_df <-analysis_df %>% distinct()

#Remove where ride_duration is 0 or negative
analysis_df <- analysis_df %>% filter(ride_duration > 0)

analysis_df <- analysis_df %>% select(-start_station_id, -end_station_id, -start_lat, -start_lng, -end_lat, -end_lng)

#View the final data
View(analysis_df)

#Create a new data frame to use in Tableau
tableau_cyclistic_df <- analysis_df

#Clean the data more
tableau_cyclistic_df <- tableau_cyclistic_df %>% select(-time, -day, -started_at, -ended_at)

View(tableau_cyclistic_df)

#Download the new data as a .csv file
fwrite(tableau_cyclistic_df,"cyclistic_data_viz.csv")
