
library(plotly)
library(bslib)
## OVERVIEW TAB INFO

my_theme <- bs_theme(bg = "#468092",
                     fg = "#dffff1",
                     primary = "#4f4f4f")

overview_tab <- tabPanel("Overview Tab",
   h1("About our project"),
   p("With differences in political beliefs playing one of the biggest roles in the US’s division, it is crucial to investigate what beliefs are more prevalent in each political party. Interestingly, UFO sightings are regarded as a bipartisan belief. Our project aims to delve into these two factors to answer the question: What is the correlation between the prevalence of UFO sightings in different US states and their respective political parties? Extrapolating meaningful conclusions from this data would pave the way for further research that delves into the historical implications of extraterrestrial sightings and how modern political ideologies play into this bipartisanship."),
   h1("Our Data"),
   p("We will be cross-analyzing Kaggle’s “UFO Sightings” dataset alongside the Pew Research Center’s “Party affiliation by state” dataset to investigate this issue. Despite these website's credibility, some limitations are important to note:"),
   p("- It is likely that not everyone who has spotted a UFO has reported it to the database we are using"),
   p("- The sample size for each state's political affiliation is significantly smaller than the actual population"),
   p("- The UFO sighting dataset is neglecting possible sightings since 2013 (last recorded sighting)"),
   imageOutput("myImage")
)



viz_1_sidebar <- sidebarPanel(
  h2("Options for graph"),
  #TODO: Put inputs for modifying graph here
  checkboxInput("show_sightings", "Show UFO Sightings (uncheck to view state affiliations)", value = TRUE)
)

viz_1_main_panel <- mainPanel(
  h2(""),
  plotlyOutput(outputId = "map11"),
  p("This choropleth map demonstrates the density of UFO sightings in each state with a more purple hue symbolizing a higher number of UFO sightings and a more yellow hue symbolizing fewer UFO sightings. It can be observed that the state with the highest number of UFO sightings is California, followed by Florida, Washington, New York, Texas, Ohio, and Pennsylvania, all of which had over 800 UFO sightings. Out of the 7 states with over 800 UFO sightings, 6 of them are Democratic-learning on the map, which led us to the conclusion that there is a correlation between state political affiliation and the number of UFO sightings. 
")
)

viz_1_tab <- tabPanel("UFO Choropleths",
                      sidebarLayout(
                        viz_1_sidebar,
                        viz_1_main_panel
                      )
)
## VIZ 2 TAB INFO

viz_2_sidebar <- sidebarPanel(
  h2("Options for graph"),
  #TODO: Put inputs for modifying graph here
  checkboxInput("show_histogram", "Show barplot", value = FALSE)
)
viz_2_main_panel <- mainPanel(
  h2(""),
  plotlyOutput(outputId = "map2"),
  h1("UFO sighting trends (dot plot)"),
  p("  
This dot plot shows the total number of UFO sightings per year. From this chart, we can see that from 2011 to 2011, the number of total UFO sightings increased by about 2000, which would indicate that there was something to increase the number. Because there is no actual data to prove the existence of UFOs, there may be other factors that led to the increase in sightings. For example, 2012 held some important news events such as natural disasters and nationwide elections. Though not directly correlated, the observation of this spike and the prevalence of these events could prompt further research into the environmental and political influences on UFO sightings in the US.
"),
  h1("UFO sighting trends (bar plot of shapes spotted)"),
  p("  
This bar plot demonstrates the frequency of different UFO shapes across all recorded observations. It can be seen that the UFO shape with the highest frequency is “light” with 4342 recorded observations. The UFO shape with the lowest frequency is “cross” with 64 recorded observations.
")
)


viz_2_tab <- tabPanel("UFO Sighting Trends",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel
  )
)
 



## VIZ 3 TAB INFO

viz_3_sidebar <- NULL

# Add a new plotlyOutput to the mainPanel
viz_3_main_panel <- mainPanel(
  h2("Sighting locations Plotted + Population per State Plotted "),
  plotlyOutput(outputId = "map6", width = "150%", height = "900px"),
  plotlyOutput(outputId = "map12", width = "150%", height = "900px"),
  h1("UFO sightings & population"),
  p("
The political map overlaid with UFO sightings shows how population per state is related to the number of UFO sightings. From the map of population, we can see that the states with the highest population (California, Florida, Texas, New York, Pennsylvania), or lean Democratic, while most of the landlocked states lean Republican. Although the UFO sightings overlay shows where UFO sightings occurred, it does not show the density because it only shows where the sightings occurred (see the “UFO Choropleths” page to look at density). Keeping this in mind, we can see that the UFO sightings that were seen on the Eastern half of the US were more spread out, whereas the sightings in the West are more concentrated on the coast, which would show that the UFO sightings in the West were more dense in states with higher population concentrations, while the states with lower populations had UFO sightings that were more spread out.

")
  
)

viz_3_main_panel2 <- mainPanel(
  h2(""),
  plotlyOutput(outputId = "map10", width = "2000%", height = "1700px"),
)

# Update the tabPanel
viz_3_tab <- tabPanel("Locations of Sightings and Populations",
                      sidebarLayout(
                        viz_3_sidebar,
                        viz_3_main_panel
                      )
)

## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Conclusion",
 h1("Our conclusions"),
 h1("There is a slight correlation between political affiliation and UFO sightings in the US
"),
 p("We can see when looking at the map showing political affiliation and the UFO sightings per state, that there is a clear correlation between political affiliation and the number of UFO sightings. From the map of UFO sighting concentration, the top 5 states with the most UFO sightings are California, Florida, Washington, New York, and Texas. These all happen to be Democratic states as well. On the other hand, the top 5 states with the least UFO sightings are North Dakota, Wyoming, South Delaware, Dakota, and Rhode Island. Although ⅖ of these listed states are Democratic-leaning, it can be seen from the political affiliation map that the majority of the Republican-leaning states are yellow on the “UFO sightings per state” choropleth (signifying a low number of UFO sightings). Despite these observations, this pattern cannot be applied or generalized to the US as a whole or be used to conclude whether UFO sightings are correlated with political affiliation.
"),
 h1("More UFO sightings reported closer to bodies of water:"),
 p("
Though geographical location was not a factor that we were initially looking for when analyzing UFO sightings, our data conveyed a greater number of UFO sightings in southern states than northern states. From looking at the map containing UFO sightings, most of the northern states were yellow on the heat map, indicating a lower number of UFO sightings. On the other hand, a handful of southern states were more darker yellow or purple such as Florida, Texas, and California. Though this observation falls outside the scope of our initial interests, it could potentially pave the way for further research regarding the geographical impact on the prevalence of UFO sightings in the US.
"),
 h1("A spike in UFO sightings in 2012: "),
 p(" 
Though geographical location was not a factor that we were initially looking for when analyzing UFO sightings, our data conveyed a greater number of UFO sightings in near bodies of water (ie. lakes, oceans, seas, etc.). From looking at the map containing UFO sightings, most of the landlocked states appeared yellow on the heat map, indicating a lower number of UFO sightings. On the other hand, a handful of states bordering bodies of water were darker yellow or purple such as Florida, Texas, and California. Though this observation falls outside the scope of our initial interests, it could potentially pave the way for further research regarding the geographical impact on the prevalence of UFO sightings in the US.

"),
)



ui <- navbarPage("Politics Out Of This World!",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)
