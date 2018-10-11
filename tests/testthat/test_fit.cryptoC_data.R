library(scryptoC)

context("Tests for fit function")

test_that("fit produces valid data", {

  #expect_output(fit.CryptoC_data(get_cryptoC(),'Bitcoin','Close'), 'List of 4')
  expect_error(fit('BLA'))
  expect_is(fit.cryptoC_data(get_cryptoC(),'Bitcoin','Close'), 'cryptoC_fit')

})
