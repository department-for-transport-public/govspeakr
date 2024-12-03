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
                 "Removed 2 header blocks.
             Please check output for potentially missing strings")

})


##Test remove rmd blocks function
test_that("remove_rmd_blocks removes multiline code blocks from a markdown file", {

  #Create a test string
  text <- "This is a test markdown file.

  ```r
  x <- 1
  y <- 2
  z <- 3
  ```

  This is some more text.
  "

  expect_equal(remove_rmd_blocks(text),
               "This is a test markdown file.

  This is some more text.
  ")

})
