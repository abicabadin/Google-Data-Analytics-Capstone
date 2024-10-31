#' ---
#' title: "Google Data Analytics Capstone"
#' author: Abigai Cabadin
#' date: "`r Sys.Date()`"
#' output: html_document
#'  ---

#' #Introduction
#' Scenario: I am a junior data analyst working on the marketing analyst team at Cyclistic, a bike share company in Chicago.
#' My team wants to understand how casual riders and annual members use Cyclistic bike differently. 
#' These line of codes will show you how I analyze the data using R. 

#' Final Analysis

#+ setup, include = FALSE
knitr::opts_chunk$set(echo=TRUE)

#' Install packages
install.packages("tidyverse")
install.packages("lubridate")
install.packages("dplyr")
install.packages("hms")
install.packages("data.table")

#' Load Packages
library(tidyverse)
library(lubridate)
library(dplyr)
library(hms)
library(data.table)

#' Set Working directory
setwd("C:/Users/abiga/OneDrive/Documents/SELF-STUDY FILES/Data Analytics Files/Google Data Analytics/Case Study/RAW .csv file")

#' Load original .csv files, a years worth of data from October 2023 to September 2024

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

#' Combine all data frames using bind_rows into one year view
cyclistic_df <- bind_rows(oct23_df,nov23_df,dec23_df,jan24_df,feb24_df,mar24_df,apr24_df,may24_df,jun24_df,jul24_df,aug24_df,sept24_df)

#' View the structure of the combined data frame
str(cyclistic_df)

#' Preview th first few rows of the combined data frame
head(cyclistic_df)

#' Remove individual monthly data frames to clear up space in the environment
rm(oct23_df,nov23_df,dec23_df,jan24_df,feb24_df,mar24_df,apr24_df,may24_df,jun24_df,jul24_df,aug24_df,sept24_df)

#' View column names using colnames
colnames(cyclistic_df)

#create a new data frame that will contain all my new columns for analysis
analysis_df <- cyclistic_df

#' Calculate ride duration in minutes and create a column for it
analysis_df <- analysis_df %>%
  mutate(ride_duration = as.numeric(difftime(ended_at,started_at, units="mins")))

#' Create columns for a day of week, month, day, year, time, hour
#' Extract Day of the Week
analysis_df$started_at <-ymd_hms(analysis_df$started_at)
analysis_df <-analysis_df %>%
  mutate(day_of_week = lubridate::wday(started_at, label = TRUE))

#' Extract the year, month, day, time, and hour
analysis_df <- analysis_df %>%
  mutate(
    year = year(started_at), #extracts the year
    month = month(started_at),#extracts the month
    day = day(started_at), #extracts the day
    time = format(started_at, "%H:%M:%S"), #extracts time
    hour = hour(started_at) #extracts the hour
  )

#' Create column for different seasons: Winter, Spring, Summer, Fall
analysis_df <- analysis_df %>%
  mutate(season=case_when(month %in% c(12,1,2) ~ "Winter",
                          month %in% c(3,4,5) ~ "Spring",
                          month %in% c(6,7,8) ~ "Summer",
                          month %in% c(9,10,11) ~ "Fall"))

#' Create a column for different time_of_day : Night, Morning, Afternoon, Evening
analysis_df <- analysis_df %>%
  mutate(time_of_day = case_when(hour >= 0 & hour < 6 ~ "Night",
                                 hour >= 6 & hour < 12 ~ "Morning",
                                 hour >= 12 & hour < 18 ~ "Afternoon",
                                 hour >= 18 & hour < 24 ~ "Evening"))

#' Data Cleaning

#Remove rows with NA values
analysis_df <- na.omit(analysis_df)

#Remove duplicates
analysis_df <-analysis_df %>% distinct()

#Remove where ride_duration is 0 or negative
analysis_df <- analysis_df %>% filter(ride_duration > 0)

analysis_df <- analysis_df %>% select(-start_station_id, -end_station_id, -start_lat, -start_lng, -end_lat, -end_lng)

#View the final data
View(analysis_df)

# Download data into .csv file
fwrite(analysis_df,"cyclistic_data_rmarkdown.csv")

