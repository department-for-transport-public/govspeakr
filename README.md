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

#### convert_rmd()

Following rendering of the Rmd output, the `convert_rmd()` function modifies formatting of the .md file to produce a govspeak output which can be read by Whitehall Publishing:

* Image tags are converted from standard markdown to govspeak i.e.
```
Figure 1
![](images/image1.png)<!-- -->!

Figure 1
[Image:image1.png]
```

* Page breaks are replaced.

* YAML header and code chunks are removed

* All hashed headers are increased by one level 

For more details on how to use this function, see the [vignette](https://department-for-transport-public.github.io/govspeakr/articles/convert_rmd.html).

### Formatting of govspeak documents for publication

The following functions are all designed to be used inside Rmarkdown documents, and aim to make it simple to include images, tables, and other content permitted on gov.uk. All of these features will appear in the final govspeak output, and in some cases an approximation of their gov.uk appearance will be returned in other formats.

#### add_image() 
Allows simple addition of figures which are not generated within the Rmarkdown document. These should preferably be in .svg format, but if they are in .png format they must adhere to the Whitehall publishing size of 960 by 640 pixels. Takes two arguments, the file name and its folder location (defaults to "graphs").

#### add_table() 
Formats a dataframe of data into a table. This will display correctly in govspeak and other (word and HTML) formats, and allows for text to go over multiple lines. Takes a single argument `data` of the table contents.

#### conditional_publishing_output()
Aims to make publishing two formats from one RMarkdown document simple. This wrapper allows any output to be conditional and only appear in one of the specified formats e.g. to output table_one in the HTML output only you can use:

```
conditional_publishing_output(table_one, "html")
```
In this example, the output will not appear at all in any non-HTML outputs such as word or pdf.

For more details on how to use this function, see the [vignette](https://department-for-transport-public.github.io/govspeakr/articles/conditional_publishing_output.html).

#### callout_box() 
Some publications use a callout box to add emphasis to text in an online publication via `$CTA` tags. This function automatically adds these `$CTA` tags to text in the govspeakr output only. If the HTML output is not used as the govspeakr output, CTA tags will appear in a grey box in HTML outputs.


### Formatting of HTML pre-releases

The following functions are all designed to be used inside Rmarkdown documents, and aim to make it simple to add aesthetic features such as the headers which are present by default on all gov.uk publications. These features will appear in the HTML output only, and should not be used in the govspeak output.

#### add_blue_header()
Includes details of the statistical publication in a blue header, mimicking the appearance of gov.uk. Takes three arguments, the title of the release, the stats badging status (defaults to National Statistics), and the pre-release sub-header (defaults to "pre-release").

