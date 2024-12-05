# Load the testthat package
library(testthat)

test_that("add_table fails with non-data frame source", {

  expect_error(add_table(matrix(1:4, nrow = 2)),
               "Data must be provided as a single data table")
})

test_that("add_table works with a data frame source", {

  expected_output_default <- knitr::kable(mtcars,
                                          format = "markdown",
                                          format.args = list(big.mark = ","))
  expect_equal(add_table(mtcars), expected_output_default)
})

test_that("add_table works with custom arguments", {


  result_custom <- add_table(mtcars, format.args = list(big.mark = ".", decimal.mark = ","))
  expected_output_custom <- knitr::kable(mtcars,
                                         format = "markdown",
                                         format.args = list(big.mark = ".", decimal.mark = ","))

  expect_equal(result_custom, expected_output_custom)
})

