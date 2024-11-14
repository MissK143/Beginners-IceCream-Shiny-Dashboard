# server.R
library(shiny)
library(dplyr)
library(ggplot2)
library(lubridate)

# Load the data
ice_cream <- read.csv("~/ice_cream-1-.csv")  # Replace with the correct path to your CSV file

# Define the server logic
shinyServer(function(input, output, session) {
  
  # Populate store dropdown choices based on data
  observe({
    updateSelectInput(session, "store", choices = unique(ice_cream$store))
  })
  
  # Reactive expression to filter data based on selected store and date range
  filtered_data <- reactive({
    req(input$store, input$dateRange)  # Ensure inputs are selected
    ice_cream %>%
      mutate(date = as.Date(date)) %>%
      filter(store == input$store, 
             date >= input$dateRange[1] & date <= input$dateRange[2])
  })
  
  # Weekly Revenue Plot (aggregated by week)
  output$dailyRevenuePlot <- renderPlot({
    filtered_data() %>%
      mutate(week = floor_date(date, "week")) %>%  # Aggregate by week
      group_by(week) %>%
      summarize(weekly_revenue = sum(sales, na.rm = TRUE)) %>%
      ggplot(aes(x = week, y = weekly_revenue)) +
      geom_line(color = "#FF8C94", linewidth = 1) +  # Pastel Pink
      labs(title = "Weekly Revenue", x = "Week", y = "Revenue ($)") +
      theme_minimal()
  })
  
  # Weekly Quantity Sold Plot (aggregated by week)
  output$dailyQuantityPlot <- renderPlot({
    filtered_data() %>%
      mutate(week = floor_date(date, "week")) %>%  # Aggregate by week
      group_by(week) %>%
      summarize(weekly_quantity = sum(quantity, na.rm = TRUE)) %>%
      ggplot(aes(x = week, y = weekly_quantity)) +
      geom_line(color = "#A8E6CF", linewidth = 1) +  # Mint Green
      labs(title = "Weekly Quantity Sold", x = "Week", y = "Quantity Sold") +
      theme_minimal()
  })
  # Weekly Sales Plot (average revenue by day of the week)
  output$weeklySalesPlot <- renderPlot({
    filtered_data() %>%
      mutate(day_of_week = wday(date, label = TRUE)) %>%
      group_by(day_of_week) %>%
      summarize(avg_sales = mean(sales, na.rm = TRUE)) %>%
      ggplot(aes(x = day_of_week, y = avg_sales)) +
      geom_bar(stat = "identity", fill = "#87CEEB", color = "#1E90FF") + # Sky Blue and darker blue outline
      labs(title = "Average Sales by Day of the Week", x = "Day of the Week", y = "Average Revenue ($)") +
      theme_minimal()
  })
  
  # Weekly Quantity Plot (average quantity sold by day of the week)
  output$weeklyQuantityPlot <- renderPlot({
    filtered_data() %>%
      mutate(day_of_week = wday(date, label = TRUE)) %>%
      group_by(day_of_week) %>%
      summarize(avg_quantity = mean(quantity, na.rm = TRUE)) %>%
      ggplot(aes(x = day_of_week, y = avg_quantity)) +
      geom_bar(stat = "identity", fill = "#FFF5BA", color = "#FFD700") + # Cream Yellow and golden outline
      labs(title = "Average Quantity Sold by Day of the Week", x = "Day of the Week", y = "Average Quantity Sold") +
      theme_minimal()
  })
})
