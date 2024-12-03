library(knitr)

##Set standard text
text = "This is my text"

##Test that conditional publishing output shows and hides content as expected

test_that("conditional_publishing_output throws an error if not run inside an Rmarkdown chunk", {

  #Set the output format to NULL
  opts_knit$set("rmarkdown.pandoc.to" = NULL)

  expect_error(conditional_publishing_output(text, "html"),
               "This function will only work inside an Rmarkdown chunk")
})

test_that("conditional_publishing_output shows content when format matches request", {

  #Set the output format to HTML
  opts_knit$set("rmarkdown.pandoc.to" = "html")

  expect_equal(conditional_publishing_output(text, "html"),
               text)


  ##Set output format to PDF
  opts_knit$set("rmarkdown.pandoc.to" = "latex")

  expect_equal(conditional_publishing_output(text, "latex"),
               text)
})


test_that("conditional_publishing_output hides content when format does not match request", {

  #Set the output format to HTML
  opts_knit$set("rmarkdown.pandoc.to" = "html")

  expect_equal(conditional_publishing_output("latex", text),
               NULL)

  ##Set output format to PDF
  opts_knit$set("rmarkdown.pandoc.to" = "latex")

  expect_equal(conditional_publishing_output("html", text),
               NULL)
})
