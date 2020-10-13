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

top10a = world %>%
  filter(country %in% top10$country)


top10$country = gsub('United Kingdom of Great Britain & Northern Ireland','United Kingdom',top10$country)
top10$country = gsub('Mexico, United Mexican States','Mexico',top10$country)
top10$country = gsub('Philippines, Republic of the','Philippines',top10$country)
top10$country = gsub('Turkey, Republic of','Turkey',top10$country)
top10$country = gsub('Korea, Republic of','South Korea',top10$country)
top10$country = gsub("China, People's Republic of",'China',top10$country)
top10$country = gsub("United States of America",'USA',top10$country)


usa = world %>%
  filter(country == 'United States of America') 

analysis = list(world=world,top10a=top10a,usa=usa)


