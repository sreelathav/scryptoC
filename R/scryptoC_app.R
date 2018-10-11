#' Shiny app for the scryptoC package
#' show case output of all the 5 functions of the package
#'
#' @import shiny
#' @return opens up the shiny app for the scryptoC package
#' @export
#'
#' @examples
#' \dontrun{
#'    scryptoC_app()
#' }
scryptoC_app <- function(){

  # Define server logic required to plot fitted currency variable -----

server <- function(input, output) {

  #get currency data
  data_cryptoC = get_cryptoC()

  #plots for the side panel
   output$sumPlot <- renderPlot({

     plotAll(data_cryptoC,
            currency_type=input$currency_type)
   })
   #render plot for main panel
   output$fitPlot <- renderPlot({

    #get fit data

    fit_cryptoC = fit.cryptoC_data(data_cryptoC,
                                   currency_type=input$currency_type,
                                   var_type = input$varType)
    # plot fit model

    plot.cryptoC_fit(fit_cryptoC,
                     time_grid = pretty(as.numeric(fit_cryptoC$data$nDate), n = 365))
  })

  #Trying to render print output
  output$weeksPerf <- renderPrint({
    print_cryptoC()

  })
}

   #define ui for the app ----

ui <- fluidPage(

  # App title
  titlePanel("Leading Crypto Currency Analysis"),


  sidebarLayout(
    # with 2 select input and a render plot
    sidebarPanel(
      selectInput("currency_type",
                  "Crypto Currency",
                  choices = list("Bitcoin" = "Bitcoin",
                                 "Ethereum" = "Ethereum",
                                 "XRP" = "XRP"),
                  selected = "XRP"),
      selectInput("var_type",
                  "Variable  ",
                  choices = list( "Market Cap" = "Mcap",
                                  "Closing Price" = "Close"),
                  selected = "Close"),
      plotOutput("sumPlot")
    ),


    # Shows fit plot of smooth spline distribution
    mainPanel(
      plotOutput("fitPlot"),
      verbatimTextOutput("weeksPerf")
   )
  )
)

# Run the application----
shinyApp(ui = ui, server = server)
}
