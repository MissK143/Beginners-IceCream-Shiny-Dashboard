# ui.R
library(shiny)

# Define the UI
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Ice Cream Store Dashboard"),
  
  # Sidebar layout
  sidebarLayout(
    # Sidebar panel for inputs
    sidebarPanel(
      selectInput("store", "Select Store", choices = NULL),  # Store dropdown input
      dateRangeInput("dateRange", "Select Date Range", 
                     start = "2020-01-01", 
                     end = "2022-12-31")                      # Date range selector
    ),
    
    # Main panel for plots
    mainPanel(
      
      # First row for daily plots
      fluidRow(
        column(width = 6, plotOutput("dailyRevenuePlot", height = "200px")),   # Daily revenue plot with specified height
        column(width = 6, plotOutput("dailyQuantityPlot", height = "200px"))   # Daily quantity sold plot with specified height
      ),
      
      # Second row for weekly summary plots
      fluidRow(
        column(width = 6, plotOutput("weeklySalesPlot", height = "200px")),    # Weekly sales plot
        column(width = 6, plotOutput("weeklyQuantityPlot", height = "200px"))  # Weekly quantity sold plot
      )
    )
  )
))
