#' Add a table in Rmarkdown suitable for publication in govspeak and in word/PDF
#' @param data dataframe; dataframe of any size to be displayed as a table
#' @param format.args additional format arguments to be passed to the table.
#' Defaults to comma thousands separation
#' @export
#' @importFrom knitr kable
#' @name add_table
#' @returns a markdown formatted table as a string
#' @examples
#' add_table(mtcars)
#' ##Example with comma formatted values
#' add_table(data.frame(datasets::EuStockMarkets))
#' ##Example with format.args set to null
#' add_table(data.frame(datasets::EuStockMarkets), format.args = NULL)
#'
#' @importFrom knitr kable
#' @title Format data in a markdown table suitable for publication, with comma separation on numbers

add_table <- function(data, format.args = list(big.mark = ",")) {

  ##Error if data is not a data table
  if(!any(grepl("data.frame", class(data)))){
    stop("Data must be provided as a single data table")
  }

  knitr::kable(data,
               format = "markdown",
               format.args = format.args
               )
}
