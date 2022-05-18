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
