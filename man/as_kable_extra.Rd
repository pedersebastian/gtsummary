% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as_kable_extra.R
\name{as_kable_extra}
\alias{as_kable_extra}
\title{Convert gtsummary object to a kableExtra object}
\usage{
as_kable_extra(
  x,
  include = everything(),
  return_calls = FALSE,
  strip_md_bold = TRUE,
  fmt_missing = TRUE,
  ...
)
}
\arguments{
\item{x}{Object created by a function from the gtsummary package
(e.g. \link{tbl_summary} or \link{tbl_regression})}

\item{include}{Commands to include in output. Input may be a vector of
quoted or unquoted names. tidyselect and gtsummary select helper
functions are also accepted.
Default is \code{everything()}.}

\item{return_calls}{Logical. Default is \code{FALSE}. If \code{TRUE}, the calls are returned
as a list of expressions.}

\item{strip_md_bold}{When TRUE, all double asterisk (markdown language for
bold weight) in column labels and spanning headers are removed.}

\item{fmt_missing}{Logical argument adding the missing value formats.}

\item{...}{Additional arguments passed to \link[knitr:kable]{knitr::kable}}
}
\value{
A {kableExtra} object
}
\description{
Function converts a gtsummary object to a knitr_kable + kableExtra object.
This allows the customized formatting available via \link[knitr:kable]{knitr::kable}
and {kableExtra}; \code{as_kable_extra()} supports arguments in \code{knitr::kable()}.
\code{as_kable_extra()} output via gtsummary supports
bold and italic cells for table bodies. Users
creating pdf output should specify \code{as_kable_extra(format = "latex")}.
}
\section{PDF via LaTeX Tips}{


This section discusses options intended for use with
\itemize{
\item \code{output: pdf_document} in yaml of \code{.Rmd}.
\item \code{as_kable_extra(format = "latex")}
}
\subsection{Custom column names}{

In pdf output, column names do not currently inherit formatting applied in
{gtsummary} tables. However, custom column names can be achieved with the
\code{col.names} argument as shown in Example 2, including attributes such as bold
formatting, italic formatting, and line breaks. Doing so requires the \code{escape = FALSE} argument; however, when using \code{escape = FALSE} special latex
characters like \verb{\\} and \verb{\%} will need to be escaped prior to entering
\code{as_kable_extra()}. Using \code{escape = FALSE} when the gtsummary table has
special LaTeX characters will result in the error \code{"LaTeX failed to compile..."}
}

\subsection{Additional table styling}{

Additional styling is available through \code{knitr::kable()} and
\code{kableExtra::kable_styling()} as shown in Example 3, which implements row
striping and repeated column headers in the presence of page breaks.
}
}

\section{Example Output}{

\if{html}{Example 1 (html)}

\if{html}{\figure{as_kable_extra_ex1_html.png}{options: width=40\%}}

\if{html}{Example 1 (pdf)}

\if{html}{\figure{as_kable_extra_ex1_pdf.png}{options: width=40\%}}

\if{html}{Example 2 (pdf)}

\if{html}{\figure{as_kable_extra_ex2_pdf.png}{options: width=40\%}}

\if{html}{Example 3 (pdf)}

\if{html}{\figure{as_kable_extra_ex3_pdf.png}{options: width=40\%}}
}

\examples{
\dontshow{if (broom.helpers::.assert_package("kableExtra", boolean = TRUE)) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
\donttest{
# Example 1 (general) -------------------------------------------------------
as_kable_extra_ex1_gen <-
  trial \%>\%
  select(trt, age, stage) \%>\%
  tbl_summary(by = trt) \%>\%
  bold_labels() \%>\%
  as_kable_extra()

# Example 2 (PDF via LaTeX) -------------------------------------------------
custom_names <- c(
   "\\\\textbf{Characteristic}",
   "\\\\textbf{Drug A}\n\\\\textit{N = 98}",
   "\\\\textbf{Drug B}\n\\\\textit{N = 102}"
)
as_kable_extra_ex2_pdf <-
  trial \%>\%
  select(trt, age, stage) \%>\%
  tbl_summary(
     by = trt,
     statistic = list(all_categorical() ~ "{n} ({p}\\\\\%)")
  ) \%>\%
  bold_labels() \%>\%
  modify_footnote(
     update = all_stat_cols() ~ "Median (IQR); n (\%)"
  ) \%>\%
  as_kable_extra(
     format = "latex",
     col.names = kableExtra::linebreak(custom_names, align = "c"),
     escape = FALSE
  )

# Example 3 (PDF via LaTeX) -------------------------------------------------
as_kable_extra_ex3_pdf <-
trial \%>\%
  select(trt, age, stage) \%>\%
  tbl_summary(by = trt) \%>\%
  bold_labels() \%>\%
  as_kable_extra(
    format = "latex",
    booktabs = TRUE,
    longtable = TRUE,
    linesep = ""
  ) \%>\%
  kableExtra::kable_styling(
    position = "left",
    latex_options = c("striped", "repeat_header"),
    stripe_color = "gray!15"
  )
}
\dontshow{\}) # examplesIf}
}
\seealso{
Other gtsummary output types: 
\code{\link{as_flex_table}()},
\code{\link{as_gt}()},
\code{\link{as_hux_table}()},
\code{\link{as_kable}()},
\code{\link{as_tibble.gtsummary}()}
}
\author{
Daniel D. Sjoberg
}
\concept{gtsummary output types}
