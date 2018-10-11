#' Extract, tidy and load data for the cryptocurrencies Bitcoin, Ethereum and XRP from
#' coinmarketcap \href{https://coinmarketcap.com/currencies/bitcoin/}{Bitcoin},
#' coinmarketcap \href{https://coinmarketcap.com/currencies/ethereum/}{Ethereum},
#' coinmarketcap \href{https://coinmarketcap.com/currencies/ripple/}{XRP}
#'
#' All the variables Close, Low, High in Us dollars and MCap is been converted into Billion scale
#' @import rvest
#' @import xml2
#' @importFrom tibble 'as_tibble'
#' @importFrom lubridate 'today' 'parse_date_time'
#' @importFrom dplyr '%>%'
#' @return alist of 3 \code{\link[tibble]{tibble}}s containing Bitcoin, Ethereum, XRP data objects
#' @export
#' @seealso \code{\link{print_cryptoC}}, \code{\link{plotAll}},
#' \code{\link{fit}}, \code{\link{plot}}
#' @examples
#' obj <- get_cryptoC()
#' bex <- get_cryptoC()
get_cryptoC <- function(){

  Name = Date = Mcap = Volume = HigH = Low = Close = nDate = NULL

  tidy_hist_data = function(raw_data,currency_name="Bitcoin"){

    suppressWarnings(name <- rep(currency_name, length.out= nrow(raw_data)))

    r_data <- lapply(raw_data, gsub, pattern = "[,?]", replacement = "")

    d <- gsub(" UTC", "", parse_date_time(r_data$Date, orders= "mdy"))
    mcap <- as.double(r_data$Market.Cap )/1e9
    volume <- as.numeric(r_data$Volume)
    high <- as.double(r_data$High)
    low <- as.double(r_data$Low)
    close <- as.double(r_data$Close..)

    nD <- round(c(1:365)/365,5)

    suppressWarnings(hist_data <- cbind( name, d,  mcap, volume, high, low, close, nD) %>%
                       as.data.frame())
    names(hist_data) <- c("Name", "Date", "Mcap", "Volume", "High", "Low", "Close", "nDate")

    return(hist_data)
  }

  arg = 'bitcoin'
  start_date = gsub("-", "",(today() - 365))
  end_date = gsub("-", "",(today()))

  get_url <- function (arg){
    url = paste0("https://coinmarketcap.com/currencies/",
                 arg,
                 "/historical-data/?start=",
                 start_date, "&end=",
                 end_date)
    return (url)
  }
  #Read  year  of Bitcoin currency data from coinmarketcp.com

  url_bitcoin <- get_url("bitcoin")
  url_bitcoin %>%
    read_html() %>%
    html_nodes(css = "table") %>%
    html_table() %>%
    as.data.frame() -> "bitcoin_data" #  bitcoin data object

  # Tidy bitcoin data
  btc_data <- tidy_hist_data(bitcoin_data,"Bitcoin")
  btc_data[1:5,]

  #Read an year data of  ethereum

  url_ethereum <- get_url("ethereum")
  url_ethereum %>%
    read_html() %>%
    html_nodes(css = "table") %>%
    html_table() %>%
    as.data.frame() -> "ethereum_data" #  ethereum data object


  # Tidy ethereum data
  eth_data <- tidy_hist_data(ethereum_data, "Ethereum")
  #eth_data[1:5,]


  #Read an year data of  xrp

  url_xrp <- get_url("ripple")
  url_xrp %>%
    read_html() %>%
    html_nodes(css = "table") %>%
    html_table() %>%
    as.data.frame() -> "xrp_data" #  xrp data object


  # Tidy xrp data
  xrp_db <- tidy_hist_data(xrp_data, "XRP")
  #xrp_db[1:5,]

  # Mking a list of 3 currency objects
  object_return = list(as_tibble(btc_data),
                       as_tibble(eth_data),
                       as_tibble(xrp_db))

  #Naming the objects after the currencies
  names(object_return) = c("Bitcoin", "Ethereum", "XRP")

  # Define cryptoC_data class for future use
  class(object_return) = 'cryptoC_data'

  return(object_return)


}
