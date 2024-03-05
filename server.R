
server <- function(input, output) {
  library(shiny)
  library(ggplot2)
  library(maps)
  library(mapproj)
  library(plotly)
  library(dplyr)
  state_shape <- map_data("state")
  pol_pty <- read.csv("Party Leaning.csv")
  ufo_sightings <- read.csv("complete.csv")
  landlocked_df <- read.csv("Landlocked States.csv")
  state_pop_df <- read.csv("States Population Size - Sheet1.csv")
  
  
  final <- read.csv("Final dataSet.csv")
  final$latitude <- as.numeric(final$latitude)
  final$longitude <- as.numeric(final$longitude)
  
  
  output$map <- renderPlotly({
    if (input$show_sightings) {
      state_data <- final %>%
        mutate(State = tolower(State)) %>%
        group_by(State) %>%
        summarize(state_total = sum(num.sightings))
      title <- "UFO Sightings per State"
    } else {
      state_data <- final %>%
        mutate(State = tolower(State)) %>%
        group_by(State) %>%
        summarize(state_total = sum(Population))
      title <- "Population per State"
    }
    
    final_join <- left_join(state_shape, 
                            state_data,
                            by = c("region" = "State"))
    
    map <- ggplot(data = final_join) + 
      geom_polygon(mapping = aes(x = long,
                                 y = lat,
                                 group = group,
                                 fill = state_total)) + 
      scale_fill_continuous(low = if (input$show_sightings) 'yellow' else 'blue',
                            high = if (input$show_sightings) 'purple' else 'red') + 
      coord_map() + 
      labs(title = title)
    
    ggplotly(map)
  })
  
  output$map2 <- renderPlotly({
    #----------------political parties
    pol_pty$region <- tolower(pol_pty$State)
    
    # Merge the map data with your data
    merged_data <- merge(state_shape, pol_pty, by = "region", all.x = T)
    
    # Create a new column for color mapping
    merged_data$color <- ifelse(merged_data$Republican.lean.Rep > merged_data$Democrat.lean.Dem, "red", "blue")
    
    # Plot the map
    map2 <- ggplot(merged_data, aes(x = long, y = lat, group = group, fill = color)) +
      geom_polygon(color = "black") +
      scale_fill_identity() +
      coord_map() +
      theme_minimal() +
      theme(legend.position = "none")
    return(map2)
  })
  output$plot3 <- renderPlot({
    final$region <- tolower(final$State)
    
    # Merge the map data with your data
    merged_data <- merge(state_shape, final, by = c("State" = "region"), all.x = T)
    
    # Create a new column for color mapping
    merged_data$color <- ifelse(merged_data$Republican.lean.Rep > merged_data$Democrat.lean.Dem, "red", "blue")
    
    # Plot the map with points
    
    
    ggplot(merged_data, aes(x = long, y = lat)) +
      geom_polygon(aes(group = group, fill = color), color = "black") +
      geom_point(data = final, aes(x = longitude, y = latitude), color = "chartreuse4", size = 1) +
      scale_fill_identity() +
      coord_map() +
      theme_minimal() +
      theme(legend.position = "none")
    
    
    
    
  })
}