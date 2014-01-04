#' R Interface of LTP-cloud service
#'
#' This function deals with communication with the server.
#' XML result will be parsed if the mission is word-splitting.
#' Else the raw XML texts will be returned for further analysis.
#' 
#' @param input The input text.
#' @param file The input file.
#' @param mission Expected result for the cloud server, may be unfinished. Optional choices are 
#' 'ws' for word-splitting,
#' 'pos' for part-of-speech,
#' 'ner' for named entity recognition，
#' 'dp' for dependency parser，
#' 'srl' for semantic role labeling,
#' 'all' for all missions.
#' @param email Your email for the cloud server.
#' @param token Your unique token appeared on http://www.ltp-cloud.com/dashboard/ .
#' @param maxUpload Due to the limitation of the server, we cut the input in pieces.
#' @export
ltp = function(input=NULL,file=NULL,mission='ws',
               email='example@gmail.com',token='1a2b3c',
               maxUpload=100000)
{
    if (is.null(input) && is.null(file))
        stop('No Input.')
    if (email=='example@gmail.com')
        stop('Please use a valid email and corresponding token')
    ID = paste(email,token,sep=':')
    if (!is.null(file))
        input = readLines(file)
    if (!isUTF8(input[1]))
        input = toUTF8(input)
    input = gsub('\\s+','',input)
    input = input[input!='']
    if (length(input)==0)
        stop('Empty Input.')
    n = length(input)
    if (n==1)
    {
        if (nchar(input)>maxUpload)
            stop('This paragraph is too long to upload, please split it into smaller pieces.')
        inputs = input
    }
    else
    {
        nc = nchar(input[1])
        inputs = ''
        L = 1
        for (i in 2:n)
        {
            if (nchar(inputs[L])+nchar(input[i])<maxUpload)
                inputs[L] = paste(inputs[L],input[i],sep='\n')
            else
            {
                L = L+1
                inputs[L] = input[i]
            }
        }
    }
    
    if (length(inputs)==1)
    {
        cat('Uploading\n')
        para = commLTP(inputs,mission=mission,ID)
        if (mission!='ws')
        {
            cat('Parser for non-Word-Splitting result is not available yet.',
                '\n','Returning Raw XML texts for each part.')
            return(para)
        }
        cat('Downloaded,Parsing\n')
        tag = para[[1]]
        sents = parseLTP(para[[2]])
    }
    else
    {
        cat('Uploading\n')
        paras = list()
        n = length(inputs)
        p = proc.time()
        for (i in 1:n)
        {
            paras[[i]] = commLTP(inputs[i],mission,ID)
            show(proc.time()-p)
            cat(paste(i,n,sep='/'),'\n')
            p = proc.time()
        }
        if (mission!='ws')
        {
            cat('Parser for non-Word-Splitting result is not available yet.',
                '\n','Returning Raw XML texts for each part.')
            return(paras)
        }
        cat('\nDownloaded,Parsing\n')
        missions = lapply(paras,function(x)x[[1]])
        missions = do.call(rbind,missions)
        n = ncol(missions)
        tag = rep(FALSE,n)
        for (i in 1:n)
            tag[i] = !any(!missions[,i])
        
        paras = lapply(paras,function(x)x[[2]])
        para = list()
        for (p in paras)
            para = c(para,p)
        sents = parseLTP(para)
    }
    ans = doc(tags=tag,sents=sents)
    ans
}
