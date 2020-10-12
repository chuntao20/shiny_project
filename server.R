
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
  # 
  output$map = renderGvis({
    gvisGeoChart(
      world_store,
      locationvar = "country",
      #numvar = "total",
      hovervar = "country",
      options = list(region='countries',height=350,
                     dataMode='regions',
                     colors='[074E38]')

       )
   })
  # 
  # output$map = renderPlotly({
  #   g <- list(
  #     scope = 'world',
  #     showland = TRUE,
  #     landcolor = toRGB('light gray'),
  #     showlakes = TRUE,
  #     lakecolor = toRGB('white')
  #   )
  #   
  #   world %>%
  #     filter(Year %in% input$Year) %>%
  #     group_by(City) %>%
  #     summarize(Approvals = sum(Initial_Approvals), Denials = sum(Initial_Denials),
  #               C_Approvals = sum(Continuing_Approvals), C_Denials = sum(Continuing_Denials)) %>%
  #     arrange(desc(Approvals)) %>%
  #     top_n(50, Approvals) %>%
  #     left_join(coords_cities, by="City") %>%
  #     plot_geo(lat = ~lat, lon = ~lon, color = ~Approvals, size=~(Approvals)) %>%
  #     add_markers(hovertext = ~(paste("City:", City, "\nNo. of Approvals:", Approvals))) %>%
  #     layout(title = 'Top cities with H-1B Visa approvals in the selected Years', geo=g)
  # })
  
  # 
  # 
  # output$store_by_top10 = renderPlot({
  #   world %>%
  #     group_by(country) %>%
  #     summarise(total=n()) %>%
  #     arrange(desc(total)) %>%
  #     top_n(10) %>%
  #     ggplot(aes(x=reorder(country,total),y=total)) +
  #      geom_col(fill='dark green') +
  #      geom_text(aes(label=total),  hjust=-0.5)+
  #      theme_bw() +
  #      coord_flip() +
  #      ylab('Number of store') +
  #      xlab('Country')
  # 
  # })
  # 
  
  output$store_by_top10 = renderPlotly({
    world %>%
      group_by(country) %>%
      summarise(total=n()) %>%
      arrange(desc(total)) %>%
      top_n(10) %>%
      plot_ly(x=~(factor(country, levels=unique(country))[order(total, decreasing = TRUE)]),
              y=total,type='bar') %>%
      layout(title = "Top 10 countries with highest number of Starbucks stores",
             xaxis = list(title = "country"),
             yaxis = list(title = "number of stores")

      )

  })
  # 
  # 
  # 
  # output$store_by_continent = plotOutput({
  #   world %>%
  #     group_by(continent) %>%
  #     summarise(total=n()) %>%
  #     arrange(desc(total)) %>%
  #     ggplot(aes(x=reorder(continent,total),y=total)) +
  #      geom_col(fill='dark green') +
  #      theme_bw() +
  #      coord_flip() +
  #      geom_text(aes(label=total),  hjust=-0.5)+
  #      ylab('Number of store') +
  #      xlab('Continent')
  # })

  
  
  
  #-------------analysis------------------
  
  
  # output$by_brand = renderGvis(
  #   
  # )
  # 
  # 
  # output$brand_country = renderGvis(
  #   
  # )
  # 
  # 
  # output$by_ownership = renderGvis(
  #   
  # )
  # 
  # 
  # output$avg_store_by_continent = renderGvis(
  #   
  # )
  
  
  
  #-------------table------------------
  


  output$table <- DT::renderDataTable({
    datatable(world, rownames=FALSE)

  })


 })