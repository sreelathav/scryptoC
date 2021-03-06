% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fit.cryptoC_data.R
\name{fit}
\alias{fit}
\title{Fits the selected currency data with spline smooth model and
returns the fit data of the chosen variable}
\usage{
fit(obj, currency_type = c("Bitcoin", "Ethereum", "XRP"),
  var_type = c("Close", "Mcap"))
}
\arguments{
\item{obj}{returned from get_cryptoC() function}

\item{currency_type}{select from C('Bitcoin','Ethereum', 'XRP')}

\item{var_type}{select from c('Close', 'Mcap')}
}
\value{
fit data, smooth spline model output, currency type, variable type
}
\description{
Fits the selected currency data with spline smooth model and
returns the fit data of the chosen variable
}
\examples{
obj <- get_cryptoC()
out1 <- fit(obj,'XRP','Close')
out2 <- fit(obj,'Bitcoin','Mcap')
out3 <- fit(obj,'Ethereum','Close')

}
\seealso{
\code{\link{print_cryptoC}}, \code{\link{plotAll}},
\code{\link{get_cryptoC}}, \code{\link{plot}}
}
