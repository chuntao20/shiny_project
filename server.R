
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
    
    if (input$city_country == 'Country'){
    
      top10 %>% 
      ggplot(aes(x=reorder(country,total),y=total)) +
       geom_col(fill='dark green') +
       geom_text(aes(label=total),  hjust=-0.7)+
       geom_text(x='USA', y=12500, label='13608',color='white')+
       theme_bw() +
       coord_flip() +
       ylab('') +
       xlab('') +
       ggtitle('Top 10 country with the most Starbucks stores') +
       theme(text=element_text(size=14,face = "bold"),
             line=element_blank(),
             panel.border = element_blank(),
             axis.line = element_line(color='grey20'))
    } else {
     topcity %>%
       ggplot(aes(x=reorder(city,total),y=total)) +
       geom_col(fill='dark green') +
       geom_text(aes(label=total),  hjust=-0.1)+
       theme_bw() +
       coord_flip() +
       ylab('') +
       xlab('') +
       ggtitle('Top 10 city with the most Starbucks stores') +
       theme(text=element_text(size=14,face = "bold"),
             line=element_blank(),
             panel.border = element_blank(),
             axis.line = element_line(color='grey20'))
    }

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
    
    if(input$store_continent == 'Number of Starbuck stores by continent') {
    
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
    } else {
    world%>%
      group_by(continent,country) %>%
      summarise(total=n()) %>%
      group_by(continent) %>%
      summarise(total=n()) %>%
      ggplot(aes(x=reorder(continent,total),y=total)) +
      geom_col(fill='dark green') +
      theme_bw() +
      geom_text(aes(label=total), vjust = -0.7)+
      ylab('') +
      xlab('') +
      ggtitle('Number of countries in each continent that has Starbucks stores') +
      theme(text=element_text(size=14,face = "bold"),
            line=element_blank(),
            panel.border = element_blank(),
            axis.line = element_line(color='grey20'))+
      theme(axis.text.x = element_text(angle = 30,vjust = 0.5, hjust=1))
    }
    
  })

  
  
  
  #-------------analysis------------------
  
  
  # output$by_brand = renderGvis(
  #   
  # )
  # 
  # 
  output$pop_gdp = renderPlot({
    g = pop_gdp %>%
      filter(feature == input$pop_gdp) %>%
      group_by(continent, present) %>%
      ggplot(aes(x=continent,y=value)) + 
      geom_boxplot(aes(fill=present)) +
      theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1))+
      theme_bw() +
      coord_flip() +
      ylab('') +
      xlab('') +
      ggtitle('GDP and population for countries have and not have Starbucks') +
      theme(text=element_text(size=14,face = "bold"),
            line=element_blank(),
            panel.border = element_blank(),
            axis.line = element_line(color='grey20'))+
      scale_fill_manual(values = c('Present'="darkgreen", 'Not Present'="grey"))
    
    if (input$pop_gdp == 'GDP'){
      g+ylim(0,2e12)
    } else if (input$pop_gdp == 'Population') {
      g+ylim(0,4e8)
    } else {
      g
    }
    
  })
  
  
  
  
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
  
  
  #-------------------------analysis 2-------------------------
  
  output$cpi1 = renderPlot({
    
    cpi = cpi_join %>%
      mutate(is_usa=ifelse(country=='United States of America',country,continent)) %>%
      group_by(is_usa,ownership_type) %>%
      summarise(num_store=n()) %>%
      arrange(desc(num_store)) %>%
      ggplot(aes(x=reorder(is_usa,num_store),y=num_store))+
      scale_fill_wsj(palette = "black_green",name='')+
      theme_bw() +
      ylab('') +
      xlab('') +
      ggtitle('Starbuck stores ownership type') +
      theme(text=element_text(size=14,face = "bold"),
            line=element_blank(),
            panel.border = element_blank(),
            axis.line = element_line(color='grey20'))+
      theme(axis.text.x = element_text(angle = 30, vjust = 0.5, hjust=1))
    
     if(input$cpi1 == 'Absolute Number'){
       cpi + geom_col(aes(fill=ownership_type),position='dodge',width=0.8)
     } else {
       cpi + geom_col(aes(fill=ownership_type),position='fill',width=0.8)
     }
    
  })
  
  
  
  output$cpi2 = renderPlot({
    
    cpi_join %>%
      filter(continent=='Asia') %>%
      mutate(has_jv=ifelse(country %in% jv_asia$country,'Has_JV','No_JV')) %>%
      group_by(has_jv,country,CPI2015) %>%
      summarise(num_store=n()) %>%
      group_by(has_jv) %>%
      summarise(avg_cpi=mean(CPI2015),avg_store=mean(num_store))%>%
      ggplot(aes(x=has_jv,y=avg_store))+
      geom_col(aes(fill=has_jv),width=0.6) +
      geom_point(aes(x=has_jv,y=avg_cpi*15),size=4,color='darkred')+
      theme_bw() +
      ylab('') +
      xlab('') +
      ggtitle('Average # of stores and CPI index in Asia countries') +
      theme(text=element_text(size=14,face = "bold"),
            line=element_blank(),
            panel.border = element_blank(),
            axis.line = element_line(color='grey20'))+
      scale_fill_manual(values = c('Has_JV'="darkgreen", 'No_JV'="grey"),name='') +
      geom_text(aes(x=has_jv,y=avg_cpi*15),label=c('avg_CPI 50','avg_CPI 46'),color='darkred',vjust= 2.5,hjust=-0.1,face = "bold")
    
  })

  
  
  #-------------table------------------
  


  output$table <- DT::renderDataTable({
    datatable(world, rownames=FALSE)

  })


 })