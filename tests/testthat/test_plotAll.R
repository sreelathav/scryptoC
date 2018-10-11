library(scryptoC)

context("Tests for plotAll function")

test_that("plotAll produces valid data", {

  #expect_output(plotAll(get_cryptoC(),'Bitcoin'), 'NULL')
  expect_error(plotAll(4))
  #expect_is(plotAll(get_cryptoC(),'Bitcoin'), img())

})
