\name{ltp}
\alias{ltp}
\title{R Interface of LTP-cloud service}
\usage{
ltp(input = NULL, file = NULL, mission = "ws",
  email = "hetong007@gmail.com", token = "ypcOZA6a", maxUpload = 1e+05)
}
\arguments{
  \item{input}{The input text.}

  \item{file}{The input file.}

  \item{mission}{Expected result for the cloud server, may
  be unfinished.}

  \item{email}{Your email for the cloud server.}

  \item{token}{Your unique token appeared on
  http://www.ltp-cloud.com/dashboard/ .}

  \item{maxUpload}{Due to the limitation of the server, we
  cut the input in pieces.}
}
\description{
This function deals with communication with the server. XML
result will be parsed if the mission is word-splitting.
Else the raw XML texts will be returned for further
analysis.
}
\examples{
#a=ltp('美国的华莱士，比你们不知高到哪里去了。我和他谈笑风生!')
}

