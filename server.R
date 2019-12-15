library(shiny)
library(dplyr)
library(DT)
library(ggplot2)
library(rsconnect)

setwd("C:/Users/mason/Desktop/Pro and A/Final Project")
df <- read.csv("APPENC03.csv")
names(df) <- c("id","market_share","price","nielsen_points","discount_price","package_promo","month","year")
df$discount_price <- as.factor(df$discount_price)
df$package_promo  <- as.factor(df$package_promo)
df$month          <- factor(df$month, levels = month.abb)
df$year           <- factor(df$year, levels = c(1999,2000,2001,2002))

shinyServer(function(input, output) {
  output$description1 <- renderText({"The data that I selected for this project is from a large food manufacturer regarding the market share of one of its main products. It was sourced from the appendix of 'Applied Linear Statistical Models fifth edition' published by McGraw-Hill Irwin. This time series data includes results from 36 months on market share, price, gross Nielsen points, discount price, package promotion, month, and year. The market share variable is the average monthly market share of the product as a percentage. The price variable is the product's price on average during the month. The gross Nielsen points variable is an index of the advertising exposure received by the product. The discount price variable is a dummy variable that represents if the product was on a discount price during the month. The package promotion variable is a dummy variable that represents if the product had a package promotion during the month. Month and Year are the remaining variables, which represent the month and year, respectively, of the period. "
    })
  output$plot1    <- renderPlot({
    targetyears       <- c(input$Year)
    filtereddf        <- filter(df, year %in% targetyears)
    mydata        <- filtereddf
    ggplot(mydata, aes(x = month, y = market_share, color = year))+
      geom_point()+
      xlab("Month")+
      ylab("Market Share")+
      ggtitle("Scatterplot of Market Share Over Time")+
      labs(color = "Year")
    })
  output$plot2    <- renderPrint({
    targetyears   <- c(input$Year)
    filtereddf    <- filter(df, year %in% targetyears)
    mydata        <- filtereddf
    xtabs(~discount_price+package_promo, data = mydata)
    })
  output$data1    <- DT::renderDataTable({
    mydata        <- df
    mydata
    })
})
