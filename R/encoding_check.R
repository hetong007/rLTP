# Basic template for encoding checks
is_x <- function(string, combine, r_func, c_func){
  
  string <- .verifyChar(string)
  
  if (length(string)  == 1) {
    switch(c_func,
      CWrapper_encoding_isbig5={
        output <- .C("CWrapper_encoding_isbig5", 
                     characters = as.character(string),
                     numres = 2L)
      },
      CWrapper_encoding_isgbk={
        output <- .C("CWrapper_encoding_isgbk", 
                     characters = as.character(string),
                     numres = 2L)
      },
      CWrapper_encoding_isgb18030={
        output <- .C("CWrapper_encoding_isgb18030", 
                     characters = as.character(string),
                     numres = 2L)
      },
      CWrapper_encoding_isgb2312={
        output <- .C("CWrapper_encoding_isgb2312", 
                     characters = as.character(string),
                     numres = 2L)
      },
      CWrapper_encoding_isutf8={
        output <- .C("CWrapper_encoding_isutf8", 
                     characters = as.character(string),
                     numres = 2L)
      },
    )
    return(as.logical(output$numres))
  }
  
  if(combine){
    return(r_func(paste(string, collapse = "")))
  }
  
  return(as.vector(sapply(string, r_func)))
  
}


#' Indicate whether the encoding of input string is BIG5.
#'
#' @title Indicate whether the encoding of input string is BIG5.
#' 
#' @param string A character vector.
#' 
#' @param combine Whether to combine all the strings.
#' 
#' @return A vector of logical values, the length of \code{string} - or a single logical value if \code{combine}
#' is TRUE.
#' 
#' @author Jian Li <\email{rweibo@@sina.com}>
isBIG5 <- function(string, combine = FALSE){
  return(is_x(string, combine, r_func = isBIG5, c_func = "CWrapper_encoding_isbig5"))
}


#' Indicate whether the encoding of input string is GBK.
#' 
#' @title Indicate whether the encoding of input string is GBK.
#' 
#' @param string A character vector.
#' 
#' @param combine Whether to combine all the strings.
#' 
#' @return A vector of logical values, the length of \code{string} - or a single logical value if \code{combine}
#' is TRUE.
#' @author Jian Li <\email{rweibo@@sina.com}>
isGBK <- function(string, combine = FALSE){
  return(is_x(string, combine, r_func = isGBK, c_func = "CWrapper_encoding_isgbk"))
}

#' Indicate whether the encoding of input string is GBK.
#' 
#' @title Indicate whether the encoding of input string is GBK.
#' 
#' @param string A character vector.
#' 
#' @param combine Whether to combine all the strings.
#' 
#' @return A vector of logical values, the length of \code{string} - or a single logical value if \code{combine}
#' is TRUE.
#' 
#' @author Jian Li <\email{rweibo@@sina.com}>
isGB18030 <- function(string, combine = FALSE){
  return(is_x(string, combine, r_func = isGB18030, c_func = "CWrapper_encoding_isgb18030"))
}

#' Indicate whether the encoding of input string is GB18030.
#' 
#' @title Indicate whether the encoding of input string is GB18030.
#' 
#' @param string A character vector.
#' 
#' @param combine Whether to combine all the strings.
#' 
#' @return A vector of logical values, the length of \code{string} - or a single logical value if \code{combine}
#' is TRUE.
#' 
#' @author Jian Li <\email{rweibo@@sina.com}>
isGB2312 <- function(string, combine = FALSE){
  return(is_x(string, combine, r_func = isGB2312, c_func = "CWrapper_encoding_isgb2312"))
}

#' Indicate whether the encoding of input string is UTF-8.
#' 
#' @title Indicate whether the encoding of input string is UTF-8.
#' 
#' @param string A character vector.
#' 
#' @param combine Whether to combine all the strings.
#' 
#' @return A vector of logical values, the length of \code{string} - or a single logical value if \code{combine}
#' is TRUE.
#' 
#' @author Jian Li <\email{rweibo@@sina.com}>
isUTF8 <- function(string, combine = FALSE){
  return(is_x(string, combine, r_func = isUTF8, c_func = "CWrapper_encoding_isutf8"))
}
