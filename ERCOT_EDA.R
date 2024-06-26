# Texas Solar Potential Analysis

# Script Name: ERCOT_EDA.R
# Purpose: Perform exploratory data analysis and time series analysis on ERCOT Energy Demand
# Author: Ayan Sarkar
# Date: June 26, 2024

# Load Relevant Libraries
library(dplyr)
library(pacman)
library(ggplot2)
library(DescTools)
library(glmnet)
library(tidyr)
library(knitr)
library(tinytex)
library(lubridate)
library(scales)
library(forecast)

# Set Working Directory & load data
directory <- setwd('/Users/ayansarkar/Desktop/ERCOT')
setwd('/Users/ayansarkar/Desktop/ERCOT')

# Load in & Clean Data to obtain system-wide Megawatt (MW) Load Consumption by Hour 
# Get a list of CSV files in the directory
csv_files <- list.files(path = directory, pattern = "\\.csv$", full.names = TRUE)
# Extract numeric part from each filename
numeric_part <- as.integer(gsub("\\D", "", basename(csv_files)))
# Sort filenames based on the numeric part
sorted_files <- csv_files[order(numeric_part)]
# Initialize a list to store DataFrames
dataframes <- list()
# Read each CSV file and store them in a list with names
for (i in seq_along(sorted_files)) {
  df <- read.csv(sorted_files[i])
  dataframes[[paste0("df", i)]] <- df
}
# Subset to maintain only whole-system load
for (i in seq_along(dataframes)) {
  # Subset the DataFrame to keep only the first and last column
  dataframes[[i]] <- dataframes[[i]][, c(1, ncol(dataframes[[i]]))]
}

# Standardize Variable Names
# Pull out dataframes from large list
df1 <- dataframes[[1]]
df2 <- dataframes[[2]]
df3 <- dataframes[[3]]
df4 <- dataframes[[4]]
df5 <- dataframes[[5]]
df6 <- dataframes[[6]]
df7 <- dataframes[[7]]
df8 <- dataframes[[8]]
df9 <- dataframes[[9]]
df10 <- dataframes[[10]]

# Rename the column "Hour_End" to "HourEnding" in each data frame
df1 <- rename(df1, HourEnding = Hour_End)
df2 <- rename(df2, HourEnding = Hour_End)
df3 <- rename(df3, HourEnding = Hour.Ending)
df7 <- rename(df7, HourEnding = Hour.Ending)
df8 <- rename(df8, HourEnding = Hour.Ending)
df9 <- rename(df9, HourEnding = Hour.Ending)
df10 <- rename(df10, HourEnding = Hour.Ending)

load_df <- rbind(df1, df2, df3, df4, df5, df6, df7, df8, df9, df10)

# Rename variable names for clarity & format data types
load_df_clean <- load_df %>%
  mutate(
    HourEnding = mdy_hm(HourEnding)
  ) %>%
  rename(ercot_mw = ERCOT, Datetime = HourEnding) %>%
  select(Datetime, ercot_mw, everything())

# Subset out non-NA entries
load_df_clean <- load_df_clean %>%
  mutate(
    ercot_mw = as.integer(gsub(",", "", ercot_mw, fixed = TRUE))
  )
load_df_clean <- load_df_clean[1:81791, ]

# Descriptive Statistics
print(summary(load_df_clean$ercot_mw))

# Plot Energy Consumption accross Texas over time
theme_set(theme_minimal())
ggplot(load_df_clean, aes(x = Datetime, y = ercot_mw)) +
  geom_line(color = "blue") +
  labs(title = "A. ERCOT Time Plot (2015-2024)",
       y = "Consumption [MW]",
       x = "Date") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Generate variables to enable further time-trend analysis
load_df_clean <- load_df_clean %>%
  mutate(
    year = year(Datetime),
    month = month(Datetime),
    week = week(Datetime),
    hour = hour(Datetime),
    day = wday(Datetime, label = TRUE),
    day_str = format(Datetime, "%a"),
    year_month = paste(year(Datetime), month(Datetime), sep = "_")
  )

# Plot Monthly Seasonal Trends
set.seed(42)
df_plot <- load_df_clean %>%
  na.omit() %>%
  group_by(month, year) %>%
  summarise(ercot_mw = mean(ercot_mw, na.rm = TRUE)) %>%
  ungroup()

years <- unique(df_plot$year)
colors <- scales::hue_pal()(length(years))

