install.packages("tidyverse") #For data importing and wrangling
install.packages("lubridate") #For date functions
install.packages("ggplot") #For visualizations (make sure to upload scales)
install.packages("stringer") # For string manipulation

library(tidyverse)
library(lubridate)
library(ggplot2)  
library(dplyr)
library(scales)


getwd() #displays your working directory
setwd("C:/Computer_Coding/Spreadsheets Case Studies/Bike Case Study/Cyclist Data/Finished Data")

bike_data <- read_csv("BikeData.csv")
colnames(bike_data) #making sure columns got imported correctly
str(bike_data) #checking to see of I have to change the data types for anything  

# Convert "ride_length" from Factor to numeric so we can run calculations on the data
is.factor(bike_data$ride_length)
bike_data$ride_length_sec <- as.numeric(as.character(bike_data$ride_length))
is.numeric(bike_data$ride_length)

# Removing any data that cant be used. Cleaning the data to remove nulls and negative values
# https://www.datasciencemadesimple.com/delete-or-drop-rows-in-r-with-conditions-2/
bike_data <- bike_data[!(bike_data$start_station_name == "HQ QR" | 
                           bike_data$ride_length<0),]

# Fixing the days being out of order
bike_data$day_of_week <- ordered(bike_data$day_of_week, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

# Creating a year/month for the start of the information to the end of whats available
bike_data$date <- format(as.Date(bike_data$started_at), "%Y-%m")

# Help for anything date related in this program refer to:
# https://www.r-bloggers.com/2020/04/a-comprehensive-introduction-to-handling-date-time-in-r/

# For a lot of the graphing below I refered to three different sources to get a 
# better understanding on the problems that where faced. Any other issues I face will link beside the line of code for future reference  
# http://www.sthda.com/english/wiki/ggplot2-pie-chart-quick-start-guide-r-software-and-data-visualization
# https://r-graph-gallery.com/index.html
# https://r-coder.com/

#Finding the % of user type
bike_data %>%
  group_by(member_casual) %>%
  count() %>% 
  ungroup() %>% 
  mutate(perc = n / sum(n)) %>% 
  arrange(perc) %>%
  mutate(labels = scales::percent(perc)) #https://thomasadventure.blog/posts/ggplot2-percentage-scale/


#Create a visualization for % of user type
bike_data %>%
  group_by(member_casual) %>%
  count() %>% 
  ungroup() %>% 
  mutate(perc = n / sum(n)) %>% 
  arrange(perc) %>%
  mutate(labels = scales::percent(perc)) %>% 
  ggplot(aes(x="", y = labels, fill=member_casual))+
  geom_bar(stat = "identity", width = 1, color = "black") +
  geom_label(aes(label = labels),
             position = position_stack(vjust = 0.5),
             show.legend = FALSE) +
  labs(fill= "User Type", x = NULL, y = NULL, title = "% of User Types")+
  coord_polar(theta = "y") +
  theme_void()

#Finding the total duration (minutes) by user type
bike_data %>% 
  group_by(member_casual) %>% 
  summarise(number_of_rides = n()
            ,total_duration = sum(ride_length), .groups = 'drop')

#Create a visualization for total duration by User type
bike_data %>% 
  group_by(member_casual) %>% 
  summarise(number_of_rides = n()
            ,total_duration = sum(ride_length), .groups = 'drop') %>% 
  ggplot(aes(x = member_casual, y = total_duration, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_y_continuous(labels = comma) +
  labs(fill= "User Type", x = NULL, y = "Duration (minutes)", title = "Total Duration by User Type")+
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) # https://stackoverflow.com/questions/35090883/remove-all-of-x-axis-labels-in-ggplot


#Finding the number of bikes rented by user type
bike_data %>% 
  group_by(member_casual, rideable_type) %>% 
  summarise(number_of_rides = n(), .groups = 'drop') %>% 
  arrange(member_casual, rideable_type)

# Visualize the number of rides by bike type
bike_data %>% 
  group_by(member_casual, rideable_type) %>% 
  summarise(number_of_rides = n(), .groups = 'drop') %>% 
  arrange(member_casual, rideable_type)  %>% 
  ggplot(aes(x = rideable_type, y = number_of_rides, fill = member_casual)) + 
  geom_col(position = "dodge") +
  labs(fill= "User Type", x = "Bike Type", y = "Number Rented", title = "Number of rentals by Bike Type")


#Finding the number of trips by the day of the week
bike_data %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(), .groups = 'drop') %>% 
  arrange(member_casual, weekday)

# Visualize the number of rides by bike type
bike_data %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(), .groups = 'drop') %>% 
  arrange(member_casual, weekday) %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") + 
  scale_y_continuous(labels = comma) +
  labs(fill= "User Type", x = "Day of the week", y = "Number of trips", title = "Number of trips during the days of the week")


#Finding the average duration (minutes) for user type by each day of the week
bike_data %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length), .groups = 'drop')

#Create a visualization for average duration by each day
bike_data %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length), .groups = 'drop') %>% 
  arrange(member_casual, weekday) %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(fill = "User Type", x = "Day of the week", y = "Avg. Trip Length (minutes)", title = "Average duration during the days of the week")


