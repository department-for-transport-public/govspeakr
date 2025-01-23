library(testthat)
library(knitr)

# Test cases for callout_box
test_that("callout_box generates correct output when it is HTML and so is format", {

  #Set the output format to HTML
  opts_knit$set("rmarkdown.pandoc.to" = "html")

  #Create a test string
  text <- "This is a test callout box."

  expect_equal(callout_box(text),
               knitr::asis_output(paste("$CTA", text, "$CTA", sep = "\n")))

})

test_that("callout_box generates correct output when it is HTML and format is not", {

  #Set the output format to HTML
  opts_knit$set("rmarkdown.pandoc.to" = "html")

  #Create a test string
  text <- "This is a test callout box."

  expect_true(
    grepl("background-color",
          callout_box(text, format = "latex")))
})


test_that("callout_box generates correct output when it is not HTML and format is", {

  #Set the output format to HTML
  opts_knit$set("rmarkdown.pandoc.to" = "latex")

  #Create a test string
  text <- "This is a test callout box."

  expect_equal(callout_box(text),
               cat(paste(text)))

})
