library(knitr)

##Test that conditional publishing output shows and hides content as expected

test_that("conditional_publishing_output shows content when format matches request", {

  #Set the output format to HTML
  opts_knit$set("rmarkdown.pandoc.to" = "html")

  text = "This is my text"

  expect_equal(conditional_publishing_output("html", text),
               text)


  ##Set output format to PDF
  opts_knit$set("rmarkdown.pandoc.to" = "latex")

  expect_equal(conditional_publishing_output("latex", text),
               text)
})


test_that("conditional_publishing_output hides content when format does not match request", {

  #Set the output format to HTML
  opts_knit$set("rmarkdown.pandoc.to" = "html")

  text = "This is my text"

  expect_equal(conditional_publishing_output("latex", text),
               NULL)

  ##Set output format to PDF
  opts_knit$set("rmarkdown.pandoc.to" = "latex")

  expect_equal(conditional_publishing_output("html", text),
               NULL)
})
