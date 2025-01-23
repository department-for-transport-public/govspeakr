test_that("hash_sub default substitution works as expected", {
  expect_identical(hash_sub("##", sub_type = TRUE), "###")
  expect_identical(hash_sub("###", sub_type = TRUE), "####")
  expect_identical(hash_sub("## This is text", sub_type = TRUE), "### This is text")
})

test_that("hash_sub does nothing when sub type is FALSE", {
  expect_identical(hash_sub("##", sub_type = FALSE), "##")
  expect_identical(hash_sub("###", sub_type = FALSE), "###")
  expect_identical(hash_sub("## This is text", sub_type = FALSE), "## This is text")
})

test_that("hash_sub allows selecting which strings to sub", {
  expect_identical(hash_sub("## ", sub_type = c("#")), "## ")
  expect_identical(hash_sub("## ", sub_type = c("#|##")), "### ")
  expect_identical(hash_sub("### ", sub_type = c("#|##")), "### ")
  expect_identical(hash_sub("## This is text", sub_type = c("#|##")), "### This is text")
})
