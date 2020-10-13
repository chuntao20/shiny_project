
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
  
  output$avg_country <- renderInfoBox({
    avg_country <- round(mean(world_store$total),1)
    infoBox("Average # of stores per country", avg_country)
  })

  # output$map = renderGvis({
  #   gvisGeoChart(
  #     world_store,
  #     locationvar = "country",
  #     #numvar = "total",
  #     hovervar = "country",
  #     options = list(region='countries',height=350,
  #                    dataMode='regions',
  #                    colors='[074E38]')
  # 
  #      )
  #  })
  
  output$map <- renderLeaflet({
    
    leaflet(world) %>% addTiles() %>%
      addMarkers(
        clusterOptions = markerClusterOptions()
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
  output$store_by_top10 = renderPlot({
    
      top10 %>% 
      ggplot(aes(x=reorder(country,total),y=total)) +
       geom_col(fill='dark green') +
       geom_text(aes(label=total),  hjust=-0.7)+
       geom_text(x='USA', y=12500, label='13608',color='white')+
       theme_bw() +
       coord_flip() +
       ylab('') +
       xlab('') +
       ggtitle('Number of stores in top 10 country') +
       theme(text=element_text(size=14,face = "bold"),
             line=element_blank(),
             panel.border = element_blank(),
             axis.line = element_line(color='grey20'))

  })
  # 
  # 
  # output$store_by_top10 = renderPlotly({
  #   world %>%
  #     group_by(country) %>%
  #     summarise(total=n()) %>%
  #     arrange(desc(total)) %>%
  #     top_n(10) %>%
  #     plot_ly(x=~(factor(country, levels=unique(country))[order(total, decreasing = TRUE)]),
  #             y=total,type='bar') %>%
  #     layout(title = "Top 10 countries with highest number of Starbucks stores",
  #            xaxis = list(title = "country"),
  #            yaxis = list(title = "number of stores")
  # 
  #     )
  # 
  # })
  # 
  # 
  # 
  output$store_by_continent = renderPlot({
    world %>%
      group_by(continent) %>%
      summarise(total=n()) %>%
      arrange(desc(total)) %>%
      ggplot(aes(x=reorder(continent,total),y=total)) +
       geom_col(fill='dark green') +
       theme_bw() +
       geom_text(aes(label=total), vjust = -0.7)+
       ylab('') +
       xlab('') +
       ggtitle('Number of stores by continent') +
       theme(text=element_text(size=14,face = "bold"),
            line=element_blank(),
            panel.border = element_blank(),
            axis.line = element_line(color='grey20'))
  })

  
  
  
  #-------------analysis------------------
  
  
  # output$by_brand = renderGvis(
  #   
  # )
  # 
  # 
  output$brand_country = renderPlot({
    
    world %>%
      group_by(continent) %>%
      summarise(num = sum(brand==input$brand2)) %>%
      ggplot(aes(x=reorder(continent,num),y=num)) +
      geom_bar(fill='dark green',stat='identity',position='dodge') +
      theme_bw() +
      geom_text(aes(label=num), vjust = -0.7)+
      ylab('') +
      xlab('') +
      ggtitle('Number of store by brand in continents') +
      theme(text=element_text(size=14,face = "bold"),
            line=element_blank(),
            panel.border = element_blank(),
            axis.line = element_line(color='grey20')) +
      theme(axis.text.x = element_text(angle = 30,vjust = 0.5, hjust=1))

  })


  output$by_ownership = renderPlot({
    
    world %>%
      filter(country %in% input$brand1) %>%
      group_by(country,ownership_type) %>%
      summarise(num = n()) %>%
      ggplot(aes(x=reorder(country,num),y=num)) +
      geom_bar(aes(fill=ownership_type),stat='identity',position='dodge') +
      theme(axis.text.x = element_text(angle = 30, vjust = 0.5, hjust=1))

  })


  output$ownership_country = renderPlot({
    world %>%
      group_by(continent) %>%
      summarise(ratio = mean(ownership_type==input$ownership2)) %>%
      ggplot(aes(x=reorder(continent,ratio),y=ratio)) +
       geom_bar(fill='dark green',stat='identity',position='dodge') +
       theme_bw() +
       geom_text(aes(label=round(ratio,2)), vjust = -0.7)+
       ylab('') +
       xlab('') +
       ggtitle('Ratio of ownership type by continent') +
       theme(text=element_text(size=14,face = "bold"),
            line=element_blank(),
            panel.border = element_blank(),
            axis.line = element_line(color='grey20')) +
       theme(axis.text.x = element_text(angle = 45,vjust = 0.5, hjust=1))

  })

  
  
  #-------------table------------------
  


  output$table <- DT::renderDataTable({
    datatable(world, rownames=FALSE)

  })


 })