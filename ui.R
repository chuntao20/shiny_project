

dashboardPage(
  
  
  dashboardHeader(title = 'Starbucks Global Location Analysis'),
  
  
  dashboardSidebar(
    
    sidebarUserPanel("Author: Chun Tao"),
    
    sidebarMenu(
          menuItem('Overview',
                   tabName = 'intro', icon = icon('thumbtack')),
          
          menuItem('Global Presents',
                   tabName = 'summary', icon = icon('globe')),
          
          menuItem('Analysis',
                   tabName = 'analysis', icon = icon('chart-bar')),
          
          menuItem('Data',
                   tabName = 'data',icon = icon('database'))
          
    ),
    
    selectizeInput('selected','Select Item to Display',
                   choices = choice)
    
  ),
  
  
  dashboardBody(
    
    ###font
    
    tabItems(
      
      tabItem(tabName = 'intro', h2("Project Introduction"),
              
              fluidRow(),
              
              fluidRow()
      ),
      
      tabItem(tabName = 'summary', h2("Glocal Presents of Stabucks Stores"),
              
              fluidRow(infoBoxOutput("num_store"),
                       infoBoxOutput("num_country"),
                       ),
              
              fluidRow(
                box(htmlOutput('map'),
                    height=350),
                box(htmlOutput('store_by_top10'),
                    height=350)
              ),
              
              fluidRow(
                box(htmlOutput('store_by_continent'),
                    height=350),
                box(htmlOutput('avg_store_by_continent'),
                    height=350)
              )
      ),
      
      
      tabItem(tabName = 'analysis', h2("Expansion Strategy Analysis"),
              
              
              fluidRow(
                box(htmlOutput('by_brand'), #select full data/usa/top10
                    height=350),
                box(htmlOutput('brand_country'), #select individual country
                    height=350)
              ),
              
              fluidRow(
                box(htmlOutput('by_ownership'), #select full data/usa/top10
                    height=350),
                box(htmlOutput('avg_store_by_continent'), #select individual country
                    height=350)
              )
      ),
      
      
      tabItem(tabName = 'analysis2', h2("Expansion Strategy Analysis"),
              
              
              fluidRow(
                box(htmlOutput('by_brand'), #select full data/usa/top10
                    height=350),
                box(htmlOutput('brand_country'), #select individual country
                    height=350)
              ),
              
              fluidRow(
                box(htmlOutput('by_ownership'), #select full data/usa/top10
                    height=350),
                box(htmlOutput('avg_store_by_continent'), #select individual country
                    height=350)
              )
      ),
      
      
      tabItem(tabName = 'data' ,
              fluidRow(
                box(DT::dataTableOutput('table'),
                    width = 12)
              ))
    )           
    
  )
)