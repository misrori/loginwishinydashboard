library(shiny)
library(shinythemes)
credentials <- list("test" = "123")

shinyServer(function(input, output) {
  
  
  USER <- reactiveValues(Logged = FALSE)
  
  observeEvent(input$login, {
    if (isTRUE(credentials[[input$username]]==input$password)){
      USER$Logged <- TRUE
    } else {
      show("message")
      output$message = renderText("Invalid user name or password")
      delay(2000, hide("message", anim = TRUE, animType = "fade"))
    }
  })
  
  output$app = renderUI(
    if (!isTRUE(USER$Logged)) {
      
      fluidRow(column(width=4, offset = 4,
                      div(titlePanel("My title"), align="center"),
                      wellPanel(id = "login",
                                textInput("username", "Username:"),
                                passwordInput("password", "Password:"),
                                div(actionButton("login", "Log in"), style="text-align:center;")
                      ),
                      textOutput("message")
      ))
    } else {
      fluidPage(theme = shinytheme("darkly"),
                navbarPage(
                  title="My title",
                  tabPanel("tab1",
                           h1('tab1')
                           
                  ),# tabpanel
                  
                  tabPanel('tab2',
                           h1("tab2")
                  )
                )#navbarpage
      )#fluidpage
      
      
    }
    
  )
  
})