library(leaflet)
library(shiny)
library(shinydashboard)


bars <- rgdal::readOGR("GainesvilleBars.kml")

icons <- awesomeIcons(icon = 'beer', library = 'fa', 
                      iconColor = "#0021A5", markerColor = 'orange')

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
        #addMarkers(data = bars, label = bars@data$Name) %>% 
        addAwesomeMarkers(data = bars, label = bars@data$Name, icon = icons) %>% 
        addMeasure() %>%
        addMiniMap()
    })
}

shinyApp(ui = ui, server = server)


