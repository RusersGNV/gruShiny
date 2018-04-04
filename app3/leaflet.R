#leaflet
library(leaflet)
library(tidyverse)

bars <- rgdal::readOGR("app3/GainesvilleBars.kml")

leaflet() %>% 
  setView(lat = 29.6436, lng = -82.3549, zoom = 14) %>% 
  addProviderTiles(provider = providers$OpenStreetMap) %>%
  addMarkers(data = bars, label = bars@data$Name) %>% 
  addMeasure() %>% 
  addMiniMap() 
