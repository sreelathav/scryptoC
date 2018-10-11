library(scryptoC)

context("Tests for get_cryptoC function")

test_that("get_cryptoC produces valid data", {


  expect_error(get_cryptoC('BLA'))
  expect_is(get_cryptoC(), 'cryptoC_data')
  #expect_output(get_cryptoC(), 'List of 3')
  # Here's one that fails
  #expect_output(get_cryptoC(), 'List of 5')
})
