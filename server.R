
server <- function(input, output) {
  library(shiny)
  library(ggplot2)
  library(maps)
  library(mapproj)
  library(plotly)
  library(dplyr)
  state_shape <- map_data("state")
  pol_pty <- read.csv("Party leaning.csv")
  ufo_sightings <- read.csv("complete.csv")
  landlocked_df <- read.csv("Landlocked States.csv")
  state_pop_df <- read.csv("States Population Size - Sheet1.csv")
  
  
  final <- read.csv("Final dataSet.csv")
  final$latitude <- as.numeric(final$latitude)
  final$longitude <- as.numeric(final$longitude)
  
  output$myImage <- renderImage({
    # Return a list containing the filename and alt text
    list(src = "www/Aliens.JPG",  # Ensure the image is in the www directory
         alt = "This is alternate text",
         width = "500px",
         height = "300px")
  }, deleteFile = FALSE)
  output$map11 <- renderPlotly({
    if (input$show_sightings) {
      # Your code for the sightings per state plot...
      state_data <- final %>%
        mutate(State = tolower(State)) %>%
        group_by(State) %>%
        summarize(state_total = n())  
      title <- "UFO Sightings per State"
      
      final_join <- left_join(state_shape, 
                              state_data,
                              by = c("region" = "State"))
      
      map <- ggplot(data = final_join) + 
        geom_polygon(mapping = aes(x = long,
                                   y = lat,
                                   group = group,
                                   fill = state_total)) + 
        scale_fill_continuous(low = 'yellow', high = 'purple') + 
        coord_map() + 
        labs(title = title)
      ggplotly(map)
    } else {
      pol_pty$region <- tolower(pol_pty$State)
      
      merged_data <- merge(state_shape, pol_pty, by = "region", all.x = T)
      
      merged_data$color <- ifelse(merged_data$Republican.lean.Rep > merged_data$Democrat.lean.Dem, "red", "blue")
      
      map10 <- ggplot(merged_data, aes(x = long, y = lat, group = group, fill = color)) +
        geom_polygon(color = "black") +
        scale_fill_identity() +
        coord_map() +
        theme_minimal() +
        theme(legend.position = "none")
      ggplotly(map10)
    }
  })
  
  output$map12 <- renderPlotly({
    # Calculate the total population per state
    state_data <- final %>%
      mutate(State = tolower(State)) %>%
      group_by(State) %>%
      summarize(state_total = sum(Population))
    title <- "Population per State"
    
    final_join <- left_join(state_shape, 
                            state_data,
                            by = c("region" = "State"))
    
    map <- ggplot(data = final_join) + 
      geom_polygon(mapping = aes(x = long,
                                 y = lat,
                                 group = group,
                                 fill = state_total)) + 
      scale_fill_continuous(low = 'blue', high = 'red') + 
      coord_map() + 
      labs(title = title)
    ggplotly(map)
  })
  

  
  output$map2 <- renderPlotly({
    # Load necessary data
    final <- read.csv("Final dataSet.csv")
    
    # Convert date.posted to Date format and extract year
    final$date.posted <- as.Date(final$date.posted, format = "%Y-%m-%d")  # Adjust the format based on your data
    final$year <- format(final$date.posted, "%Y")
    
    # Summarize total sightings per year
    yearly_sightings <- final %>%
      group_by(year) %>%
      summarize(total_sightings = n())  # Change this line
    
    # Calculate the change in sightings per year
    yearly_sightings <- yearly_sightings %>%
      mutate(change_in_sightings = total_sightings - lag(total_sightings))
    
    # Check the value of the checkbox
    if (input$show_histogram) {
      # If the checkbox is checked, show the bar plot
      map2 <- ggplot(final, aes(x = shape, fill = shape)) +
        geom_bar() +
        labs(x = "Shape", y = "Frequency", title = "Bar Plot of Shapes Spotted") +
        theme(legend.title = element_text("Shape"), legend.position = "right",
              axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels
    } else {
      # If the checkbox is not checked, show the point plot
      map2 <- ggplot(yearly_sightings, aes(x = year, y = total_sightings)) +
        geom_point() +
        labs(x = "Year", y = "Total Sightings", title = "Total UFO Sightings Per Year")
    }
    
    return(ggplotly(map2))
  })
  
  output$map6 <- renderPlotly({
    # Always calculate the total sightings per state
    state_count <- final %>%
      mutate(State = tolower(State)) %>%
      group_by(State) %>%
      summarize(state_total = sum(num.sightings))
    
    map3 <- ggplot(data = state_shape) + 
      geom_polygon(aes(x = long, y = lat, group = group)) + 
      geom_point(data = final, aes(x=longitude, y = latitude), color = "red", size = 0.2) +
      coord_map()
    
    return(ggplotly(map3))
  })
  
  
  output$map4 <- renderPlotly({
    # Merge the map data with your data
    final$region <- tolower(final$State)
    merged_data <- merge(state_shape, final, by = c("State" = "region"), all.x = T)
    
    # Create a new column for color mapping
    merged_data$color <- ifelse(merged_data$Republican.lean.Rep > merged_data$Democrat.lean.Dem, "red", "blue")
    
    # Plot the map
    map <- ggplot() +
      geom_polygon(data = merged_data, aes(x = long, y = lat, group = group, fill = color), alpha = if (input$show_overlay) 0.5 else 1) +
      geom_point(data = final, aes(x = longitude, y = latitude), color = "#dffff1", size = 0.2) +
      scale_fill_identity() +
      coord_map() +
      theme_minimal() +
      theme(legend.position = "none")
    
    ggplotly(map)
    
  })
  
  
  output$map4 <- renderPlotly({
    final$region <- tolower(final$State)
    merged_data <- merge(state_shape, final, by = c("State" = "region"), all.x = T)
    
    merged_data$color <- ifelse(merged_data$Republican.lean.Rep > merged_data$Democrat.lean.Dem, "red", "blue")
    
    # Plot the map
    map4 <- ggplot() +
      geom_polygon(data = merged_data, aes(x = long, y = lat, group = group, fill = color), alpha = if (input$show_sightings) 0.5 else 1)
    
    if (input$show_sightings) {
      map4 <- map4 + geom_point(data = final, aes(x = longitude, y = latitude), color = "red", size = 0.1)
    }
    
    map4 <- map4 + scale_fill_identity() +
      coord_map() +
      theme_minimal() +
      theme(legend.position = "none")
    
    ggplotly(map4)
  })
  
  output$map10 <- renderPlotly({
  pol_pty$region <- tolower(pol_pty$State)
  
  # Merge the map data with data
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