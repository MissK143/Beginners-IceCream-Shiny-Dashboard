# Ice Cream Store Dashboard

## Overview

This Shiny app provides a dashboard for visualizing sales data from an ice cream chain. 
Users can explore daily and weekly trends in revenue and quantity sold for each store across a specified date range.

## Features

- **Date Range Selector**: Filter data to a specific time period.
- **Store Selector**: Choose a specific store to analyze.
- **Weekly Aggregation for Plots**: View weekly revenue and quantity sold for a clearer trend analysis over time.
- **Day-of-the-Week Summary**: View average sales and quantities sold by day of the week.

## Recent Updates

### Weekly Aggregation for Daily Trends

To improve plot readability, daily revenue and quantity sold plots are now aggregated by week. 
This reduces the density of the data points and helps users interpret trends over a broader time range without excessive vertical lines.

### Layout Update

The dashboard layout was updated for a better user experience:
1. **Top Row**: Contains the date range and store selectors.
2. **First Row**: Shows weekly revenue and weekly quantity sold plots, arranged vertically.
3. **Second Row**: Displays day-of-the-week summary plots for average sales and quantities sold, shown side-by-side.

## Project Structure

```plaintext
IceCreamDashboard/
├── app.R          # Optional: Single-file app setup
├── ui.R           # UI code for layout and input elements
├── server.R       # Server code for data processing and plotting
├── ice_cream.csv  # Sample dataset (replace with actual data path)
├── README.md      # Project documentation
└── other_files    # Any additional resources or files
