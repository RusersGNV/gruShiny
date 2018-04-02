# In this app, we want user to choose their area of interest,
# and then we'll plot the line graph of monthly electricity
# usage per service unit in the particular area of interest.
# The data file is "gru_monthly.rds"

# The area outside of the "ui" and "server" runs only once
# when the app launches. Loading up libraries and reading the
# main data file is good to be here.
library(shiny)
library(tidyverse)

# Read the data file. RDS is an interesting file type that
# preserves the information about a column. For example,
# when you look into the dataframe, you see that the Date
# column is already being recognized as "date" object. This
# is very useful for sharing your data to your peer who might
# not be familiar with date object in R.
monthly <- read_rds("gru_monthly.rds")
monthly

# Defining the UI, you know, User Interface
# the variable ui is by default defined by a function called
# "fluidPage", and if you've seen the example app, the fluidPage
# function takes a lot of functions as argument, and each of these
# argument functions also take argument in functions! Confusing
# but we'll get use to it.
ui <- fluidPage(
   
   # Application title specify by titlePanel
   titlePanel("GRU Monthly Electricity Usage"),
   
   # sidebarLayout is a container that holds the "panel" of
   # sidebar and main area. The panel holds the graphical
   # elements (Text, input and output).
   # Let's create a "dropdown menu" using "selectInput"
   sidebarLayout(
      sidebarPanel(
         selectInput("Area",
                     "Area of interest:",
                     choices = c("All" = "All",
                                 "Northeast" = "NE",
                                 "Northwest" = "NW",
                                 "Southwest" = "SW",
                                 "Southeast" = "SE")
                     )
      ),
      
      # mainPanel points to the main area, and the graphical
      # element associate with the main area goes into this
      # panel.
      # We're "outputting" a line graph, so plotOutput belongs
      # here. 
      mainPanel(
         plotOutput("usagePlot")
      )
   )
)

# "server" is the "backend" that does all the processing,
# and tell "ui" what to display. "server" is a function of
# "input" and "output". When "input" changes, "server"
# knows and react to it. The series of functions "renderXXXX"
# create "reactive" object, i.e. react to changes immediately.
# We want to create plot, so we use "renderPlot" here.
server <- function(input, output) {
   
   output$usagePlot <- renderPlot({
      # generate plot based on area of interest from ui
      p <- monthly %>%
        filter(zone == input$Area) %>%
        ggplot(aes(x=Date, y=KWH)) +
        geom_line()
      
      p
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

