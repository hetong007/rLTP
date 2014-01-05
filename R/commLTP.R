commLTP = function(input,mission='ws',ID,pw='password')
{
    addr = "http://api.ltp-cloud.com:8080"
    uris = "/ltp_srv/ltp"
    server = paste(addr,uris,sep='')
    
    header = as.character(base64(paste(ID,pw,sep=':')))
    header = paste('Basic',header)
    header = c('Authorization'=header)
    
    #data = 'x=n&c=utf-8&t=all'
    #data = paste(data,input,sep='&s=')
    #data = URLencode(data)
    
    result = postForm(uri = server,
                   .opts = curlOptions(httpHEAD=header),
                   style = "post",
                   'x' = 'n',
                   's' = input,
                   'c' = 'utf-8',
                   't' = mission)
    result = rawToChar(result)
    if (Sys.info()['sysname']=='Windows')
        result = iconv(result,'UTF-8','gb2312')
    if (mission!='ws')
        return(result)
    #result = htmlTreeParse(result,useInternalNodes=T)
    result = xmlTreeParse(result,useInternalNodes=T)
    r = xmlRoot(result)
    #r = r[[1]][[1]]
    
    missions = xmlAttrs(r[[1]])=='y'
    ind = match(names(missions),
                c("sent","word","pos","ne","parser","wsd","srl"))
    missions = missions[ind]
    
    if (!missions[1])
        stop('Mission Unfinished!\n')
    
    para_xml = xmlToList(r[[2]])#doc tag
    return(list(missions,para_xml))
}

