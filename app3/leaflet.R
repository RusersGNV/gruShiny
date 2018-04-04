#leaflet
library(leaflet)

leaflet() %>% 
  setView(lat = 29.6436, lng = -82.3549, zoom = 14) %>% 
  addProviderTiles(provider = providers$OpenStreetMap) %>% 
  addMeasure() %>% 
  addMiniMap() 