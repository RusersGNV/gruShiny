# This app is to demonstrate how we can put up an
# interactive plot as output. Plotly is one of the
# package that allows us to convert the "static"
# plot to "interactive plot". It is rich on its own
# but here we rely on only a few functions.

library(shiny)
library(tidyverse)
library(plotly)

monthly <- read_rds("gru_monthly.rds")

# Define UI
ui <- fluidPage(
  
  # Application title
  titlePanel("GRU Monthly Electricity Usage"),
  

  # Dropdown & checkbox
  sidebarLayout(
    sidebarPanel(
      selectInput("Area",
                  "Area of interest:",
                  choices = c("All" = "All",
                              "Northeast" = "NE",
                              "Northwest" = "NW",
                              "Southwest" = "SW",
                              "Southeast" = "SE")
      ),
      checkboxGroupInput("Year",
                         "Year of interest:",
                         choices = 2014:2018,
                         selected = 2017
      )
    ),
    
    # Text and a plot
    # Since the output plot is now a "plotly plot",
    # and not supported by `plotOutput`, we'll use
    # another function here: `plotlyOutput`
    mainPanel(
      textOutput("plotTitle"),
      plotlyOutput("usagePlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  output$usagePlot <- renderPlotly({
    # The plotly package provides a function called
    # `ggplotly` that can convert a ggplot object to
    # a plotly plot object. Super easy!
    p <- monthly %>%
      dplyr::filter(zone == input$Area) %>%
      dplyr::filter(Year %in% input$Year) %>%
      ggplot(aes(x=Month, y=KWH, col=as.factor(Year))) +
      geom_line() 
    p <- p %>% ggplotly()
    
    p
  })
}

# Run the application 
shinyApp(ui = ui, server = server)