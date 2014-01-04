#' R object 'doc' for ltp-cloud service
#'
#' A doc-class object mainly consists of a data.frame, a character vector and two vector of indexed of sentences
#' 
#' @param tags The completeness of mission
#' @param sents List of components of the result
#' 
#' @section Slots: 
#'  \describe{
#'    \item{\code{tags}:}{Named vector of class \code{"logical"}, containing record of completed missions}
#'    \item{\code{sents}:}{List of splitted words.}
#'  }
#'  
#' @section Methods: 
#'  \describe{
#'    \item{\code{show}:}{Show object}
#'    \item{\code{length}:}{Get number of sentences}
#'    \item{\code{as.data.frame}:}{Extract the inside data frame}
#'    \item{\code{[}:}{Subset sentences}
#'  }
#' 
#' @export
setClass("doc",
         slots = c(tags = "logical",
                   sents = "list"))
#' @export
doc = function(tags=logical(7),sents=list())
{
    new("doc",tags=tags,sents=sents)
}

#' @export
setMethod("show",
          signature = "doc",
          definition = function(object)
          {
              tmp = length(object@sents[[2]])
              if (tmp==1)
                  cat('A Document with:',tmp,'sentence.\n')
              else
                  cat('A Document with:',tmp,'sentences.\n')
          })

setMethod("[",
          signature = "doc",
          definition = function(x,i=NULL,j=NULL,...,drop="missing")
          {
              n = length(x@sents[[2]])
              if (n==0)
                  stop('No sentence exists.')
              if (is.null(i))
                  i = 1:n
              if (any(i>n | i<1))
                  stop('Subscript out of bound.')
              if (length(i)==1)
              {
                  l = x@sents[[3]][i]
                  r = x@sents[[4]][i]
                  sent = list(word=x@sents[[1]][l:r,],
                              sent=x@sents[[2]][i])
              }
              else
              {
                  ind=unlist(lapply(i,function(i)x@sents[[3]][i]:x@sents[[4]][i]))
                  sent = list(word=x@sents[[1]][ind,],
                              sent=x@sents[[2]][i])
              }
              sent
          })

#' @export
setMethod("length",
          signature = "doc",
          definition = function(x)
          {
              length(x@sents[[2]])
          })

setGeneric("as.data.frame", function(object, ...) standardGeneric("as.data.frame"))
#' @export
setMethod("as.data.frame",
          signature = "doc",
          definition = function(object, ...)
              object@sents[[1]]
)
