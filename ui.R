

dashboardPage(
  
  
  dashboardHeader(title = 'Starbucks Global Location Analysis'),
  
  dashboardSidebar(
    
    sidebarUserPanel("Author: Chun Tao"),
    
    sidebarMenu(
          menuItem('About the project',
                   tabName = 'intro', icon = icon('thumbtack')
                   ),
          
          menuItem('Starbucks Store Location in',
                   tabName = 'summary', icon = icon('globe')
                   ),
          
          menuItem('General Location Analysis',
                   tabName = 'analysis', icon = icon('chart-bar')
                   ),
          
          menuItem('Ownership & Location Analysis',
                   tabName = 'analysis2', icon = icon('chart-bar')
                   ),
          
          menuItem('Data',
                   tabName = 'data',icon = icon('database')
                   )
    )    
    ),
  
  
  dashboardBody(
    
    ###font
    
    tabItems(
      
      tabItem(
              tabName = 'intro', 
              
              h2("Project Summary"),
              
              h3("Starbucks is one of the biggest coffee brands in the world. Since founded in 1971 in Seattle, Washington, it has been constantly growing and now has more than 22,519 stores worldwide (starbuscks.com). The purpose of this project is to understand the underlying logic of Starbucks global expansion strategy. The primary data set was collected in Feb 2017, containing 26,000+ Startbucks store location in 73 countries."),
      
              h3('The Shiny dashboard includes 4 tads. The overview tab gives a breif introduction of the project. The global presents tab shows the geographic location for all Starbucks stores. The Analysis tabs shows the store distribution by brands and ownership types. The data tab is the original dataset used in the project.'),
      
              br(),
              br(),
              
              h3("About Author"),
              
              h4('Chun has a master degree in Education Psychology from University of Pennsylvania.'),
              
              h3("Github"),
              
              h4('https://github.com/chuntao20/shiny_project'),
              
              br(),
              br(),
              
              h3('Data Resources:'),
              
              h4('Starbucks Location: https://www.kaggle.com/starbucks/store-locations'),
              
              h4('country code: https://datahub.io/core/country-list#data'),
              
              h4('GDP: https://data.worldbank.org/indicator/NY.GDP.MKTP.CD?end=2016&start=2015'),
              
              h4('Corruption: https://data.world/bchamptx/2015-corruption-v-gdp'),
              
              
              h4('Population: https://population.un.org/wpp/Download/Standard/CSV')
              
              ),
      
      tabItem(
              tabName = 'summary', h2("Starbucks Store Locations"),
              
              fluidRow(infoBoxOutput("num_store"),
                       infoBoxOutput("num_country"),
                       infoBoxOutput("avg_country")
                       ),
              

              fluidRow(
                box(leafletOutput('map'),
                    width = 9),
                box(h4('In 2017, 26057 Starbucks stores are open in 73 countries across the world. Among them, USA stores alone constitute 52.2% of the total. USA and Candana together make the North America the top 1 market of Starbucks. China with 2734 stores makes the second place in store number rank. While Asia become the second largest maket in the world.'),
                    width=3)
              ),
              
              fluidRow(
                
                box(h4(' See the top 10 country or city have the most Starbuck stores:'),
                    selectizeInput(inputId = "city_country",
                                   label = " Select a option",
                                   choices = unique(city_country)
                    ),
                    width=6)

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
                box(plotOutput('pop_gdp'),width=8),
                box(h4('Countries has Starbucks stores show stronger perfromance in economic indicators. Basically, in every continent, Starbucks stores appear in the countries that have higher average GDP, higher population and higher GDP per capita. '),
                    br(),
                    h4('Note: Outliers are excluded in the GDP graph (USA and China), and in the population graph(China and India)'),
                    selectizeInput(inputId = "pop_gdp",
                                   label = "Select a metric",
                                   choices = unique(gather$feature)),
                  
                    width=4)
              ),
              

              fluidRow(
                box(plotOutput('pop_store'),width = 6)
                
                #box(plotOutput('pop_store2'),width = 6)
                  
                ),
              
            
              fluidRow(
                
        
                ),
      

              fluidRow(
                
              ),
              
              fluidRow(
                
                )
      
          
      ),
      
     
      tabItem(
              tabName = 'analysis2', h2("Ownership & Location Analysis"),
              
              # fluidRow(
              #   box(h4('Foreign market entry strategy can be different depending on the local business environment and laws etc. We want to take a look in the difference in ownership type among Starbucks stores to shed a light on the overall strategy.'),
              #       width=6),
              #   box(h4(''),
              #       selectizeInput(inputId = "cpi1",
              #                      label = "Select a View",
              #                      choices = unique(cpi1)),
              #       width=3)
              #  ),
              
              
              fluidRow(
                box(plotOutput('cpi1'),width = 8
                ),
                
                box(h3(''),width = 3
                #plotOutput('cpi2'),width = 5)
                )
              ),
              
              fluidRow(
                box(leafletOutput('ownermap'),width=8),
                box(h4(''),width=3)
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