#Finding the time where bike rentals occur during the course of a single day
bike_data %>% 
  group_by(member_casual, start_hour) %>% 
  summarise(number_of_rides = n(), .groups = 'drop') %>% 
  arrange(member_casual, start_hour)

#Create a visualization during the time of day the bikes are checked in
bike_data %>% 
  group_by(member_casual, start_hour) %>% 
  summarise(number_of_rides = n(), .groups = 'drop') %>% 
  arrange(member_casual, start_hour) %>% 
  ggplot(aes(x = start_hour, y = number_of_rides, group = member_casual)) +
  geom_line(aes(color = member_casual)) +
  scale_y_continuous(labels = comma) + # https://www.r-bloggers.com/2016/11/the-y-axis-to-zero-or-not-to-zero/
  labs(color = "User Type", x = "Hour of the day", y = "Number of trips", title = "Time of day where rental occurs")


#Finding the amount of rides for each month during the course of a year
bike_data %>% 
  group_by(member_casual, date) %>% 
  summarise(number_of_rides = n(), .groups = 'drop') %>% 
  arrange(member_casual, date)

#Create a visualization for usage during the day trips/time of day
bike_data %>% 
  group_by(member_casual, date) %>% 
  summarise(number_of_rides = n(), .groups = 'drop') %>% 
  arrange(member_casual, date) %>% 
  ggplot(aes(x = date, y = number_of_rides, group = member_casual)) +
  geom_line(aes(color = member_casual)) +
  scale_x_discrete(guide = guide_axis(n.dodge = 2)) + # https://datavizpyr.com/how-to-dodge-overlapping-text-on-x-axis-labels-in-ggplot2/
  scale_y_continuous(labels = comma) +
  labs(color = "User Type", x = "Months in the Year", y = "Number of trips", title = "Number of trips in the course of a year")


#Finding the top 10 stations visited for casual users
bike_data %>% 
  group_by(start_station_name, member_casual) %>% 
  summarise(number_of_trips = n(), .groups = 'drop') %>%
  arrange(desc(number_of_trips)) %>%
  filter(member_casual == "casual") %>%
  ungroup() %>% # https://bookdown.org/yih_huynh/Guide-to-R-Book/groupby.html
  top_n(10, number_of_trips) # https://statisticsglobe.com/select-top-n-highest-values-by-group-in-r

#Create a visualization for top station by casuals
bike_data %>% 
  group_by(start_station_name, member_casual) %>% 
  summarise(number_of_trips = n(), .groups = 'drop') %>%
  arrange(desc(number_of_trips)) %>%
  filter(member_casual == "casual") %>%
  ungroup() %>% 
  top_n(10, number_of_trips) %>% 
  ggplot(aes(x = reorder(start_station_name, -number_of_trips), y = number_of_trips)) +
  geom_col(fill = "#F8766D") + # https://stackoverflow.com/questions/8197559/emulate-ggplot2-default-color-palette
  labs(x = "Station Name", y = "Number of trips", title = "Top Station by casual users") +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 12))  + # https://statisticsglobe.com/wrap-long-axis-labels-ggplot2-plot-into-multiple-lines-r
  theme(axis.text.x = element_text(angle = 60, hjust = 1))
  

#Finding the top 10 stations visited for members
bike_data %>% 
  group_by(start_station_name, member_casual) %>% 
  summarise(number_of_trips = n(), .groups = 'drop') %>%
  arrange(desc(number_of_trips)) %>%
  filter(member_casual == "member") %>%
  ungroup() %>% 
  top_n(10, number_of_trips)

#Create a visualization for top station by members
bike_data %>% 
  group_by(start_station_name, member_casual) %>% 
  summarise(number_of_trips = n(), .groups = 'drop') %>%
  arrange(desc(number_of_trips)) %>%
  filter(member_casual == "member") %>%
  ungroup() %>% 
  top_n(10, number_of_trips) %>% 
  ggplot(aes(x = reorder(start_station_name, -number_of_trips), y = number_of_trips)) +
  geom_col(fill = "#00BFC4") +
  labs(x = "Station Name", y = "Number of trips", title = "Top Station by members") +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 12))  +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))


#Finding the top 10 stations visited for all users
bike_data %>% 
  group_by(start_station_name) %>% 
  summarise(number_of_trips = n(), .groups = 'drop') %>%
  arrange(desc(number_of_trips)) %>%
  ungroup() %>% 
  top_n(10, number_of_trips) 

#Create a visualization for top station in general
bike_data %>% 
  group_by(start_station_name) %>% 
  summarise(number_of_trips = n(), .groups = 'drop') %>%
  arrange(desc(number_of_trips)) %>%
  ungroup() %>% 
  top_n(10, number_of_trips) %>% 
  ggplot(aes(x = reorder(start_station_name, -number_of_trips), y = number_of_trips)) +
  geom_col(fill = "#C77CFF") +
  labs(x = "Station Name", y = "Number of trips", title = "Top Station for all user types") +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 12))  +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

