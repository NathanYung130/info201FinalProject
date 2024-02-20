states <- read.csv("scrubbed.csv")
party <- read.csv("Party Leaning.csv")
combD <- read.csv("combinedData2.csv")


states$date.posted <- as.Date(states$date.posted, format="%m/%d/%Y")
states <- states %>%
  filter(date.posted >= as.Date("2011-01-01") & country == "us")


pol_pty <- read.csv("Party Leaning.csv")
ufo_sightings <- read.csv("scrubbed.csv")

library(dplyr)

us_ufo_sightings <- ufo_sightings %>%
  filter(country == 'us')

us_ufo_sightings$date.posted <- as.Date(us_ufo_sightings$date.posted, format = "%m/%d/%Y")

us_recent_ufo_sightings <- us_ufo_sightings %>%
  filter(date.posted > as.Date("2011-01-01"))

ufo_pol_pty_combined_df <- full_join(states, party, by = 'state')

write.csv(ufo_pol_pty_combined_df, file = "combinedData.csv")


pol_pty <- read.csv("Party Leaning.csv")
ufo_sightings <- read.csv("complete.csv")
landlocked_df <- read.csv("Landlocked States.csv")
state_pop_df <- read.csv("States Population Size - Sheet1.csv")
#write.csv(ufo_pol_pty_combined_df, file = "UPDATEDcombinedData.csv")

library(dplyr)

# converting dates into standardized format
ufo_sightings$date.posted <- as.Date(ufo_sightings$date.posted, format = "%m/%d/%Y")

# filtering dataset to include only US states and posted after 1/1/2011
filtered_ufo_sightings <- ufo_sightings %>%
  filter(country == 'us' & date.posted > as.Date("2011-01-01"))

# combining the 2 datasets with 'state' as common variable
ufo_pol_pty_combined_df <- full_join(filtered_ufo_sightings, pol_pty, by = 'state')

# seeing which UFO sightings are in landlocked states
ufo_pol_pty_combined_df$is_land_locked <- FALSE
ufo_pol_pty_combined_df$is_land_locked[ufo_pol_pty_combined_df$State %in% landlocked_df$States] <- TRUE

# full joining state population sizes with ufo_pol_pty_combined_df
ufo_pol_pty_combined_df <- full_join(ufo_pol_pty_combined_df, state_pop_df, by = 'State')

# Counting how many sightings per state there are
num_sightings <- ufo_pol_pty_combined_df %>%
  group_by(State) %>%
  summarise(num.sightings = n())

# full joining num_sightings with ufo_pol_pty_combined_df
ufo_pol_pty_combined_df <- full_join(ufo_pol_pty_combined_df, num_sightings, by = 'State')

# new column for ratio of sightings per state
ufo_pol_pty_combined_df$sighting.ratio <- ufo_pol_pty_combined_df$num.sightings / ufo_pol_pty_combined_df$Population

# making summarization data frame
data_summary <- ufo_pol_pty_combined_df %>%
  group_by(state) %>%
  summarize(stateMax = max(num.sightings)) %>%
  filter(stateMax == max(stateMax))

write.csv(ufo_pol_pty_combined_df, file = "Final dataSet.csv")



