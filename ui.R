library(shinydashboard)
library(shinyWidgets)
shinyUI(dashboardPage(skin = 'purple',
  dashboardHeader(titleWidth = 320, title = "Air Crash Investigation"),
  dashboardSidebar(width = 320,
    sidebarUserPanel("George Alster"),
    sidebarMenu(
      menuItem("Interactive Globe ", tabName = "globe", icon = icon("globe")),
      menuItem("Annual Analysis", tabName = "annual", icon = icon("chart-area")),
      menuItem("Monthly Analysis", tabName = "monthly", icon = icon("chart-bar"))
    ),
    # selectizeInput("myselect","Select Operator",choice1),
    # selectizeInput("selected","Select Aircraft Type",choice2)
    pickerInput("myselect","Select Operator",choices = choice1, options = list(`actions-box` = TRUE),multiple = T),
    pickerInput("selected","Select Aircraft Type",choices = choice2, options = list(`actions-box` = TRUE),multiple = T)
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "globe",
"to be replaced with interactive globe"),
      tabItem(tabName = "annual", 
"to be replaced with scatterplot showing across the years the highest fatality accidents"),
      tabItem(tabName = "monthly", 
        fluidRow(box(plotOutput("plot1"))))
    )
  )
))


