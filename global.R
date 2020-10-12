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

top10_modified = top10

top10_modified$country = gsub('United Kingdom of Great Britain & Northern Ireland','United Kingdom',top10_modified$country)
top10_modified$country = gsub('Mexico, United Mexican States','Mexico',top10_modified$country)
top10_modified$country = gsub('Philippines, Republic of the','Philippines',top10_modified$country)
top10_modified$country = gsub('Turkey, Republic of','Turkey',top10_modified$country)
top10_modified$country = gsub('Korea, Republic of','South Korea',top10_modified$country)
top10_modified$country = gsub("China, People's Republic of",'China',top10_modified$country)
top10_modified$country = gsub("United States of America",'USA',top10_modified$country)