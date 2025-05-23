#' Set parameters necessary for publishing on Whitehall.
#' Includes setting specific figure parameters and
#' suppressing warnings, messages and other outputs
#' @export
#' @importFrom knitr opts_chunk
#' @name knitr_opts_set
#' @param fig.path folder to save generated images to. Defaults to "graphs"
#' @title Set knitr parameters to allow publishing on Whitehall
knitr_opts_set <- function(fig.path = "graphs/") {

  knitr::opts_chunk$set(
  #Prevent creation of warning or other message blocks - should be used only
  # when publishing output, so that you remain aware of warnings
    echo = FALSE,
    cache = FALSE,
    warning = FALSE,
    message = FALSE,
  # The default path for mojspeakr::convert_rmd() to check for images
  #is ./graphs
    fig.path = fig.path,
    dev = "svg"
  )
}
