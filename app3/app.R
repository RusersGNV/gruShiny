library(leaflet)
library(shiny)
library(shinydashboard)


monthly <- read_rds("gru_monthly.rds")

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
    selectInput(inputId = "basemap",
                label = "Choose basemap:",
                choices = providers)
  ),
  dashboardBody(
    column(width = 12,
           box(width = NULL, 
               leafletOutput("map"),height = 500)
    )
  )
)

server <- function(input, output) {
  
    output$map <- renderLeaflet({
      leaflet() %>%
        setView(lat = 29.6436, lng = -82.3549, zoom = 14) %>% 
        addProviderTiles(provider = input$basemap) %>% 
        addMeasure() %>%
        addMiniMap()
    })
}

shinyApp(ui = ui, server = server)


