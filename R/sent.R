setClass("sent",
         slots = c(id = "numeric",
                   para_id = "numeric",
                   cont = "character",
                   terms = "data.frame",
                   args = "list"))

sent = function(id=0,
                para_id=0,
                cont='',
                terms=data.frame(id = numeric(0),
                                 cont = character(0),
                                 pos = character(0),
                                 ne = character(0),
                                 parent = numeric(0),
                                 relate = character(0),
                                 wsd = character(0),
                                 wsdexp = character(0),
                                 hasargs = logical(0)),
                args = list())
{
    new("sent",id=id,para_id=para_id,cont=cont,terms=terms,args=args)
}

setMethod("show",
          signature = "sent",
          definition = function(object)
          {
              cat("Paragraph",object@para_id,", Sentence",object@id,'\n')
              show(object@terms)
          })

setMethod("[",
          signature = "sent",
          definition = function(x,i=NULL,j=NULL,...,drop="missing")
          {
              n = nrow(x@terms)
              if (n==0)
                  stop('No term exists.')
              if (is.null(i))
                  i = 1:n
              if (any(i>n | i<1))
                  stop('Subscript of terms out of bound.')
              x@term[i,]
          })

setMethod("length",
          signature = "sent",
          definition = function(x)
          {
              nrow(x@terms)
          })

setGeneric("id", function(object, ...) standardGeneric("id"))
setMethod("id",
          signature = "sent",
          definition = function(object, ...)
              object@id
)

setGeneric("para_id", function(object, ...) standardGeneric("para_id"))
setMethod("para_id",
          signature = "sent",
          definition = function(object, ...)
              object@para_id
)

setGeneric("cont", function(object, ...) standardGeneric("cont"))
setMethod("cont",
          signature = "sent",
          definition = function(object, ...)
              object@cont
)

setGeneric("terms", function(object, ...) standardGeneric("terms"))
setMethod("terms",
          signature = "sent",
          definition = function(object, ...)
              object@terms
)

setGeneric("args", function(object, ...) standardGeneric("args"))
setMethod("args",
          signature = "sent",
          definition = function(object, ...)
              object@args
)
