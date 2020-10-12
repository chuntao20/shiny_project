
shinyServer(function(input, output){
  
  output$num_store <- renderInfoBox({
    num_store <- nrow(world)
    infoBox("Number of stores", num_store)
  })
  
  output$num_country <- renderInfoBox({
    num_country <- length(unique(world$country))
    infoBox("Number of countries", num_country)
  })
  
  
  
  output$hist = renderGvis(
    gvisHistogram(state_stat[,input$selected,drop=F])
    
  )
  
  output$map = renderGvis({
    gvisGeoChart(world, "state.name", input$selected,
                 options=list(region="US", displayMode="regions", 
                              resolution="provinces",
                              width="auto", height="auto"))
  })
  
  
  output$table <- DT::renderDataTable({
    datatable(world, rownames=FALSE) 
    
  })
  
  
})