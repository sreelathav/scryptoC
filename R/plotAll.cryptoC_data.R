#' Plots the variables 'Market Cap', 'Close', 'High', 'Low', 'Volume'
#' of the cryptoC_data object for the chosen cryptocurrency with respect to the weighted Date variable
#' look at \href{https://coinmarketcap.com/currencies/bitcoin/}{Bitcoin}
#' for the description of each variable
#'
#' @param obj returned from get_cryptoC() function
#' @param currency_type choose from C('Bitcoin','Ethereum', 'XRP')
#'
#' @importFrom tidyr 'gather'
#' @import ggplot2
#' @importFrom magrittr 'extract2' '%>%'
#'
#' @return Prints summary of the variables and display plots to the console
#' @export
#' @seealso \code{\link{print_cryptoC}}, \code{\link{get_cryptoC}},
#' \code{\link{fit}}, \code{\link{plot}}
#' @examples
#' obj <- get_cryptoC()
#' plotAll(obj,'Bitcoin')
#' plotAll(obj,'XRP')
#' plotAll(obj,'Ethereum')
#'

plotAll <- function(obj,
                    currency_type = c('Bitcoin', 'Ethereum', 'XRP')) {
                                                               UseMethod('plotAll')
           }

#'  plot all the variables of the chosen cryptocurrency
#' @param obj returned from get_cryptoC() function
#' @param currency_type choose from C('Bitcoin','Ethereum', 'XRP')
#' @export
#' @rawNamespace export(plotAll.cryptoC_data)
#'

plotAll.cryptoC_data <- function(obj,currency_type=c('Bitcoin', 'Ethereum', 'XRP')){

  #global variable definition
  Date = nDate= Name= value= NULL

  # get data from object depending on currency type

  #  chosen currency data type
  data_type = match.arg(currency_type)


  # Find out which bit of the data to take
  data_choose = switch(data_type,  Bitcoin = 1,
                                  Ethereum = 2,
                                       XRP = 3)

  # Extract particular data set from the given object
  dataC = obj %>% extract2(data_choose)

  #print(summary(dataC))

  #plots of Date verses other variables for the currency type

  suppressWarnings(
    dataC %>% gather( -Date, -nDate, -Name, key = "var", value = "value") %>%
      ggplot(aes(y = as.double(value),
                 x = as.double(nDate),
                 color = as.double(value))) +
      labs(title = paste0(data_type, ' Performance')) +
      stat_smooth() +
      geom_point() +
      facet_wrap(~ var, scales = "free") +
      theme_bw()  +
      xlab('Date') +
      theme(axis.text.x=element_blank(), axis.text.y=element_blank(),
            axis.ticks.y=element_blank() , axis.title.y=element_blank(),
            axis.ticks.x=element_blank()) +
      theme(legend.position = 'None')
  )


}
