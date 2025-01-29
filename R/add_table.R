#Add the option for users to specify which columns should be marked as bold, by name or position number

#' Add a table in Rmarkdown suitable for publication in govspeak and in word/PDF
#' @param data dataframe; dataframe of any size to be displayed as a table
#' @param format.args additional format arguments to be passed to the table.
#' @param bold_cols vector; vector of column names or column positions to be bolded in the table
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
#' ##Example with bold_cols set to a vector of column names
#' add_table(data.frame(datasets::EuStockMarkets), bold_cols = c("DAX", "SMI"))
#' ##Example with bold_cols set to a vector of column positions
#' add_table(data.frame(datasets::EuStockMarkets), bold_cols = c(1, 2))
#'
#' @importFrom knitr kable
#' @title Format data in a markdown table suitable for publication, with comma separation on numbers

add_table <- function(data, format.args = list(big.mark = ","), bold_cols = NULL) {

  ##Error if data is not a data table
  if(!any(grepl("data.frame", class(data)))){
    stop("Data must be provided as a single data table")
  }

  ##Error if bold_cols is not a vector
  if(!is.null(bold_cols) & !is.vector(bold_cols)){
    stop("bold_cols must be a vector")
  }

  ##If bold cols is not null, format data table to bold the columns specified
  if(!is.null(bold_cols)){
    if(all(is.numeric(bold_cols))){
      bold_cols <- colnames(data)[bold_cols]
    }
    for(col in bold_cols){
      data[[col]] <- paste0("**", data[[col]], "**")
    }
  }


  knitr::kable(data,
               format = "markdown",
               format.args = format.args
               )
}
