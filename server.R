server <- function(input, output) {
  state_shape <- map_data("state")
  pol_pty <- read.csv("Party Leaning.csv")
  ufo_sightings <- read.csv("complete.csv")
  landlocked_df <- read.csv("Landlocked States.csv")
  state_pop_df <- read.csv("States Population Size - Sheet1.csv")
  
  
  final <- read.csv("Final dataSet.csv")
  final$latitude <- as.numeric(final$latitude)
  final$longitude <- as.numeric(final$longitude)
  
  
  output$map <- renderPlot({
    state_count <- final %>%
      mutate(State = tolower(State)) %>%
      group_by(State) %>%
      summarize(state_total = sum(num.sightings))
    final_join <- left_join(state_shape, 
                            state_count,
                            by = c("region" = "State"))
    
    
    ggplot(data = final_join) + 
      geom_polygon(mapping = aes(x = long,
                                 y = lat,
                                 group = group,
                                 fill = state_total)) + 
      scale_fill_continuous(low = 'yellow',
                            high = 'purple',
      ) + 
      
      
      coord_map()
    
  })
  
  output$plot2 <- renderPlot({
    #----------------political parties
    pol_pty$region <- tolower(pol_pty$State)
    
    # Merge the map data with your data
    merged_data <- merge(state_shape, pol_pty, by = "region", all.x = T)
    
    # Create a new column for color mapping
    merged_data$color <- ifelse(merged_data$Republican.lean.Rep > merged_data$Democrat.lean.Dem, "red", "blue")
    
    # Plot the map
    ggplot(merged_data, aes(x = long, y = lat, group = group, fill = color)) +
      geom_polygon(color = "black") +
      scale_fill_identity() +
      coord_map() +
      theme_minimal() +
      theme(legend.position = "none")
  })
}