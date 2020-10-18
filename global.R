library(shiny)
library(shinydashboard)
library(DT)
library(dplyr)
library(leaflet)
library(ggthemes)
library(gridExtra)


#Read in dataset

store_level = read.csv('store_level.csv',header = T)
country_level = read.csv('pop_gdp_new.csv',header = T)
cpi_join = read.csv('cpi_join.csv',header = T)
abv_avg = read.csv('abv.csv',header=T)



# Input selections
city_country = c('Country','City')
store_continent = c('Number of Starbuck stores by continent', 'Number of countries that have Starbucks stores')
cpi1 = c('Absolute Number','Ratio')
geo_select = c('World','North America','Asia','Europe','South America', 'Oceania','Africa')


# Data preparation


cpi_clean = cpi_join %>%
  filter(!is.na(lon)&!is.na(lat))

gather = country_level %>%
  gather(key=feature,value=value,tot_pop_thousands:gdp_per_capita) 















