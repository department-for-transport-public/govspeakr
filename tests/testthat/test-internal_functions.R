##Test remove_header function

test_that("remove_header removes the header from a markdown file", {

  #Create a test string
  text <- "---
  title: This is a test title
  output: html_document
  ---
  "

  expect_equal(remove_header(text),
               "  ")

  ##More complex test string
  text <- "---
  title: 'Untitled'
  output:
    html_document:
      keep_md: true
  date: '2022-08-05'
  ---
  "

  expect_equal(remove_header(text),
               "  ")

})

test_that("remove_header does not alter a markdown file without a header", {

  #Create a test string
  text <- "This is a test markdown file."

  expect_equal(remove_header(text),
               "This is a test markdown file.")

})

test_that("remove_header does not alter markdown tables", {

  #Create a test string
  text <- "This is a test markdown file.

  | This | is | a | table |
  |------|----|---|-------|
  | 1    | 2  | 3 | 4     |
  "

  expect_equal(remove_header(text),
               "This is a test markdown file.

  | This | is | a | table |
  |------|----|---|-------|
  | 1    | 2  | 3 | 4     |
  ")

})

test_that("remove_header message and warning works as expected", {

  #Create a test string
  text <- "---
  title: This is a test title
  output: html_document
  ---
  "

  expect_message(remove_header(text),
                 "Removed 1 header block")

  #Create a test string
  text <- "---
  title: This is a test title
  output: html_document
  ---

  ---
  title: This is a test title
  output: html_document
  ---
  "

  expect_warning(remove_header(text),
                 "Removed 2 header blocks")

})


##Test remove rmd blocks function
test_that("remove_rmd_blocks removes multiline code blocks from a markdown file", {

  #Create a test string
  text <- "``` r
  summary(cars)
  ```
  "

  expect_equal(remove_rmd_blocks(text),
               "  ")

  #Create a test string
  text <- "```
  summary(cars)
  ```
  "

  expect_equal(remove_rmd_blocks(text),
               "  ")

})

test_that("remove_rmd_blocks does not alter a markdown file without multiline code blocks", {

  #Create a test string
  text <- "This is a test markdown file. It has ```"

  expect_equal(remove_rmd_blocks(text),
               "This is a test markdown file. It has ```")

  #Create a test string
  text <- "This is a test markdown file. It has ``` r"

  expect_equal(remove_rmd_blocks(text),
               "This is a test markdown file. It has ``` r")

})

test_that("remove_rmd_blocks message works as expected", {

  #Create a test string
  text <- "``` r
  summary(cars)
  ```
  "

  expect_message(remove_rmd_blocks(text),
                 "Removed code blocks; consider setting echo = FALSE for all code chunks")

  #Create a test string
  text <- "``` r
  summary(cars)
  ```
  ``` r
  ggplot(mtcars)
  ```
  "

  expect_message(remove_rmd_blocks(text),
                 "Removed code blocks; consider setting echo = FALSE for all code chunks")

})
