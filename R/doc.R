setClass("doc",
         slots = c(tags = "logical",
                   sents = "list"))

doc = function(tags=logical(7),sents=list())
{
    new("doc",tags=tags,sents=sents)
}

setMethod("show",
          signature = "doc",
          definition = function(object)
          {
              cat('Document with:',length(object@sents),'sentences.\n')
          })

setMethod("[",
          signature = "doc",
          definition = function(x,i=NULL,j=NULL,...,drop="missing")
          {
              n = length(x@sents)
              if (n==0)
                  stop('No sentence exists.')
              if (is.null(i))
                  i = 1:n
              if (any(i>n | i<1))
                  stop('Subscript of sentences out of bound.')
              if (length(i)==1)
                  sent = x@sents[[i]]
              else
                  sent = x@sents[i]
              sent
          })

setMethod("length",
          signature = "doc",
          definition = function(x)
          {
              length(x@sents)
          })

setGeneric("tags", function(object, ...) standardGeneric("tags"))
setMethod("tags",
          signature = "doc",
          definition = function(object, ...) 
              object@tags
          )

setGeneric("sents", function(object, ...) standardGeneric("sents"))
setMethod("sents",
          signature = "doc",
          definition = function(object, ...)
              object@sents
          )
