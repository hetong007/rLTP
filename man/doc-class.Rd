\docType{class}
\name{doc-class}
\alias{doc-class}
\title{R object 'doc' for ltp-cloud service}
\arguments{
  \item{tags}{The completeness of mission}

  \item{sents}{List of components of the result}
}
\description{
A doc-class object mainly consists of a data.frame, a
character vector and two vector of indexed of sentences
}
\section{Slots}{
  \describe{ \item{\code{tags}:}{Named vector of class
  \code{"logical"}, containing record of completed
  missions} \item{\code{sents}:}{List of splitted words.} }
}

\section{Methods}{
  \describe{ \item{\code{show}:}{Show object}
  \item{\code{length}:}{Get number of sentences}
  \item{\code{as.data.frame}:}{Extract the inside data
  frame} \item{\code{[}:}{Subset sentences} }
}

