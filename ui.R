

dashboardPage(
  
  
  dashboardHeader(title = 'Starbucks Global Location Analysis'),
  
  dashboardSidebar(
    
      sidebarUserPanel("Author: Chun Tao"),
    
      sidebarMenu(
          menuItem('About the project',
                   tabName = 'intro', icon = icon('thumbtack')
                   ),
          
          menuItem('Starbucks World',
                   tabName = 'summary', icon = icon('globe')
                   ),
          
          menuItem('General Location Analysis',
                   tabName = 'analysis', icon = icon('chart-bar')
                   ),
          
          menuItem('Ownership & Location Analysis',
                   tabName = 'analysis2', icon = icon('chart-bar')
                   ),
          
          menuItem('Average Distance Within City',
                   tabName = 'avg_dist', icon = icon('chart-bar')
                  ),
          
          menuItem('Data',
                   tabName = 'data',icon = icon('database')
                   )
       )    
    ),
  
  
  dashboardBody(
    
    tabItems(
      
      tabItem(
              tabName = 'intro', 
              
              img(src="stb.jpg", width='480'),
              
              h2("Project Summary"),
              br(),
              h3("Starbucks is one of the biggest coffee brands in the world. Since founded in 1971 in Seattle, Washington, it has been constantly growing and now has more than 22,519 stores worldwide (starbuscks.com). The purpose of this project is to understand the underlying logic of Starbucks store openning strategy, so as to extract transforable insights for other similar brands. The primary data set was collected in Feb 2017, containing 25,600 Startbucks store location information in 73 countries and areas."),
              h3('The Shiny dashboard includes 4 tabs. The project summary tab gives a breif introduction of the project and the data resource. The Starbucks world tab shows the geographic location and store counts information for all Starbucks stores. The three Analysis tabs give a more indepth look into the factors decide whether or not to open a store in a country, as well as how to open the store. The data tab is the primary dataset used in the project.'),
      
              br(),
              br(),
              
              h3("About Author"),
              h4('Chun Tao has a master degree in Education Psychology from University of Pennsylvania.'),
              
              h3("Find the Author:"),
              h4('Gihub:https://github.com/chuntao20/shiny_project'),
              h4('Email: taochun01@gmail.com'),
              
              br(),
              br(),
              
              h3('Data Resources:'),
              h4('Starbucks Location: https://www.kaggle.com/starbucks/store-locations'),
              h4('Country code: https://datahub.io/core/country-list#data'),
              h4('GDP: https://data.worldbank.org/indicator/NY.GDP.MKTP.CD?end=2016&start=2015'),
              h4('Corruption & Easy-to-Do-Business-Index: https://data.world/bchamptx/2015-corruption-v-gdp'),
              h4('Country Population: https://population.un.org/wpp/Download/Standard/CSV')
              
              ),
      
      tabItem(
              tabName = 'summary', h2("Starbucks World"),
              
              fluidRow(infoBoxOutput("num_store"),
                       infoBoxOutput("num_country"),
                       infoBoxOutput("avg_country")
                       ),
              
              fluidRow(
                box(leafletOutput('map'),
                    width = 9),
                box(h3('Overview:'),
                    h4('In 2017, 25600 Starbucks stores are open in 73 countries across the world. USA stores alone constitute 53% of the total. USA and Candana together make the North America the top 1 market of Starbucks.'), 
                    br(),
                    h4('Half of the Top 10 countries by sotre counts are from Asia, also the top 3 cities by store counts are all from Asia, which makes Asia become the second largest market in the Starbucks world.'),
                    br(),
                    width=3)
              ),
              
              fluidRow(
                box(h4(' See the top 10 country or city have the most Starbuck stores:'),
                    selectizeInput(inputId = "city_country",
                                   label = " Select a option",
                                   choices = unique(city_country)
                    ),
                    width = 6),
                box(h4('Using number of per thousand inhabitants store number (population in thousand/store number) may eliminate the population influence on the store count. It turns out that only 4 of the Top 10 countries have high absolute store counts too. The other are all high population density countries or tourist destination.'),
                    width = 6)
              ),

              fluidRow(
                 box(plotOutput('store_by_top10'),
                     width=6),
                 box(plotOutput('store_per_capita'),
                     width=6)
               )
             ),
      
      
      tabItem(
              tabName = 'analysis', h2("General Location Analysis"),
              
              
              fluidRow(
                box(plotOutput('pop_gdp'),
                    width=8),
                box(plotOutput('outlier_country'),
                    width=4)
                
              ),
              
              fluidRow(
                box(h4('Countries has Starbucks stores show stronger perfromance in economic indicators. Generally, countries with Starbuck stores have higher average GDP, population and GDP per capita.'),
                    h4('Note: Outliers are excluded in the GDP graph (USA and China), and in the population graph(China and India)'),
                    width=8),
                box(selectizeInput(inputId = "pop_gdp",
                                   label = "Select a metric",
                                   choices = unique(gather$feature),
                                   selected = 'gdp_per_capita'),
                    width=4)
              ),

              fluidRow(
                box(plotOutput('scatter1'),
                    width = 6),
                
                box(plotOutput('scatter2'),
                    width = 6)  
                ),
            
              fluidRow(
                box(h4("The store density (population served by 1 store) has a minimun relationship with country GDP, which indicates Starbucks doesn't only want to operate in the rich countries."),
                    h4(""),
                    width = 6),
                box(h4('For GDP Per Capita, Asia countries tend to have higher store density comparing to Europe.'),
                    width = 6)
                )
      ),
      
     
      tabItem(
              tabName = 'analysis2', h2("Ownership & Location Analysis"),

              fluidRow(
                box(plotOutput('cpi1'),width = 8
                ),
                
                box(h3("Across continents, ownership type of a Starbucks store varies so as to adapt to local business ecosystem."),
                    br(),
                    h4("In North America, Starbucks' hometown, the company shows a stronger control over the brand. While In Asia and Europe, they made different decisions to expand the business."),
                    h4("Such desicion may come from a set of various reasons. Apparently, the easiness of doing business in a country is not a major one. Other possiblility also include the local business law, such as in China, it is not allowed to open a sole-owned company by a foreign enterpreneur."),
                    br(),
                    br(),
                    width = 4
                )
              ),
              
              fluidRow(
                box(leafletOutput('ownermap'),
                    width=8),
                box(h3('The ownership type within one country could be different geographically.'),
                    br(),
                    h4("Hint: Try Zoom in China, UK, or Carribean area to check it out."),
                    br(),
                    h4("Company owned stores might be more visible in major metropolitan areas. While licensed stores are more depending on the local business owners' judgement."),
                    br(),
                    width=4)
              )

      ),
      
      tabItem(
              tabName = 'avg_dist', h2("Average Distance Between All Stores in City"),
              
              fluidRow(
                box(selectizeInput(inputId = "location",
                                   label = "Select a city",
                                   choices = unique(avg_dist_map$location)),
                    width = 5),
                box(h4('On city level, store number may not be an accurate indicator since the area of each city in the world can vary drastically. Despite all other factors, the average distance between stores plus the population density may help us to spot the city with a potential to open more stores.'),
                    width = 7)
                ),

              fluidRow(
                box(plotOutput('avg_dist_bar'),
                    width=5),
                box(leafletOutput('avg_dist_map'),
                    width=7)
                
              )
      ),
      
      tabItem(
              tabName = 'data', 
              
              h2('Raw data set of Starbucks store location info'),
              
              fluidRow(
                box(DT::dataTableOutput('table'),width = 12)
              )
      )
    )           
    
 )
)