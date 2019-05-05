shinyUI(dashboardPage(
  skin = 'purple',
  dashboardHeader(titleWidth = 320, title = "Air Crash Investigation"),
  dashboardSidebar(
    width = 320,
    sidebarUserPanel(h3("George Alster")),
    sidebarMenu(
      menuItem(
        "Homepage",
        tabName = "home",
        icon = icon("home")
      ),
      menuItem(
        "Interactive Globe ",
        tabName = "globe",
        icon = icon("globe")
      ),
      menuItem(
        "Annual Analysis",
        tabName = "annual",
        icon = icon("chart-area")
      ),
      menuItem(
        "Monthly Analysis",
        tabName = "monthly",
        icon = icon("chart-bar")
      )
    ),
    pickerInput(
      "operator",
      "Select Operator",
      choices = choice1,
      options = list(`actions-box` = TRUE),
      multiple = T,
      selected = choice1
    ),
    pickerInput(
      "type",
      "Select Aircraft Type",
      choices = choice2,
      options = list(`actions-box` = TRUE),
      multiple = T,
      selected = choice2
    )
  ),
  dashboardBody(tabItems(
    tabItem(tabName = 'home',
            fluidRow(column(
              width = 12,
              align = 'center',
              box(
                title = strong('Airplane Crashes and Fatalities Data Since 1908'),
                status = 'primary',
                solidHeader = T,
                width = NULL,
                img(src = 'https://images.q-park-resa.fr/img_dyna/g-photo_park-car_park_nice_airport-en-278.jpg',
                    width = 800, align = "center")
                )
            )),
            fluidRow(column(
              width = 12,
              box(
                title = strong('The Data'),
                status = 'info',
                solidHeader = T,
                width = NULL,
                h4("This data was found from Socrata.com and contains over five thousand observations and thirteen different variables.
                   The key information from this data is the location of the incident, the date at which it ocurred, the details of the vehicle and the 
                   tally of fatalities. After downloading this data, a variety of cleaning and organising was required to ensure it could be easily manipulated. 
                   In addition, it was compiled with another dataset containing the latitude and longitude values of world cities in order to develop the 
                   'Interactive Globe' tab. To clarify any ambiguities, the variable 'ratio' is the proportion of fatalities to those on board and the variable 'ground' represents the 
                   number of fatalities on the ground")
              )
            )),
            fluidRow(column(
              width = 12,
              box(
                title = strong('The Motivation'),
                status = 'info',
                solidHeader = T,
                width = NULL,
                h4("The motivation for this project comes in tow parts;Business and Personal. On the personal aspect, analsysis of this data enables you to settle any nerves you may have flying when you realise how infrequently accidents occur.
                   Additionally, this data may help you plan your next holiday, particularly, which airline you book your travel with. From this business point of view,this data enables companies to understand what may have caused accidnets historically. Most importantly, they
                   can analyse if a particular type of plane has more frequent incidences and from this they can target their safety focus. Finally, this data also provides summaries of the accidents that occurred. Utilising this may enable companies to discover what is the most frequent cause of 
                   commercial flight accidents and therefore exercise focus on solving this particular issue")
              )
            ))), 
    tabItem(tabName = "globe",
            fluidRow(column(width=1),
              column(h3('Airplane accidents by location'),
                width = 11,
              box(status = 'primary',
                width = 8,
                height = 7,
                  # status = "primary",
                  plotlyOutput("crash_map")),
                   # height = 720,
                   # width = 600),
                box(width = 4, 
                  dateRangeInput(
                  "dates1",
                  label = h3("Select date range"), 
                  start = "2000-01-01",
                  end = "2010-01-01"),
                solidHeader = TRUE,
                status = "primary")
              ))

            
            ),
    tabItem(tabName = "annual",
            fluidRow(
              column(width = 1),
              tabBox(
                title = "Annual analysis",
                # The id lets us use input$tabset1 on the server to find the current tab
                id = "tabset1",
                height = "300px",
                width = "500px",
                tabPanel(
                  "Fatality data",
                  plotlyOutput("scat"),
                  fluidRow(column(
                    6,
                    dateRangeInput(
                      "dates2",
                      label = h3("Date range"),
                      start = "2000-01-01",
                      end = "2010-01-01"
                    )
                  )),
                  hr(),
                  fluidRow(column(6, verbatimTextOutput("value")))
                ),
                tabPanel(
                  "Crash count",
                  plotOutput("countY"),
                  fluidRow(column(
                    4,
                    sliderInput(
                      "slider2",
                      label = h3("Slider Range"),
                      min = 1908,
                      max = 2010,
                      value = c(1940, 2000)
                    )
                  )),
                  hr(),
                  fluidRow(column(4, verbatimTextOutput("range")))
                  
                )
              )
            )),
    tabItem(tabName = "monthly",
            fluidRow(
              column(width = 1), column(
                h2('Month by month analysis'),
                width = 10,
                box(
                  status = "primary",
                  plotOutput("countM"),
                  height = 450,
                  width = 600
                )
              )
            ),
            fluidRow(column(6,selectizeInput(
              "selyear",
              "Select Year",
              choice3,
              # options = list(`actions-box` = TRUE),
              multiple = T,
              selected = "2000"
            ))))
  ))
))
