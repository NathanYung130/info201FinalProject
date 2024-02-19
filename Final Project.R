states <- read.csv("scrubbed.csv")
party <- read.csv("Party Leaning.csv")


states$date.posted <- as.Date(states$date.posted, format="%m/%d/%Y")
states <- states %>%
  filter(date.posted >= as.Date("2011-01-01") & country == "us")
