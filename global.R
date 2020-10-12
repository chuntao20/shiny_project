library(shiny)
library(shinydashboard)
library(googleVis)
library(DT)
library(dplyr)
library(leaflet)
library(plotly)


world = read.csv('world.csv',header=T)


country = unique(world$country)
ownership = unique(world$ownership_type)
brand = unique(world$brand)
continent = unique(world$continent)


world_store = world %>%
  group_by(country) %>%
  summarise(total=n())

top10 = world %>%
  group_by(country) %>%
  summarise(total=n()) %>%
  arrange(desc(total)) %>%
  top_n(10) 