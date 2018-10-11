library(scryptoC)

context("Tests for plot function")

test_that("plot produces valid data", {

  expect_output(str(plot.cryptoC_fit(fit(get_cryptoC(),'Bitcoin','Mcap'),
                                     time_grid = pretty(c(1:365)/365,n=100))), 'NULL')
  expect_error(plot.cryptoC_fit(4))
  #expect_is(plot.cryptoC_fit(fit(get_cryptoC(),'XRP','Close'),
                             #time_grid = pretty(c(1:365)/365,n=100)), 'NULL')

})
