shinyServer(function(input, output, session) {
  observe({
    print(input$operator)
  })
  
  observe({
    print(input$type)
  })
  
  ##### WORLD MAP - Tab 1
  output$crash_map <- renderPlotly({
    # print(1)
    date_start1 <- as.character(input$dates1[1])
    date_end1 <- as.character(input$dates1[2])
    map_df2 <-
      map_df2[as.Date(map_df2$realdate) >= date_start1 &
                 as.Date(map_df2$realdate) <= date_end1,]  %>%
      filter(Operator %in% input$operator & Type %in% input$type)
    # print(dim(map_df2))
    # map_df2 <- map_df2 %>%
    #   filter(Operator %in% input$operator & Type %in% input$type)

    geo <- list(
      showframe = FALSE,
      showland = TRUE,
      showcoastlines = TRUE,
      projection = list(type = 'orthographic'),
      resolution = '10000',
      showcountries = TRUE,
      countrycolor = '#ededed',
      showocean = TRUE,
      oceancolor = '#0077be',
      showlakes = TRUE,
      lakecolor = '#0077be'
      
    )
    
    plot_geo(locationmode = 'city', color = I("red")) %>%
      add_markers(
        data = map_df2,
        x = map_df2$lng,
        y = map_df2$lat,
        hovertext = map_df2$concated_column,
        alpha = 1
      ) %>%
      layout(
        geo = geo,
        showlegend = FALSE,
        height = 650,
        hovermode = 'closest'
        
      )
  })

  
  #Scatter plot for tab 2
  output$scat = renderPlotly({
    date_start2 <- as.character(input$dates2[1])
    date_end2 <- as.character(input$dates2[2])
    crash_df <-
      crash_df[as.Date(crash_df$realdate) >= date_start2 &
                 as.Date(crash_df$realdate) <= date_end2,]
    
    
    p = crash_df %>%
      filter(Operator %in% input$operator &
               Type %in% input$type) %>%
      ggplot(aes(
        x = realdate,
        y = Fatalities,
        color = Survived,
        text = concated_column
      )) + scale_color_gradient(low = "purple", high = "blue") +
      geom_point()  + ggtitle("Fatalities per accident") + xlab("Date") + ylab("Fatalities") +
      theme(
        plot.title = element_text(
          face = "bold",
          hjust = 0.5,
          size = 18
        ),
        axis.title = element_text(size = 14)
      )
    ggplotly(p) %>% layout(dragmode = "select")
  })
  
  #yearly histogram plot for tab 2
  output$countY <- renderPlot({
    yearview <- seq(input$slider2[1], input$slider2[2])
    
    crash_df[which(crash_df$Year %in% yearview), ]  %>%
      filter(Operator %in% input$operator &
               Type %in% input$type) %>%
      group_by(Year) %>%
      summarise(count = n()) %>%
      ggplot(aes(x = Year , y = count)) +
      geom_col(fill = "purple", color = "blue") +
      ggtitle("Historical Yearly Accident Count") + xlab("Year") + ylab("Number of accidents") +
      theme(
        plot.title = element_text(
          face = "bold",
          hjust = 0.5,
          size = 20
        ),
        axis.title = element_text(size = 14)
      )
  })
  
  
  #Monhtly histogram plot for tab 3
  output$countM <- renderPlot(
    crash_df %>%
      filter(Operator %in% input$operator &
               Type %in% input$type) %>%
      filter(Year %in% input$selyear) %>% 
      group_by(month) %>%
      summarise(count = n()) %>%
      ggplot(aes(x = month , y = count)) +
      geom_col(fill = "purple", color = "blue") +
      ggtitle("Historical Monthly Accident Count") + xlab("Month") + ylab("Number of accidents") +
      theme(
        plot.title = element_text(
          face = "bold",
          hjust = 0.5,
          size = 20
        ),
        axis.title = element_text(size = 14)
      )
  )
})



# observe({
#   if ("Select All" %in% input$operator) {
#     # choose all the choices _except_ "Select All"
#     selected_choices1 <- setdiff(choice1, "Select All")
#     updateSelectInput(session, "operator", selected = selected_choices1)
#   }
# })
#
# observe({
#   if ("Select All" %in% input$type) {
#     # choose all the choices _except_ "Select All"
#     selected_choices2 <- setdiff(choice2, "Select All")
#     updateSelectInput(session, "type", selected = selected_choices2)
#   }
# })