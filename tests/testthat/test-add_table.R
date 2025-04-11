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

test_that("add_table works with bold_cols as column names", {

  result_bold_cols_names <- add_table(mtcars, bold_cols = c("mpg", "cyl"))
  mtcars_bold <- mtcars

  mtcars_bold$mpg <- paste0("**", mtcars_bold$mpg, "**")
  mtcars_bold$cyl <- paste0("**", mtcars_bold$cyl, "**")

  expected_output_bold_cols_names <- knitr::kable(mtcars_bold,
                                                  format = "markdown",
                                                  format.args = list(big.mark = ","))

  expect_equal(result_bold_cols_names, expected_output_bold_cols_names)
})

test_that("add_table works with bold_cols as column positions", {

  result_bold_cols_positions <- add_table(mtcars, bold_cols = c(1, 2))

  mtcars_bold <- mtcars
  mtcars_bold$mpg <- paste0("**", mtcars_bold$mpg, "**")
  mtcars_bold$cyl <- paste0("**", mtcars_bold$cyl, "**")

  expected_output_bold_cols_positions <- knitr::kable(mtcars_bold,
                                                      format = "markdown",
                                                      format.args = list(big.mark = ","))

  expect_equal(result_bold_cols_positions, expected_output_bold_cols_positions)
})
