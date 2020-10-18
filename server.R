
shinyServer(function(input, output){
  
  
#-------------Global Presents Tab Outputs------------------
  
  #------------------Info boxes----------------------
  output$num_store <- renderInfoBox({
    num_store <- nrow(store_level)
    infoBox("Number of stores", num_store)
  })

  output$num_country <- renderInfoBox({
    num_country <- length(unique(store_level$country))
    infoBox("Number of countries", num_country)
  })
  
  output$avg_country <- renderInfoBox({
    
    mean <- country_level %>%
      filter(type!='No Starbucks') %>%
      summarise(mean = round(mean(num_of_store,na.rm=T),1))
      
    avg_country <- mean$mean
    infoBox("Average # of stores per country", avg_country)
  })

  #-------------All store location map -------------------
  
  output$map <- renderLeaflet({
    
    leaflet(store_level) %>% addTiles() %>%
      addMarkers(
        clusterOptions = markerClusterOptions()
      )
  })
  
  #---------------Top 10 country/city -----------------------
  
  output$store_by_top10 = renderPlot({
    
    if (input$city_country == 'Country'){
    
      country_level %>% 
        arrange(desc(num_of_store)) %>%
        head(10) %>%
       ggplot(aes(x=reorder(country_name,num_of_store),y=num_of_store)) +
       geom_col(fill='dark green') +
       geom_text(aes(label=num_of_store),  hjust=-0.8)+
       geom_text(x='United States of America', y=12500, label='13608',color='white')+
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
     store_level %>%
        group_by(city) %>%
        summarise(num_of_store=n()) %>%
        arrange(desc(num_of_store)) %>%
        head(10) %>%
       ggplot(aes(x=reorder(city,num_of_store),y=num_of_store)) +
       geom_col(fill='dark green') +
       geom_text(aes(label=num_of_store),  hjust=-0.1)+
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
  
  #-------------------------store per capita-------------------------
  
  output$store_per_capita = renderPlot({
    
    country_level %>%
      arrange(store_per_capita) %>%
      head(10) %>%
      ggplot(aes(x=reorder(country_name,desc(store_per_capita)),y=store_per_capita)) +
       geom_col(aes(fill=type)) +
       theme_bw() +
       geom_text(aes(label=store_per_capita), hjust = -0.7)+
       coord_flip() +
       ylab('') +
       xlab('') +
       ggtitle('Top 10 Countries By 1,000 Population Per Store') +
       theme(text=element_text(size=14,face = "bold"),
            line=element_blank(),
            panel.border = element_blank(),
            axis.line = element_line(color='grey20'))+
      scale_fill_manual(values = c('Top 10'="darkgreen", 'Not Top 10'="grey"),name='')

  })

#--------------------- General location analysis tab ---------------------
  
  #-------------economic metric comparision boxplot ------------------
  
  
  
  output$pop_gdp = renderPlot({
    
    var_display_name <- dplyr::case_when(input$pop_gdp == 'gdp_in_million' ~ 'GDP ($MM)',
                                         input$pop_gdp == 'tot_pop_thousands' ~ 'Total Population (k)',
                                         input$pop_gdp == 'gdp_per_capita' ~ 'GDP Per Capita')
    
    y_axis_upper <- dplyr::case_when(input$pop_gdp == 'gdp_in_million' ~ 1e6,
                                     input$pop_gdp == 'tot_pop_thousands' ~ 4e5,
                                     input$pop_gdp == 'gdp_per_capita' ~ NA_real_)
    gather = country_level %>%
      gather(key=feature,value=value,tot_pop_thousands:gdp_per_capita) 
    
    gather%>%
      filter(feature == input$pop_gdp) %>%
      group_by(type) %>%
      ggplot(aes(x=type,y=value)) + 
      geom_boxplot(aes(fill=type)) +
      ylim(0, y_axis_upper) +
      theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1))+
      theme_bw() +
      coord_flip() +
      ylab(var_display_name) +
      xlab('') +
      ggtitle(paste0(var_display_name, ' by Starbucks presents')) +
      theme(text=element_text(size=14,face = "bold"),
            line=element_blank(),
            panel.border = element_blank(),
            axis.line = element_line(color='grey20'))+
      scale_fill_manual(values = c('Top 10'="darkgreen", 'Not Top 10'="grey", "No Starbucks"='darkred'),
                        name='')

  })
  
  #--------------------------Scatter Plot----------------------
  
  output$pop_store = renderPlot({
    
    var_display_name <- dplyr::case_when(input$pop_gdp == 'gdp_in_million' ~ 'GDP ($MM)',
                                         input$pop_gdp == 'tot_pop_thousands' ~ 'Total Population (k)',
                                         input$pop_gdp == 'gdp_per_capita' ~ 'GDP Per Capita')
    
    gather = country_level %>%
      gather(key=feature,value=value,tot_pop_thousands:gdp_per_capita) 
    
    gather %>%
      filter(type!='No Starbucks') %>%
      filter(feature==input$pop_gdp) %>% 
      ggplot(aes(x=value,y=store_per_capita)) +
      geom_point(aes(color=type),size=2)+
      geom_smooth(method='lm',se=F,color='black')+
      theme_bw() +
      ylab('Num of Store Per 1,000 Inhabitants') +
      xlab(var_display_name) +
      theme(text=element_text(size=14,face = "bold"),
            line=element_blank(),
            panel.border = element_blank(),
            axis.line = element_line(color='grey20'))+
      scale_colour_manual(values = c('Top 10'="darkgreen", 'Not Top 10'="grey"),name='')+
      scale_x_log10()+
      scale_y_log10()+
      #scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
      #             labels = trans_format("log10", math_format(10^.x)))+
      ggtitle(paste0('Scatter Plot of Store Density by ', var_display_name))
      
  })
  
  #--------------------------Scatter Plot 2----------------------
  
  output$scatter2 = renderPlot({
    
    var_display_name <- dplyr::case_when(input$pop_gdp == 'gdp_in_million' ~ 'GDP ($MM)',
                                         input$pop_gdp == 'tot_pop_thousands' ~ 'Total Population (k)',
                                         input$pop_gdp == 'gdp_per_capita' ~ 'GDP Per Capita')
    
    gather = country_level %>%
      gather(key=feature,value=value,tot_pop_thousands:gdp_per_capita) 
    
    gather %>%
      filter(type!='No Starbucks') %>%
      filter(feature=='gdp_in_million') %>% #input$pop_gdp
      ggplot(aes(x=value,y=store_per_capita)) +
      geom_point(aes(color=continent_name),size=2)+
      geom_smooth(method='lm',se=F,color='black')+
      theme_bw() +
      ylab('Num of Store Per 1,000 Inhabitants') +
      xlab(var_display_name) +
      theme(text=element_text(size=14,face = "bold"),
            line=element_blank(),
            panel.border = element_blank(),
            axis.line = element_line(color='grey20'))+
      scale_colour_manual(values = c('Top 10'="darkgreen", 'Not Top 10'="grey"),name='')+
      scale_x_log10()+
      scale_y_log10()+
      #scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
      #             labels = trans_format("log10", math_format(10^.x)))+
      ggtitle(paste0('Scatter Plot of Store Density by ', var_display_name))
    
  })
  
  #--------------------------------Outlier country table-----------------------------
  
  output$outlier_country <- renderPlot({
    #datatable(abv_avg, rownames=FALSE,fillContainer = FALSE)
    abv <- tableGrob(abv_avg)
    grid.arrange(abv)
  })
  

#-------------------------------------------------------------------------------------
# 
#   output$by_ownership = renderPlot({
#     
#     world %>%
#       filter(country %in% input$brand1) %>%
#       group_by(country,ownership_type) %>%
#       summarise(num = n()) %>%
#       ggplot(aes(x=reorder(country,num),y=num)) +
#       geom_bar(aes(fill=ownership_type),stat='identity',position='dodge') +
#       theme(axis.text.x = element_text(angle = 30, vjust = 0.5, hjust=1))
# 
#   })
# 
# 
#   output$ownership_country = renderPlot({
#     world %>%
#       group_by(continent) %>%
#       summarise(ratio = mean(ownership_type==input$ownership2)) %>%
#       ggplot(aes(x=reorder(continent,ratio),y=ratio)) +
#        geom_bar(fill='dark green',stat='identity',position='dodge') +
#        theme_bw() +
#        geom_text(aes(label=round(ratio,2)), vjust = -0.7)+
#        ylab('') +
#        xlab('') +
#        ggtitle('Ratio of ownership type by continent') +
#        theme(text=element_text(size=14,face = "bold"),
#             line=element_blank(),
#             panel.border = element_blank(),
#             axis.line = element_line(color='grey20')) +
#        theme(axis.text.x = element_text(angle = 45,vjust = 0.5, hjust=1))
# 
#   })
  
  
#-------------------------Foreign Market Ownership & Location Analysis 2-------------------------
  #----------------------Ownership Type by Continent------------------------------------
  
  output$cpi1 = renderPlot({
    
   cpi_score = cpi_join%>%
     mutate(continent=ifelse(country=='United States of America',country,continent))%>%
     group_by(country,continent,CPI2015) %>%
     summarise(num_of_store=n()) %>%
     group_by(continent) %>%
     summarise(avg_cpi=mean(CPI2015))
    
   cpi_join %>%
      mutate(is_usa=ifelse(country=='United States of America',country,continent)) %>%
      group_by(is_usa,ownership_type) %>%
      summarise(num_store=n()) %>%
      inner_join(cpi_score,by=c('is_usa'='continent')) %>%
      arrange(desc(num_store)) %>%
      ggplot()+
      geom_col(aes(x=reorder(is_usa,num_store),y=num_store,fill=ownership_type),position='fill',width=0.8) +
      geom_line(aes(x=reorder(is_usa,num_store),y=avg_cpi/100),color='darkred',group=1,size=1.2)+
      geom_point(aes(x=reorder(is_usa,num_store),y=avg_cpi/100),color='darkred',group=1,size=3)+
      scale_fill_wsj(palette = "black_green",name='')+
      theme_bw() +
      ylab('') +
      xlab('') +
      ggtitle('Starbuck stores ownership type') +
      theme(text=element_text(size=14,face = "bold"),
            line=element_blank(),
            panel.border = element_blank(),
            axis.line = element_line(color='grey20')) +
      theme(axis.text.x = element_text(angle = 15, vjust = 0.5, hjust=1)) +
      scale_y_continuous(sec.axis = sec_axis(~.*100, name = "avg_cpi"))
  
    
  })
  
  #---------------------------- Explaination on Joint Venture------------------------
  
  # output$cpi2 = renderPlot({
  #   
  #   jv_country = cpi_join %>%
  #     filter(ownership_type=='Joint Venture') %>%
  #     group_by(country)%>%
  #     select(country) %>%
  #     unique()
  #   
  #   cpi_join %>%
  #     group_by(continent,country,CPI2015) %>%
  #     summarise(num_store=n()) %>%
  #     filter(continent %in% c('Asia','Europe','South America')) %>%
  #     mutate(has_jv=ifelse(country %in% jv_country$country,'Has_JV','No_JV')) %>%
  #     group_by(has_jv) %>%
  #     summarise(avg_cpi=mean(CPI2015),avg_store=mean(num_store))%>%
  #     ggplot(aes(x=has_jv,y=avg_store))+
  #     geom_col(aes(fill=has_jv),width=0.5) +
  #     #geom_point(aes(x=has_jv,y=avg_store),size=4,color='darkgreen') + 
  #     geom_point(aes(x=has_jv,y=avg_cpi*5),size=4,color='darkred')+
  #     #geom_line(aes(x=c('Has_JV','No_JV'),y=c(48.1*5,56.2*5)),size=1,color='darkred')
  #     theme_bw() +
  #     ylab('') +
  #     xlab('') +
  #     ggtitle('Average # of stores and CPI index in Asia countries') +
  #     theme(text=element_text(size=14,face = "bold"),
  #           line=element_blank(),
  #           panel.border = element_blank(),
  #           axis.line = element_line(color='grey20'))+
  #     #scale_fill_wsj(palette = "black_green",name='') + 
  #     geom_text(aes(x=has_jv,y=avg_cpi*5),label=c('avg_CPI 50','avg_CPI 56'),color='darkred',vjust= 2.5,hjust=-0.1)+
  #     scale_fill_manual(values = c('Has_JV'="darkgreen", 'No_JV'="grey"),name='') 
  #   
  # })
 
  #--------------------------------Location by Ownership Type-----------------------
  
  output$ownermap = renderLeaflet({
    
    
    pal <- colorFactor(c("darkgreen", "darkred", "green",'black'), levels = c("Company Owned", "Joint Venture","Licensed",'Franchise'))
    
    leaflet(cpi_clean) %>% addTiles() %>%
      addCircleMarkers(
        radius=3,
        color = ~pal(ownership_type),
        stroke = FALSE, fillOpacity = 0.5
      )
    
   
    
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  #-------------table------------------
  


  output$table <- DT::renderDataTable({
    datatable(country_level, rownames=FALSE)

  })


 })