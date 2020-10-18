

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
          
          menuItem('Data',
                   tabName = 'data',icon = icon('database')
                   )
       )    
    ),
  
  
  dashboardBody(
    
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
                                   choices = unique(gather$feature)),
                    width=4)
              ),

              fluidRow(
                box(plotOutput('scatter1'),
                    width = 6),
                
                box(plotOutput('scatter2'),
                    width = 6)  
                ),
            
              fluidRow(
                box(h4(''),
                    width = 6),
                box(h4(''),
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
                box(leafletOutput('ownermap'),width=8),
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
              tabName = 'data', 
              
              h2('Raw data set of Starbucks store location info'),
              
              fluidRow(
                box(DT::dataTableOutput('table'),width = 12)
              )
      )
    )           
    
 )
)