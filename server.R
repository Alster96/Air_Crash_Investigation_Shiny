shinyServer(function(input,output,session){
  
  # observe({
  #   if ("Select All" %in% input$myselect) {
  #     # choose all the choices _except_ "Select All"
  #     selected_choices <- setdiff(choice1, "Select All")
  #     updateSelectInput(session, "myselect", selected = selected_choices)
  #   }
  # })
  # 
  # observe({
  #   if ("Select All" %in% input$selected) {
  #     # choose all the choices _except_ "Select All"
  #     selected_choices <- setdiff(choice2, "Select All")
  #     updateSelectInput(session, "selected", selected = selected_choices)
  #   }
  # })
  
  observe({
    print(input$myselect)
  })
  
  observe({
    print(input$selected)
  })
  
  
  
  
  
  
  
  #this is the code for tab 3
  # output$hist = renderGvis(
  #   gvisHistogram(crash_df[,crash_df$Month,drop= FALSE])
  # )
  
  output$plot1 = renderPlot({
    data = crash_df$Month
    hist(data)
  })
  
  
  crash_df %>% ggvis(~Month) %>% layer_histograms()

  
  
  

})
