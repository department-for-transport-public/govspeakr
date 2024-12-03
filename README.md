# govspeakr

{govspeakr} is the replacement for the now-defunct {mojspeakr} package. This package aims to make it easier to automate official statistics publishing tasks in R:

* To allow easy conversion of an Rmarkdown file into a formatted govspeak file suitable for publishing through the Whitehall publisher on ([GOV.UK](https://www.gov.uk)). 

* To allow output of statistical releases in both govspeak and another (word, PDF, HTML) format from one RMarkdown file. 

* To allow replication of many govspeak tags and formatting appearances in the HTML output.


## Installation
This package is available on github. To install, run the following code:

```
library(remotes)
remotes::install_github("department-for-transport-public/govspeakr")
```


## Usage

### Conversion of output to govspeak format

{govspeakr} is designed to be used alongside an RMarkdown file, and cannot be called inside the RMarkdown file itself. The conversion acts on a markdown (\*.md) file only, so R markdown (\*.Rmd) should first be converted/knitted to \*.md. This can be achieved through setting the argument `keep_md` to true in the YAML header of the RMarkdown document.

```
---
title: "My Rmarkdown File"
output: 
  html_document:
    keep_md: true
---
```

Dual output of govspeak and word/PDF can be achieved as follows:

```
---
title: "My Rmarkdown File"
output: 
  html_document:
    keep_md: true
  word_document:
    #any other parameters relevant to the word document here
---
```

It is also possible to keep the md document associated with the word output, and output a HTML format alongside this:

```
---
title: "My Rmarkdown File"
output: 
  word_document:
    keep_md: true
  html_document:
    #any other parameters relevant to the html document here
---
```

To render both outputs, make use of the `rmarkdown::render()` function with the argument `outputs = "all"`.

#### convert_rmd()

Following rendering of the output, the `convert_rmd()` function modifies formatting of the .md file to produce a govspeak output which can be read by Whitehall Publishing:

* Image tags are converted from standard markdown to govspeak i.e.
```
Figure 1
![](images/image1.png)<!-- -->!

Figure 1
[Image:image1.png]
```

* Page breaks are replaced. This feature can be controlled using the "page_break" argument. ```page_break = "line"``` replaces them with a horizontal ruling, while ```page_break = "none"``` just moves the subsequent text onto a new line, and ```page_break = "unchanged"``` makes no replacement.

* YAML header is removed

* As GOV.UK cannot accept first-level headers (single #), all hashed headers are increased by one level i.e.
``` # Title ``` becomes ```## Title```. This functionality can be controlled using the sub_pattern argument. Setting it to TRUE increases all headers by one level. FALSE results in no changes to the headers as written. Passing the argument a vector allows selective changing of specific headers, e.g. ```sub_pattern = c("#", "##")``` would change only first and second level headers.

* Image names can be converted to a tidy standardised form of "image-X.png/svg". Passing a folder path for the image folder working directory (usually the same as the Rmarkdown working directory) converts the image names in that directory.

This function should be run in a separate utility script distinct from the Rmarkdown document. It produces two outputs; a govspeak format md file called x_converted.md, where x is the name of the original .md file, and a csv called img_lookup.csv, which provides a mapping of the expected image names to markdown image tags for QA purposes.  

### Formatting of govspeak documents for publication

The following functions are all designed to be used inside Rmarkdown documents, and aim to make it simple to include images, tables, and other content permitted on gov.uk. All of these features will appear in the final govspeak output, and in some cases an approximation of their gov.uk appearance will be returned in other formats.

#### add_image() 
Allows simple addition of figures which are not generated within the Rmarkdown document. These should preferably be in .svg format, but if they are in .png format they must adhere to the Whitehall publishing size of 960 by 640 pixels. Takes two arguments, the file name and its folder location (defaults to "graphs").

#### add_table() 
Formats a dataframe of data into a table. This will display correctly in govspeak and other (word and HTML) formats, and allows for text to go over multiple lines. Takes a single argument `data` of the table contents.

#### conditional_publishing_output()
Aims to make publishing two formats from one RMarkdown document simple. This wrapper allows any output to be conditional and only appear in one of the specified formats e.g. to output table_one in the HTML output only you can use:

```
conditional_publishing_output("html", table_one)
```
This output will not appear at all in any non-HTML outputs such as word or pdf.

The full list of options that can be used in the first argument are:

* **"html"** for HTML/govspeak output
* **"docx"** for Word output
* **"latex"** for PDF output
* **"markdown_strict"** for markdown output
* **"pptx"** for powerpoint presentation
* **"beamer"** for beamer presentation
* **"odt"** for odt output

#### callout_box() 
Some publications use a callout box to add emphasis to text in an online publication via `$CTA` tags. This function automatically adds these `$CTA` tags to text in the govspeakr output only. If the HTML output is not used as the govspeakr output, CTA tags will appear in a grey box in HTML outputs.


### Formatting of HTML pre-releases

The following functions are all designed to be used inside Rmarkdown documents, and aim to make it simple to add aesthetic features such as the headers which are present by default on all gov.uk publications. These features will appear in the HTML output only, and should not be used in the govspeak output.

#### add_blue_header()
Includes details of the statistical publication in a blue header, mimicking the appearance of gov.uk. Takes three arguments, the title of the release, the stats badging status (defaults to National Statistics), and the pre-release sub-header (defaults to "pre-release").

