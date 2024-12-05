#' Adds conditional CTA tags in govspeak only. Displays as text in a box on Whitehall publisher,
#' as a equivalent style HTML box in the html output if needed,
#' and as simple text only in other formats.
#' @param text string to publish in a callout box
#' @param format string which identifies the outputs you would like the
#' callout box tags to appear in. Set to HTML as default. If HTML is not the chosen format value,
#' the callout box will be displayed as a CSS-formatted in the HTML output. All other
#' formats which are not the chosen format value will display the callout box as simple text.
#' @importFrom knitr opts_knit asis_output
#' @export
#' @name callout_box
#' @title Include a callout box in govspeak output
#' @examples
#' \dontrun{
#' ##This will display the $CTA tags in the HTML output and nothing in any other format
#' callout_box("This is a callout box")
#'
#' #This will display the $CTA tags in the word output and a nicely CSS-formatted box in the HTML output
#' callout_box("This is a callout box", "word")
#' }
#'
callout_box <- function(text, format = "html") {
  if (knitr::opts_knit$get("rmarkdown.pandoc.to") %in% format) {

      knitr::asis_output(paste("$CTA", text, "$CTA", sep = "\n"))

  } else if (opts_knit$get("rmarkdown.pandoc.to") == "html") {

    #Nice formatting for HTML output if required

    knitr::asis_output(
      paste("<style type='text/css'>
        cta {
          text-align: left;
          background-color: #f3f2f1 ;
          padding-top: 20px;
          padding-bottom: 60px;
          padding-left: 30px;
          padding-right: 30px;
          display: block;
          margin-left: auto;
          margin-right: auto;
          width: 100%;

        }
       </style>",
        "<cta>",
        text,
        "</cta>", sep = "\n"))

  } else {

    cat(paste(text))
  }
}
