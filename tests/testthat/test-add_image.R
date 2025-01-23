# Load the testthat package
library(testthat)

test_that("add_image generates correct image markdown", {

  # Test with default folder
  expect_equal(add_image("example_image.png"),
               knitr::asis_output("![](graphs/example_image.png)<!-- -->"))

  ##Test with different case
  # Test with default folder
  expect_equal(add_image("example_image.PNG"),
               knitr::asis_output("![](graphs/example_image.PNG)<!-- -->"))

  # Test with custom folder
  expect_equal(add_image("example_image.png", "images"),
               knitr::asis_output("![](images/example_image.png)<!-- -->"))
})

test_that("add_image fails with no image extension",{

  expect_error(add_image("image"))
  expect_error(add_image("image"), "Image must be svg or png format")

})

test_that("add_image fails with folder location included in name",{

  expect_error(add_image("folder/image.png"))
  expect_error(add_image("folder/image.png"), "Please only provide the file name to the first argument")

})

