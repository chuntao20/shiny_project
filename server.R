
shinyServer(function(input, output){
  
  
#-------------summary------------------
  
  output$num_store <- renderInfoBox({
    num_store <- nrow(world)
    infoBox("Number of stores", num_store)
  })
  
  output$num_country <- renderInfoBox({
    num_country <- length(unique(world$country))
    infoBox("Number of countries", num_country)
  })
  
  output$map = renderGvis({
    gvisGeoChart(world_store, "country", 'Profit', 'total')
  })
  
  
  output$store_by_top10 = renderPlot(
    world %>%
      group_by(country) %>%
      summarise(total=n()) %>%
      arrange(desc(total)) %>%
      top_n(10) %>%
      ggplot(aes(x=reorder(country,total),y=total)) +
       geom_col(fill='dark green') +
       theme_bw() +
       coord_flip() +
       ylab('Number of store') +
       xlab('Country')
    
  )
  
  
  
  output$store_by_continent = renderGvis(
    world %>%
      #filter(continent == input$continent) %>%
      group_by(continent) %>%
      summarise(total=n()) %>%
      arrange(desc(total)) %>%
      ggplot(aes(x=reorder(continent,total),y=total)) +
      geom_col(fill='dark green') +
      theme_bw() +
      coord_flip() +
      ylab('Number of store') +
      xlab('Continent')
  )
  
  
  output$avg_store_by_continent = renderGvis(
    
  )
  
  
  #-------------analysis------------------
  
  
  output$by_brand = renderGvis(
    
  )
  
  
  output$brand_country = renderGvis(
    
  )
  
  
  output$by_ownership = renderGvis(
    
  )
  
  
  output$avg_store_by_continent = renderGvis(
    
  )
  
  
  
  #-------------table------------------
  
  
  
  output$table <- DT::renderDataTable({
    datatable(world, rownames=FALSE) 
    
  })
  
  
})