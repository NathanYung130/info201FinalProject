

## OVERVIEW TAB INFO

overview_tab <- tabPanel("Overview Tab Title",
   h1("Some title"),
   p("some explanation")
)

viz_1_sidebar <- sidebarPanel(
  h2("Options for graph"),
  #TODO: Put inputs for modifying graph here
  checkboxInput("show_sightings", "Show UFO Sightings (uncheck to view state populations)", value = TRUE)
)

viz_1_main_panel <- mainPanel(
  h2("Vizualization 1 Title"),
  plotlyOutput(outputId = "map")
)

viz_1_tab <- tabPanel("Viz 1 tab title",
                      sidebarLayout(
                        viz_1_sidebar,
                        viz_1_main_panel
                      )
)
## VIZ 2 TAB INFO

viz_2_sidebar <- sidebarPanel(
  h2("Options for graph"),
  #TODO: Put inputs for modifying graph here
)
viz_2_main_panel <- mainPanel(
  h2("Vizualization 2 Title"),
  plotlyOutput(outputId = "map2")  # Add this line
)


viz_2_tab <- tabPanel("Viz 2 tab title",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel
  )
)
 



## VIZ 3 TAB INFO

viz_3_sidebar <- sidebarPanel(
  h2("Options for graph"),
  #TODO: Put inputs for modifying graph here
  checkboxInput(
    inputId = "color",
    label = "scatter"
  )
)

viz_3_main_panel <- mainPanel(
  h2("Vizualization 3 Title"),
  plotOutput("plot3")
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

viz_3_tab <- tabPanel("Viz 3 tab title",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel
  )
)

## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Conclusion Tab Title",
 h1("Some title"),
 p("some conclusions")
)



ui <- navbarPage("Example Project Title",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)
