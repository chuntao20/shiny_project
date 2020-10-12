

dashboardPage(
  
  
  dashboardHeader(title = 'Starbucks Global Location Analysis'),
  
  dashboardSidebar(
    
    sidebarUserPanel("Author: Chun Tao"),
    
    sidebarMenu(
          menuItem('Overview',
                   tabName = 'intro', icon = icon('thumbtack')
                   ),
          
          menuItem('Global Presents',
                   tabName = 'summary', icon = icon('globe')
                   ),
          
          menuItem('Analysis',
                   tabName = 'analysis', icon = icon('chart-bar')
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
              
              h2("About Author"),
              
              h3('Chun has a master degree in Education Psychology from University of Pennsylvania.'),
              
              h2("Github"),
              
              h3('https://github.com/chuntao20/shiny_project')
              
              ),
      
      tabItem(
              tabName = 'summary', h2("Glocal Presents of Stabucks Stores"),
              
              fluidRow(infoBoxOutput("num_store"),
                       infoBoxOutput("num_country"),
                       infoBoxOutput("avg_country")
                       ),
              

              fluidRow(
                box(htmlOutput('map'),
                    width = 9),
                box(h4('In 2017, 26057 Starbucks stores are open in 73 countries across the world. Among them, USA stores alone constitute 52.2% of the total. USA and Candana together make the North America the top 1 market of Starbucks. China with 2734 stores makes the second place in store number rank. While Asia become the second largest maket in the world.'),
                    width=3)
              ),

              fluidRow(
              
                 box(plotOutput('store_by_top10'),
                     width=6),
              
                 box(plotOutput('store_by_continent'),
                     width=6)

               )
      ),
      
      
      tabItem(
              tabName = 'analysis', h2("Expansion Strategy Analysis"),
              

              fluidRow(
                box(plotOutput('by_brand'), #select full data/usa/top10
                    height=350),
                box(plotOutput('brand_country'), #select individual country
                   height=350)
                  
                ),
            
              fluidRow(
                box(radioButtons('brand1',label='Select a dataset:',
                                       choices = list('All countries' = world,
                                                      'Top 10 countries' = top10a,
                                                      'USA' = usa),
                                       selected = 'All countries')
                ),
              
                
                box(selectizeInput(inputId = "brand2",
                                   label = "Select an brand",
                                   choices = unique(world$brand)))
        
                ),
      

              fluidRow(
                box(plotOutput('by_ownership'), #select full data/usa/top10
                   height=350),
                box(plotOutput('ownership_country'), #select individual country
                   height=350)
              ),
              
              fluidRow(
                box(radioButtons('ownership1',label='Select a dataset:',
                                 choices = list('All countries' = world,
                                                'Top 10 countries' = top10a,
                                                'USA' = usa),
                                 selected = 'All countries')
                ),
                
                
                box(selectizeInput(inputId = "ownership2",
                                   label = "Select an ownership type",
                                   choices = unique(world$ownership_type)))
                
              )
      ),
      
      ####################################################################
      #tabItem(tabName = 'analysis2', h2("Expansion Strategy Analysis"),
              
              
      #        fluidRow(
      #          box(htmlOutput('by_brand'), #select full data/usa/top10
      #              height=350),
       #         box(htmlOutput('brand_country'), #select individual country
      #              height=350)
      #        ),
              
      #        fluidRow(
       #         box(htmlOutput('by_ownership'), #select full data/usa/top10
      #              height=350),
       #         box(htmlOutput('avg_store_by_continent'), #select individual country
       #             height=350)
      #        )
      #),
      ####################################################################
      
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