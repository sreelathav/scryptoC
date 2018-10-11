#' Load data from  \href{https://coinmarketcap.com/all/views/all/}{Coinmarketcap}
#' @param save_file 'yes' to save data to perf_cryptoC.csv in the working directory
#'
#' @importFrom rvest 'html_nodes' 'html_table'
#' @importFrom xml2 'read_html'
#' @importFrom dplyr 'arrange' '%>%' 'desc'
#' @importFrom utils 'write.csv'
#' @return  displays output to the console
#' @export
#'
#' @seealso \code{\link{get_cryptoC}}, \code{\link{plotAll}},
#' \code{\link{fit}}, \code{\link{plot}}
#' @examples
#' print_cryptoC()
#' \dontrun{
#' print_cryptoC("yes")
#' }
print_cryptoC <- function(save_file= "No"){


  #defining global variables
  Name=Symbol=M.cap=Price=Supply=Volume=var1h=var24h=var7d=Rank = NULL

  url <- "https://coinmarketcap.com/all/views/all/"


  # Read the coinmarket all view table from the url
  url  %>%
    read_html() %>%
    html_nodes(css = "table") %>%
    html_table() %>%
    as.data.frame() -> "coinmcap_data" # write market data to data frame object

  # tidy data
  coinmcap_data <- coinmcap_data[-c(1,11)]
  coinmcap_data[] <- lapply(coinmcap_data, gsub, pattern = ".*\n", replacement = "")
  coinmcap_data[] <- lapply(coinmcap_data, gsub, pattern = "\\\n|[%*$,?]", replacement = "")

  #web page gives data in the order of M.cap which is the Rank
  coinmcap_data$Rank <- as.numeric(rownames(coinmcap_data))

  names(coinmcap_data) <- c("Name", "Symbol", "M.cap", "Price", "Supply", "Volume", "var1h", "var24h", "var7d", "Rank")
  #coinmcap_data[1:10,]

  # change type of 3 to 9 variables from character type to numeric
  num_coinmcap_data <- suppressWarnings( lapply(coinmcap_data[-c(1:2)], as.numeric)) %>% as.data.frame()

  tidy_data <- cbind(coinmcap_data$Name, coinmcap_data$Symbol, num_coinmcap_data) %>%
    as.data.frame()
  names(tidy_data) <- c("Name", "Symbol", "M.cap", "Price", "Supply", "Volume", "var1h", "var24h", "var7d", "Rank")

  # arrange df in the order mcap , 7d highest, then 2h highest and 1h
  mcapLead = tidy_data %>%  arrange(desc(M.cap),desc(var7d), desc(var24h), desc(var1h))
  #head(mcapLead, 10) # Display first 10 rows

  # Export collected data to csv in the working directory
  if (tolower(save_file) == "yes"){
    write.csv(tidy_data,'perf_cryptoC.csv', row.names = FALSE)}

  #save(currency_data, file="data/perf.RData")

  #Print leading 15 to the screen
  print(mcapLead[1:15,c("Name" ,"M.cap" ,"Price", "var1h", "var24h","var7d", "Rank")])


}
