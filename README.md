"# scryptoC" is an R package consisting of 6 functions, which extracts, save, explore and fit 
crypto currency data of Bitcoin, Ethereum and XRP from coinmarketcap website
1. get_cryptoC()
   Extract, tidy and load data for the cryptocurrencies Bitcoin, Ethereum and XRP from
   coinmarketcap \href{https://coinmarketcap.com/currencies/bitcoin/}{Bitcoin},
   coinmarketcap \href{https://coinmarketcap.com/currencies/ethereum/}{Ethereum},
   coinmarketcap \href{https://coinmarketcap.com/currencies/ripple/}{XRP}
2. print_cryptoC('yes')
   Load data from  \href{https://coinmarketcap.com/all/views/all/}{Coinmarketcap}
   save_file 'yes' to save data to perf_cryptoC.csv in the working directory
3. plotAll.cryptoC_data(obj, currency_type)
   Plots the variables 'Market Cap', 'Close', 'High', 'Low', 'Volume'
   of the cryptoC_data object for the chosen cryptocurrency with respect to the weighted Date variable
   look at \href{https://coinmarketcap.com/currencies/bitcoin/}{Bitcoin}
   for the description of each variable
   @param obj returned from get_cryptoC() function
   @param currency_type choose from C('Bitcoin','Ethereum', 'XRP')
4. fit.cryptoC_data(obj, currency_type, var_type)
   Fits the selected currency data with spline smooth model and
   returns the fit data of the chosen variable
   @param obj returned from get_cryptoC() function
   @param currency_type select from C('Bitcoin','Ethereum', 'XRP')
   @param var_type select from c('Close', 'Mcap')
5. plot.cryptoC_fit(out,time_grid)
   plots the smooth spline model fit data for the currency(bitcoin/Ethereum/XRP) and varable (Close/Mcap)
   from \code{\link{fit}} function
   @param out , the fit output from \code{\link{fit}} function
   @param time_grid An optional time grid over which the fitted values of the model to be predicted
   @param ...   other parameters for the plot, not defined now
6. scryptoC_app() is a Shiny app for the scryptoC package
   show case output of all the 5 functions of the package
   Note that few functions are dependent on the 
   particular functions run in advance.
