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


analysis_df$started_at <- ymd_hms(analysis_df$started_at)
analysis_df$ended_at <- ymd_hms(analysis_df$ended_at)

install.packages("lubridate")
library(lubridate)

#Extract Day of the Week
analysis_df$started_at <-ymd_hms(analysis_df$started_at)
analysis_df <-analysis_df %>%
  mutate(day_of_week = lubridate::wday(started_at, label = TRUE))

analysis_df <- analysis_df %>%
  mutate(
    year = year(started_at),
    month = month(started_at),
    day = day(started_at),
    time = format(started_at, "%H:%M:%S"),
    hour = hour(started_at)
  )

View(analysis_df)

## Analysis

### Summary Statistics 
# Calculate summary statistics for key variables to get an overview of the differences.

summary_stats <- cyclistic_df_analysis %>%
  group_by(member_casual) %>%
  summarise(
    avg_ride_duration = mean(ride_duration, na.rm = TRUE),
    median_ride_duration = median(ride_duration, na.rm = TRUE),
    total_rides = n()
  )
print(summary_stats)

### Ride Duration Analysis
avg_ride_duration <- cyclistic_df_analysis %>%
  group_by(member_casual) %>%
  summarise(avg_duration = mean(ride_duration, na.rm = TRUE))

ggplot(avg_ride_duration, aes(x = member_casual, y = avg_duration, fill = member_casual)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Ride Duration", x = "User Type", y = "Average Duration (minutes)") +
  theme_minimal()

### Usage by the day of the Week
usage_by_day <- cyclistic_df_analysis %>%
  group_by(day_of_week, member_casual) %>%
  summarise(total_rides = n())

ggplot(usage_by_day, aes(x = day_of_week, y = total_rides, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Usage by Day of the Week", x = "Day of the Week", y = "Total Rides")

### Hourly Usage Patterns

# Group data by hour and member type
hourly_usage <- cyclistic_df_analysis %>%
  group_by(hour, member_casual) %>%
  summarise(total_rides = n(), .groups = 'drop')

# Plot the hourly usage patterns
ggplot(hourly_usage, aes(x = hour, y = total_rides, color = member_casual)) +
  geom_line(size = 1) +
  labs(title = "Hourly Usage Patterns", x = "Hour of the Day", y = "Total Rides") +
  theme_minimal() +
  scale_x_continuous(breaks = 0:24)

### Usage by time of the day
# Group data by time of day and member type
time_of_day_usage <- cyclistic_df_analysis %>%
  group_by(time_of_day, member_casual) %>%
  summarise(total_rides = n(), .groups = 'drop')

# Plot the usage patterns by time of day
ggplot(time_of_day_usage, aes(x = time_of_day, y = total_rides, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Usage by Time of Day", x = "Time of Day", y = "Total Rides") +
  theme_minimal()

### Most Popular Stations
# Most popular start stations for casual riders
popular_start_stations_casual <- cyclistic_df_analysis %>%
  filter(member_casual == "casual") %>%
  count(start_station_name, sort = TRUE) %>%
  top_n(10)

# Most popular start stations for annual members
popular_start_stations_members <- cyclistic_df_analysis %>%
  filter(member_casual == "member") %>%
  count(start_station_name, sort = TRUE) %>%
  top_n(10)

print(popular_start_stations_casual)
print(popular_start_stations_members)

# Most popular end stations for casual riders
popular_end_stations_casual <- cyclistic_df_analysis %>%
  filter(member_casual == "casual") %>%
  count(end_station_name, sort = TRUE) %>%
  top_n(10)

# Most popular end stations for annual members
popular_end_stations_members <- cyclistic_df_analysis %>%
  filter(member_casual == "member") %>%
  count(end_station_name, sort = TRUE) %>%
  top_n(10)

print(popular_end_stations_casual)
print(popular_end_stations_members)

# Visualization for start stations
ggplot(popular_start_stations_casual, aes(x = reorder(start_station_name, n), y = n, fill = "casual")) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Top 10 Start Stations for Casual Riders", x = "Start Station", y = "Number of Rides") +
  theme_minimal()

ggplot(popular_start_stations_members, aes(x = reorder(start_station_name, n), y = n, fill = "member")) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Top 10 Start Stations for Annual Members", x = "Start Station", y = "Number of Rides") +
  theme_minimal()

# Most popular end stations for casual riders
popular_end_stations_casual <- cyclistic_df_analysis %>%
  filter(member_casual == "casual") %>%
  count(end_station_name, sort = TRUE) %>%
  top_n(10)

# Most popular end stations for annual members
popular_end_stations_members <- cyclistic_df_analysis %>%
  filter(member_casual == "member") %>%
  count(end_station_name, sort = TRUE) %>%
  top_n(10)

# Visualization for end stations for casual riders
ggplot(popular_end_stations_casual, aes(x = reorder(end_station_name, n), y = n, fill = "casual")) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Top 10 End Stations for Casual Riders", x = "End Station", y = "Number of Rides") +
  theme_minimal()

# Visualization for end stations for annual members
ggplot(popular_end_stations_members, aes(x = reorder(end_station_name, n), y = n, fill = "member")) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Top 10 End Stations for Annual Members", x = "End Station", y = "Number of Rides") +
  theme_minimal()

# Seasonal usage
seasonal_usage <- cyclistic_df_analysis %>%
  group_by(season, member_casual) %>%
  summarise(total_rides = n())

ggplot(seasonal_usage, aes(x = season, y = total_rides, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Seasonal Usage", x = "Season", y = "Total Rides")

### Rideable Type Analysis
#### Count of Rides by Bike Type and User Type
# Group data by rideable type and member type
rideable_type_usage <- cyclistic_df_analysis %>%
  group_by(rideable_type, member_casual) %>%
  summarise(total_rides = n(), .groups = 'drop')

# Plot the usage patterns by rideable type
ggplot(rideable_type_usage, aes(x = rideable_type, y = total_rides, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Usage by Bike Type and User Type", x = "Bike Type", y = "Total Rides") +
  theme_minimal()

# Calculate average ride duration by rideable type and member type
avg_ride_duration <- cyclistic_df_analysis %>%
  group_by(rideable_type, member_casual) %>%
  summarise(avg_duration = mean(ride_duration, na.rm = TRUE), .groups = 'drop')

# Plot the average ride duration by rideable type
ggplot(avg_ride_duration, aes(x = rideable_type, y = avg_duration, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Average Ride Duration by Bike Type and User Type", x = "Bike Type", y = "Average Duration (minutes)") +
  theme_minimal()