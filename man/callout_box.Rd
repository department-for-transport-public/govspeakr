% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/callout_box.R
\name{callout_box}
\alias{callout_box}
\title{Include a callout box in govspeak output}
\usage{
callout_box(text, format = "html")
}
\arguments{
\item{text}{string to publish in a callout box}

\item{format}{string which identifies the outputs you would like the
callout box tags to appear in. Set to HTML as default. If HTML is not the chosen format value,
the callout box will be displayed as a CSS-formatted in the HTML output. All other
formats which are not the chosen format value will display the callout box as simple text.}
}
\description{
Adds conditional CTA tags in govspeak only. Displays as text in a box on Whitehall publisher,
as a equivalent style HTML box in the html output if needed,
and as simple text only in other formats.
}
