# Basic template for encoding checks
is_x <- function(string, combine, r_func, c_func){
  
  string <- .verifyChar(string)
  
  if (length(string)  == 1) {
    output <- .C(c_func, 
                 characters = as.character(string),
                 numres = 2L, PACKAGE = 'rLTP')
    return(as.logical(output$numres))
  }
  
  if(combine){
    return(r_func(paste(string, collapse = "")))
  }
  
  return(as.vector(sapply(string, r_func)))
  
}

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
