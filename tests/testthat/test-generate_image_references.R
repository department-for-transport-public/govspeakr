test_that("generate_image_references converts an image to a markdown reference",
          {
            ##Single reference
            expect_equal(
              generate_image_references("![](test_files/figure-html/pressure-1.png)"),
              c("[Image:pressure-1.png]")
            )
            expect_equal(
              generate_image_references("![](test_files/figure-html/pressure-2.svg)"),
              c("[Image:pressure-2.svg]")
            )

            #Double ref
            expect_equal(
              generate_image_references(
                "![](test_files/figure-html/pressure-1.png)<!-- -->![](test_files/figure-html/pressure-2.png)<!-- -->"
              ),
              c("[Image:pressure-1.png]", "[Image:pressure-2.png]")
            )

            ##Ref with plain text between
            expect_equal(
              generate_image_references(
                "![](test_files/figure-html/pressure-1.png)<!-- -->This is some text<!-- -->![](test_files/figure-html/pressure-2.png)"
              ),
              c(
                "[Image:pressure-1.png]",
                "This is some text",
                "[Image:pressure-2.png]"
              )
            )


          })

test_that("generate_image_references does not alter similar non-image strings",
          {
            #Just something in square brackets
            expect_equal(
              generate_image_references("[some text in square brackets]"),
              "[some text in square brackets]"
            )

            ##A Html link
            expect_equal(
              generate_image_references("Read this! [Link](web_link.html)"),
              "Read this! [Link](web_link.html)"
            )

          })

test_that("No error if no images are present", {
  expect_equal(generate_image_references("This is some text"),
               "This is some text")


})


test_that("Works with multiple line breaks", {
  expect_equal(
    generate_image_references(
      "![](test_files/figure-html/pressure-1.png)<!-- -->\n\n![](test_files/figure-html/pressure-2.png)"
    ),
    c("[Image:pressure-1.png]", "\n\n[Image:pressure-2.png]")
  )

})

test_that("Message returns number of images detected", {
  expect_message(generate_image_references("![](test_files/figure-html/pressure-1.png)"),
                 "Detected 1 image references")

  expect_message(
    generate_image_references(
      "![](test_files/figure-html/pressure-1.png)<!-- -->\n\n![](test_files/figure-html/pressure-2.png)"
    ),
    "Detected 2 image references"
  )

  expect_message(generate_image_references("This is some text"),
                 "Detected 0 image references")

})
