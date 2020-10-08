

dashboardPage(
  dashboardHeader(title = 'My Dashboard'),
  dashboardSidebar(
    sidebarUserPanel('Chun',
                     image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRxYFZ9ljFFrqXwKlOEF24jwEQPeo41lgppeQ&usqp=CAU'),
    
    sidebarMenu(
      menuItem('Map',tabName = 'map', icon = icon('map')),
      
      menuItem('Data',tabName = 'data',icon = icon('database'))
    ),
    
    selectizeInput('selected','Select Item to Display',
                   choices = choice)
    
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = 'map',
              
              fluidRow(infoBoxOutput("maxBox"),
                       infoBoxOutput("minBox"),
                       infoBoxOutput("avgBox")),
              
              fluidRow(
                box(htmlOutput('hist'),
                    height=350),
                box(htmlOutput('map'),
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