ggplot(df_plot, aes(x = month, y = ercot_mw, color = as.factor(year))) +
  geom_line() +
  geom_text(data = subset(df_plot, !duplicated(year)), aes(label = year, color = as.factor(year)), 
            vjust = -1, hjust = 10, position = position_nudge(y = -200)) +
  scale_color_manual(values = colors) +
  labs(title = "Seasonal Plot - Yearly Consumption",
       x = "Month",
       y = "Consumption [MW]") +
  theme_minimal() +
  scale_x_continuous(breaks = seq(2, 12, by = 2))

# Plot Weekly Seasonal Trends
set.seed(42)
df_plot <- load_df_clean %>%
  na.omit() %>%
  group_by(month, day, day_str) %>%
  summarise(ercot_mw = mean(ercot_mw, na.rm = TRUE)) %>%
  ungroup()

months <- unique(df_plot$month)
colors <- scales::hue_pal()(length(months))

df_plot$day_str <- factor(df_plot$day_str, levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))

ggplot(df_plot, aes(x = day_str, y = ercot_mw, color = as.factor(month))) +
  geom_line(data = subset(df_plot, month != min(month)), aes(group = month), size = 1) +
  geom_text(data = subset(df_plot, !duplicated(month)), aes(label = month, color = as.factor(month)), 
            vjust = -0.5, hjust = 15, position = position_nudge(y = 200)) +
  scale_color_manual(values = colors) +
  labs(title = "Seasonal Plot - Weekly Consumption",
       x = "Day",
       y = "Consumption [MW]") +
  theme_minimal()

# Plot Daily Seasonal Trends
df_plot <- load_df_clean %>%
  na.omit() %>%
  group_by(hour, day_str) %>%
  summarise(ercot_mw = mean(ercot_mw, na.rm = TRUE)) %>%
  ungroup()

ggplot(df_plot, aes(x = hour, y = ercot_mw, color = day_str)) +
  geom_line() +
  scale_x_continuous(breaks = seq(0, 23, by = 1)) +
  labs(title = "Seasonal Plot - Daily Consumption",
       x = "Hour",
       y = "Consumption [MW]")

# Total Consumption
ggplot(load_df_clean, aes(x = factor(1), y = ercot_mw, fill = factor(1))) +
  geom_boxplot() +
  labs(x = "Consumption [MW]", title = "Boxplot - Consumption Distribution") +
  theme_minimal() +
  coord_flip() +
  theme(legend.position = "none")

# Monthly Consumption
ggplot(load_df_plot, aes(x = factor(year_month), y = ercot_mw, fill = factor(year_month))) +
  geom_boxplot() +
  labs(
    title = "Boxplot Year Month Distribution",
    x = "Year Month",
    y = "Consumption [MW]"
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        legend.position = "none")

# Daily Distribution
load_df_plot <- load_df_clean %>%
  arrange(day)

load_df_plot$day_str <- factor(load_df_plot$day_str, levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))

ggplot(load_df_plot, aes(x = factor(day_str), y = ercot_mw, fill = factor(day_str))) +
  geom_boxplot() +
  labs(
    title = "Boxplot Day Distribution",
    x = "Day of week",
    y = "MW"
  ) +
  theme(legend.position = "none")

# Hourly Distribution
ggplot(load_df_clean, aes(x = factor(hour), y = ercot_mw, fill = factor(hour))) +
  geom_boxplot() +
  labs(
    title = "Boxplot Hour Distribution",
    x = "Hour",
    y = "MW"
  ) +
  theme(legend.position = "none")

# Time Series Distribution
df_plot <- load_df_clean %>%
  filter(year(Datetime) == 2020) %>%
  distinct(Datetime, .keep_all = TRUE) %>%
  arrange(Datetime)

result_add <- decompose(ts(df_plot$ercot_mw, frequency = 24*7), type = "additive")
result_mul <- decompose(ts(df_plot$ercot_mw, frequency = 24*7), type = "multiplicative")

plot(result_add, col = "blue")
plot(result_mul, col = "red")

# December Time Trends
df_plot <- load_df_clean %>%
  filter(year(Datetime) == 2020, month(Datetime) == 3) %>%
  distinct(Datetime, .keep_all = TRUE) %>%
  arrange(Datetime)

result_add <- decompose(ts(df_plot$ercot_mw, frequency = 24*7), type = "additive")
result_mul <- decompose(ts(df_plot$ercot_mw, frequency = 24*7), type = "multiplicative")

plot(result_add, col = "blue")
plot(result_mul, col = "red")







