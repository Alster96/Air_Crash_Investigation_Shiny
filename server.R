shinyServer(function(input,output,session){
  
  observe({
    print(input$operator)
  })

  observe({
    print(input$type)
  })

  #Scatter plot for tab 2
  output$scat = renderPlotly({
    #key = c(crash_df$Ratio, crash_df$Ground, crash_df$Operator, crash_df$Type)
    p = crash_df %>%
      filter(Operator %in% input$operator & Type %in% input$type) %>%
      ggplot(aes(x = realdate, y = Fatalities,color = Fatalities, text = concated_column)) +scale_color_gradient(low="purple", high="blue")+
      geom_point()  + ggtitle("Fatalities per accident") + xlab("Date") + ylab("Fatalities") +
      theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 18), axis.title = element_text(size = 14))
    ggplotly(p) %>% layout(dragmode = "select")
  })

  #yearly histogram plot for tab 2
  output$countY <- renderPlot(
    crash_df %>%
      filter(Operator %in% input$operator & Type %in% input$type) %>%
      group_by(Year) %>%
      summarise(count = n()) %>%
      ggplot(aes(x =Year , y = count)) +
      geom_col(fill = "purple",color = "blue") + 
      ggtitle("Historical Yearly Accident Count") + xlab("Year") + ylab("Number of accidents") +
      theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 20), axis.title = element_text(size = 14)) 
  )
  #Monhtly histogram plot for tab 3
  output$countM <- renderPlot(
    crash_df %>%
      filter(Operator %in% input$operator & Type %in% input$type) %>%
      group_by(month) %>%
      summarise(count = n()) %>%
      ggplot(aes(x =month , y = count)) +
      geom_col(fill = "purple",color = "blue") + 
      ggtitle("Historical Monthly Accident Count") + xlab("Month") + ylab("Number of accidents") +
      theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 20), axis.title = element_text(size = 14)) 
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