library(shiny)
library(shinydashboard)
library(DT)
library(dplyr)
library(leaflet)
library(ggthemes)


#Read in dataset

store_level = read.csv('store_level.csv',header = T)
country_level = read.csv('pop_gdp_new.csv',header = T)
cpi_join = read.csv('cpi_join.csv',header = T)
abv_avg = read.csv('abv.csv',header=T)

# world = read.csv('world.csv',header=T)
# topcity = read.csv('topcity.csv',header=T)
# pop_gdp = read.csv('pop_gdp.csv',header=T)
# pop_plot = read.csv('pop_plot.csv',header = T)



# Input selections
city_country = c('Country','City')
store_continent = c('Number of Starbuck stores by continent', 'Number of countries that have Starbucks stores')
cpi1 = c('Absolute Number','Ratio')
geo_select = c('World','North America','Asia','Europe','South America', 'Oceania','Africa')


# Data preparation

# world_store = world %>%
#   group_by(country) %>%
#   summarise(total=n())
# 
# top10 = world %>%
#   group_by(country) %>%
#   summarise(total=n()) %>%
#   arrange(desc(total)) %>%
#   top_n(10) 

# top10a = world %>%
#   filter(country %in% top10$country)
# 
# top10$country = gsub('United Kingdom of Great Britain & Northern Ireland','United Kingdom',top10$country)
# top10$country = gsub('Mexico, United Mexican States','Mexico',top10$country)
# top10$country = gsub('Philippines, Republic of the','Philippines',top10$country)
# top10$country = gsub('Turkey, Republic of','Turkey',top10$country)
# top10$country = gsub('Korea, Republic of','South Korea',top10$country)
# top10$country = gsub("China, People's Republic of",'China',top10$country)
# top10$country = gsub("United States of America",'USA',top10$country)


# usa = world %>%
#   filter(country == 'United States of America') 

cpi_clean = cpi_join %>%
  filter(!is.na(lon)&!is.na(lat))

gather = country_level %>%
  gather(key=feature,value=value,tot_pop_thousands:gdp_per_capita) 















