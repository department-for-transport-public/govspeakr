#' Extracts image references from the original markdown output into Whitehall format
#' @param lines raw contents of md file (from readLines)
#' @name generate_image_references
#' @keywords internal
#' @title Generate govdown image references
generate_image_references <- function(lines) {

  #Return a message of how many image references detected
  matches <- gregexpr("!\\[\\]\\(.*?/([^\\)]+)\\)", lines)
  num_images <- sum(sapply(matches,
                           function(x) ifelse(x[1] == -1, 0, length(x))))

  message("Detected ", num_images, " image references")

  ##Sub out markdown format for Whitehall format
  lines <- gsub("!\\[\\]\\(.*?/([^\\)]+)\\)", "[Image:\\1]", lines)

  return(lines)
}


#' Convert markdown callout sytax to govspeak
#' @param md_file string; markdown file text
#' @name convert_callouts
#' @keywords internal
#' @title Convert markdown callout syntax to govspeak
#'
convert_callouts <- function(md_file) {
  # Lazy match on lines starting with ">", which are then flanked with "^"
  # Currently only catches single line callouts

  gsub("(\\n)>[ ]*(.*?\\n)",
       "\\1^\\2",
       md_file)
}


#' Replace R markdown header with title only
#' @param md_file string; markdown file text
#' @name remove_header
#' @keywords internal
#' @title Replace R markdown header with ## title
remove_header <- function(md_file) {

  ##Message to let people know how many header blocks removed
  number_removed <- gregexpr("---\\n\\s*.*?\\s*output\\s*.*?\\s*---\\n", md_file)

  #Count number of matches
  number_removed <- length(number_removed[[1]])

  ##Message if one removed, warning if more than one removed
  if (number_removed == 1) {
    message("Removed 1 header block")
  } else if (number_removed > 1) {
    warning("Removed ", number_removed, " header blocks.
            Please check output for potentially missing strings")
  }

  # Lazy match on header to extract title
  # Remove substitution if titles must be entered manually
  gsub("---\\n\\s*.*?\\s*output\\s*.*?\\s*---\\n",
       "",
       md_file)

}


#' Remove R markdown multiline block elements
#' (package warnings, but also multiline code blocks)
#' @param md_file string; markdown file text
#' @name remove_rmd_blocks
#' @keywords internal
#' @title Remove R markdown multiline block elements
#' (package warning and code block)
#'
remove_rmd_blocks <- function(md_file) {

  ##Check if there are any code block matches and return a message if so
  if (length(grep("\`\`\`(| r)\\n.*?\`\`\`\\n", md_file)) > 0) {
    message("Removed code blocks; consider setting echo = FALSE for all code chunks")
  }

  # Lazy match on warnings and code blocks
  gsub("```(| r)\\n.*?```\\n", "", md_file)

}


#' Substitute hashed Rmarkdown headers with the next level down down
#' e.g. # to ##
#' @param x string object to substitute one # value for another
#' @param sub_type logical or vector, TRUE will substitute all heading levels,
#' FALSE will substitute none, alternatively a vector will allow you
#' to select specific levels of header to substitute.
#' @name hash_sub
#' @keywords internal
#' @title Increase Rmarkdown headers by one level
#'
hash_sub <- function(x, sub_type) {

  if (TRUE %in% sub_type) {

    #Substitute any number of hashes for that number plus 1
    gsub("(#{1,})", "\\1#", x)

  } else if (FALSE %in% sub_type) {
    #Sub nothing
    x
  } else {
    ##Substitute the values passed to the argument as a vector
    #Collapse that funky little vector into a regex string
    sub_type <- paste0("(\\b|[^#])(",
                       paste(sub_type, collapse = "|"), ")([^#])")

    #Regex; swap any of the listed patterns for that plus one #.
    #God 2022 Fran is so much better at this that 2019 Fran
    x <- gsub(sub_type, "\\1#\\2\\3", x)

    return(x)
  }
}

#' Compares summary points to vector of words indicating change,
#'  and highlights relevant words in bold.
#' @param data character vector of summary points
#' @param key_words character vector of additional words you would like
#' to highlight in bold (defaults to NULL)
#' @param key_words_remove character vector of standard key words you would NOT
#' like to highlight in bold (defaults to NULL)
#' @name bold_key_words
#' @title Highlight in bold key words in summary text
bold_key_words <- function(data, key_words = NULL, key_words_remove = NULL) {

  ##Concatenate chosen key words with pre-existing list
  key_words <- c(key_words, "decreasing", "decreased", "down", "lower", "fall",
                 "decrease", "fell", "increasing", "increased", "up", "risen",
                 "increase", "rose", "stable", "no change")

  #If key words to remove is not NULL, remove listed words from key_words
  if (!is.null(key_words_remove)) {
    key_words <-  key_words[!(key_words %in% key_words_remove)]
  }

  temp <- data
  for (i in 1:length(key_words)) {

    temp <- gsub(paste0("\\b", key_words[i], "\\b"),
                 paste0("**", key_words[i], "**"),
                 temp,
                 ignore.case = TRUE)

  }
  return(temp)
}
