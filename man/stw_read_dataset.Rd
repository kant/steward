% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stw_read_write_dataset.R
\name{stw_read_dataset}
\alias{stw_read_dataset}
\alias{stw_write_dataset}
\title{Read or write a steward dataset}
\usage{
stw_read_dataset(file_data, file_meta = NULL, ...)

stw_write_dataset(dataset, file_data, file_meta = NULL, ...)
}
\arguments{
\item{file_data}{\code{character}, path to write the CSV file}

\item{file_meta}{\code{character}, path to write the YAML file; default is to
use the wame directory and file-root as \code{file_data}}

\item{...}{additional arguments passed on to \code{\link[readr:read_csv]{readr::read_csv()}} or
\code{\link[readr:write_csv]{readr::write_csv()}}}

\item{dataset}{Object with S3 class \code{stw_dataset}, a data frame with attached meta-data}
}
\value{
invisible copy of \code{dataset}
}
\description{
This will read from or write to a set of files: o CSV file for the data,
and a YAML file for the meta-data.
}
\details{
At the moment, this provides minimal functionality. In the future, we can
imagine usung the metadata to create a function that would read a file
that comports to the meta-data specifications. The data frame would have
all its factor levels set, and in the farther future, have a timezone set
for datetime columns.
}
