% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_table.R
\name{add_table}
\alias{add_table}
\title{Format data in a markdown table suitable for publication, with comma separation on numbers}
\usage{
add_table(data, format.args = list(big.mark = ","))
}
\arguments{
\item{data}{dataframe; dataframe of any size to be displayed as a table}

\item{format.args}{additional format arguments to be passed to the table.
Defaults to comma thousands separation}
}
\value{
a markdown formatted table as a string
}
\description{
Add a table in Rmarkdown suitable for publication in govspeak and in word/PDF
}
\examples{
add_table(mtcars)
##Example with comma formatted values
add_table(data.frame(datasets::EuStockMarkets))
##Example with format.args set to null
add_table(data.frame(datasets::EuStockMarkets), format.args = NULL)

}
