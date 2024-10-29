#' Add images which are not auto-generated during the knitting process
#' to all publishing formats.
#' Images can now be saved in any format compatible with Whitehall Publisher
#' (png or svg), and with any meaningful file name.
#' @param file_name string giving the file name of the image only
#' @param folder string giving the directory the image is stored in,
#' defaults to "graphs".
#' @export
#' @importFrom knitr asis_output
#' @name add_image
#' @title Convert an image file name into a html path
#' @returns A plain text string which embeds the specified image into any output format
#' @examples
#' \dontrun{
#' ##Image in default folder (graphs)
#' add_image("rail_usage_infographic.svg")
#'
#' ##Image in different folder
#' add_image("rail_usage_infographic.svg", folder = "img")
#' }
#'
add_image <- function(file_name, folder = "graphs") {
  knitr::asis_output(paste0("![](", folder, "/", file_name, ")<!-- -->"))
}
