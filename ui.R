library(shiny)
library(shinythemes)
library(dplyr)
library(DT)
library(rsconnect)

shinyUI(fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("Final Project - Market Share of a Food Product"),
  #Side bar for selecting year
  sidebarLayout(
    sidebarPanel(
      #Multiple checkbox input for year
      checkboxGroupInput("Year",
                         "Years:",
                         c("1999", "2000", "2001", "2002")),
      helpText("Select year(s) to view data")
    ),
    position = "right",
    fluid = TRUE,
  #Main panel for displaying output
  mainPanel(
    tabsetPanel(type="tabs",
                tabPanel("Problem Description", textOutput("description1")),
                tabPanel("Plot and Table",tabsetPanel(
                  tabPanel("Scatterplot of Market Share Over Time", plotOutput("plot1")),
                  tabPanel("Table of Price Discount by Package Promotion Count", verbatimTextOutput("plot2")))),
                tabPanel("Data",DT::dataTableOutput("data1")))
   )
  )
 )
)
