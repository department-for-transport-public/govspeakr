#' Conditional display of specified objects when RMarkdown document is knitted.
#' Expression will display the object only in the specified Rmarkdown output
#' type.
#' @param output object to display in the document; can be a table, text,
#' graph, or image.
#' @param publication_type string describing type of RMarkdown output you would
#' like the object to appear in. Options include "html" for html_document,
#' "docx" for word_document, and "latex" for pdf_document.
#' @importFrom knitr opts_knit
#' @export
#' @name conditional_publishing_output
#' @title Conditional display of object depending on Rmarkdown publication type.

conditional_publishing_output <- function(output, publication_type) {

  ##If it's null, return an error
  if (is.null(knitr::opts_knit$get("rmarkdown.pandoc.to"))) {

    stop("This function will only work inside an Rmarkdown chunk")

  }

  if (knitr::opts_knit$get("rmarkdown.pandoc.to") == publication_type) {
    return(output)
  }
}
