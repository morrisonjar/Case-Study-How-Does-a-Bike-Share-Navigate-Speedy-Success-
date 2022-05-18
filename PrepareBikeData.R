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


#Finding the total duration (minutes) by user type
bike_data %>% 
  group_by(member_casual) %>% 
  summarise(number_of_rides = n()
            ,total_duration = sum(ride_length))


#Finding the number of bikes rented by user type
bike_data %>% 
  group_by(member_casual, rideable_type) %>% 
  summarise(number_of_rides = n()) %>% 
  arrange(member_casual, rideable_type)


#Finding the number of trips by the day of the week
bike_data %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n()) %>% 
  arrange(member_casual, weekday)


#Finding the average duration (minutes) for user type by each day of the week
bike_data %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length))


#Finding the time where bike rentals occur during the course of a single day
bike_data %>% 
  group_by(member_casual, start_hour) %>% 
  summarise(number_of_rides = n()) %>% 
  arrange(member_casual, start_hour)


#Finding the amount of rides for each month during the course of a year
bike_data %>% 
  mutate(date = format(as.Date(started_at), "%Y-%m"), label = TRUE) %>% 
  group_by(member_casual, date) %>% 
  summarise(number_of_rides = n()) %>% 
  arrange(member_casual, date)


#Finding the top 10 stations visited for casual users
bike_data %>% 
  group_by(start_station_name, member_casual) %>% 
  summarise(number_of_trips = n()) %>%
  arrange(desc(number_of_trips)) %>%
  filter(member_casual == "casual") %>%
  ungroup() %>% # https://bookdown.org/yih_huynh/Guide-to-R-Book/groupby.html
  top_n(10, number_of_trips) # https://statisticsglobe.com/select-top-n-highest-values-by-group-in-r


#Finding the top 10 stations visited for members
bike_data %>% 
  group_by(start_station_name, member_casual) %>% 
  summarise(number_of_trips = n()) %>%
  arrange(desc(number_of_trips)) %>%
  filter(member_casual == "member") %>%
  ungroup() %>% 
  top_n(10, number_of_trips)


#Finding the top 10 stations visited for all users
bike_data %>% 
  group_by(start_station_name) %>% 
  summarise(number_of_trips = n()) %>%
  arrange(desc(number_of_trips)) %>%
  ungroup() %>% 
  top_n(10, number_of_trips) 

