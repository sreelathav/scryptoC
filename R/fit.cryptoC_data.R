#' Fits the selected currency data with spline smooth model and
#' returns the fit data of the chosen variable
#' @param obj returned from get_cryptoC() function
#' @param currency_type select from C('Bitcoin','Ethereum', 'XRP')
#' @param var_type select from c('Close', 'Mcap')
#'
#' @importFrom tibble 'tibble'
#' @importFrom magrittr '%$%' 'extract2' '%>%'
#' @importFrom stats 'smooth.spline' 'predict' 'na.omit'
#' @return fit data, smooth spline model output, currency type, variable type
#' @export
#'
#' @seealso \code{\link{print_cryptoC}}, \code{\link{plotAll}},
#' \code{\link{get_cryptoC}}, \code{\link{plot}}
#' @examples
#' obj <- get_cryptoC()
#' out1 <- fit(obj,'XRP','Close')
#' out2 <- fit(obj,'Bitcoin','Mcap')
#' out3 <- fit(obj,'Ethereum','Close')
#'

fit <- function(obj,
                currency_type = c('Bitcoin', 'Ethereum', 'XRP'),
                var_type = c('Close', 'Mcap')) {
                                                UseMethod('fit')
       }

#' Fits currency_data object
#' @param obj returned from get_cryptoC() function
#' @param currency_type select from C('Bitcoin','Ethereum', 'XRP')
#' @param var_type select from c('Close', 'Mcap')
#' @export
#' @rawNamespace export(fit.cryptoC_data)
#'


fit.cryptoC_data <- function(obj,
                             currency_type = c('Bitcoin', 'Ethereum', 'XRP'),
                             var_type = c('Close', 'Mcap')) {
  #Global variable def
  nDate = Close = Mcap = NULL

  #  chosen currency data set
  fit_data = match.arg(currency_type)

  # chosen fitting option
  var_arg = match.arg(var_type)

  # Find out which bit of the data to take
  dat_choose = switch(fit_data, Bitcoin = 1,
                      Ethereum = 2,
                      XRP = 3)

  # Extract particular data set from the given object
  currency_data = obj %>% extract2(fit_data)

  #print(typeof (currency_data$Close))

  # Fit a model smooth spline for the chosen variable
  if(var_arg == 'Close') {
    mod = currency_data %$% smooth.spline(as.double(nDate),as.double(Close))
  } else if(var_arg == 'Mcap') {
    mod = currency_data %$% smooth.spline(as.double(nDate),as.double(Mcap))
  }
  #print(mod)

  # Output for further analysis or visualization
  out = list(model = mod,
             data = currency_data,
             currency_type = fit_data,
             var_type = var_arg)
  class(out) = 'cryptoC_fit'

  invisible(out)

}
