## Project Background

This project is part of the Google Data Analytics Professional Certificate. The goal of this capstone project is to analyze bike-share usage patterns and develop user conversion strategies. I will discuss the background of the project, the full process of cleaning, analyzing, and visualizing the data, along with my final recommendations and the summary of data.

## Quick Links
- [Final Analysis RMD file](https://abicabadin.github.io/cyclistic-analysis-project/)
- [Final Case Study Codes](https://github.com/abicabadin/Google-Data-Analytics-Capstone/blob/main/Final%20Case%20Study%20Codes.R)
- [Final Analysis Code for Tableau](https://github.com/abicabadin/Google-Data-Analytics-Capstone/blob/main/FinalAnalysisCodeforTableau.R)
- [Tableau Dashboard](https://public.tableau.com/views/GoogleDataAnalytics_17305898004570/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

## Table of Contents
- [Introduction](#introduction)
- [Data Sources](#data-sources)
- [Process](#process)
- [Data Cleaning and Preparation](#data-cleaning-and-preparation)
- [Analysis of Data Using R](#analysis-of-data-using-r)
- [Tableau Dashboard](#tableau-dashboard)
- [Recommendations and Conclusion](#recommendations-and-conclusion)
- [Future Work](#future-work)
- [Acknowledgements](#acknowledgements)

## Introduction

![Cyclistic Logo](https://raw.githubusercontent.com/abicabadin/Google-Data-Analytics-Capstone/main/cyclistic.jpeg)


Cyclistic, a bike-share company based in Chicago, has grown significantly since its launch in 2016. With a fleet of over 5,800 bicycles and 600 docking stations, Cyclistic offers a variety of bikes, including traditional two-wheelers, reclining bikes, hand tricycles, and cargo bikes, making the service inclusive for people with disabilities. The company's marketing strategy has primarily focused on building general awareness and appealing to broad consumer segments through flexible pricing plans, including single-ride passes, full-day passes, and annual memberships.

The marketing team at Cyclistic, led by Director Lily Moreno, believes that the company's future success hinges on maximizing the number of annual memberships. To achieve this, the team aims to understand how casual riders and annual members use Cyclistic bikes differently. By analyzing historical bike trip data, the team hopes to design a new marketing strategy to convert casual riders into annual members. This case study will explore the differences in usage patterns between casual riders and annual members, providing compelling data insights and professional visualizations to support the proposed marketing strategies.

### My Role

As a junior data analyst at Cyclistic, I am part of a team tasked with designing marketing strategies aimed at converting casual riders into annual members.

### Overall Goal

Design marketing strategies aimed at converting casual riders into annual members.

### Business Question

"How do annual members and casual riders use Cyclistic bikes differently?"

## Data Sources

The data used in this project comes from the [Divvy Bike Share System Data](https://divvy-tripdata.s3.amazonaws.com/index.html).

To analyze and identify trends in how different customer types used Cyclistic bikes, I used Cyclistic's historical trip data from the past 12 months. I downloaded this data from the provided link. Although Cyclistic is a fictional company, the datasets were appropriate for my case study and helped me answer the business questions. The data was made available by Motivate International Inc. under a specific license.

This public data allowed me to explore how different customer types, such as casual riders and annual members, used Cyclistic bikes. However, due to data privacy issues, I could not use personally identifiable information. This meant I wasn't able to connect pass purchases to credit card numbers to determine if casual riders lived in the Cyclistic service area or if they had purchased multiple single passes.

## Process

### Overview

I downloaded the CSV file containing data from October 2023 to September 2024. Given the large size of the dataset, I chose to analyze the data as a whole using R. R is particularly well-suited for handling big data due to its powerful data manipulation capabilities and efficient memory management. Additionally, R's extensive library ecosystem, including packages like `dplyr` and `data.table`, allows for seamless data processing and analysis.

To create visualizations, I used R Studio and the `ggplot2` package, which offers a flexible and elegant way to produce high-quality graphics. Furthermore, I developed a separate dashboard in Tableau to provide an interactive and user-friendly interface for exploring the data insights.

By leveraging R for data analysis and Tableau for visualization, I was able to efficiently manage and present the large dataset, ensuring that the insights were both comprehensive and accessible.

## Data Cleaning and Preparation

### Steps:

1. **Install and Load Packages**:
   - I installed and loaded the following packages and libraries in R:
     - `tidyverse`: A collection of R packages designed for data science, including tools for data manipulation and visualization.
     - `lubridate`: Simplifies working with dates and times.
     - `dplyr`: Provides a grammar for data manipulation, making it easier to work with data frames.
     - `hms`: Handles and manipulates time-of-day values.
     - `data.table`: Offers fast data manipulation and aggregation capabilities.

2. **Set Working Directory**:
   - I set my working directory to ensure all file paths are correctly referenced.

3. **Upload CSV Files**:
   - I uploaded all the original CSV files, containing a year's worth of data from October 2023 to September 2024, using the `fread` function and saved them in separate data frames.

4. **Combine Monthly Data Frames**:
   - I combined all the monthly data frames using the `bind_rows` function to create a single data frame representing the entire year.

5. **Remove Individual Monthly Data Frames**:
   - To clear up space in the environment, I removed the individual monthly data frames.

6. **Create Analysis Data Frame**:
   - I created a new data frame, `analysis_df`, to contain all the information for analysis.

7. **Create New Columns**:
   - I added new columns to the `analysis_df` data frame, including ride duration, day of the week, year, month, day, time, and hour.

8. **Clean Data**:
   - I cleaned the data by:
     - Removing rows with NA values.
     - Removing duplicates.
     - Removing rows where ride duration is 0 or negative.

## Analysis of Data Using R

1. **Summary Statistics**:
   - I calculated the summary statistics for casual and annual members, including the mean and median.

2. **Ride Duration Analysis**:
   - I computed the average ride duration for both members and casual riders and created a bar graph using `ggplot2`.

3. **Usage by Day**:
   - I calculated the total number of rides for casual and annual members by day and created a bar graph using `ggplot2` to visualize the data.

4. **Hourly Usage Patterns**:
   - I computed the hourly usage patterns for casual and annual members and plotted the results using a line graph with `ggplot2`.

5. **Usage by Time of Day**:
   - I calculated the usage by time of day for both members and casual riders and created a bar graph using `ggplot2` to display the findings.

6. **Popular Start and End Stations**:
   - I identified the top ten most popular start and end stations for casual and annual members and plotted them using a bar graph with `ggplot2`.

7. **Seasonal Usage**:
   - I computed the seasonal usage for both members and casual riders and plotted the results in a bar graph using `ggplot2`.

8. **Rideable Type Analysis**:
   - I analyzed the rides by bike type and user type, as well as the average ride duration by rideable type and member type. These results were also plotted on a bar graph using `ggplot2`.

### R Markdown Analysis

I created an R Markdown (RMD) HTML file of the analysis that I conducted using R Studio. This file provides a comprehensive overview of the data analysis, and visualization processes. You can view the detailed analysis [here](https://abicabadin.github.io/cyclistic-analysis-project/).

## Tableau Dashboard

![Dashboard](https://github.com/abicabadin/Google-Data-Analytics-Capstone/blob/main/Dashboard%201.png)

As part of the Google Data Analytics Professional Certificate course, I also learned Tableau and wanted to practice more with visualizing the data. I created dashboards to enhance my data visualization skills.

You can view my actual Tableau dashboard [here](https://public.tableau.com/views/GoogleDataAnalytics_17305898004570/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link).

I created a separate R code for the Tableau visualization, which you can find [here](https://github.com/abicabadin/Google-Data-Analytics-Capstone/blob/main/FinalAnalysisCodeforTableau.R).

## Recommendations and Conclusion

### Recommendations Summary

Based on the data and interpretations from the charts, here are some targeted recommendations for the marketing team to convert casual riders to annual members:

1. **Promote Membership Benefits During Peak Seasons**:
   - **Summer Campaigns**: Launch aggressive marketing campaigns during summer, highlighting benefits like unlimited rides, cost savings, and convenience.
   - **Winter Incentives**: Offer special winter promotions to encourage casual riders to become members, emphasizing the value of membership even during off-peak seasons with benefits like free or discounted rides.

2. **Leverage Popular Start and End Stations**:
   - **Tourist Spots**: Place promotional materials and membership sign-up kiosks at tourist attractions, offering special deals for tourists who sign up for annual memberships.
   - **Commuter Hubs**: Target marketing efforts at popular start and end stations for annual members, such as business districts and transit hubs, highlighting the convenience and cost-effectiveness of using bikes for daily commutes.

3. **Highlight Cost Savings and Convenience**:
   - **Cost Comparison**: Create clear, compelling comparisons showing the cost savings of annual memberships versus pay-per-ride options, using real data to demonstrate potential savings.
   - **Convenience**: Emphasize the convenience of annual memberships, such as not having to worry about payment each time they ride and having access to bikes anytime.

4. **Seasonal Promotions and Discounts**:
   - **Weekend Specials**: Run special promotions and discounts on annual memberships during weekends, offering limited-time discounts to create a sense of urgency.
   - **Referral Programs**: Implement referral programs where current members can earn rewards for bringing in new annual members, leveraging the existing member base to attract more casual riders.

5. **Personalized Marketing**:
   - **Targeted Emails**: Use data analytics to identify frequent casual riders and send them personalized emails highlighting the benefits of annual memberships, including special offers and testimonials from current members.
   - **Social Media Campaigns**: Run targeted social media ads focusing on casual riders, showcasing the benefits of annual memberships through engaging content, videos, and user stories.

6. **Improved User Experience**:
   - **App Integration**: Enhance the mobile app experience by making it easy for casual riders to upgrade to annual memberships, including features like ride history, cost savings calculators, and easy sign-up processes.
   - **Customer Support**: Provide excellent customer support to address any questions or concerns casual riders might have about switching to an annual membership, offering live chat support and detailed FAQs.

### Conclusion

By focusing on these strategies, the marketing team can effectively convert casual riders to annual members, leveraging data-driven insights to tailor their approach. This will not only increase membership but also enhance user satisfaction and loyalty.

## Future Work

Future work could include:
- Analyzing seasonal trends
- Exploring the impact of weather on bike-share usage
- Implementing machine learning models to predict user behavior

## Acknowledgements

Special thanks to the Google Data Analytics Professional Certificate program for providing the framework and resources for this project.

