shinyUI(dashboardPage(skin = 'purple',
  dashboardHeader(titleWidth = 320, title = "Air Crash Investigation"),
  dashboardSidebar(width = 320,
    sidebarUserPanel("George Alster"),
    sidebarMenu(
      menuItem("Interactive Globe ", tabName = "globe", icon = icon("globe")),
      menuItem("Annual Analysis", tabName = "annual", icon = icon("chart-area")),
      menuItem("Monthly Analysis", tabName = "monthly", icon = icon("chart-bar"))
    ),
    # selectizeInput("operator","Select Operator",choice1),
    # selectizeInput("type","Select Aircraft Type",choice2)
    pickerInput("operator","Select Operator",choices = choice1, options = list(`actions-box` = TRUE),multiple = T,
                selected = choice1),
    pickerInput("type","Select Aircraft Type",choices = choice2, options = list(`actions-box` = TRUE),multiple = T,
                selected = choice2)
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "globe",
"to be replaced with interactive globe"),
      tabItem(tabName = "annual",
              fluidRow(plotlyOutput("scat"),
                       plotOutput("countY"))),
      tabItem(tabName = "monthly", 
        fluidRow(box(plotOutput("countM"), height = 300, width =600)))
    )
  )
))


