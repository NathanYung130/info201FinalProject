states <- read.csv("scrubbed.csv")
party <- read.csv("Party Leaning.csv")


states$date.posted <- as.Date(states$date.posted, format="%m/%d/%Y")
states <- states %>%
  filter(date.posted >= as.Date("2011-01-01") & country == "us")


pol_pty <- read.csv("/Users/chris_moy/Downloads/Party leaning - Party leaning.csv")ufo_sightings <- read.csv("/Users/chris_moy/Downloads/complete.csv")library(dplyr)us_ufo_sightings <- ufo_sightings %>%  filter(country == 'us')us_ufo_sightings$date.posted <- as.Date(us_ufo_sightings$date.posted, format = "%m/%d/%Y")us_recent_ufo_sightings <- us_ufo_sightings %>%  filter(date.posted > as.Date("2011-01-01"))ufo_pol_pty_combined_df <- full_join(us_recent_ufo_sightings, pol_pty, by = 'state')