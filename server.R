
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
    gvisGeoChart(world, "state.name", input$selected,
                 options=list(region="US", displayMode="regions", 
                              resolution="provinces",
                              width="auto", height="auto"))
  })
  
  
  output$store_by_top10 = renderGvis(
    gvisHistogram(state_stat[,input$selected,drop=F])
    
  )
  
  
  
  output$store_by_continent = renderGvis(
    
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