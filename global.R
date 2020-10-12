library(shiny)
library(shinydashboard)
library(googleVis)
library(DT)
library(dplyr)


world = read.csv('world.csv',header=T)


country = unique(world$country)
ownership = unique(world$ownership_type)
brand = unique(world$brand)
continent = unique(world$continent)


