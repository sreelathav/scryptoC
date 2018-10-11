#' plots the smooth spline model fit data for the currency(bitcoin/Ethereum/XRP) and varable (Close/Mcap)
#' from \code{\link{fit}} function
#' @param out , the fit output from \code{\link{fit}} function
#' @param time_grid An optional time grid over which the fitted values of the model to be predicted
#' @param ...   other parameters for the plot, not defined now
#'
#' @import ggplot2
#' @importFrom stats 'na.omit' 'predict' 'smooth.spline'
#' @importFrom tibble 'tibble'
#' @importFrom viridis 'scale_color_viridis'
#' @return Displays plot to the console
#' @export
#'
#' @seealso \code{\link{print_cryptoC}}, \code{\link{plotAll}},
#' \code{\link{fit}}, \code{\link{get_cryptoC}}
#' @examples
#' obj <- get_cryptoC()
#' out1 <- fit(obj,'XRP','Close')
#' plot(out1)
#' out2 <- fit(obj,'Bitcoin','Mcap')
#' plot(out2)

plot <- function(out, time_grid = pretty(as.double(out$data$nDate), n = 365), ...) {
                                                                          UseMethod('plot')
        }

#' plot the model fit
#' @param out , the fit output from \code{\link{fit}} function
#' @param time_grid An optional time grid over which the fitted values of the model to be predicted
#' @param ...   other parameters for the plot, not defined now
#'
#' @export
#' @rawNamespace export(plot.cryptoC_fit)
#'


plot.cryptoC_fit <- function(out, time_grid = pretty(as.double(out$data$nDate), n = 365), ...) {

   #setting global variable
  pred = NULL
  # Create a plot from the output of fit.crptoC_data where
  # out$data is data object and out$model is the model object

  # Get  predicted values by smooth spline model  on the time_grid
  fits = tibble(time_grid, pred = predict(out$model, tibble(time_grid))$y[,1])  %>%
    na.omit()

  # Construct the plot for the Variable
  if(out$var_type == 'Close') {

    ggplot(out$data, aes(as.double(out$data$nDate), as.double( out$data$Close))) +
      geom_point(aes(colour = as.double(out$data$Close)) ) +
      theme_bw() +
      xlab('Date') +
      ylab( paste0(out$currency_type,'  Currency Closing Price')) +
      geom_line(data = fits, aes(x = time_grid, y = pred, colour = pred)) +
      theme(legend.position = 'None') +
      scale_color_viridis()

  } else if(out$var_type == 'Mcap') {

    ggplot(out$data, aes(as.double(out$data$nDate), as.double( out$data$Mcap))) +
      geom_point(aes(colour = as.double(out$data$Mcap)) ) +
      theme_bw() +
      xlab('Date') +
      ylab(paste0(out$currency_type,'  Currency Market cap')) +
      geom_line(data = fits, aes(x = time_grid, y = pred, colour = pred)) +
      theme(legend.position = 'None') +
      scale_color_viridis()
  }

}
