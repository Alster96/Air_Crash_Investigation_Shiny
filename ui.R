library(shinydashboard)
shinyUI(dashboardPage(
  dashboardHeader(title = "Air Crash Investigation"),
  dashboardSidebar(
    sidebarUserPanel("George Alster"),
    sidebarMenu(
      menuItem("Interactive Globe ", tabName = "globe", icon = icon("map")),
      menuItem("Annual Analysis", tabName = "annual", icon = icon("database")),
      menuItem("Monthly Analysis", tabName = "monthly", icon = icon("database"))
    )#,
    #selectizeInput("selected","Select Operator",choice1),
    #selectizeInput("selected","Select Aircraft Type",choice2)
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "globe",
"to be replaced with interactive globe"),
      tabItem(tabName = "annual", 
"to be replaced with scatterplot showing across the years the highest fatality accidents"),
tabItem(tabName = "monthly", 
        "to be replaced with bar chart of count of accidents in each month")
    )
  )
))

